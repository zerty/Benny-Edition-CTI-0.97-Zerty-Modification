//--- PVF Are store within the mission namespace
with missionNamespace do {
	//--- Forward a PVF to a client (client to client communication)
	CTI_PVF_Server_Forwarder = {
		private ["_pv_who"];

		_pv_who = (_this select 0) select 1;
		if (typeName _pv_who == "OBJECT") then { _pv_who = owner _pv_who };

		if (typeName _pv_who != "SCALAR") exitWith {
			if (CTI_Log_Level >= CTI_Log_Error) then { //--- Error
				["ERROR", "FUNCTION: CTI_PVF_Server_Forwarder", format ["PVF [%1] could not be forwarded to the desired client since it isn't an OBJECT (Target: [%2], Type [%3])", _this select 1, _pv_who, typeName _pv_who]] call CTI_CO_FNC_Log
			};
		};

		CTI_NetCom = _this; //--- Compose the net message (again)
		_pv_who publicVariableClient "CTI_NetCom";
	};

	CTI_PVF_Request_HQLocality = {
		private ["_hq", "_side", "_target"];
		_side = _this select 0;
		_target = _this select 1;

		_hq = (_side) call CTI_CO_FNC_GetSideHQ;
		if (isnull _target) then {_hq setOwner 0} else {_hq setOwner (owner _target)};
	};

	CTI_PVF_Request_Locality = {
		private ["_hq", "_side", "_target"];
		_obj = _this select 0;
		_target = _this select 1;

		_obj setOwner (owner _target);
	};

	CTI_PVF_Request_AddScore = { _this spawn CTI_SE_FNC_AddScore };

	CTI_PVF_Request_Building = { _this spawn CTI_SE_FNC_BuildStructure };
	CTI_PVF_Request_Defense = { _this spawn CTI_SE_FNC_BuildDefense };

	CTI_PVF_Request_Purchase = { _this spawn CTI_SE_FNC_OnClientPurchase };
	CTI_PVF_Request_PurchaseCancel = { _this spawn CTI_SE_FNC_OnClientPurchaseCancelled };
	CTI_PVF_Answer_Purchase = { _this spawn CTI_SE_FNC_OnClientPurchaseComplete };

	CTI_PVF_Request_Worker = { _this spawn CTI_SE_FNC_CreateWorker };

	CTI_PVF_Request_HandleAction = {
		private ["_action", "_param"];
		_action = _this select 0;
		_param = _this select 1;

		switch (_action) do {
			case "empty": {_param spawn CTI_SE_FNC_HandleEmptyVehicle};
			case "repair": {_param execFSM "Server\FSM\update_repairtruck.fsm"};
			case "salvager": {_param execFSM "Server\FSM\update_salvager.fsm"};
		};
	};

	CTI_PVF_Request_AIOrderAction = {
		private ["_groups", "_order", "_side"];
		_groups = _this select 0;
		_order = _this select 1;
		_side = _this select 2;

		if (typeName _groups != "ARRAY") then {_groups = [_groups]};

		{
			switch (_order) do {
				case CTI_ORDER_EMBARKCOMMANDVEH: {[["CLIENT", _side], "Client_OnMessageReceived", ["order-getin", leader _x]] call CTI_CO_FNC_NetSend; (_x) call CTI_FSM_UpdateAI_EmbarkCommandableVehicles};
				case CTI_ORDER_DISEMBARKCOMMANDVEH: {[["CLIENT", _side], "Client_OnMessageReceived", ["order-getout", leader _x]] call CTI_CO_FNC_NetSend; (_x) call CTI_FSM_UpdateAI_DisembarkCommandableVehicles};
				case CTI_ORDER_EMBARKCARGOVEH: {[["CLIENT", _side], "Client_OnMessageReceived", ["order-getinc", leader _x]] call CTI_CO_FNC_NetSend; (_x) call CTI_FSM_UpdateAI_EmbarkCargoVehicles};
				case CTI_ORDER_DISEMBARKCARGOVEH: {[["CLIENT", _side], "Client_OnMessageReceived", ["order-getoutc", leader _x]] call CTI_CO_FNC_NetSend; (_x) call CTI_FSM_UpdateAI_DisembarkCargoVehicles};
			};
		} forEach _groups;
	};

	CTI_PVF_Request_Join = {
		private ["_client", "_join", "_side"];
		_client = _this select 0;
		_side = _this select 1;

		_name = name _client;
		_uid = getPlayerUID _client;
		_teamswap = false;
		_teamstack=false;

		waitUntil {!isNil {missionNamespace getVariable Format["CTI_SERVER_CLIENT_%1",_uid];}};

		_get = missionNamespace getVariable Format["CTI_SERVER_CLIENT_%1",_uid];
		_side_origin = _get select 1; //--- Get the original side.

		// TEAMSWAP
		if (_side_origin != _side && (_side_origin in [east,west]) && CTI_TEAMSWAP == 1) then { //--- The joined side differs from the original one.
			_teamswap = true;
			//["CLIENT", "Client_OnMessageReceived", ["teamswap", _name]] call CTI_CO_FNC_NetSend;
			if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Request_Join", format["Player [%1] [%2] tried to teamswap from it's original side [%3] to side [%4]. The server explicitely answered that he should be sent back to the lobby.", _name, _uid, _side_origin, _side]] call CTI_CO_FNC_Log};
		};
		//TEAWSTACK
		_west_count=0;
		_east_count=0;
		{_west_count=_west_count + ({isplayer _x} count(units _x));true }count (["GetAllGroupsOfSide",[west]]call BIS_fnc_dynamicGroups);
		{_east_count=_east_count + ({isplayer _x} count(units _x));true }count (["GetAllGroupsOfSide",[east]]call BIS_fnc_dynamicGroups);
		_teamstack=if ((_side_origin == civilian) && CTI_TEAMSTACK == 1 &&((_side == west && _west_count >=(_east_count +2)) ||	(_side == east && _east_count >=(_west_count +2)))) then {true} else {false};

		//SAVE
		if !(_teamstack || _teamswap ) then {
			_get set [1,_side];
			missionNamespace setVariable [Format["CTI_SERVER_CLIENT_%1",_uid],_get];
		};

		//jail
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Request_Join", format["Player [%1] [%2] can join? -> teamswap [%3] | teawstack [%4].", _name, _uid, _teamswap,_teamstack]] call CTI_CO_FNC_Log};

		_was_jailed = false;
		_get = missionNamespace getVariable format ["CTI_SERVER_CLIENT_ELITE_%1", _uid];
		if !(isNil '_get') then {if (_get select 1 == 1) then {_was_jailed = true}};
		[["CLIENT", _client], "Client_JoinRequestAnswer", [_teamswap,_teamstack,_was_jailed]] call CTI_CO_FNC_NetSend;
	};

	CTI_PVF_Request_NoobLogger = { _this spawn CTI_SE_FNC_NoobLogger };
	CTI_PVF_Request_NoobLoggerEnd = { _this spawn CTI_SE_FNC_NoobLoggerEnd };
	CTI_PVF_Request_Upgrade = { _this spawn CTI_SE_FNC_StartUpgrade };
	CTI_PVF_Request_EventDestroyedHQ = { _this spawn CTI_SE_FNC_OnHQDestroyed };
	CTI_PVF_Request_HQRepair = { _this spawn CTI_SE_FNC_RepairHQ };


	CTI_PVF_Request_TownAddVehicles = {
		private ["_side", "_town", "_vehicles"];

		_town = _this select 0;
		_side = _this select 1;
		_vehicles = _this select 2;

		if (_side == resistance) then {
			_town setVariable ["cti_town_resistance_active_vehicles", (_town getVariable "cti_town_resistance_active_vehicles") + _vehicles];
		} else {
			_town setVariable ["cti_town_occupation_active_vehicles", (_town getVariable "cti_town_occupation_active_vehicles") + _vehicles];
		};
	};
	CTI_PVF_Request_Cache = { _this spawn CTI_SE_FNC_Cache };
	CTI_PVF_Uncache = {
		_this  enableSimulationGlobal true;
		diag_log format [":: Cache :: Force Uncaching %1",(_this) ];
	};
};
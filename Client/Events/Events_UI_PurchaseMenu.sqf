private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		// cti_dialog_ui_purchasemenu_action
		_get = call CTI_UI_Purchase_GetFirstAvailableFactories;
		_factory = _get select 0;
		_factory_index = _get select 1;
		_factory_type = _get select 2;

		if (isNull _factory) exitWith { closeDialog 0; };
		// if (count _factories == 0) exitWith {  }; //debug

		{if (isNil {uiNamespace getVariable format ["cti_dialog_ui_purchasemenu_vehicon_%1", _x]}) then {uiNamespace setVariable [format ["cti_dialog_ui_purchasemenu_vehicon_%1", _x], true]}} forEach ['driver','gunner','commander','turrets','lock'];
		uiNamespace setVariable ["cti_dialog_ui_purchasemenu_unitcost", 90000]; //--- Muhahahah!

		call CTI_UI_Purchase_SetVehicleIconsColor;
		(_factory_index) call CTI_UI_Purchase_SetIcons;
		(_factory_type) call CTI_UI_Purchase_FillUnitsList;
		call CTI_UI_Purchase_OnUnitListLoad;

		(_factory_type) call CTI_UI_Purchase_LoadFactories;

		if (_factory_type != CTI_REPAIR || !(call CTI_CL_FNC_IsPlayerCommander)) then {((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 100016) ctrlenable false};
		//((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 100016) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.535), SafeZoneY + (SafeZoneH * 0.825), SafeZoneW * 0.275, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 100016) ctrlCommit 0;

		_groups = [group player];
		if (call CTI_CL_FNC_IsPlayerCommander) then {
			_groups = if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 3 || CTI_P_SideJoined == west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 1 || CTI_P_SideJoined == east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 2 ) then {
				(CTI_P_SideJoined) call CTI_CO_FNC_GetSideGroups
			} else {
				(CTI_P_SideJoined) call CTI_CO_FNC_GetSidePlayerGroups
			};
			{
				_header_ai = if (isPlayer leader _x) then {""} else {"[AI] "};
				((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110018) lbAdd format ["%1%2 (%3)", _header_ai, _x getVariable ["cti_alias", CTI_PLAYER_DEFAULT_ALIAS], name leader _x];
				if (leader _x == player) then {((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110018) lbSetCurSel _forEachIndex};
			} forEach (_groups);
		} else {
			((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110018) lbAdd format ["%1", group player];
			((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110018) lbSetCurSel 0;
		};

		uiNamespace setVariable ["cti_dialog_ui_purchasemenu_team", group player];
		uiNamespace setVariable ["cti_dialog_ui_purchasemenu_teams", _groups];

		execVM "Client\GUI\GUI_PurchaseMenu.sqf";
	};
	case "onUnitsLBSelChanged": {
		_changedTo = _this select 1;

		_classname = ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 111007) lnbData [_changedTo, 0];
		(_classname) call CTI_UI_Purchase_UpdateVehicleIcons;
	};
	case "onGroupLBSelChanged": {
		_changedTo = _this select 1;

		uiNamespace setVariable ["cti_dialog_ui_purchasemenu_team", (uiNamespace getVariable "cti_dialog_ui_purchasemenu_teams") select _changedTo];
	};
	case "onFactoryLBSelChanged": {
		_changedTo = _this select 1;

		_factory = (uiNamespace getVariable "cti_dialog_ui_purchasemenu_factories") select _changedTo;
		if (alive _factory) then {
			[_factory, 2, .175] call CTI_UI_Purchase_CenterMap;
			uiNamespace setVariable ["cti_dialog_ui_purchasemenu_factory", _factory];
		} else {
			if ({alive _x} count (uiNamespace getVariable "cti_dialog_ui_purchasemenu_factories") > 0) then {
				(uiNamespace getVariable "cti_dialog_ui_purchasemenu_factory_type") call CTI_UI_Purchase_LoadFactories;//reload.
			} else {
				['onLoad'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'
			};
		};
	};
	case "onIconSet": {
		_factory_index = _this select 1;
		_factory_type = _this select 2;

		_available = [CTI_Base_BarracksInRange, CTI_Base_LightInRange, CTI_Base_HeavyInRange, CTI_Base_AirInRange, CTI_Base_RepairInRange, CTI_Base_AmmoInRange, CTI_Base_NavalInRange,CTI_Town_InRange];

		if (_available select _factory_index) then {
			(_factory_index) call CTI_UI_Purchase_SetIcons;
			(_factory_type) call CTI_UI_Purchase_FillUnitsList;
			if (_factory_type == CTI_REPAIR && (call CTI_CL_FNC_IsPlayerCommander)) then {
				((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 100016) ctrlenable true
			} else {
				((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 100016) ctrlenable false
			};
			call CTI_UI_Purchase_OnUnitListLoad;

			(_factory_type) call CTI_UI_Purchase_LoadFactories;
		};
	};
	case "onVehicleIconClicked": {
		_role = _this select 1;
		_idc = _this select 2;

		_classname = ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 111007) lnbData [lnbCurSelRow 111007, 0];

		_toggle = if (uiNamespace getVariable format ["cti_dialog_ui_purchasemenu_vehicon_%1", _role]) then {false} else {true};
		uiNamespace setVariable [format ["cti_dialog_ui_purchasemenu_vehicon_%1", _role], _toggle];

		_color = if (_toggle) then {[0.258823529, 0.713725490, 1, 1]} else {[0.2, 0.2, 0.2, 1]};
		((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl _idc) ctrlSetTextColor _color;
		(_classname) call CTI_UI_Purchase_UpdateCost;
	};
	case "onVehicleLockClicked": {
		_toggle = if (uiNamespace getVariable "cti_dialog_ui_purchasemenu_vehicon_lock") then {false} else {true};
		uiNamespace setVariable ["cti_dialog_ui_purchasemenu_vehicon_lock", _toggle];

		_color = if (uiNamespace getVariable "cti_dialog_ui_purchasemenu_vehicon_lock") then {[1, 0.22745098, 0.22745098, 1]} else {[0.2, 0.2, 0.2, 1]};
		((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110104) ctrlSetTextColor _color;
	};
	case "onPurchase": {
		_selected = _this select 1;

		if (_selected == -1) exitWith {}; //nothing selected.

		_funds = call CTI_CL_FNC_GetPlayerFunds;
		if (_funds > (uiNamespace getVariable "cti_dialog_ui_purchasemenu_unitcost")) then {
			_classname = ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 111007) lnbData [_selected, 0];
			_selected_group = (uiNamespace getVariable "cti_dialog_ui_purchasemenu_teams") select (lbCurSel ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110018)); //todo Change that by combo value

			_isEmpty = false;
			_veh_info = if (_classname isKindOf "Man") then { [] } else { call CTI_UI_Purchase_GetVehicleInfo };
			if (count _veh_info > 0) then {
				if !((_veh_info select 0) || (_veh_info select 1) || (_veh_info select 2) || (_veh_info select 3)) then { _isEmpty = true };
			};

			if (alive(uiNamespace getVariable "cti_dialog_ui_purchasemenu_factory")) then {
				_ai_enabled = missionNamespace getVariable "CTI_AI_TEAMS_ENABLED";
				if (_ai_enabled >0 || ((isPlayer leader _selected_group || (missionNamespace getVariable "CTI_BUY_RESTRICT_LEADER" == 0 ))&& _ai_enabled == 0)) then {
					if ((count units _selected_group) <= (CTI_PLAYERS_GROUPSIZE + ({isplayer _x } count ( units _selected_group ))) || _isEmpty) then { //todo ai != player limit
						_proc_purchase = true;
						if (_isEmpty && _selected_group != group player) then {
							_proc_purchase = false;
							hint parseText localize "STR_Purchase_Empty";
						};
						if ! (_classname in ( missionNamespace getVariable format ["CTI_%1_%2Units", CTI_P_SideJoined,(uiNamespace getVariable "cti_dialog_ui_purchasemenu_factory_type")])) then { 
							_proc_purchase = false;
							hint parseText localize "STR_Purchase_Factory";
						};
						if (_proc_purchase) then {
							_get = missionNamespace getVariable _classname;
							_picture = if ((_get select CTI_UNIT_PICTURE) != "") then {
								format["<img image='%1' size='2.5'/><br /><br />", _get select CTI_UNIT_PICTURE]
							}
							else {""};
							hint parseText format [localize "STR_Purchase_Build", _get select CTI_UNIT_LABEL, _picture];
							[_classname, uiNamespace getVariable "cti_dialog_ui_purchasemenu_factory", _selected_group, _veh_info] call CTI_CL_FNC_PurchaseUnit;
						};
					} else {
						hint parseText localize "STR_Purchase_Limit";
					};
				} else {
					hint parseText localize "STR_Purchase_AI_Unit";
				};
			};
		} else {
			hint parseText localize "STR_Upgrade_Not_Funds";
		};
	};
	case "onIndependentSalvagerPressed": {
		if (isNil 'CTI_P_LastIndepSalvagerPurchased') then { CTI_P_LastIndepSalvagerPurchased = -600 };

		_in_use = (uiNamespace getVariable "cti_dialog_ui_purchasemenu_factory") getVariable "cti_inuse";
		if (isNil '_in_use') then { _in_use = false };
		if !(_in_use) then {
			_funds = call CTI_CL_FNC_GetPlayerFunds;
			if (_funds >= CTI_VEHICLES_SALVAGER_PRICE) then {
				if (count(CTI_P_SideLogic getVariable "cti_salvagers") < CTI_VEHICLES_SALVAGE_INDEPENDENT_MAX) then {
					if (time - CTI_P_LastIndepSalvagerPurchased > 5) then {
						CTI_P_LastIndepSalvagerPurchased = time;
						["SERVER", "Request_Purchase", [CTI_P_SideJoined, group player, CTI_P_SideJoined, format["CTI_Salvager_Independent_%1", CTI_P_SideJoined], uiNamespace getVariable "cti_dialog_ui_purchasemenu_factory", [], (time + random 10000 - random 500 + diag_frameno)]] call CTI_CO_FNC_NetSend;
					} else {
						hint parseText localize "STR_Purchase_Wait";
					};
				} else {
					hint parseText localize "STR_Purchase_Limit_Salvager";
				};
			} else {
				hint parseText localize "STR_Upgrade_Not_Funds";
			};
		} else {
			hint parseText localize "STR_Purchase_Salvager";
		};
	};
	case "onQueueCancel": {
		_selected = _this select 1;

		if (_selected != -1) then {
			_classname = ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110013) lbData _selected;
			_rounded_seed = ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110013) lbValue _selected;

			// player sidechat format ["trying to remove %1 %2", _classname, _rounded_seed];
			_is_present = false;
			_req_can_alter = true;
			_req_factory = objNull;
			_req_team = grpNull;
			_seed = -1;
			_index = -1;
			{
				if (round(_x select 0) == _rounded_seed && _x select 1 == _classname) exitWith {
					_is_present = true;
					_seed = _x select 0;
					_req_factory = _x select 3;
					_req_team = _x select 4;
					_req_can_alter = _x select 5;
					_index = _forEachIndex;
				};
			} forEach CTI_P_PurchaseRequests;

			if (_is_present) then {
				//--- Yes it's here, but can we alter it ?
				if (_req_can_alter) then {
					CTI_P_PurchaseRequests set [_index, "!nil!"];
					CTI_P_PurchaseRequests = CTI_P_PurchaseRequests - ["!nil!"];

					//--- Notify the server thread that our request has been canceled.
					["SERVER", "Request_PurchaseCancel", [_seed, _classname, _req_factory, _req_team, group player]] call CTI_CO_FNC_NetSend;
				} else {
					hint "commander assigned units may not be removed";
				};
			};
		};
	};
	case "onUnload": {
		uiNamespace setVariable ["cti_dialog_ui_purchasemenu_action", objNull];
	};
};

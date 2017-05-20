/*
  # HEADER #
	Script: 		Client\Functions\Client_OnPurchaseOrderReceived.sqf
	Alias:			CTI_CL_FNC_OnPurchaseOrderReceived
	Description:	Triggered when the client order is being processed
					Note this function is called automatically when the client purchase is ready by
					the "Client_OnPurchaseOrderReceived" PVF
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Number]: The purchase seed
    1	[String]: The classname
    2	[Group]: The unit which made the purchase order
    3	[Array]: The vehicle special info (lock, crew)
    4	[Object]: The factory

  # RETURNED VALUE #
	None

  # SYNTAX #
	[SEED, CLASSNAME, BUYER, INFORMATION, FACTORY] spawn CTI_CL_FNC_OnPurchaseOrderReceived

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayPush
	Common Function: CTI_CO_FNC_CreateUnit
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_ChangeFunds
	Common Function: CTI_CO_FNC_GetFunds
	Common Function: CTI_CO_FNC_InitializeCustomVehicle
	Common Function: CTI_CO_FNC_NetSend
	Common Function: CTI_CO_FNC_SanitizeAircraft

  # EXAMPLE #
	[_seed, _classname, group player, _veh_infos, _factory] spawn CTI_CL_FNC_OnPurchaseOrderReceived
*/

private ["_cost", "_factory", "_funds", "_index", "_model", "_net", "_req_buyer", "_req_classname", "_req_seed", "_req_time", "_req_time_out", "_script", "_var", "_var_classname", "_vehicle", "_veh_infos"];

_req_seed = _this select 0;
_req_classname = _this select 1;
_req_buyer = _this select 2;
_factory = _this select 3;
_veh_infos = _this select 4;

_model = _req_classname;
_var_classname = missionNamespace getVariable _req_classname;

//--- Custom vehicle?
_script = _var_classname select CTI_UNIT_SCRIPT;
_customid = -1;
if (typeName (_var_classname select CTI_UNIT_SCRIPT) == "ARRAY") then { _model = (_var_classname select CTI_UNIT_SCRIPT) select 0; _script = (_var_classname select CTI_UNIT_SCRIPT) select 1; _customid = (_var_classname select CTI_UNIT_SCRIPT) select 2};

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Client\Functions\Client_OnPurchaseOrderReceived.sqf", format["Received purchase order concerning classname [%1] with seed [%2] from [%3] on factory [%4, (%5)]", _req_classname, _req_seed, _req_buyer, _factory, _factory getVariable "cti_structure_type"]] call CTI_CO_FNC_Log };

//--- Find the current request among our requests
_index = -1;
{ if ((_x select 0) == _req_seed && (_x select 1) == _req_classname) exitWith {_index = _forEachIndex} } forEach CTI_P_PurchaseRequests;
if (_index == -1) exitWith { diag_log "debug: unknown index in onpurchaseorderreceived" }; //todo better msg.

CTI_P_PurchaseRequests set [_index, "!REMOVE!"];
CTI_P_PurchaseRequests = CTI_P_PurchaseRequests - ["!REMOVE!"];

//--- Check if the group can handle the current unit without breaking the group size limit
_process = false;
if !(_req_classname isKindOf "Man") then {
	if (!(_veh_infos select 0) && !(_veh_infos select 1) && !(_veh_infos select 2) && !(_veh_infos select 3)) then { _process = true }; //--- Empty
};

_req_time_out = time + (_var_classname select CTI_UNIT_TIME);

//--- Soft limit (skip for empty vehicles)
if !(_process) then { if ((count units (group player))+1 <= CTI_PLAYERS_GROUPSIZE) then { _process = true }};
if !(_process) exitWith { ["SERVER", "Answer_Purchase", [_req_seed, _req_classname, _req_buyer, _factory]] call CTI_CO_FNC_NetSend }; //--- Can't do it but we answer to the server.

//--- Check if the buyer has enough funds to perform this operation
_cost = _var_classname select 2;
if ((_factory getVariable "cti_structure_type") == CTI_FTOWN) then {_cost=_cost*CTI_TOWNS_SHOPS};
if !(_model isKindOf "Man") then { //--- Add the vehicle crew cost if applicable
	_crew = switch (true) do { case (_model isKindOf "Tank"): {"Crew"}; case (_model isKindOf "Air"): {"Pilot"}; default {"Soldier"}};
	_crew = missionNamespace getVariable format["CTI_%1_%2", CTI_P_SideJoined, _crew];

	//--- Ultimately if we're dealing with a sub we may want to use divers unless that our current soldiers are free-diving champions
	if (_model isKindOf "Ship") then {
		if (getText(configFile >> "CfgVehicles" >> _model >> "simulation") == "submarinex") then { _crew = missionNamespace getVariable format["CTI_%1_Diver", CTI_P_SideJoined] };
	};

	_var_crew_classname = missionNamespace getVariable _crew;
	if !(isNil '_var_crew_classname') then {
		for '_i' from 0 to 2 do { if (_veh_infos select _i) then { _cost = _cost + (_var_crew_classname select 2) } };

		if (_veh_infos select 3) then { //--- Turrets
			{ if (count _x == 1) then { _cost = _cost + (_var_crew_classname select 2) } } forEach (_var_classname select CTI_UNIT_TURRETS);
		};
	};
};

_funds = [group (_req_buyer), CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
if (_funds < _cost) exitWith { ["SERVER", "Answer_Purchase", [_req_seed, _req_classname, _req_buyer, _factory]] call CTI_CO_FNC_NetSend; };
// [_req_buyer, CTI_P_SideJoined, -_cost] call CTI_CO_FNC_ChangeFunds; //--- Change the buyer's funds

while { time <= _req_time_out && alive _factory } do { sleep .25 };

if !(alive _factory) exitWith { diag_log "the factory is dead" };
if (_factory in CTI_TOWNS && ! ((_factory getvariable ["cti_town_sideID",-1]) == CTI_P_SideID)) exitWith { ["SERVER", "Answer_Purchase", [_req_seed, _req_classname, _req_buyer, _factory]] call CTI_CO_FNC_NetSend; };
//--- Soft limit (skip for empty vehicles)
if !(_process) then { if ((count units (group player))+1 <= CTI_PLAYERS_GROUPSIZE) then { _process = true }};
if !(_process) exitWith { ["SERVER", "Answer_Purchase", [_req_seed, _req_classname, _req_buyer, _factory]] call CTI_CO_FNC_NetSend }; //--- Can't do it but we answer to the server.

_funds = [group(_req_buyer), CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
if (_funds < _cost) exitWith { ["SERVER", "Answer_Purchase", [_req_seed, _req_classname, _req_buyer, _factory]] call CTI_CO_FNC_NetSend; };
[group(_req_buyer), CTI_P_SideJoined, -_cost] call CTI_CO_FNC_ChangeFunds; //--- Change the buyer's funds

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Client\Functions\Client_OnPurchaseOrderReceived.sqf", format["Purchase order concerning classname [%1] with seed [%2] from [%3] on factory [%4, (%5)] is done. Processing the creation...", _req_classname, _req_seed, _req_buyer, _factory, _factory getVariable "cti_structure_type"]] call CTI_CO_FNC_Log };

//--- Creation.
_var = missionNamespace getVariable [format ["CTI_%1_%2", CTI_P_SideJoined, _factory getVariable "cti_structure_type"],[[0,"Town"],0,0,0,[0,0]]];
_direction = 360 - ((_var select 4) select 0);
_distance = (_var select 4) select 1;

_position = _factory modelToWorld [(sin _direction * _distance), (cos _direction * _distance), 0];
_net = if ((missionNamespace getVariable "CTI_MARKERS_INFANTRY") == 1) then { true } else { false };
_vehicle = objNull;
_units = [];
if (_model isKindOf "Man") then {
	_vehicle = [_model, group player, _position, CTI_P_SideID, _net] call CTI_CO_FNC_CreateUnit;
	[_units, _vehicle] call CTI_CO_FNC_ArrayPush;
} else {
	_vehicle = [_model, _position, _direction + getDir _factory, CTI_P_SideID, (_veh_infos select 4), true, true] call CTI_CO_FNC_CreateVehicle;

	if (_veh_infos select 0 || _veh_infos select 1 || _veh_infos select 2 || _veh_infos select 3) then { //--- Not empty.
		_crew = switch (true) do { case (_model isKindOf "Tank"): {"Crew"}; case (_model isKindOf "Air"): {"Pilot"}; default {"Soldier"}};
		_crew = missionNamespace getVariable format["CTI_%1_%2", CTI_P_SideJoined, _crew];

		//--- Ultimately if we're dealing with a sub we may want to use divers unless that our current soldiers are free-diving champions
		if (_model isKindOf "Ship") then {
			if (getText(configFile >> "CfgVehicles" >> _model >> "simulation") == "submarinex") then { _crew = missionNamespace getVariable format["CTI_%1_Diver", CTI_P_SideJoined] };
		};

		if (_veh_infos select 0) then {
			_unit = [_crew, group player, _position, CTI_P_SideID, _net] call CTI_CO_FNC_CreateUnit;
			_unit moveInDriver _vehicle;
			[_units, _unit] call CTI_CO_FNC_ArrayPush;
		};

		{
			if (count _x == 1 && _veh_infos select 3) then {
				_unit = [_crew, group player, _position, CTI_P_SideID, _net] call CTI_CO_FNC_CreateUnit;
				_unit moveInTurret [_vehicle, (_x select 0)];
				[_units, _unit] call CTI_CO_FNC_ArrayPush;
			}; //--- Turret

			if (count _x == 2) then {
				switch (_x select 1) do {
					case "Gunner": { if (_veh_infos select 1) then { _unit = [_crew, group player, _position, CTI_P_SideID, _net] call CTI_CO_FNC_CreateUnit; _unit moveInTurret [_vehicle, (_x select 0)]; [_units, _unit] call CTI_CO_FNC_ArrayPush; }};
					case "Commander": { if (_veh_infos select 2) then { _unit = [_crew, group player, _position, CTI_P_SideID, _net] call CTI_CO_FNC_CreateUnit; _unit moveInTurret [_vehicle, (_x select 0)]; [_units, _unit] call CTI_CO_FNC_ArrayPush; }};
				};
			};
		} forEach (_var_classname select CTI_UNIT_TURRETS);
	};

	_vehicle addAction ["<t color='#86F078'>Unlock</t>","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player &&alive _target && locked _target == 2'];
	_vehicle addAction ["<t color='#86F078'>Lock</t>","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player &&alive _target && locked _target == 0'];
	if (! (_vehicle isKindOf "Thing") && !( _vehicle isKindOf "StaticWeapon")) then {_vehicle setVariable ["v_keys",[getPlayerUID player,group player],true]};
	player reveal _vehicle;

	//--- Authorize the air loadout depending on the parameters set
	if (_vehicle isKindOf "Air") then {[_vehicle, CTI_P_SideJoined] call CTI_CO_FNC_SanitizeAircraft};

	//--- Sanitize the artillery loadout, mines may lag the server for instance
	if (CTI_ARTILLERY_FILTER == 1) then {if (_model in (missionNamespace getVariable ["CTI_ARTILLERY", []])) then {(_vehicle) call CTI_CO_FNC_SanitizeArtillery}};
	
	//ss83 No despawn----------------------------------
	_script=true;
	if (_model isKindof  'ReammoBox_F') then {_script=false};  //ss83 prevents the crate from being de spawned
	if (_model isKindof  'O_Truck_03_medical_F') then {_script=false};  //ss83 prevents the mobile respawns from despawning
	if (_model isKindof  'B_Truck_01_medical_F') then {_script=false};  //ss83 prevents the mobile respawns from despawning
	if (_model isKindof  'O_Truck_03_repair_F') then {_script=false}; 
	if (_model isKindof  'B_Truck_01_repair_F') then {_script=false}; 
	if (_model isKindof  'O_Truck_03_ammo_F') then {_script=false}; 
	if (_model isKindof  'B_Truck_01_ammo_F') then {_script=false}; 
	if (_model isKindof  'I_Heli_light_03_unarmed_F') then {_script=false}; 
	if (_model isKindof  'O_Heli_Transport_04_medevac_F') then {_script=false};	
		if (_model isKindof  'O_Heli_Transport_04_ammo_F') then {_script=false};	
	if (_model isKindof  'O_Heli_Transport_04_repair_F') then {_script=false};	
	if (_model isKindof  'O_MBT_02_arty_F') then {_script=false};	
	if (_model isKindof  'B_MBT_01_arty_F') then {_script=false};	
	if (_model isKindof  'B_MBT_01_mlrs_F') then {_script=false};	
	
	
	if (_script == "") then {
		["SERVER", "Request_HandleAction", ["empty", [_vehicle]]] call CTI_CO_FNC_NetSend; //--- Ask the server to track our vehicle emptyness
	};
	
	
};

{
	_x setVariable ["cti_ai_order", CTI_ORDER_CLIENT_NONE];
	_x setVariable ["cti_ai_order_pos", [0,0]];
} forEach _units;

if (_script != "" && alive _vehicle) then {
	[_vehicle, CTI_P_SideJoined, _script] spawn CTI_CO_FNC_InitializeCustomVehicle;
	if (_customid > -1) then {_vehicle setVariable ["cti_customid", _customid, true]};
};

//--- Notify the current client
_picture = if ((_var_classname select CTI_UNIT_PICTURE) != "") then {format["<img image='%1' size='2.5'/><br /><br />", _var_classname select CTI_UNIT_PICTURE]} else {""};
hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />%4<t>Your <t color='#ccffaf'>%1</t> has arrived from the <t color='#fcffaf'>%2</t> at grid <t color='#beafff'>%3</t></t>", _var_classname select CTI_UNIT_LABEL, (_var select 0) select 1, mapGridPosition _position, _picture];

//--- send a notice to the server that our order is now complete
["SERVER", "Answer_Purchase", [_req_seed, _req_classname, _req_buyer, _factory]] call CTI_CO_FNC_NetSend;

/*
  # HEADER #
	Script: 		Server\Functions\Server_HandleAIPurchase.sqf
	Alias:			CTI_SE_FNC_HandleAIPurchase
	Description:	Handle an AI purchase request
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013

  # PARAMETERS #
    0	[Number]: The purchase seed
    1	[String]: The purchased unit classname
    2	[Group]: The buyer
    3	[Group]: The group the unit shall belong to
    4	[Object]: The factory
    5	[Side]: The side of the unit

  # RETURNED VALUE #
	None

  # SYNTAX #
	[PURCHASE SEED, UNIT CLASSNAME, BUYER, TARGET, FACTORY, SIDE] spawn CTI_SE_FNC_HandleAIPurchase

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ChangeFunds
	Common Function: CTI_CO_FNC_CreateUnit
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_GetFunds
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_GetVehicleTurrets
	Common Function: CTI_CO_FNC_InitializeCustomVehicle
	Common Function: CTI_CO_FNC_SanitizeAircraft
	Server Function: CTI_SE_FNC_HandleEmptyVehicle
	Server Function: CTI_SE_FNC_OnClientPurchaseComplete

  # EXAMPLE #
    [_req_seed, _req_classname, _req_buyer, _req_target, _factory, _req_side] spawn CTI_SE_FNC_HandleAIPurchase;
*/

private ["_can_afford", "_cost", "_direction", "_distance", "_factory", "_funds", "_model", "_net", "_position", "_req_buyer", "_req_classname", "_req_seed", "_req_side", "_req_target", "_req_time_out", "_script", "_sideID", "_var", "_vehicle", "_var_classname"];

_req_seed = _this select 0;
_req_classname = _this select 1;
_req_buyer = _this select 2;
_req_target = _this select 3;
_factory = _this select 4;
_req_side = _this select 5;


if !((typeName _req_buyer) == "GROUP") then {_req_buyer = group _req_buyer};

//--- First of all, make sure that we don't go "softly" above the AI group size
_process = true;
if (typeName _req_target != "SIDE") then { if ((count units _req_target)+1 > CTI_AI_TEAMS_GROUPSIZE) then {_process = false} };
if !(_process) exitWith {[_req_seed, _req_classname, _req_target, _factory] call CTI_SE_FNC_OnClientPurchaseComplete};

_sideID = (_req_side) call CTI_CO_FNC_GetSideID;
_model = _req_classname;
_var_classname = missionNamespace getVariable _req_classname;
_req_time_out = if !(isNil '_var_classname') then {time + (_var_classname select CTI_UNIT_TIME)} else {5};

//--- Custom vehicle?
_script = _var_classname select CTI_UNIT_SCRIPT;
_customid = -1;
if (typeName (_var_classname select CTI_UNIT_SCRIPT) == "ARRAY") then { _model = (_var_classname select CTI_UNIT_SCRIPT) select 0; _script = (_var_classname select CTI_UNIT_SCRIPT) select 1; _customid = (_var_classname select CTI_UNIT_SCRIPT) select 2};

//--- Then we check if the buyer has enough funds to perform this operation
_cost = _var_classname select 2;
if !(_model isKindOf "Man") then { //--- Add the vehicle crew cost if applicable
	_crew = switch (true) do { case (_model isKindOf "Tank"): {"Crew"}; case (_model isKindOf "Air"): {"Pilot"}; default {"Soldier"}};
	_crew = missionNamespace getVariable format["CTI_%1_%2", _req_side, _crew];

	_var_crew_classname = missionNamespace getVariable _crew;
	if !(isNil '_var_crew_classname') then { _cost = _cost + ((count(_model call CTI_CO_FNC_GetVehicleTurrets)+1) * (_var_crew_classname select 2)) };
};

_funds = [_req_buyer, _req_side] call CTI_CO_FNC_GetFunds;
if (_funds < _cost) exitWith { [_req_seed, _req_classname, _req_target, _factory] call CTI_SE_FNC_OnClientPurchaseComplete };
// [_req_buyer, _req_side, -_cost] call CTI_CO_FNC_ChangeFunds; //--- Change the buyer's funds

_var = missionNamespace getVariable format ["CTI_%1_%2", _req_side, _factory getVariable "cti_structure_type"];
_direction = 360 - ((_var select 4) select 0);
_distance = (_var select 4) select 1;
_position = _factory modelToWorld [(sin _direction * _distance), (cos _direction * _distance), 0];

while { time <= _req_time_out && alive _factory } do { sleep .25 }; //--- Construction...

if !(alive _factory) exitWith { diag_log "the factory is dead" };

_net = if ((missionNamespace getVariable "CTI_MARKERS_INFANTRY") == 1) then { true } else { false };

//--- Condition?
_process = true;
if (_req_classname == format["CTI_Salvager_Independent_%1", _req_side]) then {if (count((_req_side call CTI_CO_FNC_GetSideLogic) getVariable "cti_salvagers") >= CTI_VEHICLES_SALVAGE_INDEPENDENT_MAX) then { _process = false }};

if !(_process) exitWith {[_req_seed, _req_classname, _req_target, _factory] call CTI_SE_FNC_OnClientPurchaseComplete};
if (typeName _req_target != "SIDE") then {if ((count units _req_target) > CTI_AI_TEAMS_GROUPSIZE) exitWith { [_req_seed, _req_classname, _req_target, _factory] call CTI_SE_FNC_OnClientPurchaseComplete }};

_funds = [_req_buyer, _req_side] call CTI_CO_FNC_GetFunds;
if (_funds < _cost) exitWith { [_req_seed, _req_classname, _req_target, _factory] call CTI_SE_FNC_OnClientPurchaseComplete };
[_req_buyer, _req_side, -_cost] call CTI_CO_FNC_ChangeFunds; //--- Change the buyer's funds

if (typeName _req_target == "SIDE") then { _req_target = createGroup _req_side };

_vehicle = objNull;
if (_model isKindOf "Man") then {
	_vehicle = [_model, _req_target, _position, _sideID, _net] call CTI_CO_FNC_CreateUnit;
} else {
	private ["_crew", "_unit"];
	_vehicle = [_model, _position, _direction + getDir _factory, _sideID, true, true, true] call CTI_CO_FNC_CreateVehicle;

	_crew = switch (true) do { case (_model isKindOf "Tank"): {"Crew"}; case (_model isKindOf "Air"): {"Pilot"}; default {"Soldier"}};
	_crew = missionNamespace getVariable format["CTI_%1_%2", _req_side, _crew];

	_unit = [_crew, _req_target, _position, _sideID, _net] call CTI_CO_FNC_CreateUnit;
	_unit moveInDriver _vehicle;

	{
		_unit = [_crew, _req_target, _position, _sideID, _net] call CTI_CO_FNC_CreateUnit;
		_unit moveInTurret [_vehicle, _x];
	} forEach (_model call CTI_CO_FNC_GetVehicleTurrets);

	[_vehicle] spawn CTI_SE_FNC_HandleEmptyVehicle;

	//--- Authorize the air loadout depending on the parameters set
	if (_vehicle isKindOf "Air") then {[_vehicle, _req_side] call CTI_CO_FNC_SanitizeAircraft};
	// _req_target addVehicle _vehicle;
};

if (_script != "" && alive _vehicle) then {
	[_vehicle, _req_side, _script] spawn CTI_CO_FNC_InitializeCustomVehicle;
	if (_customid > -1) then {_vehicle setVariable ["cti_customid", _customid, true]};
};

[_req_seed, _req_classname, _req_target, _factory] call CTI_SE_FNC_OnClientPurchaseComplete;

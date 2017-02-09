/*
  # HEADER #
	Script: 		Server\Functions\Server_SpawnTownOccupation.sqf
	Alias:			CTI_SE_FNC_SpawnTownOccupation
	Description:	This script will spawn the town occupation whenever a threat is
					detected near a town.
					Note that this function can be replaced by another one.
					Keep in mind to keep an identical return format.
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	10-10-2013
	Edited by PR9INICHEK 23-11-2016

  # PARAMETERS #
    0	[Object]: The town
    1	[Side]: The side which hold the town

  # RETURNED VALUE #
	0   [Array]: The created groups
	1   [Array]: The created vehicles

  # SYNTAX #
	[TOWN, SIDE] call CTI_SE_FNC_SpawnTownOccupation

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_ArrayShuffle
	Common Function: CTI_CO_FNC_CreateUnit
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_GetEmptyPosition
	Common Function: CTI_CO_FNC_GetRandomPosition
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideUpgrades
	Common Function: CTI_CO_FNC_ManVehicle
	Server Function: CTI_SE_FNC_HandleEmptyVehicle

  # EXAMPLE #
    [Town0, West] call CTI_SE_FNC_SpawnTownOccupation
	  -> Will spawn West defense forces for Town0
*/

private ["_groups", "_occupation_size", "_pool", "_pool_group_size", "_pool_units", "_positions", "_side", "_sideID", "_teams", "_totalGroups", "_town", "_upgrade", "_value", "_vehicles", "_maxSpawnRange"];

_town = _this select 0;
_side = _this select 1;
_sideID = (_side) call CTI_CO_FNC_GetSideID;
_upgrade = (_side call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TOWNS;
//_upgrade = 10;
_value = _town getVariable "cti_town_value";

_occupation_size = round(_value * _value * CTI_TOWNS_OCCUPATION_GROUPS_RATIO / 1000);
_totalGroups = round(_occupation_size / 2000);
if (_totalGroups<2) then {_totalGroups=_totalGroups+1};
if (_totalGroups>6) then {_totalGroups=5};


// switch value...
_pool_units = [];
_pool_group_size = missionNamespace getVariable "CTI_AI_TEAMS_GROUPSIZE";

//--- Pool data: [<UNIT TYPE>, <PRESENCE>, {<PROBABILITY>}]
switch (true) do {
	case (_value <= 30) : {
		_pool_units = [[["SOLDIER", 4], ["SOLDIER_GL", 2], ["SOLDIERS_AT_LIGHT", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2]],[]];
	};
	case (_value > 30 && _value <= 50) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 2], ["SOLDIERS_AT_LIGHT", 2], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["VEHICLE_MOTORIZED", 1, 30]],
		[["VEHICLE_MECHANIZED", 1, 25]]];
	};
	case (_value > 50 && _value <= 75) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 2], ["SOLDIERS_AT_LIGHT", 2], ["SOLDIER_AA", 1, 65], ["SOLDIER_MEDIC", 2], ["SOLDIER_MG", 2], ["SOLDIER_AR", 2], ["SOLDIERS_ENGINEER", 1, 75], ["SOLDIERS_SNIPERS", 1, 55]],
		[["VEHICLES_LIGHT", 2, 30], ["VEHICLE_APC", 1, 30], ["VEHICLES_AA_LIGHT", 1, 20]]];
	};
	case (_value > 75 && _value <= 100) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 2], ["SOLDIERS_AT_LIGHT", 2], ["SOLDIERS_AT_MEDIUM", 1, 75], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 70], ["SOLDIERS_SNIPERS", 1, 70]],
		[["VEHICLES_LIGHT", 2, 33], ["VEHICLES_MEDIUM", 1, 30],["VEHICLES_HEAVY", 1, 0],["VEHICLES_AA_LIGHT", 1, 20]]];
	};
	case (_value > 100 && _value <= 150) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 1], ["SOLDIERS_AT_LIGHT", 2, 80], ["SOLDIERS_AT_HEAVY", 2, 50], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 70], ["SOLDIERS_SPECOPS", 1]],
		[["VEHICLES_LIGHT", 1, 35],["SOLDIERS_SNIPERS", 1, 75],["VEHICLES_MEDIUM", 1, 33],["VEHICLES_HEAVY", 1, 0],["VEHICLES_AA_LIGHT", 1, 22]]];
	};
	case (_value > 150 && _value <= 200) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 1], ["SOLDIERS_AT_LIGHT", 2, 70], ["SOLDIERS_AT_MEDIUM", 2, 65], ["SOLDIERS_AT_HEAVY", 2, 60], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 75], ["SOLDIERS_SPECOPS", 1], ["SOLDIERS_SNIPERS", 1, 80]],
		[["VEHICLES_LIGHT", 1, 40],["VEHICLES_MEDIUM", 1, 33],["VEHICLES_HEAVY", 1, 0],["VEHICLES_AA_LIGHT", 1, 25]]];
	};
	case (_value > 200 && _value <= 250) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 1], ["SOLDIERS_AT_LIGHT", 2, 55], ["SOLDIERS_AT_MEDIUM", 2, 65], ["SOLDIERS_AT_HEAVY", 2, 65], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 75], ["SOLDIERS_SPECOPS", 1], ["SOLDIERS_SNIPERS", 1, 85]],
		[["VEHICLES_LIGHT", 1, 37],["VEHICLES_MEDIUM", 1, 35], ["VEHICLES_HEAVY", 1, 0], ["VEHICLES_AA_LIGHT", 1, 27]]];
	};
	case (_value > 250 && _value <= 300) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 1], ["SOLDIERS_AT_LIGHT", 2, 50],["SOLDIERS_AT_MEDIUM", 2, 70], ["SOLDIERS_AT_HEAVY", 2, 70], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 75], ["SOLDIERS_SPECOPS", 1], ["SOLDIERS_SNIPERS", 1, 90]],
		[["VEHICLES_LIGHT", 1, 35],["VEHICLES_MEDIUM", 1, 37],["VEHICLES_HEAVY", 1, 10],["VEHICLES_AA_LIGHT", 1, 15]]];
	};
	case (_value > 300 && _value <= 350) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 1], ["SOLDIERS_AT_LIGHT", 2, 45],["SOLDIERS_AT_MEDIUM", 2, 75], ["SOLDIERS_AT_HEAVY", 2, 75], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 75], ["SOLDIERS_SPECOPS", 1], ["SOLDIERS_SNIPERS", 1, 95]],
		[["VEHICLES_LIGHT", 1, 33],["VEHICLES_MEDIUM", 1, 40],["VEHICLES_HEAVY", 1, 15],["VEHICLES_AA_LIGHT", 1, 20]]];
	};
	case (_value > 350 && _value <= 400) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 1], ["SOLDIERS_AT_LIGHT", 2, 40], ["SOLDIERS_AT_MEDIUM", 1, 80], ["SOLDIERS_AT_HEAVY", 2, 75], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 75], ["SOLDIERS_SPECOPS", 1], ["SOLDIERS_SNIPERS", 1]],
		[["VEHICLES_LIGHT", 1, 33], ["VEHICLES_MEDIUM", 1, 35], ["VEHICLES_HEAVY", 1, 20], ["VEHICLES_AA_LIGHT", 1, 25]]];
	};
	case (_value > 400 && _value <= 450) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 1], ["SOLDIERS_AT_LIGHT", 2, 37], ["SOLDIERS_AT_MEDIUM", 1, 82], ["SOLDIERS_AT_HEAVY", 2, 75], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 75], ["SOLDIERS_SPECOPS", 1], ["SOLDIERS_SNIPERS", 1]],
		[["VEHICLES_LIGHT", 1, 30], ["VEHICLES_MEDIUM", 1, 30], ["VEHICLES_HEAVY", 1, 25], ["VEHICLES_AA_LIGHT", 1, 30]]];
	};
	case (_value > 450) : {
		_pool_units = [[["SOLDIER", 3], ["SOLDIER_GL", 1], ["SOLDIERS_AT_LIGHT", 2, 35], ["SOLDIERS_AT_MEDIUM", 1, 84], ["SOLDIERS_AT_HEAVY", 2, 75], ["SOLDIER_AA", 1], ["SOLDIER_MEDIC", 2], ["SOLDIERS_MG", 2], ["SOLDIERS_ENGINEER", 1, 75], ["SOLDIERS_SPECOPS", 1], ["SOLDIERS_SNIPERS", 1]],
		[["VEHICLES_LIGHT", 1, 27], ["VEHICLES_MEDIUM", 1, 20], ["VEHICLES_HEAVY", 1, 30], ["VEHICLES_AA_LIGHT", 1, 30]]];
	};
};

//--- Parse properly the pool.
_pool_u = [];
{
	_unit = _x select 0;
	_presence = _x select 1;
	if !(isNil {missionNamespace getVariable format["%1_%2",_side, _unit]}) then {
		_probability = if (count _x > 2) then {_x select 2} else {100};
		//--- Get content before parsing (don't alter the source!)
		_content = +(missionNamespace getVariable format["%1_%2",_side, _unit]);

		_load = false;
		switch (typeName (_content select 0)) do {
			case "ARRAY": { //---  Multiple content
				//--- Sligty different here, we do a deep check.
				{
					_upgrade_required = _x select 1;
					if (_upgrade < _upgrade_required) then {_content set [_forEachIndex, -1]};
				} forEach +_content;

				_content = _content - [-1];

				if (count _content > 0) then { //--- We have some content
					//--- Sanitize
					_sanitized = [];
					{_sanitized pushBack (_x select 0)} forEach _content;

					_content = _sanitized; //--- Replace if altered
					// if (_altered) then {_content set [0, _content]}; //--- Replace if altered
					_load = true;
				};
			};
			case "STRING": { //--- Simple content
				_upgrade_required = _content select 1;
				if (_upgrade >= _upgrade_required) then {_content = _content select 0; _load = true};
			};
		};

		if (_load) then { //--- Finally load if available
			for '_i' from 1 to _presence do { _pool_u pushBack [_content, _probability] };
		};
	};
} forEach (_pool_units select 0);
_pool_u = _pool_u call CTI_CO_FNC_ArrayShuffle;

_pool_v = [];
{
	_unit = _x select 0;
	_presence = _x select 1;
	if !(isNil {missionNamespace getVariable format["%1_%2",_side, _unit]}) then {
		_probability = if (count _x > 2) then {_x select 2} else {100};
		//--- Get content before parsing (don't alter the source!)
		_content = +(missionNamespace getVariable format["%1_%2",_side, _unit]);

		_load = false;
		switch (typeName (_content select 0)) do {
			case "ARRAY": { //---  Multiple content
				//--- Sligty different here, we do a deep check.
				{
					_upgrade_required = _x select 1;
					if (_upgrade < _upgrade_required) then {_content set [_forEachIndex, -1]};
				} forEach +_content;

				_content = _content - [-1];

				if (count _content > 0) then { //--- We have some content
					//--- Sanitize
					_sanitized = [];
					{_sanitized pushBack (_x select 0)} forEach _content;

					_content = _sanitized; //--- Replace if altered
					// if (_altered) then {_content set [0, _content]}; //--- Replace if altered
					_load = true;
				};
			};
			case "STRING": { //--- Simple content
				_upgrade_required = _content select 1;
				if (_upgrade >= _upgrade_required) then {_content = _content select 0; _load = true};
			};
		};

		if (_load) then { //--- Finally load if available
			for '_i' from 1 to _presence do { _pool_v pushBack [_content, _probability]  };
		};
	};
} forEach (_pool_units select 1);

_pool_v = _pool_v call CTI_CO_FNC_ArrayShuffle;

_pool=_pool_v+_pool_u;

if (count _pool < 1) exitWith {[[],[],[]]};



//--- Compose the pools.
_teams = [];
for '_i' from 1 to _totalGroups do {
	_units = [(missionNamespace getVariable format["%1_SOLDIER_SQUADLEADER", _side]) select 0];

	// _pool_group_size_current = _pool_group_size;
	_pool_group_size_current = _pool_group_size-1;
	_ci=0;
	while {_pool_group_size_current > 0} do {
		_picked = _pool select _ci;

		_unit = _picked select 0;
		_probability = _picked select 1;

		_can_use = true;
		if (_probability != 100) then {
			if (random 100 > _probability) then { _can_use = false };
		};

		if (_can_use) then {
			if (typeName _unit == "ARRAY") then { _unit = _unit select floor(random count _unit) };
			_units pushBack _unit;

			_pool_group_size_current = _pool_group_size_current - 1;
		};
		_ci=_ci+1;
	};

	_teams pushBack _units;
};

diag_log format ["OCCUPATION POOL Composer for %1 (value %2)", _town getVariable "cti_town_name", _value];

// _vehicles = [];
_groups = [];
_positions = [];
{
	//diag_log _x;

	_maxSpawnRange = CTI_TOWNS_OCCUPATION_SPAWN_RANGE;
	if (name _town == "Town29") then {_maxSpawnRange = 25};	//--- Makrynisi
	if (name _town == "Town9") then {_maxSpawnRange = 125};	//--- Telos
	_position = [getPos _town, 25, _maxSpawnRange] call CTI_CO_FNC_GetRandomPosition;

//	_position = [getPos _town, 25, CTI_TOWNS_OCCUPATION_SPAWN_RANGE] call CTI_CO_FNC_GetRandomPosition;
	_position = [_position, 50] call CTI_CO_FNC_GetEmptyPosition;
	_road_pos=(_position nearRoads 100);
	if (count _road_pos > 0) then {_position = _road_pos select floor random (count _road_pos);};
	_positions pushBack _position;

	_group = createGroup _side;
	_group setVariable ["cti_server_group", str _side];
	_groups pushBack _group;

	/*
	{
		if (_x isKindOf "Man") then {
			[_x, _group, [_position, 2, 15] call CTI_CO_FNC_GetRandomPosition, _sideID] call CTI_CO_FNC_CreateUnit;
		} else {
			_crew = switch (true) do {
				case (_x isKindOf "Tank"): { missionNamespace getVariable format["%1_SOLDIER_CREW", _side] };
				case (_x isKindOf "Air"): { missionNamespace getVariable format["%1_SOLDIER_PILOT", _side] };
				default { missionNamespace getVariable format["%1_SOLDIER", _side] };
			};
			if (typeName _crew == "ARRAY") then {_crew = _crew select 0};
			_vehicle = [_x, [_position, 2, 15] call CTI_CO_FNC_GetRandomPosition, random 360, _sideID, false, false, true] call CTI_CO_FNC_CreateVehicle;
			[_vehicle, _crew, _group, _sideID] call CTI_CO_FNC_ManVehicle;
			_vehicles pushback _vehicle;
			[_vehicle] spawn CTI_SE_FNC_HandleEmptyVehicle;
		};
	} forEach _x;

	[_town, _group, _sideID] execFSM "Server\FSM\town_patrol.fsm";*/
} forEach _teams;

[_teams, _groups, _positions]
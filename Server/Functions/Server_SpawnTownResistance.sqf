/*
  # HEADER #
	Script: 		Server\Functions\Server_SpawnTownResistance.sqf
	Alias:			CTI_SE_FNC_SpawnTownResistance
	Description:	This script will spawn the town resistance whenever a threat is
					detected near a town.
					Note that this function can be replaced by another one.
					Keep in mind to keep an identical return format.
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	23-09-2013
	Edited by PR9INICHEK 23-11-2016

  # PARAMETERS #
    0	[Object]: The town

  # RETURNED VALUE #
	0   [Array]: The created groups
	1   [Array]: The created vehicles

  # SYNTAX #
	(TOWN) call CTI_SE_FNC_SpawnTownResistance

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_ArrayShuffle
	Common Function: CTI_CO_FNC_CreateUnit
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_GetEmptyPosition
	Common Function: CTI_CO_FNC_GetRandomPosition
	Common Function: CTI_CO_FNC_ManVehicle
	Server Function: CTI_SE_FNC_HandleEmptyVehicle

  # EXAMPLE #
    (Town0) call CTI_SE_FNC_SpawnTownResistance
	  -> Will spawn Resistance defense forces for Town0
*/

private ["_groups", "_pool", "_pool_group_size", "_pool_units", "_positions", "_resistanceSize", "_teams", "_totalGroups", "_town", "_value", "_vehicles", "_maxSpawnRange"];
_town = _this;

_value = _town getVariable "cti_town_value";
_resistanceSize = round(_value * _value * CTI_TOWNS_RESISTANCE_GROUPS_RATIO / 1000);
_totalGroups = round(_resistanceSize / 2000);
if (_totalGroups<2) then {_totalGroups=_totalGroups+1};
if (_totalGroups>6) then {_totalGroups=6};


// switch value...
_pool_units = [];
_pool_group_size = missionNamespace getVariable "CTI_AI_TEAMS_GROUPSIZE";


//--- Pool data: [<UNIT TYPE>, <PRESENCE>, {<PROBABILITY>}]
switch (true) do {
	case (_value <= 30) : {
		_pool_units = [[["GUER_SOLDIER", 4], ["GUER_SOLDIER_GL", 2], ["GUER_SOLDIERS_AT_LIGHT", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2]],[]];
	};
	case (_value > 30 && _value <= 50) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 2], ["GUER_SOLDIERS_AT_LIGHT", 2], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2]],
		[["GUER_VEHICLES_LIGHT", 1, 30], ["GUER_VEHICLES_MEDIUM", 1, 0], ["GUER_VEHICLES_HEAVY", 1, 0]]];
	};
	case (_value > 50 && _value <= 75) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 2], ["GUER_SOLDIERS_AT_LIGHT", 2], ["GUER_SOLDIER_AA", 1, 65], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIER_MG", 2], ["GUER_SOLDIER_AR", 2], ["GUER_SOLDIERS_ENGINEER", 1, 75], ["GUER_SOLDIER_MARKSMAN", 1, 50]],
		[["GUER_VEHICLES_LIGHT", 1, 30], ["GUER_VEHICLES_MEDIUM", 1, 0], ["GUER_VEHICLES_HEAVY", 1, 0]]];
	};
	case (_value > 75 && _value <= 100) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 2], ["GUER_SOLDIERS_AT_LIGHT", 2], ["GUER_SOLDIERS_AT_MEDIUM", 1, 75], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 70], ["GUER_SOLDIER_MARKSMAN", 1, 75]],
		[["GUER_VEHICLES_LIGHT", 1, 30], ["GUER_VEHICLES_MEDIUM", 1, 0], ["GUER_VEHICLES_HEAVY", 1, 0]]];
	};
	case (_value > 100 && _value <= 150) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 1], ["GUER_SOLDIERS_AT_LIGHT", 2, 80], ["GUER_SOLDIERS_AT_HEAVY", 2, 50], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 70], ["GUER_SOLDIERS_SPECOPS", 1], ["GUER_SOLDIER_MARKSMAN", 1]],
		[["GUER_VEHICLES_LIGHT", 1, 30], ["GUER_VEHICLES_MEDIUM", 1, 25], ["GUER_VEHICLES_HEAVY", 1, 0]]];
	};
	case (_value > 150 && _value <= 200) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 1], ["GUER_SOLDIERS_AT_LIGHT", 2, 70], ["GUER_SOLDIERS_AT_MEDIUM", 2, 65], ["GUER_SOLDIERS_AT_HEAVY", 2, 60], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 75], ["GUER_SOLDIERS_SPECOPS", 1], ["GUER_SOLDIER_MARKSMAN", 2]],
		[["GUER_VEHICLES_LIGHT", 1, 40], ["GUER_VEHICLES_MEDIUM", 1, 30], ["GUER_VEHICLES_HEAVY", 1, 0]]];
	};
	case (_value > 200 && _value <= 250) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 1], ["GUER_SOLDIERS_AT_LIGHT", 2, 55], ["GUER_SOLDIERS_AT_MEDIUM", 2, 65], ["GUER_SOLDIERS_AT_HEAVY", 2, 65], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 75], ["GUER_SOLDIERS_SPECOPS", 1], ["GUER_SOLDIER_MARKSMAN", 3]],
		[["GUER_VEHICLES_LIGHT", 1, 50], ["GUER_VEHICLES_MEDIUM", 1, 35], ["GUER_VEHICLES_HEAVY", 1, 0]]];
	};
	case (_value > 250 && _value <= 300) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 1], ["GUER_SOLDIERS_AT_LIGHT", 2, 50], ["GUER_SOLDIERS_AT_MEDIUM", 2, 70], ["GUER_SOLDIERS_AT_HEAVY", 2, 70], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 75], ["GUER_SOLDIERS_SPECOPS", 1], ["GUER_SOLDIERS_SNIPERS", 1, 90]],
		[["GUER_VEHICLES_LIGHT", 1, 50], ["GUER_VEHICLES_MEDIUM", 1, 40], ["GUER_VEHICLES_HEAVY", 1, 5]]];
	};
	case (_value > 300 && _value <= 350) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 1], ["GUER_SOLDIERS_AT_LIGHT", 2, 45], ["GUER_SOLDIERS_AT_MEDIUM", 2, 75], ["GUER_SOLDIERS_AT_HEAVY", 2, 75], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 75], ["GUER_SOLDIERS_SPECOPS", 1], ["GUER_SOLDIERS_SNIPERS", 1, 95]],
		[["GUER_VEHICLES_LIGHT", 1, 40], ["GUER_VEHICLES_MEDIUM", 1, 45], ["GUER_VEHICLES_HEAVY", 1, 10]]];
	};
	case (_value > 350 && _value <= 400) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 1], ["GUER_SOLDIERS_AT_LIGHT", 2, 40], ["GUER_SOLDIERS_AT_MEDIUM", 1, 80], ["GUER_SOLDIERS_AT_HEAVY", 2, 75], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 75], ["GUER_SOLDIERS_SPECOPS", 1], ["GUER_SOLDIERS_SNIPERS", 1]],
		[["GUER_VEHICLES_LIGHT", 1, 30], ["GUER_VEHICLES_MEDIUM", 1, 40], ["GUER_VEHICLES_HEAVY", 1, 15]]];
	};
	case (_value > 400 && _value <= 450) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 1], ["GUER_SOLDIERS_AT_LIGHT", 2, 37], ["GUER_SOLDIERS_AT_MEDIUM", 1, 82], ["GUER_SOLDIERS_AT_HEAVY", 2, 75], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 75], ["GUER_SOLDIERS_SPECOPS", 1], ["GUER_SOLDIERS_SNIPERS", 1]],
		[["GUER_VEHICLES_LIGHT", 1, 20], ["GUER_VEHICLES_MEDIUM", 1, 35], ["GUER_VEHICLES_HEAVY", 1, 25]]];
	};
	case (_value > 450) : {
		_pool_units = [[["GUER_SOLDIER", 3], ["GUER_SOLDIER_GL", 1], ["GUER_SOLDIERS_AT_LIGHT", 2, 35], ["GUER_SOLDIERS_AT_MEDIUM", 1, 84], ["GUER_SOLDIERS_AT_HEAVY", 2, 75], ["GUER_SOLDIER_AA", 1], ["GUER_SOLDIER_MEDIC", 2], ["GUER_SOLDIERS_MG", 2], ["GUER_SOLDIERS_ENGINEER", 1, 75], ["GUER_SOLDIERS_SPECOPS", 1], ["GUER_SOLDIERS_SNIPERS", 1]],
		[["GUER_VEHICLES_LIGHT", 1, 15], ["GUER_VEHICLES_MEDIUM", 1, 30], ["GUER_VEHICLES_HEAVY", 1, 30]]];
	};
};

//--- Parse properly the pool.
_pool_u = [];
{
	_unit = _x select 0;
	_presence = _x select 1;
	if !(isNil {missionNamespace getVariable _unit}) then {
		for '_i' from 1 to _presence do { _pool_u pushBack [missionNamespace getVariable _unit, if (count _x > 2) then {_x select 2} else {100}] };
	};
} forEach (_pool_units select 0);
_pool_u = _pool_u call CTI_CO_FNC_ArrayShuffle;
_pool_v = [];

{
	_unit = _x select 0;
	_presence = _x select 1;
	if !(isNil {missionNamespace getVariable _unit}) then {
		for '_i' from 1 to _presence do { _pool_v pushBack [missionNamespace getVariable _unit, if (count _x > 2) then {_x select 2} else {100}]};
	};
} forEach (_pool_units select 1);
_pool_v =_pool_v call CTI_CO_FNC_ArrayShuffle;

//--- Shuffle!
_pool = _pool_v + _pool_u;
//SM_LOG= _pool;

//--- Compose the pools.
_teams = [];
for '_i' from 1 to _totalGroups do {
	//_units = [GUER_SOLDIER_SQUADLEADER];
	_units = [];
	 _pool_group_size_current = _pool_group_size;
	//_pool_group_size_current = _pool_group_size-1;
	_ci=0;
	while {_pool_group_size_current > 0} do {

		_picked = _pool select _ci;

		_unit = _picked select 0;
		_probability = _picked select 1;

		_can_use = true;
		if (_probability != 100) then {
			if (random 100 > (_probability)) then { _can_use = false };
		};
		//diag_log [_unit,_probability,_can_use];
		if (_can_use) then {
			if (typeName _unit == "ARRAY") then { _unit = _unit select floor(random count _unit) };
			_units pushBack _unit;

			_pool_group_size_current = _pool_group_size_current - 1;
		};
		_ci=_ci+1;
	};

	_teams pushBack _units;
};

//todo: calculate group size (don't go over the limit if possible).
diag_log format ["POOL Composer for %1 (value %2)", _town getVariable "cti_town_name", _value];

// _vehicles = [];
_groups = [];
_positions = [];
{
	//diag_log _x;

	_maxSpawnRange = CTI_TOWNS_RESISTANCE_SPAWN_RANGE;
	if (name _town == "Town29") then {_maxSpawnRange = 50;};	//--- Makrynisi
	if (name _town == "Town9") then {_maxSpawnRange = 150;};	//--- Telos
	_position = [getPos _town, 25, _maxSpawnRange] call CTI_CO_FNC_GetRandomPosition;

//	_position = [getPos _town, 25, CTI_TOWNS_RESISTANCE_SPAWN_RANGE] call CTI_CO_FNC_GetRandomPosition;
	_position = [_position, 50] call CTI_CO_FNC_GetEmptyPosition;
	_road_pos=(_position nearRoads 100);
	if (count _road_pos > 0) then {_position = _road_pos select floor random (count _road_pos);};
	_positions pushBack _position;

	_group = createGroup resistance;
	_group setVariable ["cti_server_group", str (side _group)];
	_groups pushBack _group;

} forEach _teams;

[_teams, _groups, _positions]
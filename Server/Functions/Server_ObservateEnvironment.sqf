/*
  # HEADER #
	Script: 		Server\Functions\Server_ObservateEnvironment.sqf
	Alias:			CTI_SE_FNC_ObservateEnvironment
	Description:	Perform an environment observation for a given group
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013
	
  # PARAMETERS #
    0	[Side]: The side of the group
    1	[Group]: The given group
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, GROUP] call CTI_SE_FNC_ObservateEnvironment
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideGroups
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_GetSideStructures
	Common Function: CTI_CO_FNC_IsGroupPlayable
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    [CTI_P_SideJoined, group player] call CTI_SE_FNC_ObservateEnvironment;
	  -> Perform a situation awareness scan around the player and it's units
*/

private ["_group", "_groupisplayable", "_side", "_side_enemy", "_side_logic", "_spotted_base", "_spotted_units", "_spotted_structure", "_spotted_unit", "_structures", "_value"];

_side = _this select 0;
_group = _this select 1;

_side_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_side_enemy = ([east, west] - [_side]) select 0;
_structures = (_side_enemy call CTI_CO_FNC_GetSideStructures) + [_side_enemy call CTI_CO_FNC_GetSideHQ];
_groupisplayable = _group call CTI_CO_FNC_IsGroupPlayable;

//--- Sanitize a bit to avoid ending up with a thousand crap in the array
_spotted_units = _side_logic getVariable "cti_spotted_units";
{if !(alive _x) then {_spotted_units set [_forEachIndex, objNull]}} forEach +_spotted_units;
_spotted_units = _spotted_units - [objNull];
_side_logic setVariable ["cti_spotted_units", _spotted_units];

_spotted_base = _side_logic getVariable "cti_spotted_structures";
{if !(alive _x) then {_spotted_base set [_forEachIndex, objNull]}} forEach +_spotted_base;
_spotted_base = _spotted_base - [objNull];
_side_logic setVariable ["cti_spotted_structures", _spotted_base];

_spotted_unit = objNull;
_spotted_structure = objNull;

//--- Base
{
	if (!(_x in _spotted_base) && alive _x) then {
		_value = 1;
		if (_groupisplayable) then {_value = if (leader _group distance _x < 400) then {0.5} else {0.75}};
		if (leader _group knowsAbout _x >= _value) then {_spotted_structure = _x};
	};
	if !(isNull _spotted_structure) exitWith {};
} forEach _structures;

//--- Units
{
	{
		if (!(_x in _spotted_units) && alive _x) then {
			_value = 1.25;
			if (_groupisplayable) then {_value = if (leader _group distance _x < 400) then {0.5} else {0.9}};
			if (leader _group knowsAbout _x >= _value) then {_spotted_unit = _x};
		};
		if !(isNull _spotted_unit) exitWith {};
	} forEach units _x;
	if !(isNull _spotted_unit) exitWith {};
} forEach (_side_enemy call CTI_CO_FNC_GetSideGroups);

//--- Reveal?
{
	_what = _x select 0;
	if (alive _what) then {
		_last_report = _group getVariable (_x select 2);
		if (isNil '_last_report') then {_last_report = -1000};

		if (time - _last_report > (_x select 1)) then {
			[["CLIENT", _side], "Client_OnSpottedTargetReceived", [getPos _what, _x select 3, leader _group]] call CTI_CO_FNC_NetSend;
			_group setVariable [_x select 2, time];
			_side_logic setVariable [_x select 4, (_side_logic getVariable (_x select 4)) + [_what]];
		};
	};
} forEach [[_spotted_structure, CTI_AI_TEAMS_OBSERVATION_BASE_DELAY, "cti_spotted_lastbasereport", "base", "cti_spotted_structures"], [_spotted_unit, CTI_AI_TEAMS_OBSERVATION_UNIT_DELAY, "cti_spotted_lastunitreport", "unit", "cti_spotted_units"]];
/*
  # HEADER #
	Script: 		Common\Functions\Common_ManVehicle.sqf
	Alias:			CTI_CO_FNC_ManVehicle
	Description:	Man the commandeable positions of a vehicles + turrets
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Object]: The vehicle
    1	[String]: The crew classname to use
    2	[Group]: The group of the crew
    3	[Integer]: The Side ID of the vehicle
	
  # RETURNED VALUE #
	[Array]: The created crew
	
  # SYNTAX #
	[VEHICLE, CREW, GROUP, SIDE ID] call CTI_CO_FNC_ManVehicle
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_CreateUnit
	
  # EXAMPLE #
    _crew = [tank1, "B_crew_F", group player, CTI_P_SideID] call CTI_CO_FNC_ManVehicle
	  -> Assuming tank1 is an empty tank, a crew will be spawned in it and will join the player's group
*/

private ["_crew", "_config", "_config_sub", "_group", "_net", "_position", "_sideID", "_turrets", "_units", "_vehicle"];

_vehicle = _this select 0;
_crew = _this select 1;
_group = _this select 2;
_sideID = _this select 3;

_turrets = [];
_config = configFile >> "CfgVehicles" >> typeOf _vehicle >> "turrets";
for '_i' from 0 to (count _config)-1 do {
	_turret_main = _config select _i;
	_turrets = _turrets + [[_i]];
	
	_config_sub = _turret_main >> "turrets";
	for '_j' from 0 to (count _config_sub) -1 do {
		_turret_sub = _config_sub select _j;
		_turrets = _turrets + [[_i, _j]];
	};
};

// _turrets
_units = [];
_position = getPos _vehicle;
_position = [(_position select 0) + 5, (_position select 1) + 5, 0];

_net = if ((missionNamespace getVariable "CTI_MARKERS_INFANTRY") == 1 && _sideID in [CTI_WEST_ID, CTI_EAST_ID]) then { true } else { false };

if (_vehicle emptyPositions "driver" > 0) then {
	_unit = [_crew, _group, _position, _sideID, _net] call CTI_CO_FNC_CreateUnit;
	_unit moveInDriver _vehicle;
	_units = _units + [_unit];
};

{
	_unit = [_crew, _group, _position, _sideID, _net] call CTI_CO_FNC_CreateUnit;
	_unit moveInTurret [_vehicle, _x];
	_units = _units + [_unit];
} forEach _turrets;

_units

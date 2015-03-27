/*
  # HEADER #
	Script: 		Common\Functions\Common_GetTeamVehicles.sqf
	Alias:			CTI_CO_FNC_GetTeamVehicles
	Description:	Get the vehicles in use by a group
	Author: 		Benny, adapted from Mike Melvin
	Creation Date:	18-09-2013
	Revision Date:	17-10-2013
	
  # PARAMETERS #
    0	[Group]: The group
    1	[Boolean]: Retrieve only mobile vehicle (false for all)
    2	{Optionnal} [Object]: Exclude vehicles further than the entity (150 meters by default)
    3	{Optionnal} [Number]: Define the exclusion range
    4	{Optionnal} [Boolean]: Define whether non-local vehicles shall be skipped or not
	
  # RETURNED VALUE #
	[Array]: The current side upgrades
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideUpgrades
	
  # EXAMPLE #
    _upgrades = (West) call CTI_CO_FNC_GetSideUpgrades
	  -> Return the current west upgrades levels
*/

private["_center", "_group", "_local", "_move", "_range", "_vehicle", "_vehicles"];

_group = _this select 0;
_move = _this select 1;
_center = if (count _this > 2) then {_this select 2} else {objNull};
_range = if (count _this > 3) then {_this select 3} else {150};
_local = if (count _this > 4) then {_this select 4} else {false};

_vehicles = [];

{
	_vehicle = vehicle _x;
	
	if (_x != _vehicle && !(_vehicle in _vehicles)) then {_vehicles = _vehicles + [_vehicle]};
	if (_move && (!canMove _vehicle && !(_vehicle isKindOf "StaticWeapon"))) then {_vehicles = _vehicles - [_vehicle]};
	if (!isNull _center && _center distance _vehicle > _range) then {_vehicles = _vehicles - [_vehicle]};
	if (_local && !local _vehicle) then {_vehicles = _vehicles - [_vehicle]};
} forEach units _group;

_vehicles
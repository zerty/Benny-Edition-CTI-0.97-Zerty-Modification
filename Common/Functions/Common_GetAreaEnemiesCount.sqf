/*
  # HEADER #
	Script: 		Common\Functions\Common_GetAreaEnemiesCount.sqf
	Alias:			CTI_CO_FNC_GetAreaEnemiesCount
	Description:	Get the enemies of a side in a list
					We asume that resistance is hostile to all
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array]: A list of entities
    1	[Side]: The "friendly" side
    2	{Optionnal} [Array]: The sides to ignore
	
  # RETURNED VALUE #
	[Integer]: The amount of enemies
	
  # SYNTAX #
	[LIST, FRIENDLY SIDE] call CTI_CO_FNC_GetAreaEnemiesCount
	[LIST, FRIENDLY SIDE, IGNORED SIDES] call CTI_CO_FNC_GetAreaEnemiesCount
	
  # EXAMPLE #
    _list = [WestLoon1, EastLoon1, GuerLoon1];
	[_list, West] call CTI_CO_FNC_GetAreaEnemiesCount; -> 2
	[_list, West, [East]] call CTI_CO_FNC_GetAreaEnemiesCount; -> 1
	[_list, West, [East, Resistance]] call CTI_CO_FNC_GetAreaEnemiesCount; -> 0
*/

private ["_count","_sides","_sideFriendly","_sideIgnored","_units"];

_units = _this select 0;
_sideFriendly = _this select 1;
_sideIgnored = if (count _this > 2) then {_this select 2} else {[]};

_sides = [west, east, resistance, sideEnemy] - [_sideFriendly] - _sideIgnored;
_count = 0;

{_count = _count + (_x countSide _units)} forEach _sides;

_count
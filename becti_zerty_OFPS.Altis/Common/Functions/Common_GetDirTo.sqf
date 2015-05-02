/*
  # HEADER #
	Script: 		Common\Functions\Common_GetDirTo.sqf
	Alias:			CTI_CO_FNC_GetDirTo
	Description:	Get the direction between two objects
	Author: 		Benny, adapted from Mike Melvin
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array/Object]: The first object
    0	[Array/Object]: The second object
	
  # RETURNED VALUE #
	[Integer]: The direction
	
  # SYNTAX #
	[POSITION, POSITION] call CTI_CO_FNC_GetDirTo
	
  # EXAMPLE #
    _direction = [player, Town1] call CTI_CO_FNC_GetDirTo
	  -> Assuming player is straigh North of Town1 then: 180
*/

private ["_pos1","_pos2","_ret"];

_pos1 = _this select 0;
_pos2 = _this select 1;

if(typename _pos1 == "OBJECT") then {_pos1 = getpos _pos1};
if(typename _pos2 == "OBJECT") then {_pos2 = getpos _pos2};

_ret = ((_pos2 select 0) - (_pos1 select 0)) atan2 ((_pos2 select 1) - (_pos1 select 1));
_ret = _ret % 360;
_ret
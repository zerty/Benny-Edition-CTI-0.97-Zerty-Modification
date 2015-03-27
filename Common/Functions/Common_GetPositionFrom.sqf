/*
  # HEADER #
	Script: 		Common\Functions\Common_GetPositionFrom.sqf
	Alias:			CTI_CO_FNC_GetPositionFrom
	Description:	Get a position from a center according to a distance and a direction
	Author: 		Benny, adapted from Mike Melvin
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Array/Object]: The center
    1	[Number]: The distance from the center
    2	[Array/Object/Number]: The direction from the center
	
  # RETURNED VALUE #
	[Array]: The expected position
	
  # SYNTAX #
	[CENTER, DISTANCE, DIRECTION] call CTI_CO_FNC_GetPositionFrom
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetDirTo
	
  # EXAMPLE #
    _position = [player, 50, direction player] call CTI_CO_FNC_GetPositionFrom
	  -> Will return the position 50 meters ahead of where the player is facing
    _position = [player, 50, 0] call CTI_CO_FNC_GetPositionFrom
	  -> Will return the position 50 meters straight north of the player
*/

private["_destination","_distance","_direction","_position"];

_position = _this select 0;
_distance = _this select 1;
_direction = _this select 2;

if (typeName _position != "ARRAY") then {_position = position _position};
if (typeName _direction != "SCALAR") then {_direction = [_position, _direction] call CTI_CO_FNC_GetDirTo};

[(_position select 0)+((sin _direction)*_distance),(_position select 1)+((cos _direction)*_distance),(_position select 2)]
/*
  # HEADER #
	Script: 		Common\Functions\Common_GetRandomPosition.sqf
	Alias:			CTI_CO_FNC_GetRandomPosition
	Description:	Get a random position which is not "water" around a center
					Note that the position may not be "empty" or "flat", use
					CTI_CO_FNC_GetEmptyPosition to detect a safe position after
					this one
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Array/Object]: The center
    1	[Number]: The minimum radius
    2	[Number]: The maximum radius

  # RETURNED VALUE #
	[Array]: A random position

  # SYNTAX #
	[CENTER, RADIUS MIN, RADIUS MAX] call CTI_CO_FNC_GetRandomPosition

  # EXAMPLE #
    _position = [player, 25, 150] call CTI_CO_FNC_GetRandomPosition
	  -> Get a random position around 25-150 meters from the player
*/


private["_position","_radius","_direction","_maxRadius","_minRadius"];

_position = _this select 0;
_minRadius = _this select 1;
_maxRadius = _this select 2;
_direction = random 360;

if (typeName _position == "OBJECT") then {_position = getPos _position};
if (count _position < 3) then {_position set [2, 0]};

_radius = (random (_maxRadius - _minRadius)) + _minRadius;
_position = [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius),(_position select 2)];
_tries=0;
while {surfaceIsWater _position && _tries <1000}do {_direction = random 360;_radius = (random (_maxRadius - _minRadius)) + _minRadius;_position = [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius),(_position select 2)];_tries = _tries+1;};

_position
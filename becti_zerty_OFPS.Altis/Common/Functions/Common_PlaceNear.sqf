/*
  # HEADER #
	Script: 		Common\Functions\Common_PlaceNear.sqf
	Alias:			CTI_CO_FNC_PlaceNear
	Description:	Place an object/unit/vehicle next to a position
	Author: 		Benny, Adapted from Mike Melvin
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Object]: The object to place
    1	[Array]: The center
    2	[Number]: The minimum radius
    3	[Number]: The maximum radius
    4	{Optionnal} [Boolean]: Force the unit to face away from the center
    5	{Optionnal} [Boolean]: Set a random direction
    6	{Optionnal} [Boolean]: Place the unit safely
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[OBJECT, CENTER, RADIUS MIN, RADIUS MAX] call CTI_CO_FNC_GetRandomPosition
	[OBJECT, CENTER, RADIUS MIN, RADIUS MAX, FACE AWAY] call CTI_CO_FNC_GetRandomPosition
	[OBJECT, CENTER, RADIUS MIN, RADIUS MAX, FACE AWAY, RANDOM DIRECTION] call CTI_CO_FNC_GetRandomPosition
	[OBJECT, CENTER, RADIUS MIN, RADIUS MAX, FACE AWAY, RANDOM DIRECTION, SAFE PLACEMENT] call CTI_CO_FNC_GetRandomPosition
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_PlaceSafe
	
  # EXAMPLE #
    [vehicle player, getPos Town0, 10, 20] call CTI_CO_FNC_PlaceNear;
	  -> Place the player's vehicle near Town0
	[vehicle player, getPos Town0, 10, 20, true] call CTI_CO_FNC_PlaceNear;
	  -> Place the player's vehicle near Town0 and force it to face away from the center
	[vehicle player, getPos Town0, 10, 20, true, false, true] call CTI_CO_FNC_PlaceNear;
	  -> Place the player's vehicle safely near Town0 and force it to face away from the center
*/

private["_destination","_direction","_faceAway","_maxRadius","_minRadius","_object","_placeSafe","_position","_radius","_randomDirection","_safeRadius"];

_object = _this select 0;
_position = _this select 1;
_minRadius = _this select 2;
_maxRadius = _this select 3;
_faceAway = if (count _this > 4) then {_this select 4} else {true};
_randomDirection = if (count _this > 5) then {_this select 5} else {true};
_placeSafe = if (count _this > 6) then {_this select 6} else {false};

_direction = random 360;
_radius = (random (_maxRadius - _minRadius)) + _minRadius;

if (_placeSafe) then {
	_safeRadius = (_maxRadius - _minRadius) / 2;
	if (_safeRadius < 5) then {_safeRadius = 5};
	_destination = [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius),(_position select 2)+0.5];
	[_object,_destination,_safeRadius] call CTI_CO_FNC_PlaceSafe;
} else {
	_object setPos [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius),(_position select 2)+0.5];
};

if (_randomDirection) then {_object setDir random 360};

if (_faceAway) then {
	_destination = getPos _object;
	_object setDir -((((_destination select 1) - (_position select 1)) atan2 ((_destination select 0) - (_position select 0))) - 90);
};
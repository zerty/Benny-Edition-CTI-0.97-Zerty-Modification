/*
  # HEADER #
	Script: 		Common\Functions\Common_GetClosestEntity.sqf
	Alias:			CTI_CO_FNC_GetClosestEntity
	Description:	Get the closest position among a list of positions/objects
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array/Object]: A position or an object which determine the center
    1	[Array]: The list (objects/positions)
	
  # RETURNED VALUE #
	[Object]: The closest position
	
  # SYNTAX #
	[CENTER, LIST] call CTI_CO_FNC_GetClosestEntity
	
  # EXAMPLE #
    _closest = [player, [Town1, Town2, Town3]] call CTI_CO_FNC_GetClosestEntity;
    _closest = [player, [Town1, [0,0,0], [50,50]]] call CTI_CO_FNC_GetClosestEntity;
*/

private ["_distance", "_nearest", "_object", "_objects"];

_object = _this select 0;
_objects = _this select 1;

_nearest = objNull;
_distance = 100000;
{if (_x distance _object < _distance) then {_nearest = _x;_distance = _x distance _object}} forEach _objects;

_nearest
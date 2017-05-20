/*
  # HEADER #
	Script: 		Common\Functions\Common_GetClosestStructure.sqf
	Alias:			CTI_CO_FNC_GetClosestStructure
	Description:	Get the closest structure of a given type, sort if needed
					The structures types are defined in Init_CommonConstants.sqf
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Integer]: The structure type
    1	[Array/Object]: The center position
    2	[Array]: The structure list
    3	[Number]: The maximum distance between the center and the closest structure
	
  # RETURNED VALUE #
	[Object]: The closest structure of the given type
	
  # SYNTAX #
	[TYPE, CENTER, STRUCTURES, DISTANCE] call CTI_CO_FNC_GetClosestStructure
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetClosestEntity
	Common Function: CTI_CO_FNC_GetSideStructuresByType
	
  # EXAMPLE #
	_structures = (West) call CTI_CO_FNC_GetSideStructures;
    _closest = [CTI_BARRACKS, player, _structures] call CTI_CO_FNC_GetClosestStructure;
	  -> Return the barracks which is the closest of the player
	_closest = [CTI_BARRACKS, player, _structures, 500] call CTI_CO_FNC_GetClosestStructure;
	  -> Return the barracks which is the closest of the player within 500 meters
*/

private ["_center", "_distance", "_closest", "_structures", "_type"];

_type = _this select 0;
_center = _this select 1;
_structures = _this select 2;
_distance = if (count _this > 3) then { _this select 3 } else { 0 };

_closest = objNull;
_structures = [_type, _structures] call CTI_CO_FNC_GetSideStructuresByType;

if (count _structures > 0) then { _closest = [_center, _structures] call CTI_CO_FNC_GetClosestEntity };

if (_distance > 0 && _closest distance _center > _distance) then { _closest = objNull };

_closest
/*
  # HEADER #
	Script: 		Common\Functions\Common_PlaceSafe.sqf
	Alias:			CTI_CO_FNC_PlaceSafe
	Description:	Place an object/unit/vehicle safely at a position
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Object]: The object to place
    1	[Array]: The center
    2	[Number]: The radius area
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[OBJECT, CENTER, RADIUS] call CTI_CO_FNC_PlaceSafe
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetEmptyPosition
	
  # EXAMPLE #
    [vehicle player, getPos Town0, 75] call CTI_CO_FNC_PlaceSafe;
	  -> Place the player's vehicle safely near Town0 within 75 meters
*/

private ["_center", "_object", "_position", "_radius"];

_object = _this select 0;
_center = _this select 1;
_radius = _this select 2;

_position = [_center, _radius] call CTI_CO_FNC_GetEmptyPosition;

_object setPos _position;
_object setVelocity [0,0,-1];
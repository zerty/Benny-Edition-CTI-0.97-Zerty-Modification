/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideLogic.sqf
	Alias:			CTI_CO_FNC_GetSideLogic
	Description:	Return the Game Logic binded to a side
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Side]: The side

  # RETURNED VALUE #
	[Object]: The matching Game Logic

  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideLogic

  # EXAMPLE #
    _side = (West) call CTI_CO_FNC_GetSideLogic
	  -> Return the CTI_WEST logic
*/

if (typeName _this != "SIDE") exitWith {objNull};

switch (_this) do {
	case west: {CTI_WEST};
	case east: {CTI_EAST};
	default {objNull}
}
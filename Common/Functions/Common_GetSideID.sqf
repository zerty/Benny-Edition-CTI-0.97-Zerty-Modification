/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideID.sqf
	Alias:			CTI_CO_FNC_GetSideID
	Description:	Return the Side ID that match a side, -1 by default
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Side]: The side
	
  # RETURNED VALUE #
	[Integer]: The matching Side ID
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideID
	
  # EXAMPLE #
    _side = (West) call CTI_CO_FNC_GetSideID
	  -> Return CTI_WEST_ID
*/

if (typeName _this != "SIDE") exitWith {-1};

switch (_this) do {
	case west: {CTI_WEST_ID};
	case east: {CTI_EAST_ID};
	case resistance: {CTI_RESISTANCE_ID};
	default {-1}
}
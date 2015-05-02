/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideFromID.sqf
	Alias:			CTI_CO_FNC_GetSideFromID
	Description:	Return the side matching the Side ID
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Integer]: A Side ID
	
  # RETURNED VALUE #
	[Side]: The matching Side
	
  # SYNTAX #
	(SIDE ID) call CTI_CO_FNC_GetSideFromID
	
  # EXAMPLE #
    _side = (CTI_RESISTANCE_ID) call CTI_CO_FNC_GetSideFromID
	  -> Return the resistance's side
*/

if (typeName _this != "SCALAR") exitWith {civilian};

switch (_this) do {
	case CTI_WEST_ID: {west};
	case CTI_EAST_ID: {east};
	case CTI_RESISTANCE_ID: {resistance};
	default {civilian}
}
/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideStructures.sqf
	Alias:			CTI_CO_FNC_GetSideStructures
	Description:	Return the base structures of a side which are constructed
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Side]: The side
	
  # RETURNED VALUE #
	[Array]: A copy of the side's structures
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideStructures
	
  # EXAMPLE #
    _side = (West) call CTI_CO_FNC_GetSideStructures
	  -> Return the west structures
*/

switch (_this) do {
	case west: {+(CTI_WEST getVariable "cti_structures")};
	case east: {+(CTI_EAST getVariable "cti_structures")};
	default {[]};
}
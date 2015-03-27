/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideCommander.sqf
	Alias:			CTI_CO_FNC_GetSideCommander
	Description:	Return the group of a side's commander
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Side]: The side
	
  # RETURNED VALUE #
	[Group]: The side's commander, null if none
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideCommander
	
  # EXAMPLE #
    _commander = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideCommander
	  -> Return the commander of the player's side
*/

if (typeName _this != "SIDE") exitWith {grpNull};

switch (_this) do {
	case west: {CTI_WEST getVariable "cti_commander"};
	case east: {CTI_EAST getVariable "cti_commander"};
	default {grpNull};
}
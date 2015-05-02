/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideUpgrades.sqf
	Alias:			CTI_CO_FNC_GetSideUpgrades
	Description:	Return the upgrades level array of a side
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Side]: The side
	
  # RETURNED VALUE #
	[Array]: The current side upgrades
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideUpgrades
	
  # EXAMPLE #
    _upgrades = (West) call CTI_CO_FNC_GetSideUpgrades
	  -> Return the current west upgrades levels
*/

if (typeName _this != "SIDE") exitWith {[]};

switch (_this) do {
	case west: {CTI_WEST getVariable "cti_upgrades"};
	case east: {CTI_EAST getVariable "cti_upgrades"};
	default {[]};
}
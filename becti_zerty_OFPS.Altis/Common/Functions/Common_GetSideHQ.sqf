/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideHQ.sqf
	Alias:			CTI_CO_FNC_GetSideHQ
	Description:	Return a side's HQ
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Side]: The side

  # RETURNED VALUE #
	[Object]: The HQ

  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideHQ

  # EXAMPLE #
    _side = (West) call CTI_CO_FNC_GetSideHQ
	  -> Return the West HQ
*/

if (typeName _this != "SIDE") exitWith {objNull};

switch (_this) do {
	case west: {CTI_WEST getVariable "cti_hq"};
	case east: {CTI_EAST getVariable "cti_hq"};
	//case resistance: {CTI_GUER getVariable "cti_hq"};
	default {objNull};
}
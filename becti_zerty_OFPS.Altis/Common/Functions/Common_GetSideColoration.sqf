/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideColoration.sqf
	Alias:			CTI_CO_FNC_GetSideColoration
	Description:	Return assigned color of a side
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Side]: The side

  # RETURNED VALUE #
	[String]: The color of the side

  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideColoration

  # EXAMPLE #
    _color = (West) call CTI_CO_FNC_GetSideColoration
	  -> Return the color assigned to CTI_WEST_COLOR
*/

if (typeName _this != "SIDE") exitWith {""};

switch (_this) do {
	case west: {CTI_WEST_COLOR};
	case east: {CTI_EAST_COLOR};
	case resistance: {CTI_RESISTANCE_COLOR};
	default {"ColorGreen"}
}
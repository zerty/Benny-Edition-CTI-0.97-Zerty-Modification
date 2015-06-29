/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideTowns.sqf
	Alias:			CTI_CO_FNC_GetSideTowns
	Description:	Return the towns owned by a given side
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Side/Integer]: The side

  # RETURNED VALUE #
	[Array]: The side's towns

  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideTowns

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_GetSideID

  # EXAMPLE #
    _side = (West) call CTI_CO_FNC_GetSideTowns
	  -> Return the towns owned by West
*/

private["_sideID", "_towns"];

_sideID = _this;

if (typeName _sideID == "SIDE") then { _sideID = _this call CTI_CO_FNC_GetSideID };

_towns = [];
{if ((_x getVariable "cti_town_sideID") == _sideID) then {_towns pushBack _x}} forEach CTI_Towns;

_towns
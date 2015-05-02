/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideTownCount.sqf
	Alias:			CTI_CO_FNC_GetSideTownCount
	Description:	Return the amount of towns owned by a given side
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Side/Integer]: The side
	
  # RETURNED VALUE #
	[Integer]: The side's towns count
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideTownCount
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	
  # EXAMPLE #
    _side = (West) call CTI_CO_FNC_GetSideTownCount
	  -> Return the towns count owned by West
*/

private["_sideID"];

_sideID = _this;

if (typeName _sideID == "SIDE") then { _sideID = _this call CTI_CO_FNC_GetSideID };

{(_x getVariable "cti_town_sideID") == _sideID} count CTI_Towns
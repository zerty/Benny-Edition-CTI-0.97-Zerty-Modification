/*
  # HEADER #
	Script: 		Common\Functions\Common_GetFundsTeam.sqf
	Alias:			CTI_CO_FNC_GetFundsTeam
	Description:	Get the funds of a CTI Group
					Note that this function ignore the commander funds
	Author: 		Benny
	Creation Date:	09-10-2013
	Revision Date:	09-10-2013
	
  # PARAMETERS #
    0	[Group]: The group
	
  # RETURNED VALUE #
	[Number]: The group's funds
	
  # SYNTAX #
	(CTI GROUP) call CTI_CO_FNC_GetFundsTeam
	
  # EXAMPLE #
    _funds = (group player) call CTI_CO_FNC_GetFundsTeam
*/

private ["_funds", "_group", "_side"];

_group = _this;

_funds = _group getVariable "cti_funds";
if (isNil '_funds') then {0} else {_funds}
/*
  # HEADER #
	Script: 		Common\Functions\Common_ChangeFundsTeam.sqf
	Alias:			CTI_CO_FNC_ChangeFundsTeam
	Description:	Change the funds of a CTI Group
					Note that this function ignore the commander funds
	Author: 		Benny
	Creation Date:	09-10-2013
	Revision Date:	09-10-2013
	
  # PARAMETERS #
    0	[Group]: A CTI Group
    1	[Number]: The amount to add or subtract (int, float, double...)
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[CTI GROUP, AMOUNT] call CTI_CO_FNC_ChangeFundsTeam
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetFundsTeam
	
  # EXAMPLE #
	[group player, 500] call CTI_CO_FNC_ChangeFundsTeam; 
	  -> If the player had 25 before then he will have 525
*/

private ["_funds", "_group", "_value"];

_group = _this select 0;
_value = _this select 1;

if (isNil '_value') exitWith {"error CTI_CO_FNC_ChangeFundsTeam: attempted to set nil value"};
if (typeName _value != "SCALAR") exitWith {"error CTI_CO_FNC_ChangeFundsTeam: attempted to set non scalar value"};

_funds = (_group) call CTI_CO_FNC_GetFundsTeam;
_group setVariable ["cti_funds", _funds + _value, true];
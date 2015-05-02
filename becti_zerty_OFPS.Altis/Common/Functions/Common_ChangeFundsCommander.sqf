/*
  # HEADER #
	Script: 		Common\Functions\Common_ChangeFundsCommander.sqf
	Alias:			CTI_CO_FNC_ChangeFundsCommander
	Description:	Change the funds of a commander by adding/subtracting funds to the
					existing ones
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	09-10-2013
	
  # PARAMETERS #
    0	[Side]: The side of the commander
    1	[Number]: The amount to add (int, float, double...)
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, AMOUNT] call CTI_CO_FNC_ChangeFundsCommander
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetFundsCommander
	Common Function: CTI_CO_FNC_GetSideLogic
	
  # EXAMPLE #
	[West, 1000] call CTI_CO_FNC_ChangeFundsCommander; 
	  -> Assuming commander had 5000 before: 6000
	[West, -1000] call CTI_CO_FNC_ChangeFundsCommander; 
	  -> Assuming commander had 5000 before: 4000
*/

private ["_funds", "_side", "_value"];

_side = _this select 0;
_value = _this select 1;

if (isNil '_value') exitWith {"error CTI_CO_FNC_ChangeFundsCommander: attempted to set nil value"};
if (typeName _value != "SCALAR") exitWith {"error CTI_CO_FNC_ChangeFundsCommander: attempted to set non scalar value"};

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_funds = (_side) call CTI_CO_FNC_GetFundsCommander;
_logic setVariable ["cti_commander_funds", _funds + _value, true];

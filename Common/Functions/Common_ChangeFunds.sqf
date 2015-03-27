/*
  # HEADER #
	Script: 		Common\Functions\Common_ChangeFunds.sqf
	Alias:			CTI_CO_FNC_ChangeFunds
	Description:	Change the funds of a group by adding/subtracting funds to the
					existing ones.
					Note that this function determine if the group is the commander's or not
	Author: 		Benny
	Creation Date:	09-10-2013
	Revision Date:	09-10-2013
	
  # PARAMETERS #
    0	[Group]: The group in question
    1	[Side]: The side of the group
    2	[Number]: The amount to add (int, float, double...)
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[GROUP, SIDE, AMOUNT] call CTI_CO_FNC_ChangeFunds
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ChangeFundsCommander
	Common Function: CTI_CO_FNC_ChangeFundsTeam
	Common Function: CTI_CO_FNC_GetSideCommander
	Common Function: CTI_CO_FNC_GetFunds
	
  # EXAMPLE #
	[group player, West, 500] call CTI_CO_FNC_ChangeFunds; 
	  -> Assuming the player is the commander and had 5000 before: 5500
	[group player, West, 500] call CTI_CO_FNC_ChangeFunds; 
	  -> Assuming the player is not the commander and had 25 before: 525
*/

private ["_funds", "_group", "_side", "_value"];

_group = _this select 0;
_side = _this select 1;
_value = _this select 2;

if ((_side call CTI_CO_FNC_GetSideCommander) == _group) then {
	//--- Change the commander's funds
	[_side, _value] call CTI_CO_FNC_ChangeFundsCommander;
} else {
	//--- Change a team's funds
	[_group, _value] call CTI_CO_FNC_ChangeFundsTeam;
};

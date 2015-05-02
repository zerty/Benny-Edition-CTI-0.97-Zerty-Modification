/*
  # HEADER #
	Script: 		Client\Functions\Client_ChangePlayerFunds.sqf
	Alias:			CTI_CL_FNC_ChangePlayerFunds
	Description:	Change the player's funds by adding of subtracting a value
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	09-10-2013
	
  # PARAMETERS #
    0	[Number]: The amount of funds to change
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	(FUNDS) call CTI_CL_FNC_ChangePlayerFunds
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ChangeFunds
	
  # EXAMPLE #
    (500) call CTI_CL_FNC_ChangePlayerFunds -> Adds 500 funds to the player
    (-500) call CTI_CL_FNC_ChangePlayerFunds -> Removes 500 funds from the player
*/

[group player, CTI_P_SideJoined, _this] call CTI_CO_FNC_ChangeFunds;
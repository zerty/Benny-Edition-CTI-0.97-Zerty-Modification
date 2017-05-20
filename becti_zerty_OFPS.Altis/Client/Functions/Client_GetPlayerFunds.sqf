/*
  # HEADER #
	Script: 		Client\Functions\Client_GetPlayerFunds.sqf
	Alias:			CTI_CL_FNC_GetPlayerFunds
	Description:	Return the player's funds
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	09-10-2013
	
  # PARAMETERS #
    None
	
  # RETURNED VALUE #
	[Number]: The player's funds
	
  # SYNTAX #
	call CTI_CL_FNC_GetPlayerFunds
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetFunds
	
  # EXAMPLE #
    call CTI_CL_FNC_GetPlayerFunds 
	  -> Will return the current player funds
*/

[group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds

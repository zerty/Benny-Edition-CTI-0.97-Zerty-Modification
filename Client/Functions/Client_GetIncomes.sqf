/*
  # HEADER #
	Script: 		Client\Functions\Client_GetIncomes.sqf
	Alias:			CTI_CL_FNC_GetIncomes
	Description:	Return the income of the commander and the one of the players
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    None
	
  # RETURNED VALUE #
	[Array]: The command and players income
	
  # SYNTAX #
	call CTI_CL_FNC_GetIncomes
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetTownsResources
	
  # EXAMPLE #
    call CTI_CL_FNC_GetIncomes 
	  -> Will return [Commander Income, Players Income]
*/

_total_values = (CTI_P_SideJoined) call CTI_CO_FNC_GetTownsResources;
if (_total_values == 0) exitWith {[0,0]}; //--- Don't bother if we have no towns!

_percent_award = CTI_P_SideLogic getVariable "cti_pool_award";
_percent_resources = CTI_P_SideLogic getVariable "cti_pool_resources";
_pool_award = _total_values * _percent_award;

_pool_income_total = _total_values - _pool_award; //--- The resources pool overall
_pool_income_players = _pool_income_total * _percent_resources; //--- The resources pool for the players
_pool_income_commander = round(_pool_income_total - _pool_income_players);
_pool_income_players_all = _pool_income_players + _pool_award;

[_pool_income_commander, _pool_income_players_all]
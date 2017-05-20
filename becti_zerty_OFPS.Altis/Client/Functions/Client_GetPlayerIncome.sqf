/*
  # HEADER #
	Script: 		Client\Functions\Client_GetPlayerIncome.sqf
	Alias:			CTI_CL_FNC_GetPlayerIncome
	Description:	Return the player's income
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    None

  # RETURNED VALUE #
	[Number]: The player's funds

  # SYNTAX #
	call CTI_CL_FNC_GetPlayerIncome

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideCommander
	Common Function: CTI_CO_FNC_GetSideGroups
	Common Function: CTI_CO_FNC_GetTownsResources
	Common Function: CTI_CO_FNC_GetUnitsScore

  # EXAMPLE #
    call CTI_CL_FNC_GetPlayerIncome
	  -> Will return the current player income
*/
_base_income = missionNamespace getVariable "CTI_ECONOMY_BASE_PLAYER_INCOME";

_total_values = (CTI_P_SideJoined) call CTI_CO_FNC_GetTownsResources;
//if (_total_values == 0) exitWith {0}; //--- Don't bother if we have no towns!

_percent_award = CTI_P_SideLogic getVariable "cti_pool_award";
_percent_resources = CTI_P_SideLogic getVariable "cti_pool_resources";
_pool_award = _total_values * _percent_award;

_pool_income_total = _total_values - _pool_award; //--- The resources pool overall
_pool_income_players = _pool_income_total * _percent_resources; //--- The resources pool for the players
_pool_income_commander = round(_base_income+_pool_income_total - _pool_income_players);

_commander = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideCommander;

if (_commander == group player) exitWith { _pool_income_commander };

_side_units = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideGroups;
_total_players = count (_side_units - [_commander]);
_total_score = (_side_units - [_commander]) call CTI_CO_FNC_GetUnitsScore;
if (_total_score < 1) then {_total_score = count _side_units};

_score = score player;
_value = round((_score / _total_score) * _pool_award);
if (_value < 0) then { _value = 0 ;};
_value= _value + _base_income ;
_value = _value + (round(_pool_income_players / _total_players));

_value
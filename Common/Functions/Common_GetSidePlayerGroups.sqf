/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSidePlayerGroups.sqf
	Alias:			CTI_CO_FNC_GetSidePlayerGroups
	Description:	Return all player-controlled CTI Groups of a side
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Side]: The side

  # RETURNED VALUE #
	[Array]: The current player-controlled CTI Groups

  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSidePlayerGroups

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_GetSideLogic

  # EXAMPLE #
    _group_players = (West) call CTI_CO_FNC_GetSidePlayerGroups
	  -> Return the west player-controlled CTI Groups
*/

private ["_logic", "_teams"];

if (typeName _this != "SIDE") exitWith {[]};

_logic = (_this) call CTI_CO_FNC_GetSideLogic;

_teams = [];
if !(isNull _logic) then {
	{
		if !(isNil '_x') then {
			if (isPlayer leader _x) then { _teams pushBack _x };
		}
	} forEach (_logic getVariable "cti_teams");
};

_teams
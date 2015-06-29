/*
  # HEADER #
	Script: 		Common\Functions\Common_GetEnemyTowns.sqf
	Alias:			CTI_CO_FNC_GetEnemyTowns
	Description:	Get the enemy towns for a given side
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Integer/Side]: The "friendly" side which we want to get enemy towns from

  # RETURNED VALUE #
	[Array]: The enemy towns

  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetEnemyTowns

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_GetSideID

  # EXAMPLE #
    _towns_enemy = (CTI_P_SideID) call CTI_CO_FNC_GetEnemyTowns;
	  -> Return the towns which are considered enemy to the player
    _towns_enemy = (resistance) call CTI_CO_FNC_GetEnemyTowns;
    _towns_enemy = (CTI_RESISTANCE_ID) call CTI_CO_FNC_GetEnemyTowns;
	  -> Return the towns which are considered enemy to the Resistance
*/

private ["_sideID", "_towns"];

_sideID = _this;

if (typeName _sideID == "SIDE") then { _sideID = (_sideID) call CTI_CO_FNC_GetSideID };

_towns = [];
{if (_x getVariable "cti_town_sideID" != _sideID) then { _towns pushBack _x}} forEach CTI_Towns;

_towns
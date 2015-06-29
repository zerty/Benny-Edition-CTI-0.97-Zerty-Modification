/*
  # HEADER #
	Script: 		Common\Functions\Common_GetFriendlyTowns.sqf
	Alias:			CTI_CO_FNC_GetFriendlyTowns
	Description:	Get the friendly towns for a given side
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Integer/Side]: The side which we want to get the towns from

  # RETURNED VALUE #
	[Array]: The friendly towns

  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetFriendlyTowns

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_GetSideID

  # EXAMPLE #
    _towns_enemy = (CTI_P_SideID) call CTI_CO_FNC_GetFriendlyTowns;
	  -> Return the towns which are considered friendly to the player
    _towns_enemy = (resistance) call CTI_CO_FNC_GetFriendlyTowns;
    _towns_enemy = (CTI_RESISTANCE_ID) call CTI_CO_FNC_GetFriendlyTowns;
	  -> Return the towns which are considered friendly to the Resistance
*/

private ["_sideID", "_towns"];

_sideID = _this;

if (typeName _sideID == "SIDE") then { _sideID = (_sideID) call CTI_CO_FNC_GetSideID };

_towns = [];
{if (_x getVariable "cti_town_sideID" == _sideID) then { _towns pushBack _x}} forEach CTI_Towns;

_towns
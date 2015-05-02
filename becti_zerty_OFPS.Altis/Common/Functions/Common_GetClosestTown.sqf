/*
  # HEADER #
	Script: 		Common\Functions\Common_GetClosestTown.sqf
	Alias:			CTI_CO_FNC_GetClosestTown
	Description:	Get the closest town from a center
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array/Object]: The center
	
  # RETURNED VALUE #
	[Object]: The closest town
	
  # SYNTAX #
	(CENTER) call CTI_CO_FNC_GetClosestTown
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetClosestEntity
	
  # EXAMPLE #
    _closest = (player) call CTI_CO_FNC_GetClosestTown
*/

private ["_center"];

_center = _this;

[_center, CTI_Towns] call CTI_CO_FNC_GetClosestEntity
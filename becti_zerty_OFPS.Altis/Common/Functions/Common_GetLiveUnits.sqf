/*
  # HEADER #
	Script: 		Common\Functions\Common_GetLiveUnits.sqf
	Alias:			CTI_CO_FNC_GetLiveUnits
	Description:	Get the living units within a group
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Array/Group]: A units array or a group
	
  # RETURNED VALUE #
	[Array]: The living units
	
  # SYNTAX #
	(GROUP/ARRAY) call CTI_CO_FNC_GetLiveUnits
	
  # EXAMPLE #
    _lives = (units player) call CTI_CO_FNC_GetLiveUnits
    _lives = (group player) call CTI_CO_FNC_GetLiveUnits
*/

private["_liveUnits","_units"];

_units = _this;

if (typeName _units == "GROUP") then { _units = units _units };

_liveUnits = [];

{if (alive _x) then {_liveUnits = _liveUnits + [_x]}} forEach _units;
_liveUnits

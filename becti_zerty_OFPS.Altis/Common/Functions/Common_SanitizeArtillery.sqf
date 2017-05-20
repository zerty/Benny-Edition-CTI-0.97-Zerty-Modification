/*
  # HEADER #
	Script: 		Common\Functions\Common_SanitizeArtillery.sqf
	Alias:			CTI_CO_FNC_SanitizeArtillery
	Description:	Sanitize the equipment of an Artillery/Howitzer
	Author: 		Benny
	Creation Date:	14-10-2013
	Revision Date:	14-10-2013
	
  # PARAMETERS #
    0	[Object]: The vehicle
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	(VEHICLE) call CTI_CO_FNC_SanitizeArtillery
	
  # EXAMPLE #
    (vehicle player) call CTI_CO_FNC_SanitizeArtillery;
	  -> Sanitize the player's vehicle (Mags)
*/

private ["_vehicle"];

_vehicle = _this;

{
	if (_x in ["6Rnd_155mm_Mo_mine","6Rnd_155mm_Mo_AT_mine"]) then {_vehicle removeMagazine _x};
} forEach magazines _vehicle;

true
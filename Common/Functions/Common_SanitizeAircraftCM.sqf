/*
  # HEADER #
	Script: 		Common\Functions\Common_SanitizeAircraftCM.sqf
	Alias:			CTI_CO_FNC_SanitizeAircraftCM
	Description:	Sanitize the CM equipment of an aircraft
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Object]: The vehicle

  # RETURNED VALUE #
	None

  # SYNTAX #
	(VEHICLE) call CTI_CO_FNC_SanitizeAircraftCM

  # EXAMPLE #
    (vehicle player) call CTI_CO_FNC_SanitizeAircraftCM;
	  -> Sanitize the player's vehicle (CM)
*/

private ["_cms","_magazines","_vehicle","_weapons"];

_vehicle = _this;

_weapons = getArray(configFile >> "CfgVehicles" >> typeOf _vehicle >> "weapons");

if ("CMFlareLauncher" in _weapons) then {
	{
		if (getText(configFile >> "CfgMagazines" >> _x >> "ammo") in ["CMflareAmmo", "CMflare_Chaff_Ammo"]) then {_vehicle removeMagazineTurret [_x, [-1]]};
	} forEach (getArray(configFile >> "CfgVehicles" >> typeOf _vehicle >> "magazines"));
};

if ("CMFlareLauncher_Singles" in _weapons) then {
	{
		if (getText(configFile >> "CfgMagazines" >> _x >> "ammo") in ["CMflareAmmo", "CMflare_Chaff_Ammo"]) then {_vehicle removeMagazineTurret [_x, [-1]]};
	} forEach (getArray(configFile >> "CfgVehicles" >> typeOf _vehicle >> "magazines"));
};

if ("CMFlareLauncher_Triples" in _weapons) then {
	{
		if (getText(configFile >> "CfgMagazines" >> _x >> "ammo") in ["CMflareAmmo", "CMflare_Chaff_Ammo"]) then {_vehicle removeMagazineTurret [_x, [-1]]};
	} forEach (getArray(configFile >> "CfgVehicles" >> typeOf _vehicle >> "magazines"));
};

true
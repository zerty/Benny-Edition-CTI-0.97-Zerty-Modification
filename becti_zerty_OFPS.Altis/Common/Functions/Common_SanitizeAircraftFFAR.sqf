/*
  # HEADER #
	Script: 		Common\Functions\Common_SanitizeAircraftFFAR.sqf
	Alias:			CTI_CO_FNC_SanitizeAircraftFFAR
	Description:	Sanitize the FFAR equipment of an aircraft
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	04/04/2014 (sari)

  # PARAMETERS #
    0	[Object]: The vehicle

  # RETURNED VALUE #
	None

  # SYNTAX #
	(VEHICLE) call CTI_CO_FNC_SanitizeAircraftFFAR

  # EXAMPLE #
    (vehicle player) call CTI_CO_FNC_SanitizeAircraftFFAR;
	  -> Sanitize the player's vehicle (FFAR)
*/

private ["_magazines","_vehicle","_weapons"];

_vehicle = _this;

_weapons = weapons _vehicle;
_magazines = magazines _vehicle;

_specialweapons = ["Rocket_03_AP_F","Rocket_03_HE_F","Rocket_04_AP_F","Rocket_04_HE_F"]; // Wipeout and Neophron rockets have missilebase parents and not rocketbase parents for some reason. http://feedback.arma3.com/view.php?id=18283


_weapons_remove = [];
_magazines_remove = [];

//--- Find AT Lock weapons.
{
	_remove = false;

	{
		_ammo = getText(configFile >> "CfgMagazines" >> _x >> "ammo"); //--- We grab the ammo used by the magazine.

		if (_ammo != "") then {
			//--- We check if the ammo is air-lock based and that in inherits from the missile class.
			if ((configName(inheritsFrom(configFile >> "CfgAmmo" >> _ammo)) == "RocketBase") || {_ammo iskindof _x} foreach _specialweapons) then {_remove = true; _magazines_remove = _magazines_remove + [_x]};
		};
	} forEach getArray(configFile >> "CfgWeapons" >> _x >> "magazines"); //--- We check the magazines array of the weapon.

	if (_remove) then {_weapons_remove = _weapons_remove + [_x]};
} forEach _weapons;

{if (_x in _magazines_remove) then {_vehicle removeMagazine _x}} forEach _magazines; //--- Remove AT magazines if found.
//{_vehicle removeWeapon _x} forEach _weapons_remove; //--- Remove all weapons linked to AT lock.
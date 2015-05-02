/*
  # HEADER #
	Script: 		Common\Functions\Common_GetItemBaseConfig.sqf
	Alias:			CTI_CO_FNC_GetItemBaseConfig
	Description:	Get an item base config (weapons, magazine, item...)
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[String]: The item classname

  # RETURNED VALUE #
	[String]: The item's base config

  # SYNTAX #
	(CLASSNAME) call CTI_CO_FNC_GetItemBaseConfig

  # EXAMPLE #
    _base = (secondaryWeapon player) call CTI_CO_FNC_GetItemBaseConfig
    _base = ("30Rnd_556x45_Stanag") call CTI_CO_FNC_GetItemBaseConfig
    _base = ("arifle_Katiba_F") call CTI_CO_FNC_GetItemBaseConfig
    _base = ("B_AssaultPack_khk") call CTI_CO_FNC_GetItemBaseConfig
*/

private ["_type"];

_type = switch (true) do { //--- Determine the kind of item that we're dealing with
	case (isClass (configFile >> 'CfgWeapons' >> _this)): {"CfgWeapons"};
	case (isClass (configFile >> 'CfgMagazines' >> _this)): {"CfgMagazines"};
	case (isClass (configFile >> 'CfgVehicles' >> _this)): {"Item"};
	case (isClass (configFile >> 'CfgGlasses' >> _this)): {"Goggles"}; //todo, find where the flying fuck goggles are supposed to go
	default {"nil"};
};

if (_type == "CfgWeapons") then {
	_itype = getNumber(configFile >> "CfgWeapons" >> _this >> "type");
	if (_itype == CTI_TYPE_ITEM) then {_type = "Item"};
	if (_itype == CTI_TYPE_EQUIPMENT) then {
		_type = if (getText(configFile >> 'CfgWeapons' >> _item >> 'simulation') == "NVGoggles") then {"Item"} else {"CfgWeapons"};// NVG is considered as an item but binocs and rest are not.
	};
};

_type
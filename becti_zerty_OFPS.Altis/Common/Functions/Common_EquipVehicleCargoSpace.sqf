/*
  # HEADER #
	Script: 		Common\Functions\Common_EquipVehicleCargoSpace.sqf
	Alias:			CTI_CO_FNC_EquipVehicleCargoSpace
	Description:	Equip the cargo space of a vehicle (Weapons/Magazines/Backpacks)
	Author: 		Benny
	Creation Date:	16-10-2013
	Revision Date:	16-10-2013

  # PARAMETERS #
    0	[Object]: The vehicle to equip
    1	[Array]: The loadout (Type/Count)

  # RETURNED VALUE #
	None

  # SYNTAX #
	[UNIT, ARRAY] call CTI_CO_FNC_EquipVehicleCargoSpace

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetItemBaseConfig

  # EXAMPLE #
	_gear = [["PaperRifle", 2], ["PaperMagazine", 4]];

	[vehicle player, _gear] call CTI_CO_FNC_EquipVehicleCargoSpace;
	  -> This will add the content of gear on the player's vehicle
*/

private ["_count", "_item", "_loadout", "_vehicle"];

_vehicle = _this select 0;
_loadout = _this select 1;

if !(alive _vehicle) exitWith {};
//if (count _loadout == 0) exitWith {};

//--- Cleanup the vehicle
clearBackpackCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;

//--- Start loading up stuff
{
	_item = _x select 0;
	_count = _x select 1;

	//_vehicle addItemCargoGlobal [_item, _count];
	switch (_item call CTI_CO_FNC_GetItemBaseConfig) do { //todo figure out bout that goggle mystery
		case "CfgMagazines": { _vehicle addMagazineCargoGlobal [_item, _count] };
		case "CfgWeapons": { _vehicle addWeaponCargoGlobal [_item, _count] };
		case "Item": { if (getNumber(configFile >> 'CfgVehicles' >> _item >> 'isbackpack') == 1) then {_vehicle addBackpackCargoGlobal [_item, _count] } else {_vehicle addItemCargoGlobal [_item, _count]}; };
		default {_vehicle addItemCargoGlobal [_item, _count]; };
	};
} forEach _loadout;
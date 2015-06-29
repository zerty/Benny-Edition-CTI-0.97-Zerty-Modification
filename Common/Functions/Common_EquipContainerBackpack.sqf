/*
  # HEADER #
	Script: 		Common\Functions\Common_EquipContainerBackpack.sqf
	Alias:			CTI_CO_FNC_EquipContainerBackpack
	Description:	Alter the content of the backpack and it's items on a unit.
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013

  # PARAMETERS #
    0	[Object]: The unit
    1	[String]: The backpack classname
    2	[Array]: The items to add in the backpack

  # RETURNED VALUE #
	None

  # SYNTAX #
	[UNIT, CLASSNAME, ITEMS] call CTI_CO_FNC_EquipContainerBackpack

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_GetItemBaseConfig

  # EXAMPLE #
	[player, "B_FieldPack_blk", ["Laserbatteries","7Rnd_408_Mag",...]] call CTI_CO_FNC_EquipContainerBackpack;
*/

private ["_added", "_backpack", "_items", "_unit"];

_unit = _this select 0;
_backpack = _this select 1;
_items = _this select 2;

if (backpack _unit != _backpack) then { removeBackpack _unit };
if (_backpack != "" && backpack _unit == "") then { _unit addBackpack _backpack };
if (backpack _unit != "") then { clearAllItemsFromBackpack _unit };

_added = [];
{
	_item = _x;
	if (_item != "") then {
		if !(_item in _added) then {
			_base = (_item) call CTI_CO_FNC_GetItemBaseConfig;
			_added pushBack _item;
			_count = {_x == _item} count _items;

			//(unitBackPack _unit) addItemCargoGlobal [_item, _count];
			switch (_base) do { //todo figure out bout that goggle mystery
				case "CfgMagazines": { (unitBackPack _unit) addMagazineCargoGlobal [_item, _count] };
				case "CfgWeapons": { (unitBackPack _unit) addWeaponCargoGlobal [_item, _count] };
				case "Item": { (unitBackPack _unit) addItemCargoGlobal [_item, _count] };
				case "Goggles": { for '_i' from 1 to _count do {_unit addItemToBackpack _item} };
			};
		};
	};
} forEach _items;
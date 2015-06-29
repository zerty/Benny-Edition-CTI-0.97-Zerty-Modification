/*
  # HEADER #
	Script: 		Common\Functions\CTI_CO_FNC_EquipContainerVest.sqf
	Alias:			CTI_CO_FNC_EquipContainerVest
					Note that BIS didn't add a command for it...
	Description:	Alter the content of the vest and it's items on a unit.
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013

  # PARAMETERS #
    0	[Object]: The unit
    1	[String]: The vest classname
    2	[Array]: The items to add in the vest

  # RETURNED VALUE #
	None

  # SYNTAX #
	[UNIT, CLASSNAME, ITEMS] call CTI_CO_FNC_EquipContainerVest

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_GetItemBaseConfig

  # EXAMPLE #
	[player, "V_TacVest_oli", ["Laserbatteries","7Rnd_408_Mag",...]] call CTI_CO_FNC_EquipContainerVest;
*/

private ["_added", "_items", "_unit", "_vest"];

_unit = _this select 0;
_vest = _this select 1;
_items = _this select 2;

if (vest _unit != "") then {removeVest _unit}; //todo clearAllItemsFromVest if it ever gets added someday.
// if (vest _unit != _vest) then { removeVest _unit }; //todo clearAllItemsFromVest if it ever gets added someday.
if (_vest != "" && vest _unit == "") then { _unit addVest _vest };

_added = [];
{
	_item = _x;
	if (_item != "") then {
		if !(_item in _added) then {
			//_base = (_item) call CTI_CO_FNC_GetItemBaseConfig;
			_added pushBack _item;
			_count = {_x == _item} count _items;

			(vestContainer _unit) addItemCargoGlobal [_item, _count];
			/*switch (_base) do { //todo figure out bout that goggle mystery
				case "CfgMagazines": { (vestContainer _unit) addMagazineCargoGlobal [_item, _count] };
				case "CfgWeapons": { (vestContainer _unit) addWeaponCargoGlobal [_item, _count] };
				case "Item": { (vestContainer _unit) addItemCargoGlobal [_item, _count] };
				case "Goggles": { for '_i' from 1 to _count do {_unit addItemToVest _item} };
			};*/
			// player sidechat format ["when bis will add the commands, maybe i'll be able to add a %1 in my vest..", _item];
		};
	};
} forEach _items;
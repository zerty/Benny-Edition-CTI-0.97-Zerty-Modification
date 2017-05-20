/*
  # HEADER #
	Script: 		Common\Functions\Common_GetGearItemCost.sqf
	Alias:			CTI_CO_FNC_GetGearItemCost
	Description:	Get an item cost (weapons, magazine, item...)
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[String]: The item classname

  # RETURNED VALUE #
	[Number]: The item cost, 0 by default

  # SYNTAX #
	(CLASSNAME) call CTI_CO_FNC_GetGearItemCost

  # EXAMPLE #
    _cost = (primaryWeapon player) call CTI_CO_FNC_GetGearItemCost;
    _cost = ("30Rnd_556x45_Stanag") call CTI_CO_FNC_GetGearItemCost;
    _cost = ("arifle_Katiba_F") call CTI_CO_FNC_GetGearItemCost;
    _cost = ("B_AssaultPack_khk") call CTI_CO_FNC_GetGearItemCost;
*/

private ["_cost", "_item", "_var"];

_item = _this;

_cost = 0;
_var = missionNamespace getVariable _item;
if (!(isNil '_var') && ({_x==_item} count (missionNamespace getVariable "cti_gear_all")>0)) then { _cost = (_var select 0) select 1 };

_cost
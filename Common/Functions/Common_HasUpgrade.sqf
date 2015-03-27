/*
  # HEADER #
	Script: 		Common\Functions\Common_HasUpgrade.sqf
	Alias:			CTI_CO_FNC_HasUpgrade
	Description:	Check if a side has the given upgrade
	Author: 		Benny
	Creation Date:	17-10-2013
	Revision Date:	17-10-2013

  # PARAMETERS #
    0	[Side]: The side
    1	[Integer]: The upgrade
    2	[Integer]: The upgrade level

  # RETURNED VALUE #
	[Boolean]: True if the existing upgrade level is (or above) the desired one

  # SYNTAX #
	[SIDE, UPGRADE, UPGRADE LEVEL] call CTI_CO_FNC_HasUpgrade

  # EXAMPLE #
    _has_barracks1 = [west, CTI_UPGRADE_BARRACKS, 1] call CTI_CO_FNC_HasUpgrade;
    _has_occupation2 = [west, CTI_UPGRADE_TOWNS, 2] call CTI_CO_FNC_HasUpgrade;
*/

private ["_side", "_upgrade", "_upgrade_level", "_upgrades"];

_side = _this select 0;
if (_side == resistance) exitWith {false};
_upgrade = _this select 1;
_upgrade_level = _this select 2;

_upgrades = (_side) call CTI_CO_FNC_GetSideUpgrades;
_existing = _upgrades select _upgrade;

if (_existing >= _upgrade_level) then {true} else {false}
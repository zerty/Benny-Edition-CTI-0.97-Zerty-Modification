0 execVM "Addons\Henroth_AirLoadout\Set_WeaponLoadouts.sqf";


	// AIR Customisation fuctions
	CTI_AC_REFRESH_LOADOUT_ON_MOUNTED = compileFinal preprocessFileLineNumbers "Addons\Henroth_AirLoadout\Common_ACRefreshLoadoutMounted.sqf";
	CTI_AC_GET_STANDARD_EMPTY_LOADOUT = compileFinal preprocessFileLineNumbers "Addons\Henroth_AirLoadout\Common_ACGetStandardEmptyLoadout.sqf";
	CTI_AC_GET_STANDARD_VANILLA_LOADOUT = compileFinal preprocessFileLineNumbers "Addons\Henroth_AirLoadout\Common_ACGetStandardVanillaLoadout.sqf";
	CTI_AC_GET_VEHCICLE_LOADOUT_COST = compileFinal preprocessFileLineNumbers "Addons\Henroth_AirLoadout\Common_ACGetVehicleLoadoutCost.sqf";
if (CTI_isCLient) then {
	0 execVM "Addons\Henroth_AirLoadout\Functions_UI_AircraftLoadoutMenu.sqf";
};

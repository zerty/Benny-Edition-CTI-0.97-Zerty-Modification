/*
  # HEADER #
	Script: 		Common\Functions\Common_RearmVehicle.sqf
	Alias:			CTI_CO_FNC_RearmVehicle
	Description:	Rearm a vehicle and it's turrets
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	14-10-2013

  # PARAMETERS #
    0	[Object]: The vehicle
    1	[Side]: The side of the vehicle

  # RETURNED VALUE #
	None

  # SYNTAX #
	[VEHICLE, SIDE] call CTI_CO_FNC_RearmVehicle

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_SanitizeAircraft
	Common Function: CTI_CO_FNC_SanitizeArtillery

  # EXAMPLE #
    [vehicle player, CTI_P_SideJoined] call CTI_CO_FNC_RearmVehicle;
	  -> Rearm the player vehicle of the player
*/

private ["_side", "_type", "_vehicle"];

_vehicle = _this select 0;
_side = _this select 1;
_type = typeOf _vehicle;
_t_side = if (typeName _side == "SCALAR") then {(_side call CTI_CO_FNC_GetSideFromID)} else {_side};

//_vehicle setVehicleAmmoDef 1;

// Fix for air vehicles ... uses sanatise script to clean up afterwards
if ( _vehicle isKindOf "Air" && (!(_vehicle isKindOf "O_Plane_Fighter_02_F")) && (!(_vehicle isKindOf "B_Plane_Fighter_01_F")) && (!(_vehicle isKindOf "I_Plane_Fighter_04_F")) && (missionNamespace getVariable "CTI_AC_ENABLED")>0) then
{
	_vehicle call CTI_AC_PURGE_ALL_WEAPONS;
	_vehicle call CTI_AC_REFRESH_LOADOUT_ON_MOUNTED;
	if (_vehicle isKindOf "Air") then {[_vehicle, _side] call CTI_CO_FNC_SanitizeAircraft};
} else {

	//--- Driver
	{_vehicle removeMagazineTurret [_x, [-1]];} forEach (getArray(configFile >> "CfgVehicles" >> _type >> "magazines"));
	{_vehicle addMagazineTurret [_x, [-1]]} forEach (getArray(configFile >> "CfgVehicles" >> _type >> "magazines"));
	
	if (_vehicle isKindOf "O_Plane_Fighter_02_F") then {
	_vehicle setAmmoOnPylon [1, 0];
	_vehicle setAmmoOnPylon [2, 0];
	_vehicle setAmmoOnPylon [3, 0];
	_vehicle setAmmoOnPylon [4, 0];
	_vehicle setAmmoOnPylon [5, 0];
	_vehicle setAmmoOnPylon [6, 0];
	_vehicle setAmmoOnPylon [7, 0];
	_vehicle setAmmoOnPylon [8, 0];
	_vehicle setAmmoOnPylon [9, 0];
	_vehicle setAmmoOnPylon [10, 0];
	_vehicle setAmmoOnPylon [11, 0];
	_vehicle setAmmoOnPylon [12, 0];
	_vehicle setAmmoOnPylon [13, 0];

	_vehicle setPylonLoadOut [13, "PylonMissile_1Rnd_BombCluster_02_cap_F", false, []];
	_vehicle setAmmoOnPylon [13, 2];

	if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AT) == 1) then {
		_vehicle setPylonLoadOut [3, "PylonMissile_Missile_AGM_KH25_x1", false, []];
		_vehicle setPylonLoadOut [4, "PylonMissile_Missile_AGM_KH25_x1", false, []];
		_vehicle setPylonLoadOut [5, "PylonMissile_Missile_AGM_KH25_x1", false, []];
		_vehicle setPylonLoadOut [6, "PylonMissile_Missile_AGM_KH25_x1", false, []];
	};
	if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AA) == 1) then {
		_vehicle setPylonLoadOut [1, "PylonMissile_Missile_AA_R77_x1", false, []];
		_vehicle setPylonLoadOut [2, "PylonMissile_Missile_AA_R77_x1", false, []];
		_vehicle setPylonLoadOut [7, "PylonMissile_Missile_AA_R73_x1", false, []];
		_vehicle setPylonLoadOut [8, "PylonMissile_Missile_AA_R73_x1", false, []];
	};
	if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_CM) == 1) then {
		_vehicle addWeapon "CMFlareLauncher";
	};
	};
	
	if (_vehicle isKindOf "B_Plane_Fighter_01_F") then {
	_vehicle setAmmoOnPylon [1, 0];
	_vehicle setAmmoOnPylon [2, 0];
	_vehicle setAmmoOnPylon [3, 0];
	_vehicle setAmmoOnPylon [4, 0];
	_vehicle setAmmoOnPylon [5, 0];
	_vehicle setAmmoOnPylon [6, 0];
	_vehicle setAmmoOnPylon [7, 0];
	_vehicle setAmmoOnPylon [8, 0];
	_vehicle setAmmoOnPylon [9, 0];
	_vehicle setAmmoOnPylon [10, 0];
	_vehicle setAmmoOnPylon [11, 0];
	_vehicle setAmmoOnPylon [12, 0];
	
	_vehicle setPylonLoadOut [11, "PylonMissile_1Rnd_BombCluster_03_F", false, []];
	_vehicle setPylonLoadOut [12, "PylonMissile_1Rnd_BombCluster_03_F", false, []];
		
	if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AT) == 1) then {
		_vehicle setPylonLoadOut [1, "PylonRack_Missile_AGM_02_x1", false, []];
		_vehicle setPylonLoadOut [2, "PylonRack_Missile_AGM_02_x1", false, []];
		_vehicle setPylonLoadOut [3, "PylonRack_Missile_AGM_02_x1", false, []];
		_vehicle setPylonLoadOut [4, "PylonRack_Missile_AGM_02_x1", false, []];
	};
	if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AA) == 1) then {
		_vehicle setPylonLoadOut [5, "PylonMissile_Missile_BIM9X_x1", false, []];
		_vehicle setPylonLoadOut [6, "PylonMissile_Missile_BIM9X_x1", false, []];
		_vehicle setPylonLoadOut [7, "PylonMissile_Missile_AMRAAM_D_INT_x1", false, []];
		_vehicle setPylonLoadOut [8, "PylonMissile_Missile_AMRAAM_D_INT_x1", false, []];
	};
	if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_CM) == 1) then {
		_vehicle addWeapon "CMFlareLauncher_Singles";
	};
	};
	
	if (_vehicle isKindOf "I_Plane_Fighter_04_F") then {
		_vehicle setAmmoOnPylon [1, 0];
		_vehicle setAmmoOnPylon [2, 0];
		_vehicle setAmmoOnPylon [3, 0];
		_vehicle setAmmoOnPylon [4, 0];
		_vehicle setAmmoOnPylon [5, 0];
		_vehicle setAmmoOnPylon [6, 0];
		
		if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AT) == 1) then {
		_vehicle setPylonLoadOut [3, "PylonRack_Missile_AGM_02_x1", false, []];
		_vehicle setPylonLoadOut [4, "PylonRack_Missile_AGM_02_x1", false, []];
		};
		if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AA) == 1) then {
		_vehicle setPylonLoadOut [1, "PylonMissile_Missile_BIM9X_x1", false, []];
		_vehicle setPylonLoadOut [2, "PylonMissile_Missile_BIM9X_x1", false, []];
		_vehicle setPylonLoadOut [5, "PylonRack_Missile_AMRAAM_C_x1", false, []];
		_vehicle setPylonLoadOut [6, "PylonRack_Missile_AMRAAM_C_x1", false, []];
		};
		if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_CM) == 1) then {
		_vehicle addWeapon "CMFlareLauncher";
		};
	};

	//--- Turrets
	_config = configFile >> "CfgVehicles" >> _type >> "turrets";
	for '_i' from 0 to (count _config)-1 do {
		_turret_main = _config select _i;
		_config_sub = _turret_main >> "turrets";
		{_vehicle removeMagazineTurret [_x, [_i]];} forEach (getArray(_turret_main >> "magazines"));
		{ _vehicle addMagazineTurret [_x, [_i]]} forEach (getArray(_turret_main >> "magazines"));
		for '_j' from 0 to (count _config_sub) -1 do {
			_turret_sub = _config_sub select _j;
			{_vehicle removeMagazineTurret [_x, [_i, _j]];} forEach (getArray(_turret_sub >> "magazines"));
			{_vehicle addMagazineTurret [_x, [_i, _j]];} forEach (getArray(_turret_sub >> "magazines"));
		};
	};

	//--- Authorize the air loadout depending on the parameters set
	if ((_vehicle isKindOf "Air") && (!(_vehicle isKindOf "O_Plane_Fighter_02_F")) && (!(_vehicle isKindOf "B_Plane_Fighter_01_F")) && (!(_vehicle isKindOf "I_Plane_Fighter_04_F"))) then {[_vehicle, _side] call CTI_CO_FNC_SanitizeAircraft};

	//--- Sanitize the artillery loadout, mines may lag the server for instance
	if (CTI_ARTILLERY_FILTER == 1) then {if (typeOf _vehicle in (missionNamespace getVariable ["CTI_ARTILLERY", []])) then {(_vehicle) call CTI_CO_FNC_SanitizeArtillery}};

	// Reload the trophy system

	if (_vehicle isKindOf "tank" || _vehicle isKindOf "Wheeled_APC_F") then {
		_ammo=if (! (count ((_side) call CTI_CO_FNC_GetSideUpgrades) == 0)) then {2+2*(((_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TRA)} else {2};
		_vehicle setVariable ["TROPHY_time_l",time-10000,true];
		_vehicle setVariable ["TROPHY_time_r",time-10000,true];
		_vehicle setVariable ["TROPHY_ammo_l",ceil(_ammo/2),true];
		_vehicle setVariable ["TROPHY_ammo_r",ceil(_ammo/2),true];

	};
	
		if (_vehicle isKindOf "B_SAM_System_01_F" || _vehicle isKindOf "B_SAM_System_02_F") then {
		_vehicle setAmmo [currentWeapon _vehicle, 0];
		_vehicle setAmmo [currentWeapon _vehicle, 21];
	};
};
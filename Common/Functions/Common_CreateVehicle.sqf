/*
  # HEADER #
	Script: 		Common\Functions\Common_CreateVehicle.sqf
	Alias:			CTI_CO_FNC_CreateVehicle
	Description:	Create an empty vehicle
					Note that making a vehicle public with the _net variable will make it
					undergo the function CTI_CO_FNC_InitializeNetVehicle
					A public vehicle is initialized for all (+JIP) but the server
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	12-05-2018

  # PARAMETERS #
    0	[String]: The type of vehicle to create
    1	[Array/Object]: The 2D/3D position where the vehicle should be created at
    2	[Integer]: The Azimuth direction (0-360?) of the vehicle
    3	[Side/Integer]: The Side or Side ID of the vehicle
    4	{Optionnal} [Boolean]: Determine if the vehicle should be created locked or not
    5	{Optionnal} [Boolean]: Determine if the vehicle should be "public" or not
    6	{Optionnal} [Boolean]: Determine if the vehicle should be handled upon destruction or not (bounty...tk...)
    7	{Optionnal} [String]: Set a special spawn mode for the vehicle

  # RETURNED VALUE #
	[Object]: The created vehicle

  # SYNTAX #
	[CLASSNAME, POSITION, DIRECTION, SIDE] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC, HANDLED] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC, HANDLED, SPECIAL] call CTI_CO_FNC_CreateVehicle

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_OnUnitGetOut
	Common Function: CTI_CO_FNC_OnUnitHit
	Common Function: CTI_CO_FNC_OnUnitKilled

  # EXAMPLE #
	_vehicle = ["B_Quadbike_01_F", getPos player, 0, CTI_P_SideJoined] call CTI_CO_FNC_CreateVehicle;
	  -> Create a "B_Quadbike_01_F" at the player's position facing North on the player's initial side
	_vehicle = ["B_Quadbike_01_F", getPos player, 180, CTI_P_SideJoined, true, true] call CTI_CO_FNC_CreateVehicle;
	  -> Create a locked and handled "B_Quadbike_01_F" at the player's position facing South on the player's initial side
*/

private ["_direction", "_handle", "_locked", "_net", "_position", "_side", "_special", "_type", "_vehicle"];

_type = _this select 0;
_position = _this select 1;
_direction = _this select 2;
_side = _this select 3;
_locked = if (count _this > 4) then {_this select 4} else {false};
_net = if (count _this > 5) then {_this select 5} else {false};
_handle = if (count _this > 6) then {_this select 6} else {false};
_special = if (count _this > 7) then {_this select 7} else {"FORM"};
_created = if (count _this > 8) then {_this select 8} else {objNull};
_t_side=if (typeName _side == "SCALAR") then {(_side call CTI_CO_FNC_GetSideFromID)} else {_side};
if (typeName _position == "OBJECT") then {_position = getPos _position};
if (typeName _side == "SIDE") then {_side = (_side) call CTI_CO_FNC_GetSideID};


_vehicle = if ( isNull _created) then {createVehicle [_type, _position, [], 7, _special]} else {_created};


// henroth air loadout
//Does a gun config exsist?
_gun_config = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , typeOf _vehicle ] );
if (
( 	((typeOf _vehicle) == "O_APC_Tracked_02_AA_F")
	|| ((typeOf _vehicle) == "B_APC_Tracked_01_AA_F")
	|| _type isKindOf "Air")
&& (missionNamespace getVariable "CTI_AC_ENABLED")>0
&& _side != CTI_RESISTANCE_ID
&& CTI_isCLient
&& !isNil "_gun_config") then
{
	_vanilla_loadout = _vehicle call CTI_AC_GET_STANDARD_VANILLA_LOADOUT;
	_vehicle setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_MOUNTED", (_vanilla_loadout) , true ];
	_vehicle setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_COST", ( _vehicle call CTI_AC_GET_VEHCICLE_LOADOUT_COST ) , true ];
	_vehicle setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY_TIME" , 0 , true ]; // Last time locked
	_vehicle setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY", false , true ]; // Semaphore
};

if (isNull _created) then {
	_vehicle setDir _direction;

	if (_vehicle isKindOf "CAR" || _vehicle isKindOf "TANK") then {
		_ep = (getPos _vehicle) findEmptyPosition [0,100,"O_T_VTOL_02_vehicle_dynamicLoadout_F"];
		if (count _ep == 0) then {_ep = (getPos _vehicle) findEmptyPosition [0,250,"O_T_VTOL_02_vehicle_dynamicLoadout_F"];};
		_vehicle setPos _ep;
	};

	if (_vehicle isKindOf "HELICOPTER" && _special == "FORM" && _side != CTI_RESISTANCE_ID) then {
		_pads = nearestObjects [getPos _vehicle, ["Helipad_Base_F"], 150];
		_free = [];
		if (count _pads > 0) then {
			for "_i" from 0 to (count _pads - 1) do {
				_no = nearestObjects [getPos (_pads select _i), [], 9];
				_double = "Helipad_Base_F" countType _no;
				if (_no isEqualTo [_pads select _i] || _double == count _no) then {_free = _free + [getPos (_pads select _i)];};
			};
		};
		if (count _free > 0) then {_vehicle setPos (selectRandom _free);} else {_vehicle setPos (getPos _vehicle);};
	};

	if (_vehicle isKindOf "SHIP" && _side != CTI_RESISTANCE_ID) then {
		_wp = [getPos _vehicle, 0, 75, 7, 2, 1, 0] call BIS_fnc_findSafePos;
		if (count _wp == 0) then {_wp = getPos _vehicle};
		_vehicle setPos _wp;
	};

	//if (_special == "FORM") then {_vehicle setPos [(getPos _vehicle) select 0, (getPos _vehicle) select 1, 0.75];}; //--- Make the vehicle spawn above the ground level to prevent any bisteries
	if (_special == "FORM") then {_vehicle setPos [(getPos _vehicle) select 0, (getPos _vehicle) select 1];};
	// --- Zerty edit
	if (_type isKindOf "UAV" || _type isKindOf "UGV_01_base_F") then {createVehicleCrew _vehicle};

	if (_vehicle isKindOf "B_T_UAV_03_dynamicLoadout_F") then {createVehicleCrew _vehicle};


	//Ensures any air vehicle does not have a weapon that is not researched (SanitizeAircraft)
	if (
	((_side == CTI_EAST_ID) || (_side == CTI_WEST_ID))
	&& CTI_isCLient
	&& !(isNil "CTI_ALM_AA_RESEARCHED_MAGAZINES") //makes sure henroths loadouts are set
	&& (_type isKindOf "Air"
		|| (_vehicle isKindOf "O_APC_Tracked_02_AA_F")
		|| (_vehicle isKindOf "B_APC_Tracked_01_AA_F"))
	) then {
		//Setting default loadout for given aircraft
		if ((missionNamespace getVariable "CTI_AC_ENABLED")>0 && !isNil "_gun_config") then {
			_vehicle setVehicleAmmo 0;
			_vehicle call CTI_AC_PURGE_ALL_WEAPONS;
			[_vehicle, _t_side] call CTI_AC_REFRESH_LOADOUT_ON_MOUNTED;
			//[_vehicle, _t_side] call CTI_CO_FNC_SanitizeAircraft; //is no longer needed
		} else {
		//Testing for aircraft that do not have an loadout configured

			//For Pylon system: Test all pylons if not researched weapon is present - remove it
			{
				_pylon = configName(_x); //needs to be number
				_pylonIndex = _forEachIndex +1; //needs to be number
				_default_magazine = getText (configFile >> "CfgVehicles" >> _type >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _pylon >> "attachment");

				//No ATGM  if upgrade not present
				if (((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AT) == 0)
				&& (_default_magazine in CTI_ALM_ATGM_RESEARCHED_MAGAZINES)) then {
					_vehicle setPylonLoadOut [_pylonIndex, "", true];
					_//vehicle setAmmoOnPylon [_pylonIndex, 0];
				};
				//No AA  if upgrade not present
				if (((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AA) == 0)
				&& (_default_magazine in CTI_ALM_AA_RESEARCHED_MAGAZINES)) then {
					_vehicle setPylonLoadOut [_pylonIndex, "", true];
					//_vehicle setAmmoOnPylon [_pylonIndex, 0];
				};
				//No FFAR  if upgrade not present
				if (((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_FFAR) == 0)
				&& (_default_magazine in CTI_ALM_FFAR_RESEARCHED_MAGAZINES)) then {
					_vehicle setPylonLoadOut [_pylonIndex, "", true];
					//_vehicle setAmmoOnPylon [_pylonIndex, 0];
				};
			} forEach (configProperties [configFile >> "CfgVehicles" >> _type >> "Components" >> "TransportPylonsComponent" >> "Pylons"]);

			//For old system: Test all weapons if not researched weapon is present - remove it
			{
				_mag 			= _x select 0;
				_turret_path 	= _x select 1;
				_ammo_count 	= _x select 2;
				_id 			= _x select 3;
				_creator 		= _x select 4;

				//No ATGM  if upgrade not present
				if (((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AT) == 0)
				&& _mag in CTI_ALM_ATGM_RESEARCHED_MAGAZINES) then {
					_vehicle removeMagazineTurret [_mag,_turret_path];
				};
				//No AA  if upgrade not present
				if (((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_AA) == 0)
				&& _mag in CTI_ALM_AA_RESEARCHED_MAGAZINES) then {
					_vehicle removeMagazineTurret [_mag,_turret_path];
				};
				//No FFAR  if upgrade not present
				if (((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_FFAR) == 0)
				&& _mag in CTI_ALM_FFAR_RESEARCHED_MAGAZINES)  then {
					_vehicle removeMagazineTurret [_mag,_turret_path];
				};
			} forEach (magazinesAllTurrets _vehicle);

			//No CM  if upgrade not present
			if ((((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_AIR_CM) == 0) then {
				_vehicle setAmmo ["CMFlareLauncher", 0];
			};
		};
	};

	if (_special == "FLY" && _vehicle isKindOf "Plane") then {
		_vehicle setVelocity [75 * (sin _direction), 75 * (cos _direction), 0];
	} else {
		_vehicle setVelocity [0,0,1];
	};

	//Spawn with components [H]Tom
	if (_vehicle isKindOf "Wheeled_APC_F" || _vehicle isKindOf "Tank") then {
		if (_vehicle isKindOf "I_APC_Wheeled_03_cannon_F") then {[_vehicle, nil, ["showTools",1]] call BIS_fnc_initVehicle;};
		if (_vehicle isKindOf "O_APC_Wheeled_02_rcws_v2_F" || _vehicle isKindOf "O_T_APC_Wheeled_02_rcws_v2_ghex_F") then {[_vehicle, nil, ["showTools",1]] call BIS_fnc_initVehicle;};
		if (_vehicle isKindOf "O_MBT_02_arty_F" || _vehicle isKindOf "O_T_MBT_02_arty_ghex_F") then {[_vehicle, nil, ["showLog",1]] call BIS_fnc_initVehicle;};
		if (_vehicle isKindOf "I_LT_01_AT_F" || _vehicle isKindOf "I_LT_01_AA_F" || _vehicle isKindOf "I_LT_01_scout_F" || _vehicle isKindOf "I_LT_01_cannon_F") then {[_vehicle, nil, ["showTools",1]] call BIS_fnc_initVehicle;};
		if (_vehicle isKindOf "O_APC_Tracked_02_cannon_F" || _vehicle isKindOf "O_T_APC_Tracked_02_cannon_ghex_F") then {[_vehicle, nil, ["showTracks",1]] call BIS_fnc_initVehicle;};
		if (_vehicle isKindOf "I_APC_tracked_03_cannon_F") then {[_vehicle, nil, ["showBags2",1,"showTools",1]] call BIS_fnc_initVehicle;};
		if (_vehicle isKindOf "I_MBT_03_cannon_F") then {[_vehicle, nil, ["HideTurret",1,"HideHull",1]] call BIS_fnc_initVehicle;};
		if (_vehicle isKindOf "O_MBT_02_cannon_F" || _vehicle isKindOf "O_T_MBT_02_cannon_ghex_F") then {[_vehicle, nil, ["showLog",1]] call BIS_fnc_initVehicle;};
		if (_vehicle isKindOf "O_APC_Tracked_02_AA_F" || _vehicle isKindOf "O_T_APC_Tracked_02_AA_ghex_F") then {[_vehicle, nil, ["showTracks",1]] call BIS_fnc_initVehicle;};
	};
	if (_vehicle isKindOf "Car") then {
		_offroads = ["I_G_Offroad_01_F", "I_G_Offroad_01_armed_F", "I_G_Offroad_01_AT_F", "B_G_Offroad_01_F", "B_G_Offroad_01_armed_F", "B_G_Offroad_01_AT_F", "O_G_Offroad_01_F", "O_G_Offroad_01_armed_F", "O_G_Offroad_01_AT_F"];
		if ((typeOf _vehicle) in _offroads) then {
		_offroadcolors = ["Guerilla_01", "Guerilla_02", "Guerilla_03", "Guerilla_04", "Guerilla_05", "Guerilla_06", "Guerilla_07", "Guerilla_08", "Guerilla_09", "Guerilla_10", "Guerilla_11", "Guerilla_12"];
		[_vehicle, [(selectRandom _offroadcolors),1], nil] call BIS_fnc_initVehicle;};
		_4wds = ["I_C_Offroad_02_unarmed_F", "I_C_Offroad_02_LMG_F", "I_C_Offroad_02_AT_F", "C_Offroad_02_unarmed_F"];
		if ((typeOf _vehicle) in _4wds) then {
		_4wdcolors = ["Green", "Olive", "Black", "Brown"];
		[_vehicle, [(selectRandom _4wdcolors),1], nil] call BIS_fnc_initVehicle;};
	};

};

//Add Data link
if(count ((_t_side) call CTI_CO_FNC_GetSideUpgrades) >= CTI_UPGRADE_DATA) then {
if(((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_DATA == 1) then {
	_vehicle setVehicleReportOwnPosition true;
	_vehicle setVehicleReportRemoteTargets true;
	_vehicle setVehicleReceiveRemoteTargets true;
};};


if (missionNamespace getVariable "CTI_TROPHY_APS" == 1) then {
	if (_vehicle isKindOf "tank" || _vehicle isKindOf "Wheeled_APC_F") then {

		_ammo=if (! (count ((_t_side) call CTI_CO_FNC_GetSideUpgrades) == 0) ) then {2+2*(((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TRA)} else {2};
		if (isNil "_ammo") then {_ammo = 2};
		_vehicle setVariable ["TROPHY_time_l",time-10000,true];
		_vehicle setVariable ["TROPHY_time_r",time-10000,true];
		_vehicle setVariable ["TROPHY_ammo_l",ceil(_ammo/2),true];
		_vehicle setVariable ["TROPHY_ammo_r",ceil(_ammo/2),true];

	};
};



if ((missionNamespace getVariable [format ["%1", typeOf _vehicle],["","","","","","","",""]]) select 7 != "") then {
	_side_logic=(_side call CTI_CO_FNC_GetSideFromID) call CTI_CO_FNC_GetSideLogic;
	_current=_side_logic getVariable ["cti_service", []];
	_current=_current -[objNull];
	_current set [count _current,_vehicle];
	_side_logic setVariable ["cti_service", _current,true];
};



if (_locked && !( _vehicle isKindOf "Thing") && !( _vehicle isKindOf "StaticWeapon") && !( _vehicle isKindOf "UAV") && !( _vehicle isKindOf "UGV_01_base_F") && !( _vehicle isKindOf "B_T_UAV_03_dynamicLoadout_F")) then {_vehicle lock 2} else {_vehicle lock 0};
if (_net && !( _vehicle isKindOf "Thing")) then {_vehicle setVariable ["cti_net", _side, true]};
if (_handle) then {
	_vehicle addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _side]]; //--- Called on destruction
	_vehicle addEventHandler ["hit", {_this spawn CTI_CO_FNC_OnUnitHit}]; //--- Register importants hits
	//--- Track who get in or out of the vehicle so that we may determine the death more easily
	_vehicle addEventHandler ["getIn", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	_vehicle addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	_vehicle setVariable ["cti_occupant", _side call CTI_CO_FNC_GetSideFromID,true];
};


//disable net for offroads (JIP issue with BIS bug) + static load
if (_net &&missionNamespace getVariable "CTI_EW_ANET" == 1 && !(_side == CTI_RESISTANCE_ID)&& !( _vehicle isKindOf "Thing")) then {
	["SERVER","Server_Run_Net",[_vehicle,_side]] call CTI_CO_FNC_NetSend;
};

// fix for empty resistance vehicles
if (_vehicle getVariable ["CTI_Net",100]==100 && (_side == CTI_RESISTANCE_ID)) then {_vehicle setvariable ["CTI_Net",CTI_RESISTANCE_ID,true];};

if (_vehicle isKindOf "CargoNet_01_base_F") then {
	clearBackpackCargoGlobal _vehicle;
	clearMagazineCargoGlobal  _vehicle;
	clearWeaponCargoGlobal _vehicle;
	clearItemCargoGlobal  _vehicle;
};



//AdminZeus

if !( isNil "ADMIN_ZEUS") then {
	if !(CTI_isServer) then {
		["SERVER", "Server_Addeditable",[ADMIN_ZEUS,_vehicle]] call CTI_CO_FNC_NetSend;
	} else {
		ADMIN_ZEUS addCuratorEditableObjects [[_vehicle],true] ;
	};
};

//artillery radar revamp
if (missionNamespace getVariable "CTI_SM_RADAR" == 1) then {

	["SERVER", "Server_ARTR_handle",_vehicle] call CTI_CO_FNC_NetSend;
	["SERVER", "Server_AIRR_handle",_vehicle] call CTI_CO_FNC_NetSend;
};



//trophy system
if (missionNamespace getVariable "CTI_TROPHY_APS" == 1) then {
	_vehicle addEventHandler["Fired","_this call TR_HANDLER;"];
};


// weigth fix
if ((_vehicle isKindOf "Pod_Heli_Transport_04_base_F") || (_vehicle isKindOf "Slingload_01_Base_F")  ) then { _vehicle setmass [2000,0];};


//cache

if ((!((_vehicle isKindOf "Plane") || (_vehicle isKindOf "UAV") ||(_vehicle isKindOf "Pod_Heli_Transport_04_base_F") || (_vehicle isKindOf "Slingload_01_Base_F")))  && (missionNamespace getVariable "CACHE_EMPTY") == 1)then {
 ["SERVER", "Request_Cache", _vehicle] call CTI_CO_FNC_NetSend;
};

//wheel protection
if (_vehicle isKindOf "Car" && ! isnil "H_PROTECT_WHEELS") then {
	_vehicle setVariable ["wheel_prot",true,true];
	["CLIENT", "Protect_Wheels", _vehicle,true] call CTI_CO_FNC_NetSend;
	["SERVER", "Protect_Wheels", _vehicle,true] call CTI_CO_FNC_NetSend;

};

//Disable Repair/Rearm/Refuel actions
_vehicle setAmmoCargo 0;
_vehicle setFuelCargo 0;
_vehicle setRepairCargo 0;

//tutorial protection

_vehicle spawn {
	while { !isNull _this && alive _this && ! cti_gameover } do {
		    sleep 20;
		    if ((([_this,getMarkerPos "CTI_TUTORIAL"] call  BIS_fnc_distance2D) < 1000) && !isNull _this && alive _this) then {_this setDamage 1};
		};
};


// attachement system

if (_vehicle  isKindOf "Helicopter") then {
	_vehicle addEventHandler ["RopeAttach", {	["SERVER", "Request_Locality", [(_this select 2), (_this select 0)]] call CTI_CO_FNC_NetSend ;  }];
};

//_vehicle addEventHandler ["getIn", {if ((isplayer (_this select 2)) && ({isplayer _x} count (crew (_this select 0)))<2) exitwith {(_this select 2) assignAsCommander (_this select 0)}}];


_vehicle
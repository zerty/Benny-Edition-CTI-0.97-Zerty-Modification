/*
  # HEADER #
	Script: 		Common\Functions\Common_CreateUnit.sqf
	Alias:			CTI_CO_FNC_CreateUnit
	Description:	Create a simple unit for a group
					Note that making a unit public with the _net variable will make it
					undergo the function CTI_CO_FNC_InitializeNetVehicle
					A public unit is initialized for all (+JIP) but the server
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013

  # PARAMETERS #
    0	[String]: The type of unit to create
    1	[Group]: The team that the unit should belong to
    2	[Array/Object]: The 2D/3D position where the unit should be created at
    3	[Side/Integer]: The Side or Side ID of the unit
    4	{Optionnal} [Boolean]: Determine if the unit should be "public" or not
    5	{Optionnal} [String]: Set a special spawn mode for the unit

  # RETURNED VALUE #
	[Object]: The created unit

  # SYNTAX #
	[CLASSNAME, GROUP, POSITION, SIDE] call CTI_CO_FNC_CreateUnit
	[CLASSNAME, GROUP, POSITION, SIDE, PUBLIC] call CTI_CO_FNC_CreateUnit
	[CLASSNAME, GROUP, POSITION, SIDE, PUBLIC, SPECIAL] call CTI_CO_FNC_CreateUnit

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID

  # EXAMPLE #
	_unit = ["B_Soldier_F", group player, getPos player, CTI_P_SideJoined] call CTI_CO_FNC_CreateUnit;
	  -> Create a "B_Soldier_F" at the player's position
	_unit = ["B_Soldier_F", group player, getPos player, CTI_P_SideJoined, true, "NONE"] call CTI_CO_FNC_CreateUnit;
	  -> Create a "B_Soldier_F" at the player's position, initialize it over the network and ignore the formation on creation
*/

private ["_net", "_position", "_sideID", "_special", "_team", "_type", "_unit"];

_classname = _this select 0;
_team = _this select 1;
_position = _this select 2;
_sideID = _this select 3;
_net = if (count _this > 4) then {_this select 4} else {false};
_special = if (count _this > 5) then {_this select 5} else {"FORM"};

if (CTI_Log_Level >= CTI_Log_Debug) then {
	["DEBUG", "FILE: Common\Functions\Common_CreateUnit.sqf", format["Attempting to create a [%1] unit on team [%2] at [%3] on side [%4], net? [%5] special? [%6]", _classname, _team, _position, _sideID, _net, _special]] call CTI_CO_FNC_Log;
};

if (typeName _position == "OBJECT") then {_position = getPos _position};
if (typeName _sideID == "SIDE") then {_sideID = (_sideID) call CTI_CO_FNC_GetSideID};
_position=[_position select 0,_position select 1,0];
_unit = _team createUnit [_classname, _position, [], 0, _special];

if (_unit isKindOf "Man") then {

	_nearesthouse = typeOf ((position _unit) nearestObject "House");
	_nearesthousepos = getPos ((position _unit) nearestObject "House");
	_nearesthouseradius = round (sizeOF _nearesthouse / 2);
	if (_nearesthouse == "Land_Shed_Big_F" || _nearesthouse == "Land_SM_01_shelter_wide_F") then {_nearesthouseradius = 16;};
	if ((_nearesthouse in CTI_BUILDINGPOS_MISSING) && ((_unit distance2d _nearesthousepos) < (_nearesthouseradius))) then {
	[_unit, _position] call KK_fnc_setPosAGLS;
	_unit setPos [getPos _unit select 0, getPos _unit select 1, 0.25];
	} else {
	[_unit, _position] call KK_fnc_setPosAGLS;
	};

	if (((_unit distance2d nearestbuilding _unit) < 10) && (!(typeOF nearestbuilding _unit in CTI_BUILDINGPOS_MISSING))) then {
	_buildingpos = nearestBuilding _unit buildingPos -1;
	if (count _buildingpos > 10) then {_buildingpos deleteRange [(count _buildingpos / 3), count _buildingpos];};
	_unit setpos (selectrandom _buildingpos);
	};
};

//_unit setSkill (0.3 + (random 0.5));//tbd tweak
//--- bl1p and fluit rnd skills START

// Call the function
_AISkill = missionNamespace getVariable "CTI_AI_SKILL";
_skill = [_AISkill] call CTI_CO_FNC_GetRandomSkill;


// Set the skills
_unit setSkill ["aimingAccuracy",_skill select 0];
_unit setSkill ["aimingShake",_skill select 1];
_unit setSkill ["aimingSpeed",_skill select 2];
_unit setSkill ["spotDistance",_skill select 3];
_unit setSkill ["spotTime",_skill select 4];
_unit setSkill ["courage",_skill select 5];
_unit setSkill ["commanding",_skill select 6];
_unit setSkill ["general",_skill select 7];
_unit setSkill ["endurance",_skill select 8];
_unit setSkill ["reloadspeed",_skill select 9];
//--- bl1p and fluit rnd skills END

_unit enableFatigue false;

if (_unit isKindOf "I_Soldier_M_F") then {
_rnd = random (1);
if (_rnd > 0.7) then {
	comment "Exported from Arsenal by [H] Tom";

	comment "Remove existing items";
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	comment "Add containers";
	_unit forceAddUniform "U_I_CombatUniform";
	for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
	_unit addItemToUniform "20Rnd_762x51_Mag";
	_unit addVest "V_PlateCarrierIA2_dgtl";
	for "_i" from 1 to 2 do {_unit addItemToVest "9Rnd_45ACP_Mag";};
	for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
	for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_green";};
	_unit addItemToVest "SmokeShell";
	_unit addItemToVest "SmokeShellGreen";
	for "_i" from 1 to 6 do {_unit addItemToVest "20Rnd_762x51_Mag";};
	_unit addBackpack "B_AssaultPack_dgtl";
	_unit addHeadgear "H_HelmetIA";
	_unit addGoggles "G_Tactical_Clear";

	comment "Add weapons";
	_unit addWeapon "srifle_DMR_06_olive_F";
	_unit addPrimaryWeaponItem "optic_Hamr";
	_unit addWeapon "hgun_ACPC2_F";
	_unit addHandgunItem "acc_flashlight_pistol";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
	_unit linkItem "ItemGPS";
	_unit linkItem "NVGoggles_INDEP";

	comment "Set identity";
	_unit setFace "WhiteHead_12";
	_unit setSpeaker "male02gre";
	[_unit,"AAF_3rdRegiment"] call bis_fnc_setUnitInsignia;
	};
};

if (_unit isKindOf "I_soldier_F") then {
_rnd = random (1);
if (_rnd > 0.8) then {
	comment "Exported from Arsenal by [H] Tom";

	comment "Remove existing items";
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	comment "Add containers";
	_unit forceAddUniform "U_I_CombatUniform";
	for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
	_unit addItemToUniform "30Rnd_762x39_Mag_F";
	_unit addItemToUniform "30Rnd_762x39_Mag_Green_F";
	_unit addVest "V_PlateCarrierIA2_dgtl";
	for "_i" from 1 to 2 do {_unit addItemToVest "9Rnd_45ACP_Mag";};
	for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_762x39_Mag_Green_F";};
	for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
	for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_green";};
	_unit addItemToVest "SmokeShell";
	_unit addItemToVest "SmokeShellGreen";
	_unit addBackpack "B_AssaultPack_dgtl";
	_unit addHeadgear "H_HelmetIA";
	_unit addGoggles "G_Tactical_Clear";

	comment "Add weapons";
	_unit addWeapon "arifle_AKM_F";
	_unit addWeapon "hgun_ACPC2_F";
	_unit addHandgunItem "acc_flashlight_pistol";

	comment "Add items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
	_unit linkItem "ItemGPS";
	_unit linkItem "NVGoggles_INDEP";

	comment "Set identity";
	_unit setFace "WhiteHead_12";
	_unit setSpeaker "male04gre";
	[_unit,"AAF_3rdRegiment"] call bis_fnc_setUnitInsignia;
	};
};

//Ad event handle to UAV operators
_unit addEventHandler ["WeaponAssembled",{[["CLIENT",side (_this select 1)], "Client_UAVSetFuel",(_this select 1),true] call CTI_CO_FNC_NetSend;}];


if (_net) then {_unit setVariable ["cti_net", _sideID, true]};

//--- Add a Killed EH.

_unit addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _sideID]];

//Adv network
if (missionNamespace getVariable "CTI_EW_ANET" == 1 && !(_sideID == CTI_RESISTANCE_ID)) then {
	//["SERVER","Server_Run_Net",[_unit,_sideID]] call CTI_CO_FNC_NetSend;
	[_unit,_sideID] spawn AN_Launch;
};
//admin zeus
if !( isNil "ADMIN_ZEUS"  ) then {
	if !(isServer) then {
		["SERVER", "Server_Addeditable",[ADMIN_ZEUS,_unit]] call CTI_CO_FNC_NetSend;
	} else {
		ADMIN_ZEUS addCuratorEditableObjects [[_unit],true] ;
	};
};


//trophy system
if (missionNamespace getVariable "CTI_TROPHY_APS" == 1) then {
	_unit addEventHandler["Fired","_this call TR_HANDLER;"];
};

//art radar
if (missionNamespace getVariable "CTI_SM_RADAR" == 1) then {
	_unit addEventHandler ["WeaponAssembled",{["SERVER", "Server_ARTR_handle",(_this select 1)] call CTI_CO_FNC_NetSend}];
};


//cache
 //["SERVER", "Request_Cache", _unit] call CTI_CO_FNC_NetSend;

_unit addAction [localize "STR_Common_CreateUnit_Remote_Control","
	player connectTerminalToUAV ( vehicle(_this select 0));
	(_this select 0) spawn {
		waitUntil {   uavControl ( vehicle(_this)) select 1 == 'GUNNER' || ! (driver (vehicle _this)==_this) || (vehicle _this ==_this) || ! alive _this || ! alive player};
		sleep 1;
		 player connectTerminalToUAV objNull;
		objNull remoteControl cameraon;
		vehicle (player) switchCamera 'Internal'

		};
	player remoteControl (driver vehicle (_this select 0));
	( vehicle(_this select 0)) switchCamera 'Internal';
	","",100, false, true, "", "(vehicle _this) == (vehicle _target) && ! (vehicle _this ==_this) && driver (vehicle _this)==_this  && isnull gunner (vehicle _this) && !((vehicle _this) == vehicle (player)) &&! (uavControl ( vehicle(_this)) select 0 == player)"];

// returnvehicle objNull remoteControl cameraon;  player connectTerminalToUAV objNull; (player) switchCamera 'Internal';


_unit
private ["_pos","_spawn_at","_hq","_structures"];



// init player put in tutorial area
player allowDamage false;
[player] joinsilent grpNull;
_oh = player addAction ["<t color='#86F078'>Online Help</t>", {createDialog "CTI_RscTabletOnlineHelpMenu";}];
_pos=getMarkerPos "CTI_TUTORIAL";
_pos = [_pos,5,20] call CTI_CO_FNC_GetRandomPosition;
player setPos _pos;


//no escape from spawn
0 spawn {
	while {!((profileNamespace getVariable ["TUTO_COMPLETE",false]) || missionNamespace getVariable ["TUTO_COMPLETE",false])} do {
		if (([player,getMarkerPos "CTI_TUTORIAL"] call  BIS_fnc_distance2D)> 42.5) then {
			_pos=getMarkerPos "CTI_TUTORIAL";
			_pos = [_pos,5,20] call CTI_CO_FNC_GetRandomPosition;
			player setPos _pos;
		};
		sleep 5;
	};
};
//==
waitUntil {(profileNamespace getVariable ["TUTO_COMPLETE",false]) || missionNamespace getVariable ["TUTO_COMPLETE",false]};
waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_structures"} && !isNil {CTI_P_SideLogic getVariable "cti_hq"}};

12452 cutText [localize "STR_End_Tutorial", "PLAIN", 0];
sleep 1;
player removeAction _oh;

_spawn_at=objNull;

if (!(CTI_P_Jailed)) then { // if not jailed
	12452 cutText [localize "STR_Wait_GroupCreate", "BLACK FADED", 50000];

	//wait for group creation in dyn group
	waitUntil {(["PlayerHasGroup",[player] ] call BIS_fnc_dynamicGroups)};

	//group ok go on
	player allowDamage true;

	// ------------------------------------
	// FIND initial position
	while {isNull _spawn_at} do {
		_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		_spawn_at = _hq;
		if (count _structures > 0) then {  _spawn_at = [_hq, _structures] call CTI_CO_FNC_GetClosestEntity; if (isnull _spawn_at) then { _spawn_at=_hq;} };
		sleep 1;
	};



	_spawn_at = [_spawn_at, 8, 30] call CTI_CO_FNC_GetRandomPosition;
	player setPos _spawn_at;

	// find building pos
	EXCEPTIONS = ["Land_Dome_Small_F","Land_Dome_Big_F","Land_FuelStation_Shed_F","Land_fs_roof_F","Land_FuelStation_01_roof_F","Land_FuelStation_02_roof_F","Land_FuelStation_01_roof_malevil_F","Land_SM_01_shelter_wide_F","Land_Shed_Big_F","Land_Shed_Small_F","Land_SM_01_shelter_narrow_F","Land_TentHangar_V1_F","Land_Airport_01_hangar_F","Land_Shed_06_F","Land_MetalShelter_01_F","Land_MetalShelter_02_F","Land_WarehouseShelter_01_F","Land_SCF_01_shed_F"];


	_nearesthouse = typeOf ((position player) nearestObject "House");
	_nearesthousepos = getPos ((position player) nearestObject "House");
	_nearesthouseradius = round (sizeOF _nearesthouse / 2);
	if (_nearesthouse == "Land_Shed_Big_F" || _nearesthouse == "Land_SM_01_shelter_wide_F") then {_nearesthouseradius = 16;};
	if ((_nearesthouse in EXCEPTIONS) && ((player distance2d _nearesthousepos) < (_nearesthouseradius))) then {
		[player, _spawn_at] call KK_fnc_setPosAGLS;
		player setPos [getPos player select 0, getPos player select 1, 0.25];
	} else {
		[player, _spawn_at] call KK_fnc_setPosAGLS;
	};

	if (((player distance2d nearestbuilding player) < 10) && (!(typeOF nearestbuilding player in EXCEPTIONS))) then {
	_buildingpos = nearestBuilding player buildingPos -1;
	if (count _buildingpos > 10) then {_buildingpos deleteRange [(count _buildingpos / 3), count _buildingpos];};
	player setpos (selectrandom _buildingpos);
	//--------------------------------------
	};

//	player setPos _spawn_at;
	sleep 2;
	12452 cutText ["", "PLAIN", 0];
};
CTI_UI_Respawn_GetAvailableLocations = {
	private ["_fobs", "_hq", "_ignore_mobile_crew", "_list", "_mobile", "_structures"];

	_list = [];

	_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
	_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
	if (alive _hq) then { [_list, _hq] call CTI_CO_FNC_ArrayPush };
	_list = _list + _structures;
	if (count _list < 1) then { _list = [_hq] };
	_list=_list - [objNull];
	//--- Add FOBs if available.
	if (CTI_BASE_FOB_MAX > 0) then {
		_fobs = CTI_P_SideLogic getVariable ["cti_fobs", []];
		{if (alive _x && _x distance CTI_DeathPosition <= CTI_RESPAWN_FOB_RANGE) then {[_list, _x] call CTI_CO_FNC_ArrayPush}} forEach _fobs;
	};
	// --- zerty was here for towns
	_towns = [];
	switch (missionNamespace getVariable "CTI_PLAYER_TOWN_RESPAWN") do {
		case 1: {
			_sid = (CTI_P_SideJoined)  call CTI_CO_FNC_GetSideID;
			_c_towns = ( _sid )  call CTI_CO_FNC_GetSideTowns;
			_posible =[];
			{if ((_x  getVariable "cti_town_capture") == CTI_TOWNS_CAPTURE_VALUE_CEIL) then{ _posible set [count _posible,_x]};} count _c_towns;

			_t = [CTI_DeathPosition, _posible ] call CTI_CO_FNC_GetClosestEntity;
			if (! (isNull _t) ) then {[_towns, _t] call CTI_CO_FNC_ArrayPush;};
		};
		case 2: {
			_sid = (CTI_P_SideJoined)  call CTI_CO_FNC_GetSideID;
			_towns = ( _sid )  call CTI_CO_FNC_GetSideTowns;
		};
	};
	_list =_list + _towns ;
	// ---

	//--- Add mobile respawns if available (Also we retrieve the crew which may belong to the player to prevent "in-AI-respawn" over those)
	_ignore_mobile_crew = [];
	if ((missionNamespace getVariable "CTI_RESPAWN_MOBILE") > 0) then {
		_mobile = (CTI_DeathPosition) call CTI_UI_Respawn_GetMobileRespawn;
		_list = _list + _mobile;
		{{if (group _x == group player) then {[_ignore_mobile_crew, _x] call CTI_CO_FNC_ArrayPush}} forEach crew _x} forEach _mobile;
	};

	//--- Add the nearest player's AI (impersonation) minus the mobile's crew
	if ((missionNamespace getVariable "CTI_RESPAWN_AI") > 0) then {
		{
			if (_x distance CTI_DeathPosition <= CTI_RESPAWN_AI_RANGE && !(_x in _ignore_mobile_crew) && !isPlayer _x) then {[_list, _x] call CTI_CO_FNC_ArrayPush};
		} forEach ((units player - [player]) call CTI_CO_FNC_GetLiveUnits);
	};

	_list
};

CTI_UI_Respawn_GetMobileRespawn = {
	private ["_available", "_center"];
	_center = _this;
  _up=if (!( count ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades) == 0)) then {((CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_REST} else {0};
  _range=500+500*_up;
	_available = [];

	{
		if (CTI_SPECIAL_MEDICALVEHICLE in (_x getVariable ["cti_spec", []]) && (_x getVariable ["cti_net", -1]) == CTI_P_SideID) then {[_available, _x] call CTI_CO_FNC_ArrayPush};
	} forEach (_center nearEntities [["Car","Air","Tank","Ship","Thing","StaticWeapon"], _range]);
	_available
};

CTI_UI_Respawn_GetListLabels = {
	private ["_emplacements", "_hq", "_list"];

	_emplacements = _this;

	_list = [];
	_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;

	{
		_list = _list + [format["%1 - %2 (%3 s)", _x call CTI_UI_Respawn_GetRespawnLabel, _x call CTI_UI_Respawn_GetLocationInformation,floor((CTI_P_LastDeathTime+ (_x call CTI_UI_Respawn_GetTime)-time) max 0) ]];
	} forEach _emplacements;

	_list
};

CTI_UI_Respawn_GetRespawnLabel = {
	private ["_location", "_value"];
	_location = _this;

	_value = "Structure";
	switch (true) do {
		case (_location in CTI_Towns): {_value=_location getVariable "cti_town_name"};
		case (_location == (CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ)): { _value = "Headquarters"	};
		case (!isNil {_location getVariable "cti_structure_type"}): {
			_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _location getVariable "cti_structure_type"];
			_value = (_var select 0) select 1;
		};
		case (_location == (leader group player)) : {_value=format ["[LEADER] %1",name _location]};
		case (_location isKindOf "AllVehicles"&& !(_location == (leader group player))): { _value = getText(configFile >> "CfgVehicles" >> typeOf _location >> "displayName") };
	};

	_value
};

CTI_UI_Respawn_GetLocationInformation = {
	private ["_closest", "_direction", "_direction_eff", "_distance", "_distance_near", "_format", "_location"];

	_location = _this;
	if (_location in CTI_Towns) exitWith {""};
	_format = "";

	_closest = (_location) call CTI_CO_FNC_GetClosestTown;
	_direction = [_closest, _location] call CTI_CO_FNC_GetDirTo;
	if (_direction < 0) then { _direction = _direction + 360};

	_direction_eff = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"];
	_direction_eff = _direction_eff select round((_direction + 22.5)/45);

	_distance = _closest distance _location;
	_distance_near = _distance - (_distance % 100);

	format ["%1 %2 %3",_closest getVariable "cti_town_name", _direction_eff, _distance_near]
};

CTI_UI_Respawn_AppendTracker = {
	private ["_location", "_marker", "_tracker"];

	_location = _this;

	_marker = createMarkerLocal [Format ["cti_respawn_marker %1", CTI_P_MarkerIterator], getPos _location];
	CTI_P_MarkerIterator = CTI_P_MarkerIterator + 1;
	_marker setMarkerTypeLocal "Select";
	_marker setMarkerColorLocal "ColorYellow";
	_marker setMarkerSizeLocal [1,1];

	_tracker = uiNamespace getVariable "cti_dialog_ui_respawnmenu_locations_tracker";
	[_tracker, [_location, _marker]] call CTI_CO_FNC_ArrayPush;

	if (_location isKindOf "AllVehicles") then {
		[_location, _marker] spawn {
			_location = _this select 0;
			_marker = _this select 1;

			while {!isNil {uiNamespace getVariable "cti_dialog_ui_respawnmenu"} && alive _location} do {
				_locations_tracker = uiNamespace getVariable "cti_dialog_ui_respawnmenu_locations_tracker";

				_marker setMarkerPosLocal (getPos _location);

				_abort = true;
				{ if ((_x select 0) == _location) exitWith {_abort = false} } forEach _locations_tracker;
				sleep .25;
			};
		};
	};
};

CTI_UI_Respawn_LoadLocations = {
	private ["_old_locations", "_respawn_locations", "_respawn_locations_formated", "_set", "_spawn"];
	_respawn_locations = call CTI_UI_Respawn_GetAvailableLocations;
	_leader= if (!((leader group player) == player) && isPlayer (leader group player)&& (missionNamespace getVariable "CTI_GROUP_LEADER_RESP") == 1 && ((leader group player) distance (getMarkerPos "prison")) >500 && ((leader group player) distance (getMarkerPos format ["CTI_%1Respawn",side (group player)])) >2000 ) then {[leader group player]} else {[]};
	_respawn_locations =_leader + ([CTI_DeathPosition, _respawn_locations] call CTI_CO_FNC_SortByDistance);
	_respawn_locations_formated = (_respawn_locations) call CTI_UI_Respawn_GetListLabels;

	_old_locations = uiNamespace getVariable "cti_dialog_ui_respawnmenu_locations";
	if (isNil '_old_locations') then { _old_locations = [] };
	uiNamespace setVariable ["cti_dialog_ui_respawnmenu_locations", _respawn_locations];

	{if !(_x in _old_locations) then {(_x) call CTI_UI_Respawn_AppendTracker}} forEach _respawn_locations;

	lbClear ((uiNamespace getVariable "cti_dialog_ui_respawnmenu") displayCtrl 120002);

	{
		((uiNamespace getVariable "cti_dialog_ui_respawnmenu") displayCtrl 120002) lbAdd _x;
		// ((uiNamespace getVariable "cti_dialog_ui_respawnmenu") displayCtrl 120002) lbSetValue [_forEachIndex, _forEachIndex];
	} forEach _respawn_locations_formated;

	//--- Is a spawn currently selected?
	_spawn = uiNamespace getVariable "cti_dialog_ui_respawnmenu_respawnat";

	_set = false;
	{
		if (_x == _spawn) exitWith { _set = true; uiNamespace setVariable ["cti_dialog_ui_respawnmenu_respawn_update", false]; ((uiNamespace getVariable "cti_dialog_ui_respawnmenu") displayCtrl 120002) lbSetCurSel _forEachIndex; };
	} forEach _respawn_locations;

	if !(_set) then {
		((uiNamespace getVariable "cti_dialog_ui_respawnmenu") displayCtrl 120002) lbSetCurSel 0;
	};
};

CTI_UI_Respawn_CenterMap = {
	private ["_position"];
	_position = _this;

	ctrlMapAnimClear ((uiNamespace getVariable "cti_dialog_ui_respawnmenu") displayCtrl 120001);
	((uiNamespace getVariable "cti_dialog_ui_respawnmenu") displayCtrl 120001) ctrlMapAnimAdd [.65, .35, _position];
	ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_respawnmenu") displayCtrl 120001);
};

CTI_UI_Respawn_UseSelector = {
	private ["_marker","_marker_difference","_marker_expand","_marker_dir","_marker_min_size","_marker_max_size","_marker_size","_target"];

	_target = _this;
	_marker_size = 1.4;
	_marker_min_size = 1.4;
	_marker_max_size = 1.8;
	_marker_dir = 0;
	_marker_difference = (_marker_max_size - _marker_min_size)/10;
	_marker_expand = true;

	_marker = createMarkerLocal [format["cti_respawn_selector_%1", CTI_P_MarkerIterator], [0,0,0]];
	CTI_P_MarkerIterator = CTI_P_MarkerIterator + 1;
	_marker setMarkerTypeLocal "Select";
	_marker setMarkerColorLocal CTI_P_SideColor;
	_marker setMarkerSizeLocal [_marker_size, _marker_size];

	while {_target == (uiNamespace getVariable "cti_dialog_ui_respawnmenu_respawnat") && !isNil {uiNamespace getVariable "cti_dialog_ui_respawnmenu"}} do {
		_marker_dir = (_marker_dir + 1) % 360;
		_marker setMarkerDirLocal _marker_dir;
		_marker setMarkerSizeLocal [_marker_size, _marker_size];

		if (_marker_size > _marker_max_size) then {_marker_expand = false};
		if (_marker_size < _marker_min_size) then {_marker_expand = true};
		if (_marker_expand) then {_marker_size = _marker_size + _marker_difference} else {_marker_size = _marker_size - _marker_difference};

		if (getMarkerPos _marker distance _target > 0.5) then {_marker setMarkerPosLocal getPos _target};

		sleep .03;
	};

	deleteMarkerLocal _marker;
};

CTI_UI_Respawn_OnRespawnReady = {
	_where = uiNamespace getVariable "cti_dialog_ui_respawnmenu_respawnat";

	_respawn_ai = false;
	_respawn_ai_gear = [];
	if (_where isKindOf "Man" && ! (isPlayer _where)) then { //--- The location is an AI?
		if (_where in units player) then { //--- The AI is in the player group?
			_pos = getPos _where; //--- Get the AI position (todo: copy the stance)
			_respawn_ai_gear = (_where) call CTI_UI_Gear_GetUnitEquipment; //--- Get the AI current equipment using the Gear UI function
			deleteVehicle _where; //--- Remove the AI
			player setPos _pos; //--- Place the player where the AI was
			_respawn_ai = true;
		};
	};
	CTI_P_LastRespawnTime=time;
	if !(_respawn_ai) then { //--- Stock respawn
		_spawn_at = [_where, 8, 30] call CTI_CO_FNC_GetRandomPosition;
		player setPos _spawn_at;
	};

	titleCut["","BLACK IN",1];

	closeDialog 0;

	if !(isNil "CTI_DeathCamera") then {
		CTI_DeathCamera cameraEffect ["TERMINATE", "BACK"];
		camDestroy CTI_DeathCamera;
	};

	if (CTI_REDEPLOY) then {
		{
		if (vehicle _x == _x) then { //--- On foot
			_x setPos ([player, 8, 30] call CTI_CO_FNC_GetRandomPosition);
		} else { //--- In vehicle
			if ((effectiveCommander vehicle _x) in units player) then { //--- The vehicle is lead by us
				vehicle _x setPos ([player, 10, 35] call CTI_CO_FNC_GetRandomPosition);
			} else { //--- The vehicle is lead by someone else
				unassignVehicle _x;
				_x setPos ([player, 8, 30] call CTI_CO_FNC_GetRandomPosition);
			};
		};
		} forEach (units player call CTI_CO_FNC_GetLiveUnits);
		CTI_REDEPLOY=false;
	};
/*	if !(_respawn_ai) then { //--- Stock respawn
		[player, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR", CTI_P_SideJoined]] call CTI_CO_FNC_EquipUnit; //--- Equip the default equipment
	} else { //--- Respawn in own AI
		[player, _respawn_ai_gear] call CTI_CO_FNC_EquipUnit; //--- Equip the equipment of the AI on the player
	};

	if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {player enableFatigue false}; //--- Disable the unit's fatigue
	CTI_P_Respawning = false;
};*/
	if !(_respawn_ai) then { //--- Stock respawn
		// --- zerty edit
		if  (!isNil {CTI_P_LastPurchase } &&  (CTI_PLAYER_REEQUIP >= 1 ) ) then {
			[player, CTI_P_LastPurchase] call CTI_CO_FNC_EquipUnit;
		} else {
			[player, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR", CTI_P_SideJoined]] call CTI_CO_FNC_EquipUnit; //--- Equip pure clients
		};
		//[player, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR", CTI_P_SideJoined]] call CTI_CO_FNC_EquipUnit; //--- Equip the default equipment
	} else { //--- Respawn in own AI
		// --- zerty edit
		if  (!isNil {CTI_P_LastPurchase } &&  (CTI_PLAYER_REEQUIP >= 1 ) ) then {
			[player, CTI_P_LastPurchase] call CTI_CO_FNC_EquipUnit;
		} else {
			[player, _respawn_ai_gear] call CTI_CO_FNC_EquipUnit; //--- Equip the equipment of the AI on the player
		};
		[player, _respawn_ai_gear] call CTI_CO_FNC_EquipUnit; //--- Equip the equipment of the AI on the player
	};
	if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {player enableFatigue false}; //--- Disable the unit's fatigue
	CTI_P_Respawning = false;
};

CTI_UI_Respawn_GetTime={
	private ["_time_factor","_distance_factor"];
	_target=_this;
	_time=240;
	if ((_target in CTI_TOWNS) || (isPlayer _target)) then {
		_time_factor=((CTI_P_LastDeathTime-CTI_P_LastRespawnTime)/240) min 1;
		_distance_factor =((CTI_DeathPosition distance _target)/4000) min 1;
		_time = (missionNamespace getVariable "CTI_RESPAWN_TIMER") max (_time - _time * (_time_factor + _distance_factor));
	} else {
		_time=(missionNamespace getVariable "CTI_RESPAWN_TIMER");
		if (_target in ( CTI_P_SideLogic getVariable ["cti_structures",[]])) then {_time = (_time-10) max 20;}
	};
	_time
};

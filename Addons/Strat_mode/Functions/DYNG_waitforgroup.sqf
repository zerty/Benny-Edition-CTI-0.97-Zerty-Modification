0 spawn {
	private ["_pos","_hq","_structures","_spawn_at"];
	if (missionNamespace getVariable ["WAIT_GROUP",false]) exitWith {};
	waitUntil {!isNull (findDisplay 46)};
	WAIT_GROUP=true;
	["InitializePlayer",[player] ] call BIS_fnc_dynamicGroups;
	12453 cutText ["Please either join or create a group","BLACK OUT"];
	_pos=getMarkerPos format ["CTI_%1Respawn",CTI_P_SideJoined];
	_pos = [_pos,0,10] call CTI_CO_FNC_GetRandomPosition;
	player setpos _pos;
	player setCaptive false;
	waitUntil {(["PlayerHasGroup",[player] ] call BIS_fnc_dynamicGroups)};
	waitUntil {!isNil 'CTI_Init_CommanderClient'};
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_structures"} && !isNil {CTI_P_SideLogic getVariable "cti_hq"}};
	if !(CTI_P_Jailed) then {
		_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;

		_spawn_at = _hq;
		if (count _structures > 0) then { _spawn_at = [_hq, _structures] call CTI_CO_FNC_GetClosestEntity };

		_spawn_at = [_spawn_at, 8, 30] call CTI_CO_FNC_GetRandomPosition;
		player setPos _spawn_at;
	};
	//Save data
	//==========
	_uid=getPlayerUID player;
	if (isMultiplayer ) then {
		waitUntil {!isNil {missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid] }};
		_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid];
		_get set [3,group player];
		missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _uid],_get];
		publicVariableServer format["CTI_SERVER_CLIENT_%1", _uid];
	} else {
		missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _uid],[_uid,CTI_P_SideJoined,0,group player]];
	};
	//==========
	12453 cutText ["","BLACK IN"];
	WAIT_GROUP=nil;
};
if (isnull (findDisplay 60490)) then {createDialog "RscDisplayDynamicGroups";};

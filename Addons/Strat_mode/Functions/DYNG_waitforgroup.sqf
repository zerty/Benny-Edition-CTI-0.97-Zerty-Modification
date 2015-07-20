0 spawn {
	private ["_pos","_hq","_structures","_spawn_at"];
	if (missionNamespace getVariable ["WAIT_GROUP",false]) exitWith {};
	waitUntil {!isNull (findDisplay 46)&& !isnull player};
	WAIT_GROUP=true;
	[player] joinsilent grpNull;
	//[player] joinsilent (group (missionNamespace getvariable format ["CTI_%1_DEFAULT_GROUP",CTI_P_SideJoined] )) ;
	// group cleanup since BIS has fucked it
	//{if ((count(units _x) == 0) && local _x && ! ( groupID _x == "Defense Team") && ! ( groupID _x == "Default Team")) then {deleteGroup _x} ;true }count allgroups;
	["InitializePlayer",[player] ] call BIS_fnc_dynamicGroups;
	12453 cutText ["Please either join or create a group","BLACK OUT",0];
	//_pos=getMarkerPos format ["CTI_%1Respawn",CTI_P_SideJoined];
	//_pos = [_pos,0,10] call CTI_CO_FNC_GetRandomPosition;
	//player setpos _pos;
	//player setCaptive false;
	waitUntil {(["PlayerHasGroup",[player] ] call BIS_fnc_dynamicGroups)};
	/*waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_structures"} && !isNil {CTI_P_SideLogic getVariable "cti_hq"}};
	_spawn_at=objNull;

	if (!(CTI_P_Jailed) && ((player distance _pos) < 2000)) then {
		while {isNull _spawn_at} do {
			_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
			_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;

			_spawn_at = _hq;
			if (count _structures > 0) then { _spawn_at = [_hq, _structures] call CTI_CO_FNC_GetClosestEntity };
			sleep 1;
		};
		_spawn_at = [_spawn_at, 8, 30] call CTI_CO_FNC_GetRandomPosition;
		player setPos _spawn_at;
	};
	//Save data
	//==========
	_uid=getPlayerUID player;
	if (!(isMultiplayer) && isnil {missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid]} ) then {
		missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _uid],[_uid,CTI_P_SideJoined, (missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", CTI_P_SideJoined]),group player]];
	};
	// Done
	//==========*/
	12453 cutText ["","BLACK IN"];
	WAIT_GROUP=nil;
};
if (isnull (findDisplay 60490)) then {createDialog "RscDisplayDynamicGroups";};

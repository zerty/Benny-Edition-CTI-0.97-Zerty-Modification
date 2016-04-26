0 spawn {
	private ["_pos","_hq","_structures","_spawn_at"];
	if (missionNamespace getVariable ["WAIT_GROUP",false]) exitWith {};
	waitUntil {!isNull (findDisplay 46)&& !isnull player};
	WAIT_GROUP=true;
	[player] joinsilent grpNull;
	["InitializePlayer",[player] ] call BIS_fnc_dynamicGroups;
	12453 cutText [localize "STR_WaitForGroup","BLACK OUT",0];
	waitUntil {(["PlayerHasGroup",[player] ] call BIS_fnc_dynamicGroups)};
	12453 cutText ["","BLACK IN"];
	WAIT_GROUP=nil;
};
if (isnull (findDisplay 60490)) then {createDialog "RscDisplayDynamicGroups";};

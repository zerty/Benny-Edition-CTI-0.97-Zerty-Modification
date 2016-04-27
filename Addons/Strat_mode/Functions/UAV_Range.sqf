if !((getConnectedUAV player) isKindOf "UAV_01_base_F") exitWith {};
if (([player,(getConnectedUAV player)] call BIS_fnc_distance2D) > (missionNamespace getVariable "CTI_GAMEPLAY_DARTER")) exitWith {
	player connectTerminalToUAV objNull;
	hintSilent parseText format [localize "STR_UAV_Range",(missionNamespace getVariable "CTI_GAMEPLAY_DARTER")];
	0 spawn {sleep 5;hintSilent ""; };
};
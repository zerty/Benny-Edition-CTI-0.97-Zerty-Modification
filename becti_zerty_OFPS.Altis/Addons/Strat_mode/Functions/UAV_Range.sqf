if !((getConnectedUAV player) isKindOf "UAV_01_base_F") exitWith {};
if (([player,(getConnectedUAV player)] call BIS_fnc_distance2D) > (missionNamespace getVariable "CTI_GAMEPLAY_DARTER")) exitWith {
	player connectTerminalToUAV objNull;
	hintSilent parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />You have lost connection to your UAV. Maximum range is <t color='#ccffaf'>%1 meters.</t>",(missionNamespace getVariable "CTI_GAMEPLAY_DARTER")];
	0 spawn {sleep 5;hintSilent ""; };
};
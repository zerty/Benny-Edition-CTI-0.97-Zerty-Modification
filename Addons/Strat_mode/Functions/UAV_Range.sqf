if !((getConnectedUAV player) isKindOf "O_UAV_01_F" || (getConnectedUAV player) isKindOf "B_UAV_01_F" || (getConnectedUAV player) isKindOf "O_UAV_02_dynamicLoadout_F" || (getConnectedUAV player) isKindOf "O_UAV_02_CAS_F" || (getConnectedUAV player) isKindOf "O_UAV_02_dynamicLoadout_F" || (getConnectedUAV player) isKindOf "B_UAV_02_F" || (getConnectedUAV player) isKindOf "B_UAV_02_dynamicLoadout_F" || (getConnectedUAV player) isKindOf "B_UAV_02_dynamicLoadout_F" || (getConnectedUAV player) isKindOf "B_UAV_06_medical_F" || (getConnectedUAV player) isKindOf "B_UAV_06_F" || (getConnectedUAV player) isKindOf "O_UAV_06_medical_F" || (getConnectedUAV player) isKindOf "O_UAV_06_F") exitWith {};
if ((getConnectedUAV player) isKindOf "O_UAV_01_F" || (getConnectedUAV player) isKindOf "B_UAV_01_F" || (getConnectedUAV player) isKindOf "B_UAV_06_medical_F" || (getConnectedUAV player) isKindOf "B_UAV_06_F" || (getConnectedUAV player) isKindOf "O_UAV_06_medical_F" || (getConnectedUAV player) isKindOf "O_UAV_06_F") exitWith {
if (([player,(getConnectedUAV player)] call BIS_fnc_distance2D) > (missionNamespace getVariable "CTI_GAMEPLAY_DARTER")) exitWith {
	player connectTerminalToUAV objNull;
	hintSilent parseText format [localize "STR_UAV_Range",(missionNamespace getVariable "CTI_GAMEPLAY_DARTER")];
	0 spawn {sleep 5;hintSilent ""; };
	};
};
if ((getConnectedUAV player) isKindOf "O_UAV_02_dynamicLoadout_F" || (getConnectedUAV player) isKindOf "O_UAV_02_CAS_F" || (getConnectedUAV player) isKindOf "O_UAV_02_dynamicLoadout_F" || (getConnectedUAV player) isKindOf "B_UAV_02_F" || (getConnectedUAV player) isKindOf "B_UAV_02_dynamicLoadout_F" || (getConnectedUAV player) isKindOf "B_UAV_02_dynamicLoadout_F") exitWith {
if ((getPos (getConnectedUAV player) select 2) > (missionNamespace getVariable "CTI_GAMEPLAY_UAV_ALT")) exitWith {

		(getConnectedUAV player) flyInHeight ((missionNamespace getVariable "CTI_GAMEPLAY_UAV_ALT") - 200);

//		_randomairport = selectRandom [0,1,2,3,4,5]; //Tanoa
//		(getConnectedUAV player) landAt _randomairport;

		player connectTerminalToUAV objNull;
		hintSilent parseText format [localize "STR_UAV_ALT",(missionNamespace getVariable "CTI_GAMEPLAY_UAV_ALT")];
		0 spawn {sleep 5; hintSilent ""; };
		};
};

if (missionNamespace getVariable "CTI_GAMEPLAY_3P"==0) then {
	["3pr","onEachFrame", 'if (cameraView =="GROUP") then {(vehicle player) switchCamera "INTERNAL";};'] call BIS_fnc_addStackedEventHandler;
};
if (missionNamespace getVariable "CTI_GAMEPLAY_3P"==1) then {
	["3pr","onEachFrame", 'if (!(cameraView in ["GUNNER","INTERNAL"]) && cameraOn == vehicle (player)&& (vehicle player) == player) then {(vehicle player) switchCamera "INTERNAL";};'] call BIS_fnc_addStackedEventHandler;
};
if (missionNamespace getVariable "CTI_GAMEPLAY_3P"==2) then {
	["3pr","onEachFrame",'if (!(cameraView in ["GUNNER","INTERNAL"]) && cameraOn == vehicle (player)) then {(vehicle player) switchCamera "INTERNAL";};' ] call BIS_fnc_addStackedEventHandler;
};

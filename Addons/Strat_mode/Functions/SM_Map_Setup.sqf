private ["_neigh","_ot","_oneigh"];
waitUntil {CTI_InitTowns};

{
		[_x] call CTI_SM_Connect_Towns;
} forEach CTI_Towns;

SM_MAP_READY=true;

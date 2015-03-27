_nearest = [player, CTI_P_SideLogic getVariable ["cti_fobs",[]]] call CTI_CO_FNC_GetClosestEntity;

if (alive _nearest) then {
	if (_nearest distance player < 50) then {
		CTI_P_SideLogic setVariable ["cti_fobs", (CTI_P_SideLogic getVariable "cti_fobs") - [_nearest, objNull], true];
		deleteVehicle _nearest;
		CTI_P_TeamsRequests_FOB_Dismantle = 0;
	};
};
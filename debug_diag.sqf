// call CTI_CL_FNC_PurchaseUnit;

// {
	// diag_log format ["%1 ", typeOf _x];
// } forEach (player nearObjects 10);

// diag_log CTI_P_PurchaseRequests;
// player sidechat format ["%1 %2",count CTI_P_PurchaseRequests, CTI_P_PurchaseRequests];

// (west) execFSM "Server\FSM\update_commander.fsm";

// a2 setPos getpos player;
// [player, objNull] spawn CTI_CL_FNC_OnPlayerKilled;

// (CTI_P_SideJoined) spawn CTI_CL_FNC_OnMissionEnding;
// createDialog "CTI_RscUnitsCamera";
// createDialog "CTI_RscUpgradeMenu";
// createDialog "CTI_RscHookMenu";
// createDialog "CTI_RscBuildMenu";
// createDialog "CTI_RscCommandMenu";
// createDialog "CTI_RscAIMicromanagementMenu";
// createDialog "CTI_RscSatelitteCamera";
// createDialog "CTI_RscDefenseMenu";
// createDialog "CTI_RscPurchaseMenu";
// createDialog "CTI_RscOptionsMenu";
// createDialog "CTI_RscGearMenu";
// createDialog "CTI_RscWorkersMenu";
// createDialog "CTI_RscTransferResourcesMenu";
// createDialog "CTI_RscRequestMenu";
// createDialog "CTI_RscArtilleryMenu";
// [vehicle player, side player] call CTI_CO_FNC_RearmVehicle;
// CTI_P_TeamsRequests_FOB = 1;
// player sidechat format ["%1",player ammo primaryWeapon player];

// _structures = (side player) call CTI_CO_FNC_GetSideStructures;
// _structure = [player, _structures] call CTI_CO_FNC_GetClosestEntity;

// _structure setDammage 1;

// _q = (side player) call CTI_CO_FNC_GetSideHQ;
// _q setDammage 1;
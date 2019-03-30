_last_funds = -1;
_last_townheld = -1;
_last_award_pool = -1;
_last_resources_pool = -1;
_last_income = -1;

//_town_count = count CTI_Towns;
_town_count=0;
{
	_town_count = _town_count + (_x getVariable "cti_town_value");
} forEach CTI_Towns;

_last_infocheck = -100;

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_tabletmain"}) exitWith {}; //--- Menu is closed.

	if (time - _last_infocheck > 1) then {
		_uptime = call CTI_CL_FNC_GetMissionTime;
		_t=format[localize "STR_MAX_MISSION_TIME", _uptime select 0,_uptime select 1,_uptime select 2, _uptime select 3,missionNamespace getVariable "CTI_MAX_MISSION_TIME"];
		if !(side group player == resistance) then {
				_funds = call CTI_CL_FNC_GetPlayerFunds;
				_held=0;
				{_held=_held+ (_x getVariable "cti_town_value"); } ForEach ((CTI_P_SideJoined) call CTI_CO_FNC_GetFriendlyTowns);
				_award_pool = CTI_P_SideLogic getVariable "cti_pool_award";
				_resources_pool = CTI_P_SideLogic getVariable "cti_pool_resources";
				_income = call CTI_CL_FNC_GetPlayerIncome;
				_side_income = (CTI_P_SideJoined) call CTI_CO_FNC_GetTownsResources;
				_t=_t+(format[localize "STR_Coloration_Money", CTI_P_Coloration_Money, _funds]) + (format[localize "STR_Coloration_Pools", round(_resources_pool*100), round(_award_pool*100), "%"]) +  (format[localize "STR_Coloration_Income", CTI_P_Coloration_Money, _income, round (_side_income), missionNamespace getVariable "CTI_ECONOMY_INCOME_CYCLE" ])+(format[localize "STR_Coloration_Towns", _held, _town_count,floor (_town_count * 0.75)]);
		};
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130001) ctrlSetStructuredText parsetext _t;
	};

	//if ((CTI_Base_GearInRange || CTI_Base_GearInRange_Mobile || CTI_Base_GearInRange_FOB) && !CTI_P_PreBuilding) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210012) ctrlEnable true;} else {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210012) ctrlEnable false;};
	if (!CTI_P_PreBuilding &&Client_AN_Connected) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210012) ctrlEnable true;} else {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210012) ctrlEnable false;};
	if (!CTI_P_PreBuilding &&Client_AN_Connected && (CTI_Base_BarracksInRange || CTI_Base_LightInRange || CTI_Base_HeavyInRange || CTI_Base_AirInRange || CTI_Base_AmmoInRange || CTI_Base_RepairInRange || CTI_Base_NavalInRange)) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210013) ctrlEnable true;} else {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210013) ctrlEnable false;};
	if (vehicle player == player && !CTI_P_PreBuilding && CTI_Base_HaloInRange && [CTI_P_SideJoined, CTI_UPGRADE_HALO, 1] call CTI_CO_FNC_HasUpgrade && ( (missionNamespace getVariable 'CTI_SM_HALO')==1) && !(player getvariable ["REV_UNC",false])) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210014) ctrlEnable true;} else {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210014) ctrlEnable false;};
	if (vehicle player == player && (CTI_P_SideLogic getVariable "cti_commander") == group player && !CTI_P_PreBuilding && CTI_Base_HQInRange) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210015) ctrlEnable true;} else {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210015) ctrlEnable false;};


	if !(CTI_Base_ControlCenterInRange && Client_AN_Connected) then {
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210005) ctrlEnable false;
	} else {
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210005) ctrlEnable true;
	};

	//if ((missionNamespace getVariable"CTI_SM_STRATEGIC") >0 ) then {
	//!CTI_P_PreBuilding && ! CTI_P_Repairing
		if !(true && CTI_CL_FNC_IsPlayerCommander) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210010) ctrlEnable false;};
		if !(true && CTI_CL_FNC_IsPlayerCommander && !(isNull ((CTI_P_SideJoined call CTI_CO_FNC_GetSideLogic) getVariable "CTI_PRIORITY") ) && time > (SM_Last_dis +SM_TO_dis) && (count ((CTI_P_SideJoined call CTI_CO_FNC_GetSideLogic) getVariable "CTI_ACTIVE"))== CTI_SM_STRATEGIC_NB ) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210011) ctrlEnable false;};
	/*} else {
	((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210010) ctrlEnable false;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210011) ctrlEnable false;
	};*/



	if (!(call CTI_CL_FNC_IsPlayerCommander) || ! Client_AN_Connected) then {
		{((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl _x) ctrlEnable false} forEach [210003,210004,210008,210010,210011]; };
	if ((missionNamespace getVariable "CTI_ARTILLERY_SETUP") < 0) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210009) ctrlEnable false};



	sleep .1;
};
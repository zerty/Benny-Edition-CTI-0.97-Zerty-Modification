private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		CTI_P_LastRootMenu = "Commanding";

		if !(CTI_Base_ControlCenterInRange && Client_AN_Connected) then {
			{((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl _x) ctrlEnable false} forEach [210003,210004,210005,210009];
		};

		if !(call CTI_CL_FNC_IsPlayerCommander) then {
			{((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl _x) ctrlEnable false} forEach [210003,210004,210006,210008];
		};

		if ((missionNamespace getVariable "CTI_ARTILLERY_SETUP") < 0) then {((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210009) ctrlEnable false};
			/*
		((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210003) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafezoneH * 0.32), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210003) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210004) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafezoneH * 0.37), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210004) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210005) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafezoneH * 0.42), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210005) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210006) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafezoneH * 0.47), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210006) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210008) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafezoneH * 0.52), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210008) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210009) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafezoneH * 0.57), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210009) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210010) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafezoneH * 0.62), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_commandmenu") displayCtrl 210010) ctrlCommit 0;*/
	};
	case "onMapPressed": {
		if (CTI_Base_ControlCenterInRange && call CTI_CL_FNC_IsPlayerCommander) then {
			closeDialog 0;
			createDialog "CTI_RscMapCommandMenu";
		};
	};
	case "onResourcesPressed": {
		closeDialog 0;
		createDialog "CTI_RscTransferResourcesMenu";
	};
	case "onTeamsPressed": {
		if (CTI_Base_ControlCenterInRange && call CTI_CL_FNC_IsPlayerCommander) then {
			closeDialog 0;
			createDialog "CTI_RscTeamsMenu";
		};
	};
	case "onUpgradesPressed": {
		if (CTI_Base_ControlCenterInRange) then {
			closeDialog 0;
			createDialog "CTI_RscUpgradeMenu";
		};
	};
	case "onWorkersPressed": {
		if (call CTI_CL_FNC_IsPlayerCommander) then {
			closeDialog 0;
			createDialog "CTI_RscWorkersMenu";
		};
	};
	case "onRequestMenuPressed": {
		closeDialog 0;
		createDialog "CTI_RscRequestMenu";
	};
	case "onArtilleryMenuPressed": {
		if ((missionNamespace getVariable "CTI_ARTILLERY_SETUP") > -1 && CTI_Base_ControlCenterInRange) then {
			closeDialog 0;
			createDialog "CTI_RscArtilleryMenu";
		};
	};
};
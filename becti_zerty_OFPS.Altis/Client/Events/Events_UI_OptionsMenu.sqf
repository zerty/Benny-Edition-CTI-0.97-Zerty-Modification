private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		if (CTI_P_SideJoined == resistance) then {
			((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130008) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130009) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130011) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130014) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130012) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130013) ctrlEnable false;
		} else {
		//--- Units cam available?
		((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130012) ctrlEnable (if( Client_AN_Connected && CTI_Base_ControlCenterInRange) then {true} else {false});
		//((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130012) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafeZoneH * 0.795), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130012) ctrlCommit 0;

		//--- Sat cam available?
		_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
		_enable = if (CTI_Base_ControlCenterInRange && Client_AN_Connected && _upgrades select CTI_UPGRADE_SATELLITE > 0) then {true} else {false};
		((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130013) ctrlEnable _enable;
		//((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130013) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafeZoneH * 0.845), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130013) ctrlCommit 0;

	};
		execVM "Client\GUI\GUI_OptionsMenu.sqf";
		CTI_P_LastRootMenu = "Options";
	};
	case "onTransferResourcesPressed": {
		closeDialog 0;
		createDialog "CTI_RscTransferResourcesMenu";
	};
	case "onVideoSettingsPressed": {
		closeDialog 0;
		createDialog "CTI_RscVideoSettingsMenu";
	};
	case "onOnlineHelpPressed": {
		closeDialog 0;
		createDialog "CTI_RscOnlineHelpMenu";
	};
	case "onUnflipPressed": { //--- Unflip the nearest vehicle
		_vehicle = vehicle player;
		if (player != _vehicle) then {
			if (speed _vehicle < 5 && getPos _vehicle select 2 < 5) then {
				_vehicle setPos [getPos _vehicle select 0, getPos _vehicle select 1, 1];
				_vehicle setVelocity [0,0,1];
			};
		} else {
			{
				if (speed _x < 5 && getPos _x select 2 < 5) then {
					_x setPos [getPos _x select 0, getPos _x select 1, 1];
					_x setVelocity [0,0,1];
				};
			} forEach (player nearEntities[["Car","Motorcycle","Ship","Tank"],10]);
		};
	};
	case "onMusicPressed": { //--- Play some music
		player sidechat "lalalalaaaaaaaaaa lalalalaaaaaaaa laaaa";
	};
	case "onServicePressed": {
		closeDialog 0;
		createDialog "CTI_RscServiceMenu";
	};
	case "onAIMicroPressed": {
		closeDialog 0;
		createDialog "CTI_RscAIMicromanagementMenu";
	};
	case "onUnitsCamPressed": {
		if (CTI_Base_ControlCenterInRange && Client_AN_Connected) then {
			closeDialog 0;
			createDialog "CTI_RscUnitsCamera";
		};
	};
	case "onSatCamPressed": {
		_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
		if (CTI_Base_ControlCenterInRange && Client_AN_Connected && _upgrades select CTI_UPGRADE_SATELLITE > 0) then {
			closeDialog 0;
			createDialog "CTI_RscSatelitteCamera";
		};
	};
};
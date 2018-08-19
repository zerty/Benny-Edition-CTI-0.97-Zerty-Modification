private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		if (CTI_P_SideJoined == resistance) then {
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130008) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130009) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130011) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130014) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130012) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130013) ctrlEnable false;
		} else {
		//--- Units cam available?
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130012) ctrlEnable (if( Client_AN_Connected && CTI_Base_ControlCenterInRange) then {true} else {false});
		//((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130012) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafeZoneH * 0.795), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130012) ctrlCommit 0;

		//--- Sat cam available?
		_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
		_enable = if (CTI_Base_ControlCenterInRange && Client_AN_Connected && _upgrades select CTI_UPGRADE_SATELLITE > 0) then {true} else {false};
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130013) ctrlEnable _enable;
		//((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130013) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafeZoneH * 0.845), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 130013) ctrlCommit 0;

		};
		if !(CTI_Base_ControlCenterInRange && Client_AN_Connected) then {
			{((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl _x) ctrlEnable false} forEach [210003,210004,210005,210008,210009];
		};
		if (isnull (CTI_P_SideLogic getVariable "cti_commander")) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210020) ctrlshow false} else {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210020) ctrlshow true};
		if !(call CTI_CL_FNC_IsPlayerCommander) then {
			if (time - CTI_P_LastVotedTime>10 && !((getplayeruid player) in (CTI_P_SideLogic getvariable ["CTI_COM_VOTES",[]]))) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210020)ctrlenable true} else {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210020) ctrlEnable false;};
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210020) ctrlsettext format ["Eject Com. (%1/%2)",count (CTI_P_SideLogic getvariable ["CTI_COM_VOTES",[]]),ceil ((count (CTI_P_SideJoined call CTI_CO_FNC_GetSidePlayerGroups))*CTI_VOTE_RATIO)];
			{((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl _x) ctrlEnable false} forEach [210003,210004,210006,210008];
		} else {
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210020) ctrlEnable true;
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210020) ctrlsettext "Leave Com.";
		};

		if ((missionNamespace getVariable "CTI_ARTILLERY_SETUP") < 0) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210009) ctrlEnable false};
		if !(missionNamespace getVariable "CTI_EW_ANET" == 1) then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210016) ctrlEnable false};
		if (!((getAssignedCuratorUnit ADMIN_ZEUS) == player) && (serverCommandAvailable '#shutdown' || !isMultiplayer)) then {
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210019) ctrlEnable true;
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210019) ctrlSetPosition [SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.76,SafeZoneY+safezoneH*(0.28+0.035*3),(3/4*SafeZoneH)*0.615*0.22,SafeZoneH * 0.03]; ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210019) ctrlCommit 0;
		} else {
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210019) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210019) ctrlSetPosition [SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.76,SafeZoneY+safezoneH*(0.28+0.035*3+5),(3/4*SafeZoneH)*0.615*0.22,SafeZoneH * 0.03]; ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210019) ctrlCommit 0;
		};
		if ((player getVariable ['CTI_Net',-1])!= -1) Then {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210016) ctrlsettext "Net-Discon.";} else {((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210016) ctrlsettext "Net-Recon.";} ;
		_column=SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.54;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210003) ctrlSetPosition [_column,(ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210003)) select 1];
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210003) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210004) ctrlSetPosition [_column, (ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210004)) select 1];
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210004) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210005) ctrlSetPosition [_column, (ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210005)) select 1];
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210005) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210006) ctrlSetPosition [_column, (ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210006)) select 1];
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210006) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210008) ctrlSetPosition [_column,(ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210008)) select 1];
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210008) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210009) ctrlSetPosition [_column, (ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210009)) select 1];
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210009) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210010) ctrlSetPosition [_column,(ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210010)) select 1];
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210010) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210011) ctrlSetPosition [_column,(ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210011)) select 1];
		((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210011) ctrlCommit 0;
		execVM "Addons\Strat_mode\Tablet\GUI_TabletMain.sqf";
		CTI_P_LastRootMenu = "Options";
	};
	case "onTransferResourcesPressed": {
		closeDialog 0;
		createDialog "CTI_RscTabletTransferResourcesMenu";
	};
	case "onVideoSettingsPressed": {
		closeDialog 0;
		createDialog "CTI_RscVideoSettingsMenu_tablet";
	};
	case "onOnlineHelpPressed": {
		closeDialog 0;
		createDialog "CTI_RscTabletOnlineHelpMenu";
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
				if !((_x == (( CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ))&& !((group player) == ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideCommander)) ) then {
					if !(simulationEnabled _x) then {_x enableSimulation true};
					if (speed _x < 5 && getPos _x select 2 < 5) then {
						_x setPos [getPos _x select 0, getPos _x select 1, 1];
						_x setVelocity [0,0,1];
					};
				};
			} forEach (player nearEntities[["Car","Motorcycle","Ship","Tank"],10]);
		};
	};
	case "onServicePressed": {
		closeDialog 0;
		createDialog "CTI_RscTabletServiceMenu";
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
	case "onMapPressed": {
		if (CTI_Base_ControlCenterInRange && call CTI_CL_FNC_IsPlayerCommander) then {
			closeDialog 0;
			createDialog "CTI_RscMapCommandMenu";
		};
	};
	case "onResourcesPressed": {
		closeDialog 0;
		createDialog "CTI_RscTabletTransferResourcesMenu";
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
			createDialog "CTI_RscTabletUpgradeMenu";
		};
	};
	case "onWorkersPressed": {
		if (call CTI_CL_FNC_IsPlayerCommander) then {
			closeDialog 0;
			createDialog "CTI_RscTabletWorkersMenu";
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
	case "onBuildPressed": {
		closeDialog 0;
		createDialog "CTI_RscBuildMenu_Tablet";
	};
	case "onGearPressed": {
		closeDialog 0;
		createDialog "CTI_RscGearMenu";
	};
	case "onFactPressed": {
		closeDialog 0;
		createDialog "CTI_RscTabletPurchaseMenu";
	};
	case "onHaloPressed": {
		if (time - CTI_HALO_LASTTIME >= CTI_HALO_COOLDOWN) then {
		closeDialog 0;
		0 execvm "Addons\ATM_airdrop\atm_airdrop.sqf"
		} else {
		hintsilent parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Next HALO Jump in:<br /><t color='#ccffaf'>%1 min.</t>", floor((CTI_HALO_COOLDOWN - (time - CTI_HALO_LASTTIME))/60)];
		};
	};
	case "onPriorityPressed": {
		closeDialog 0;
		0 spawn SM_Ask_Priority;
	};
	case "onDisacPressed": {
		closeDialog 0;
		0 spawn SM_Disactivate_Town;
	};
	case "onNetPressed": {
		if ((player getVariable ['CTI_Net',-1])!= -1) Then {
			player setVariable ['CTI_Net',-1,true];
			player setVariable ['AN_iNet',CTI_P_SideID,true];
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210016) ctrlsettext "Net-Recon.";
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210016) ctrlSetBackgroundColor [0.7, 0, 0, 1];
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210016) ctrlSetForegroundColor [0.7, 0, 0, 1];
		} else {
			player setVariable ["AN_iNet",-1,true];
			player setVariable ["AN_Parrents",[],false];
			player setVariable ['CTI_Net',CTI_P_SideID,true];
			((uiNamespace getVariable "cti_dialog_ui_tabletmain") displayCtrl 210016) ctrlsettext "Net-Disco.";
		};
	};
	case "onVotePressed": {
		closeDialog 0;
		if ( 0 call CTI_CL_FNC_IsPlayerCommander )then {
			["SERVER", "Server_Com_Leave", CTI_P_SideJoined] call CTI_CO_FNC_NetSend;
		} else {
			if (([player,getMarkerPos "CTI_TUTORIAL"] call  BIS_fnc_distance2D) > 42.5) then {
			["SERVER", "Server_Vote_Eject", [player,CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;
			} else {
			hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />No vote in Tutorial area!";
			};
		};
	};

};
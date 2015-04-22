#include "Styles.hpp"

class CTI_RscInteraction {
	movingEnable = 0;
	idd = 510000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_interractions', _this select 0];['onLoad'] execVM 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_interractions', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';";
	class controlsBackground {};
	class controls {
		class CTI_Background : RscText {
			idc = 510100;
			x = "SafeZoneX + SafeZoneW*0.5";
			y = "SafeZoneY+safezoneH*0.50+5";
			w = "safezoneW * 0.04";
			h = "SafeZoneH * 0.04*2.2";
			colorBackground[] = {0,0,0,0.8};
			text="";
		};
		class CTI_Menu_LeftBottomFrame : RscFrame {
			idc = 510101;
			x = "SafeZoneX + SafeZoneW*0.5";
			y = "SafeZoneY+safezoneH*0.50+5";
			w = "safezoneW * 0.05";
			h = "SafeZoneH * 0.05";
		};
		class CTI_Menu_LeftBottomFrame2 : RscFrame {
			idc = 510102;
			x = "SafeZoneX + SafeZoneW*0.5";
			y = "SafeZoneY+safezoneH*0.50+5";
			w = "safezoneW * 0.05";
			h = "SafeZoneH * 0.05";
		};
		class CTI_Info : RscText {
			idc = 510103;
			x = "SafeZoneX + SafeZoneW*0.5";
			y = "SafeZoneY+safezoneH*0.50+5";
			w = "safezoneW * 0.5";
			h = "SafeZoneH * 0.03";
			size = "0.7 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			text="sdfsdfsdf";
		};
		class CTI_Icon_Tablet : RscActiveText {
			idc = 511001;
			style = ST_KEEP_ASPECT_RATIO;
			x = "SafeZoneX + SafeZoneW*0.5";
			y = "SafeZoneY+safezoneH*0.50+5";
			w = "safezoneW * 0.05";
			h = "SafeZoneH * 0.05";

			color[] = {1,0,0,1};
			colorActive[] = {1,1,1,0.7};
			colorBackground[] = {0.6, 0.8392, 0.4706, 0.7};
			colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 0.7};
			colorFocused[] = {0.0, 0.0, 0.0, 0};

			text = "Rsc\Pictures\icon_tablet.paa";
			action = "['OnTablet'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Open tablet";
		};
		class CTI_Icon_group : CTI_Icon_Tablet {
			idc = 511002;
			text = "a3\ui_f\data\gui\Rsc\RscDisplayArcadeMap\icon_toolbox_groups_ca.paa";
			action = "['OnGroup'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Group Dialog";
		};
		class CTI_Icon_Units : CTI_Icon_Tablet {
			idc = 511003;

			text = "Rsc\Pictures\icon_wf_building_lvs.paa";
			toolTip="Buy Units";
			action = "['OnUnits'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
		};
		class CTI_Icon_Gear : CTI_Icon_Tablet {
			idc = 511004;
			text = "Rsc\Pictures\icon_wf_gear_primary.paa";
			action = "['OnGear'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Buy Gear";
		};
		class CTI_Icon_Netp : CTI_Icon_Tablet {
			idc = 511005;
			text = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\radio_ca.paa";
			action = "['OnNetp'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Network";
		};
		class CTI_Icon_earp : CTI_Icon_Tablet {
			idc = 511006;
			text = "Rsc\Pictures\icon_earp.paa";
			action = "['OnEarp'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Ear Plugs";
		};
		class CTI_Icon_BFact : CTI_Icon_Tablet {
			idc = 511007;
			text = "Rsc\Pictures\icon_fact.paa";
			action = "['OnBFact'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Build Factory/Def";
		};
		class CTI_Icon_halo : CTI_Icon_Tablet {
			idc = 511008;
			text = "Rsc\Pictures\icon_para.paa";
			action = "['OnHalo'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Halo Jump";
		};


		class CTI_Icon_Lock : CTI_Icon_Tablet {
			idc = 511009;

			text = "Rsc\Pictures\i_lock.paa";
			toolTip="(Un)Lock";
			action = "['OnLock'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
		};
		class CTI_Icon_Net : CTI_Icon_Tablet {
			idc = 511010;
			text = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\radio_ca.paa";
			action = "['OnNet'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Network";
		};
		class CTI_Icon_Def : CTI_Icon_Lock {
			idc = 511011;
			text = "Rsc\Pictures\icon_def.paa";
			action = "['OnDef'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Defence Menu";
		};
		class CTI_Icon_Rep : CTI_Icon_Lock {
			idc = 511012;
			text ="Rsc\Pictures\icon_rep.paa";
			action = "['OnRepair'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Repair";
		};
		class CTI_Icon_fl : CTI_Icon_Lock {
			idc = 511013;
			text = "Rsc\Pictures\icon_force.paa";
			action = "['OnForce'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Force Lock";
		};
		class CTI_Icon_rev : CTI_Icon_Lock {
			idc = 511014;
			text = "A3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
			action = "['OnRev'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Revive";
		};
		class CTI_Icon_drag : CTI_Icon_Lock {
			idc = 511015;
			x = "SafeZoneX + SafeZoneW*0.85";
			text = "Rsc\Pictures\icon_drag.paa";
			action = "['OnDrag'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Drag/Release";
		};
		class CTI_Icon_fpk : CTI_Icon_Lock {
			idc = 511016;
			x = "SafeZoneX + SafeZoneW*0.50";
			y = "SafeZoneY+safezoneH*0.55+5";
			text = "Rsc\Pictures\icon_fpk.paa";
			action = "['OnFpk'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Force Public key";
		};
		class CTI_Icon_intru : CTI_Icon_fpk {
			idc = 511017;
			x = "SafeZoneX + SafeZoneW*0.55";
			text = "Rsc\Pictures\icon_intru.paa";
			action = "['OnIntru'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Start Intrusion";
		};
		class CTI_Icon_load : CTI_Icon_fpk {
			idc = 511018;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_load.paa";
			action = "['OnLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Load Static/Crate";
		};
		class CTI_Icon_fact : CTI_Icon_fpk {
			idc = 511019;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_fact.paa";
			action = "['OnFact'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Use Factory";
		};
		class CTI_Icon_del : CTI_Icon_fpk {
			idc = 511020;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_del.paa";
			action = "['OnDel'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Delete Factory";
		};
		class CTI_Icon_repHQ : CTI_Icon_fpk {
			idc = 511021;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_rephq.paa";
			action = "['OnRepHQ'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Repair HQ";
		};
		class CTI_Icon_push : CTI_Icon_fpk {
			idc = 511022;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_push.paa";
			action = "['OnPush'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Push";
		};
		class CTI_Icon_pull : CTI_Icon_fpk {
			idc = 511023;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_pull.paa";
			action = "['OnPull'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Pull";
		};
		class CTI_Icon_pack : CTI_Icon_fpk {
			idc = 511024;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_pack.paa";
			action = "['OnPack'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="(Un)Pack";
		};
		class CTI_Icon_att : CTI_Icon_fpk {
			idc = 511025;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_att.paa";
			action = "['OnAtt'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Attach Slingload";
		};
		class CTI_Icon_para : CTI_Icon_fpk {
			idc = 511026;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_para.paa";
			action = "['OnPara'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Paradrop Slingload/Attachment";
		};
		class CTI_Icon_build : CTI_Icon_fpk {
			idc = 511027;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_build.paa";
			action = "['OnBuild'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Build Structure";
		};
		class CTI_Icon_srep : CTI_Icon_fpk {
			idc = 511028;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_build.paa";
			action = "['OnSRep'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Repair Structure";
		};
		class CTI_Icon_AC : CTI_Icon_fpk {
			idc = 511029;
			x = "SafeZoneX + SafeZoneW*0.60";
			text = "Rsc\Pictures\icon_al.paa";
			action = "['OnAircraftCust'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Aircraft Loadout Customisation";
		};
		class CTI_Icon_Com : CTI_Icon_fpk {
			idc = 511030;
			x = "SafeZoneX + SafeZoneW*0.55";
			text = "Rsc\Pictures\icon_com.paa";
			action = "['OnCom'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Take Command";
		};
		class CTI_Icon_Pilot : CTI_Icon_fpk {
			idc = 511031;
			x = "SafeZoneX + SafeZoneW*0.55";
			text = "Rsc\Pictures\i_driver.paa";
			action = "['OnPilot'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'";
			toolTip="Getin as Pilot";
		};
	};
};

//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################

class CTI_RscTablet_main {
	movingEnable = 1;
	idd = 500000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_tabletmain', _this select 0];['onLoad'] execVM 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf';";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_tabletmain', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf';";
	class controlsBackground {
		class CTI_Background : RscTablet {
						moving = 1;
		};


		class CTI_Menu_InfoListFrame : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";

		};
		class CTI_Menu_LeftBottomFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.420";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH*0.300";
		};
		class CTI_Menu_RigthBottomFrame : CTI_Menu_LeftBottomFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.27";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH*0.135";
			colorBackground[] = {0.5, 0.5, 0.5, 0.7};
		};
	};
	class controls {
		class CTI_Menu_Options_Info1 : RscStructuredText {
			idc = 130001;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.27";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH*0.135";

			size = "0.75 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			// text = "Victory: Destroy Enemy";
		};
		class CTI_Menu_Options_OnlineHelp : RscButton {
			idc = 130006;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.04";
			y = "SafeZoneY+safezoneH*(0.420+0.005)";
			w = "(3/4*SafeZoneH)*0.615*0.42";
			h = "SafeZoneH * 0.03";

			text = "Online Help";
			action = "['onOnlineHelpPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Menu_Options_Video : CTI_Menu_Options_OnlineHelp {
			idc = 130007;

			y = "SafeZoneY+safezoneH*(0.420+0.005*2+0.03)";

			text = "Video Settings";
			action = "['onVideoSettingsPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};

		class CTI_Menu_Options_TransferFunds : CTI_Menu_Options_OnlineHelp {
			idc = 130009;

			y = "SafeZoneY+safezoneH*(0.420+0.005*3+0.03*2)";
			text = "Transfer Resources";
			action = "['onTransferResourcesPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Menu_Options_Unflip : CTI_Menu_Options_OnlineHelp {
			idc = 130010;

			y = "SafeZoneY+safezoneH*(0.420+0.005*4+0.03*3)";

			text = "Unflip Nearest Vehicle";
			action = "['onUnflipPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Menu_Options_Service : CTI_Menu_Options_OnlineHelp {
			idc = 130011;

			y = "SafeZoneY+safezoneH*(0.420+0.005*5+0.03*4)";

			text = "Service Menu";
			action = "['onServicePressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Menu_Options_AIMicro : CTI_Menu_Options_OnlineHelp {
			idc = 130014;

			y = "SafeZoneY+safezoneH*(0.420+0.005*6+0.03*5)";

			text = "AI Management";
			action = "['onAIMicroPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Menu_Options_UnitsCam : CTI_Menu_Options_OnlineHelp { //--- Render out
			idc = 130012;

			y = "SafeZoneY+safezoneH*(0.420+0.005*7+0.03*6)";

			text = "Units Camera";
			action = "['onUnitsCamPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Menu_Options_SatCam : CTI_Menu_Options_OnlineHelp { //--- Render out
			idc = 130013;

			y = "SafeZoneY+safezoneH*(0.420+0.005*8+0.03*7)";

			text = "Satellite Camera";
			action = "['onSatCamPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		/*class CTI_Control_Resources : RscButton {
			idc = 210002;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.505";
			y = "SafeZoneY+safezoneH*0.275+SafeZoneH*0.451*0.32";
			w = "(3/4*SafeZoneH)*0.615*0.45";
			h = "SafeZoneH * 0.03";

			text = "Resources";
			action = "['onResourcesPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_CommandMenu.sqf'";
		};*/
		class CTI_Control_Teams : RscButton {
			idc = 210003;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.54";
			y = "SafeZoneY+safezoneH*(0.420+0.005)";
			w = "(3/4*SafeZoneH)*0.615*0.42";
			h = "SafeZoneH * 0.03";
			colorDisabled[] = {0.4,0.4,0.4,1};
			colorBackground[] = {0.258823529,1, 0.713725490,  0.7};
			colorBackgroundActive[] = {0.258823529,1, 0.713725490,  1};
			colorBackgroundDisabled[] = {0.95,0.95,0.95,1};

			text = "Teams";
			action = "['onTeamsPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Map : CTI_Control_Teams {
			idc = 210004;

			y = "SafeZoneY+safezoneH*(0.420+0.005*2+0.03*1)";

			text = "Map Commanding";
			action = "['onMapPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Upgrades : CTI_Control_Teams {
			idc = 210005;

			y = "SafeZoneY+safezoneH*(0.420+0.005*3+0.03*2)";

			text = "Upgrades";
			action = "['onUpgradesPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Workers : CTI_Control_Teams {
			idc = 210006;

			y = "SafeZoneY+safezoneH*(0.420+0.005*4+0.03*3)";

			text = "Base Management";
			action = "['onWorkersPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_RequestMenu : CTI_Control_Teams {
			idc = 210008;

			y = "SafeZoneY+safezoneH*(0.420+0.005*5+0.03*4)";

			text = "Team Requests";
			action = "['onRequestMenuPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_ArtilleryMenu : CTI_Control_Teams {
			idc = 210009;

			y = "SafeZoneY+safezoneH*(0.420+0.005*6+0.03*5)";

			text = "Artillery";
			action = "['onArtilleryMenuPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Setpriority : CTI_Control_Teams {
			idc = 210010;

			y = "SafeZoneY+safezoneH*(0.420+0.005*7+0.03*6)";

			text = "Set Priority Town";
			action = "['onPriorityPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Disactivate : CTI_Control_Teams {
			idc = 210011;

			y = "SafeZoneY+safezoneH*(0.420+0.005*8+0.03*7)";

			text = "Force disactivation";
			action = "['onDisacPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		/*class CTI_Control_Gear : RscButton_Lesser {
			idc = 210012;

			colorBackground[] = {0.6470588235294118, 0.7686274509803922, 1, 0.7};
			colorBackgroundActive[] = {0.6470588235294118, 0.7686274509803922, 1, 1};
			colorFocused[] = {0.6470588235294118, 0.7686274509803922, 1, 1};
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.28";
			w = "(3/4*SafeZoneH)*0.615*0.22";
			h = "SafeZoneH * 0.03";
			text = "Gear";
			action = "['onGearPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};*/
		class CTI_Control_Fact : RscButton_Lesser {
			idc = 210013;
			colorBackground[] = {0.6470588235294118, 0.7686274509803922, 1, 0.7};
			colorBackgroundActive[] = {0.6470588235294118, 0.7686274509803922, 1, 1};
			colorFocused[] = {0.6470588235294118, 0.7686274509803922, 1, 1};
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*(0.28+0.035*1)";
			w = "(3/4*SafeZoneH)*0.615*0.22";
			h = "SafeZoneH * 0.03";

			text = "Units.";
			action = "['onFactPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Halo : CTI_Control_Fact {
			idc = 210014;

			y = "SafeZoneY+safezoneH*(0.28+0.035*2)";

			text = "HALO";
			action = "['onHaloPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Build : CTI_Control_Fact {
			idc = 210015;

			y = "SafeZoneY+safezoneH*(0.28+0.035*3)";

			text = "Build";
			action = "['onBuildPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Disco : CTI_Control_Fact {
			idc = 210016;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.28";
			text = "Net-Disco.";
			size = "0.7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1, 0.7686274509803922,0.6470588235294118, 0.7};
			colorBackgroundActive[] = {1, 0.7686274509803922,0.6470588235294118, 1};
			colorFocused[] = {0.6470588235294118, 0.7686274509803922, 1, 1};
			action = "['onNetPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Eject : CTI_Control_Disco {
			idc = 210020;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.76";
			size = "0.7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1, 0.7686274509803922,0.6470588235294118, 0.7};
			colorBackgroundActive[] = {1, 0.7686274509803922,0.6470588235294118, 1};
			colorFocused[] = {0.6470588235294118, 0.7686274509803922, 1, 1};
			text = "Eject Com.";
			action = "['onVotePressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletMain.sqf'";
		};
		class CTI_Control_Log : CTI_Control_Eject {
			idc = 210017;
			y = "SafeZoneY+safezoneH*(0.28+0.035*1+5)";
		};
		class CTI_Control_Request : CTI_Control_Eject {
			idc = 210018;
			y = "SafeZoneY+safezoneH*(0.28+0.035*2+5)";
			text = "Make request";

			action = "";
		};
		class CTI_Control_Zeus : CTI_Control_Eject {
			idc = 210019;
			y = "SafeZoneY+safezoneH*(0.28+0.035*3+5)";
			text = "Zeus Con.";

			action = "['SERVER', 'Server_Assign_Zeus', player] call CTI_CO_FNC_NetSend;";
		};
	};
};
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################

class CTI_RscBuildMenu_Tablet {
	movingEnable = 0;
	idd = 600000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_buildmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_BuildMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_buildmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		}
		class CTI_Menu_BuildingListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615*0.49";
			h = "SafeZoneH*0.451";
		};
		class CTI_Menu_DefenseListFrame : CTI_Menu_BuildingListFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.50";

		};
		class CTI_Menu_Info : CTI_Menu_BuildingListFrame {
			y = "SafeZoneY+safezoneH*0.275";
			h = "SafeZoneH * 0.06";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615*0.49";
			h = "SafeZoneH * 0.06";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
	};

	class controls {
		class CTI_Menu_Control_Undo : RscButton {
			idc = 100001;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.195";
			y="SafeZoneY+safezoneH*(0.275+0.07+0.035 + 0.035+0.274)";
			w = "(3/4*SafeZoneH)*0.615*0.47";
			h = "SafeZoneH * 0.03";

			text = "Undo Structure";
			action = "['onUndoStructure'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_UndoDefense : CTI_Menu_Control_Undo {
			idc = 100010;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.505";
			text = "Undo Defense";
			action = "['onUndoDefense'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_BuildStructure : CTI_Menu_Control_Undo {
			idc = 100002;

			y="SafeZoneY+safezoneH*(0.275+0.07+0.035)";

			text = "Build Structure";
			action = "['onBuildStructure', lnbCurSelRow 100006] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_AutoAlign : CTI_Menu_Control_Undo {
			idc = 100003;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.505";
			y="SafeZoneY+safezoneH*(0.280 +0.035)";

			text = "";
			action = "['onAutoAlign'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_AutoManning : RscButton_Lesser {
			idc = 100011;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.505";
			y="SafeZoneY+safezoneH*(0.280)";
			w = "(3/4*SafeZoneH)*0.615*0.47";
			h = "SafeZoneH * 0.03";

			text = "";
			action = "['onAutoManning'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_BuildDefense : CTI_Menu_Control_AutoAlign {
			idc = 100004;

			y="SafeZoneY+safezoneH*(0.280 +0.035+0.035)";

			text = "Build Defense";
			action = "['onBuildDefense', lnbCurSelRow 100007] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_AddWorker : CTI_Menu_Control_Undo {
			idc = 100005;

			y="SafeZoneY+safezoneH*(0.275+0.065)";

			text = "Add Worker";
			action = "['onAddWorker'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};

		class CTI_Menu_Control_BuildingList : RscListNBox {
			idc = 100006;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y="SafeZoneY+safezoneH*(0.275+0.07+0.035 + 0.035)";
			w = "(3/4*SafeZoneH)*0.615*0.48";
			h = "SafeZoneH*0.274";

			rowHeight = "1.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			itemBackground[] = {1,1,1,0.1};
			// columns[] = {0.001, 0.26};
			columns[] = {0.001, 0.18};

			onLBDblClick = "['onBuildStructure', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_DefenseList : CTI_Menu_Control_BuildingList {
			idc = 100007;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.50";
			y="SafeZoneY+safezoneH*(0.275+0.07+0.035 + 0.025)";

			onLBDblClick = "['onBuildDefense', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_Info : RscStructuredText {
			idc = 100008;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615*0.49";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_InfoWorkers : CTI_Menu_Control_Info {
			idc = 100009;

			y = "SafeZoneY+safezoneH*0.305";
		};
	};
};
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################

class CTI_RscVideoSettingsMenu_tablet {
	movingEnable = 0;
	idd = 700000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_videosettingsmenu', _this select 0];['onLoad'] execVM 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_videosettingsmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame2 : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		}

		class CTI_Menu_InfoListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.201";
			y = "SafeZoneY+safezoneH*0.285";
			w = "(3/4*SafeZoneH)*0.595";
			h = "SafeZoneH * 0.2";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.201";
			y = "SafeZoneY+safezoneH*0.285";
			w = "(3/4*SafeZoneH)*0.595";
			h = "SafeZoneH * 0.2";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_GridFrame : CTI_Menu_InfoListFrame {
			y = "SafeZoneY+safezoneH*0.495";
			h = "SafeZoneH * 0.07";
		};
		class CTI_Menu_Grid_Background : CTI_Menu_Info_Background {
			y = "SafeZoneY + (SafezoneH * 0.495)";
			h = "SafeZoneH * 0.07";
		};
	};

	class controls {
		class CTI_Menu_Video_ViewDistanceLabel : RscText {
			idc = 150001;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.211";
			y = "SafeZoneY+safezoneH*0.285";
			w = "(3/4*SafeZoneH)*0.575";
			h = "SafeZoneH * 0.035";

			text = "View Distance: 1000m";

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Video_ViewDistance : RscXSliderH {
			idc = 150002;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.221";
			y = "SafeZoneY+safezoneH*(0.285+0.040)";
			w = "(3/4*SafeZoneH)*0.555";
			h = "SafeZoneH * 0.025";

			onSliderPosChanged = "['onViewSliderChanged', _this select 1] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";
		};
		class CTI_Menu_Video_ObjectDistanceLabel : CTI_Menu_Video_ViewDistanceLabel {
			idc = 150003;
			y = "SafeZoneY + (SafezoneH * (0.285+0.040+0.025))";

			text = "Objects Distance: 1000m";
		};
		class CTI_Menu_Video_ObjectDistance : CTI_Menu_Video_ViewDistance {
			idc = 150004;

			y = "SafeZoneY + (SafezoneH * (0.285+0.040+0.025+0.04))";

			onSliderPosChanged = "['onObjectSliderChanged', _this select 1] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";
		};
		class CTI_Menu_Video_ShadowsDistanceLabel : CTI_Menu_Video_ViewDistanceLabel {
			idc = 150005;
			y = "SafeZoneY + (SafezoneH * (0.285+0.040+0.025+0.04+0.025))";

			// text = "Shadows Distance: 200m";
		};
		class CTI_Menu_Video_ShadowsDistance : CTI_Menu_Video_ViewDistance {
			idc = 150006;

			y = "SafeZoneY + (SafezoneH * (0.285+0.040+0.025+0.04+0.025+0.04))";
			onSliderPosChanged = "['onShadowsSliderChanged', _this select 1] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";
		};

		class CTI_Menu_Video_GridLabel : CTI_Menu_Video_ViewDistanceLabel {
			idc = 150007;
			y = "SafeZoneY+safezoneH*0.495";

			// text = "Terrain Grid: 25";
		};
		class CTI_Menu_Video_GridLevel : CTI_Menu_Video_ViewDistance {
			idc = 150008;

			y = "SafeZoneY + (SafezoneH * 0.526)";

			onSliderPosChanged = "['onGridSliderChanged', _this select 1] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";
		};
		class CTI_Menu_Hud_Basic : RscButton {
			idc = 150010;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.201";
			w = "(3/4*SafeZoneH)*0.595";

			y = "SafeZoneY + (SafezoneH * 0.57)";
			h = "SafeZoneH * 0.03";

			text = "";
			action = "['onHudBasicPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";
		};
		class CTI_Menu_Hud_Tac : CTI_Menu_Hud_Basic {
			idc = 150011;

			y = "SafeZoneY + (SafezoneH * (0.57+0.035))";

			text = "";
			action = "['onHudTacPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";
		};
		class CTI_Menu_Hints : CTI_Menu_Hud_Basic {
			idc = 150009;

			y = "SafeZoneY + (SafezoneH * (0.57+0.035+0.035))";

			text = "";
			action = "['onHintsPressed'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_TabletVideoSettingsMenu.sqf'";
		};
	};
};

//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################

class CTI_RscTabletTransferResourcesMenu {
	movingEnable = 0;
	idd = 800000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_transferresourcesmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_TransferResourcesMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_transferresourcesmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TransferResourcesMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		}

		class CTI_Menu_InfoListFrame3 : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.196";
			y = "SafeZoneY + (SafezoneH * 0.280)";
			w = "(3/4*SafeZoneH)*0.297";
			h = "SafeZoneH*0.441";
		};
		class CTI_Menu_InfoResourcesFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297)";
			y = "SafeZoneY + (SafezoneH * 0.280)";
			w = "(3/4*SafeZoneH)*0.297";
			h = "SafeZoneH*0.441";
		};
		class CTI_Menu_TransferFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004)";
			y = "SafeZoneY + (SafezoneH * 0.35)";
			w = "(3/4*SafeZoneH)*0.289";
			h = "SafeZoneH * 0.1";
		};
		class CTI_Menu_IncomeFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004)";
			y = "SafeZoneY + (SafezoneH * 0.465)";
			w = "(3/4*SafeZoneH)*0.289";
			h = "SafeZoneH * 0.06";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297)";
			y = "SafeZoneY + (SafezoneH * 0.280)";
			w = "(3/4*SafeZoneH)*0.297";
			h = "SafeZoneH*0.441";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_CommanderFrame : CTI_Menu_IncomeFrame {
			y = "SafeZoneY + (SafezoneH * 0.54)";
			h = "SafeZoneH * 0.115";
		};
		class CTI_Menu_Commander_Background : CTI_Menu_Info_Background {
			y = "SafeZoneY + (SafezoneH * 0.54)";
			h = "SafeZoneH * 0.115";
		};
		class CTI_Menu_Transfer_Background : CTI_Menu_Info_Background {
			y = "SafeZoneY + (SafezoneH * 0.35)";
			h = "SafeZoneH * 0.1";
		};
		class CTI_Menu_Income_Background : CTI_Menu_Info_Background {
			y = "SafeZoneY + (SafezoneH * 0.465)";
			h = "SafeZoneH * 0.06";
		};

		class CTI_Menu_Info_EditBackground : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004+0.297*0.77)";
			y = "SafeZoneY + (SafezoneH * 0.36)";
			w = "(3/4*SafeZoneH)*0.297*0.19";
			h = "SafeZoneH * 0.03";
			colorBackground[] = {0, 0, 0, 0.8};
		};


		class CTI_Menu_PlayerPoolLabel : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.52)";
			y = "SafeZoneY + (SafezoneH * 0.55)";
			w = "SafeZoneW * 0.16";
			h = "SafeZoneH * 0.035";

			text = "Player Resources %";

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_AwardPoolLabel : CTI_Menu_PlayerPoolLabel {
			y = "SafeZoneY + (SafezoneH * 0.605)";

			text = "Award Pool %";
		};
	};

	class controls {
		class CTI_Menu_Funds_GroupsList : RscListNBox {
			idc = 140001;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.196";
			y = "SafeZoneY + (SafezoneH * 0.280)";
			w = "(3/4*SafeZoneH)*0.297";
			h = "SafeZoneH*0.441";

			rowHeight = "1.22 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			// columns[] = {0.001, 0.26};
			columns[] = {0.001, 0.3};

			onLBDblClick = "['onGivePlayerPressed', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TransferResourcesMenu.sqf'";
			onLBSelChanged = "['onGroupLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TransferResourcesMenu.sqf'";
		};
		class CTI_Menu_Funds_MyResources : RscStructuredText {
			idc = 140002;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004)";
			y = "SafeZoneY + (SafezoneH * 0.280)";
			w = "(3/4*SafeZoneH)*0.289";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			// text = "Your Resources: $8000";
		};
		class CTI_Menu_Funds_TargetResources : CTI_Menu_Funds_MyResources {
			idc = 140003;

			y = "SafeZoneY + (SafezoneH * 0.310)";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			// text = "Player Resources: $8000";
		};
		class CTI_Menu_Funds_Slider : RscXSliderH {
			idc = 140008;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004+0.297*0.02)";
			y = "SafeZoneY + (SafezoneH * 0.36)";
			w = "(3/4*SafeZoneH)*0.297*0.71";
			h = "SafeZoneH * 0.03";

			onSliderPosChanged = "['onFundSliderChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TransferResourcesMenu.sqf'";
		};
		class CTI_Menu_Funds_Box : RscEdit {
			idc = 140009;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004+0.297*0.77)";
			y = "SafeZoneY + (SafezoneH * 0.36)";
			w = "(3/4*SafeZoneH)*0.297*0.19";
			h = "SafeZoneH * 0.03";

			sizeEx = "0.7 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			text = "0";
		};
		class CTI_Menu_Funds_GivePlayer : RscButton {
			idc = 140004;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004+0.005)";
			y = "SafeZoneY + (SafezoneH * 0.4)";
			w = "(3/4*SafeZoneH)*0.277";
			h = "SafeZoneH * 0.04";

			text = "Give Player";
			action = "['onGivePlayerPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TransferResourcesMenu.sqf'";
		};
		class CTI_Menu_Funds_Commander : RscStructuredText {
			idc = 140010;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004)";
			y = "SafeZoneY + (SafezoneH * 0.465)";
			w = "(3/4*SafeZoneH)*0.287";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Funds_Players : CTI_Menu_Funds_Commander {
			idc = 140011;

			y = "SafeZoneY + (SafezoneH * 0.495)";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Funds_ResourcesPool : RscCombo {
			idc = 140006;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.196+0.01 +0.297+0.004+0.287*0.77)";
			y = "SafeZoneY + (SafezoneH * 0.55)";
			w = "(3/4*SafeZoneH)*0.287*0.21";
			h = "SafeZoneH * 0.03";

			onLBSelChanged = "['onResourcesPoolLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TransferResourcesMenu.sqf'";
			sizeEx = "0.7 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Funds_AwardPool : CTI_Menu_Funds_ResourcesPool {
			idc = 140007;

			y = "SafeZoneY + (SafezoneH * 0.605)";

			onLBSelChanged = "['onAwardPoolLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TransferResourcesMenu.sqf'";
		};
	};
};
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################

class CTI_RscTabletServiceMenu {
	movingEnable = 0;
	idd = 90000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_servicemenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_ServiceMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_servicemenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ServiceMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		}


		class CTI_Menu_ListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)";
			y = "SafeZoneY+safezoneH*(0.275+0.01)";
			w = "(3/4*SafeZoneH)*(0.615-0.02)";
			h = "SafeZoneH * 0.3";
		};
		class CTI_Menu_ListHeaders_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)";
			y = "SafeZoneY+safezoneH*(0.275+0.01)";
			w = "(3/4*SafeZoneH)*(0.615-0.02)";
			h = "SafeZoneH * 0.04";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_Repair_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*((0.615-0.02)*0.20)";
			y = "SafeZoneY+safezoneH*(0.275+0.01+0.3+0.01)";
			w = "(3/4*SafeZoneH)*((0.615-0.02)*0.20)";
			h = "SafeZoneH * 0.03";

			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_Rearm_Background : CTI_Menu_Repair_Background {
			y = "SafeZoneY + (SafeZoneH * 0.635)";
		};
		class CTI_Menu_Refuel_Background : CTI_Menu_Repair_Background {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*((0.615-0.02)*0.70)";
		};
		class CTI_Menu_Heal_Background : CTI_Menu_Refuel_Background {
			y = "SafeZoneY + (SafeZoneH * 0.63)";
		};

		class CTI_Menu_Header_Unit : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)";
			y = "SafeZoneY+safezoneH*(0.275+0.01)";
			w = "SafeZoneW * 0.1";
			h = "SafeZoneH * 0.04";

			colorText[] = {0.678431373, 0.815686275, 1};
			text = "Unit";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class CTI_Menu_Header_Damage : CTI_Menu_Header_Unit {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*(0.615-0.02)*0.5";

			text = "Damage";
		};
		class CTI_Menu_Header_Fuel : CTI_Menu_Header_Unit {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*(0.615-0.02)*0.65";

			text = "Fuel";
		};
		class CTI_Menu_Header_Health : CTI_Menu_Header_Unit {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*(0.615-0.02)*0.80";

			text = "Health";
		};
	};

	class controls {
		class CTI_Menu_Control_Repair : RscButton {
			idc = 230001;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)";
			y = "SafeZoneY+safezoneH*(0.275+0.01+0.3+0.01)";
			w = "(3/4*SafeZoneH)*((0.615-0.02)*0.20)";


			text = "Repair";
			action = "['onRepairPressed', lnbCurSelRow 230005] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ServiceMenu.sqf'";
		};
		class CTI_Menu_Control_Rearm : CTI_Menu_Control_Repair {
			idc = 230002;

			y = "SafeZoneY + (SafeZoneH * 0.63)";

			text = "Rearm";
			action = "['onRearmPressed', lnbCurSelRow 230005] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ServiceMenu.sqf'";
		};
		class CTI_Menu_Control_Refuel : CTI_Menu_Control_Repair {
			idc = 230003;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*((0.615-0.02)*0.20)+(3/4*SafeZoneH)*((0.615-0.02)*0.20)+(3/4*SafeZoneH)*((0.615-0.02)*0.10)";

			text = "Refuel";
			action = "['onRefuelPressed', lnbCurSelRow 230005] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ServiceMenu.sqf'";
		};
		class CTI_Menu_Control_Heal : CTI_Menu_Control_Refuel {
			idc = 230004;

			y = "SafeZoneY + (SafeZoneH * 0.63)";

			text = "Heal";
			action = "['onHealPressed', lnbCurSelRow 230005] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ServiceMenu.sqf'";
		};

		class CTI_Menu_RepairCost : RscStructuredText {
			idc = 230011;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*((0.615-0.02)*0.20)";
			y = "SafeZoneY+safezoneH*(0.275+0.01+0.3+0.01)";
			w = "(3/4*SafeZoneH)*((0.615-0.02)*0.20)";
			h = "SafeZoneH * 0.03";


			text = "";

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Rearm : CTI_Menu_RepairCost {
			idc = 230012;

			y = "SafeZoneY + (SafeZoneH * 0.635)";

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Refuel : CTI_Menu_RepairCost {
			idc = 230013;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*((0.615-0.02)*0.70)";

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Heal : CTI_Menu_RepairCost {
			idc = 230014;

			y = "SafeZoneY + (SafeZoneH * 0.635)";
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)+(3/4*SafeZoneH)*((0.615-0.02)*0.70)";

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_Control_EntityList : RscListNBox {
			idc = 230005;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191+0.01)";
			y = "SafeZoneY+safezoneH*(0.275+0.01+0.04)";
			w = "(3/4*SafeZoneH)*(0.615-0.02)";
			h = "SafeZoneH * 0.26";

			rowHeight = "1.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			columns[] = {0.001, 0.50, 0.65, 0.80};

			onLBSelChanged = "['onEntityListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ServiceMenu.sqf'";
			// onLBDblClick = "['onBuildStructure', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};

	};
};
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################


class CTI_RscTabletPurchaseMenu {
	movingEnable = 0;
	idd = 1000000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_purchasemenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_PurchaseMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_purchasemenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";


	class controlsBackground {
		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		};

		class CTI_Menu_Info : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH * 0.045";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH * 0.045";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_SubInfo : CTI_Menu_Info {
			y = "SafeZoneY + (SafezoneH *( 0.280+0.045+0.002))";
			h = "SafeZoneH * 0.07";
		};
		class CTI_Menu_ResourcesInfo_Background : CTI_Menu_Info_Background {
			y = "SafeZoneY + (SafezoneH * (0.280+0.045+0.002+0.04))";
			h = "SafeZoneH * 0.030";
		};
		class CTI_Menu_UnitsListFrame : CTI_Menu_Info {
			y = "SafeZoneY + (SafezoneH *( 0.280+0.045+0.002+0.07+0.002))";
			h = "SafeZoneH * 0.266";
		};


		class CTI_Menu_ComboFrame : CTI_Menu_Info {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			h = "SafeZoneH * 0.078";
		};

		class CTI_Menu_TeamComboLabel : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46*0.33";
			h = "SafeZoneH * 0.035";

			text = "Team :";
			// colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_FactoryComboLabel : CTI_Menu_TeamComboLabel {
			y = "SafeZoneY+safezoneH*(0.280+0.04)";

			text = "Factory :";
		};

		class CTI_Menu_MapFrame : CTI_Menu_ComboFrame {
			y = "SafeZoneY + (SafezoneH * 0.361)";
			h = "SafeZoneH * 0.15";
		};
		class CTI_Menu_Info_MapIntel : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			y = "SafeZoneY + (SafezoneH * 0.361)";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH * 0.03";

			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};

		class CTI_Menu_QueueFrame : CTI_Menu_MapFrame {
			y = "SafeZoneY + (SafezoneH * (0.361+0.15+0.002))";
			h = "SafeZoneH * 0.138";
		};
	};

	class controls {
		class CTI_Menu_Map : RscMapControl {
			idc = 110010;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			y = "SafeZoneY + (SafezoneH * 0.391)";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH * 0.12";

			showCountourInterval = 1;
		};
		class CTI_Menu_Map_Info : RscStructuredText {
			idc = 110901;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			y = "SafeZoneY + (SafezoneH * 0.361)";
			w = "(3/4*SafeZoneH)*0.615*0.46*0.5";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			class Attributes {
				font = "PuristaMedium";
				color = "#ffffff";
				align = "left";
				shadow = 1;
			};
		};
		class CTI_Menu_Group_Info : CTI_Menu_Map_Info {
			idc = 110902;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52+(3/4*SafeZoneH)*0.615*0.46*0.5";
		};
		class CTI_Icon_Barracks : RscActiveText {
			idc = 110001;
			style = ST_KEEP_ASPECT_RATIO;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.282";
			w = "(3/4*SafeZoneH)*0.615*0.46*(1/8)";
			h = "SafeZoneH * 0.041";

			color[] = {0.75,0.75,0.75,0.7};
			colorActive[] = {1,1,1,0.7};
			colorBackground[] = {0.6, 0.8392, 0.4706, 0.7};
			colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 0.7};
			colorFocused[] = {0.0, 0.0, 0.0, 0};

			text = "Rsc\Pictures\icon_wf_building_barracks.paa";
			action = "['onIconSet', 0, CTI_BARRACKS] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Light : CTI_Icon_Barracks {
			idc = 110002;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+(3/4*SafeZoneH)*0.615*0.46*(1/8.1)*1";

			text = "Rsc\Pictures\icon_wf_building_lvs.paa";
			action = "['onIconSet', 1, CTI_LIGHT] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Heavy : CTI_Icon_Barracks {
			idc = 110003;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+(3/4*SafeZoneH)*0.615*0.46*(1/8.1)*2";

			text = "Rsc\Pictures\icon_wf_building_hvs.paa";
			action = "['onIconSet', 2, CTI_HEAVY] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Air : CTI_Icon_Barracks {
			idc = 110004;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+(3/4*SafeZoneH)*0.615*0.46*(1/8.1)*3";

			text = "Rsc\Pictures\icon_wf_building_air.paa";
			action = "['onIconSet', 3, CTI_AIR] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Repair : CTI_Icon_Barracks {
			idc = 110005;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+(3/4*SafeZoneH)*0.615*0.46*(1/8.1)*4";

			text = "Rsc\Pictures\icon_wf_building_repair.paa";
			action = "['onIconSet', 4, CTI_REPAIR] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Ammo : CTI_Icon_Barracks {
			idc = 110006;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+(3/4*SafeZoneH)*0.615*0.46*(1/8.1)*5";

			text = "Rsc\Pictures\icon_wf_building_ammo.paa";
			action = "['onIconSet', 5, CTI_AMMO] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Naval : CTI_Icon_Barracks {
			idc = 110007;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+(3/4*SafeZoneH)*0.615*0.46*(1/8.1)*6";

			text = "Rsc\Pictures\icon_wf_building_naval.paa";
			action = "['onIconSet', 6, CTI_NAVAL] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Town : CTI_Icon_Barracks {
			idc = 110008;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+(3/4*SafeZoneH)*0.615*0.46*(1/8.1)*7";

			text = "\A3\ui_f\data\map\markers\military\flag_ca.paa";
			action = "['onIconSet', 7, CTI_FTOWN] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};

		class CTI_Icon_Lock : CTI_Icon_Barracks {
			idc = 110104;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY + (SafezoneH *( 0.280+0.045+0.002+0.002))";
			h=  "SafeZoneH * 0.036";

			color[] = {1, 0.22745098, 0.22745098, 1};

			colorActive[] = {1,1,1,0.7};
			colorBackground[] = {0.6, 0.8392, 0.4706, 0.7};
			colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 0.7};
			colorFocused[] = {0.0, 0.0, 0.0, 0};

			text = "Rsc\Pictures\i_lock.paa";
			action = "['onVehicleLockClicked'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Driver : CTI_Icon_Lock {
			idc = 110100;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02 + SafeZoneH * 0.036*2 ";
			color[] = {0.258823529, 0.713725490, 1, 1};


			text = "Rsc\Pictures\i_driver.paa";
			action = "['onVehicleIconClicked', 'driver', 110100] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Gunner : CTI_Icon_Driver {
			idc = 110101;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+ SafeZoneH * 0.036*3 ";

			text = "Rsc\Pictures\i_gunner.paa";
			action = "['onVehicleIconClicked', 'gunner', 110101] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Commander : CTI_Icon_Driver {
			idc = 110102;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+ SafeZoneH * 0.036*4 ";

			text = "Rsc\Pictures\i_commander.paa";
			action = "['onVehicleIconClicked', 'commander', 110102] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Turrets : CTI_Icon_Driver {
			idc = 110103;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+ SafeZoneH * 0.036*5 ";

			text = "Rsc\Pictures\i_turrets.paa";
			action = "['onVehicleIconClicked', 'turrets', 110103] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};

		class CTI_Menu_Control_UnitsList : RscListNBox {
			idc = 111007;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			w = "(3/4*SafeZoneH)*0.615*0.46";

			y = "SafeZoneY + (SafezoneH *( 0.280+0.045+0.002+0.07+0.002))";
			h = "SafeZoneH * 0.266";

			// rowHeight = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			rowHeight = "1.35 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			// columns[] = {0.001, 0.26};
			columns[] = {0.001, 0.40};

			onLBSelChanged = "['onUnitsLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
			onLBDblClick = "['onPurchase', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};

		class CTI_Menu_ComboTeam : RscCombo {
			idc = 110018;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52+(3/4*SafeZoneH)*0.615*0.46*0.33 ";
			y = "SafeZoneY+safezoneH*0.282";
			w = "(3/4*SafeZoneH)*0.615*0.46*0.66";
			h = "SafeZoneH * 0.035";

			sizeEx = "0.7 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onLBSelChanged = "['onGroupLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_ComboFactory : CTI_Menu_ComboTeam {
			idc = 110009;

			y = "SafeZoneY+safezoneH*(0.282+0.04)";
			onLBSelChanged = "['onFactoryLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};

		class CTI_Menu_Control_Purchase : RscButton {
			idc = 100011;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*(0.275+0.410)";
			w = "(3/4*SafeZoneH)*0.615*0.46";

			h = "SafeZoneH * 0.03";

			text = "Purchase";
			action = "['onPurchase', lnbCurSelRow 111007] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_Control_IndependentSalvager : CTI_Menu_Control_Purchase {
			idc = 100016;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";

			text = "Buy Independent Salvager";
			action = "['onIndependentSalvagerPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_Control_CancelQueu : CTI_Menu_Control_IndependentSalvager {
			idc = 100012;


			y = "SafeZoneY+safezoneH*(0.275+0.410)-SafeZoneH * 0.032 ";

			text = "Cancel Queue";
			action = "['onQueueCancel', lbCurSel 110013] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};

		class CTI_Menu_Control_QueueList : RscListBox {
			idc = 110013;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			y = "SafeZoneY + (SafezoneH * (0.361+0.15+0.002))";
			h = "SafeZoneH * 0.138";
			w = "(3/4*SafeZoneH)*0.615*0.46";

			rowHeight = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			// onLBSelChanged = "['onUnitsLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
			onLBDblClick = "['onQueueCancel', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_Control_Cost : RscStructuredText {
			idc = 110014;
			y = "SafeZoneY + (SafezoneH * (0.280+0.045+0.002+0.04+0.002))";
			h = "SafeZoneH * 0.030";
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			w = "(3/4*SafeZoneH)*0.615*0.46*0.5";

			size = "0.7 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_Resources : CTI_Menu_Control_Cost {
			idc = 110015;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02+(3/4*SafeZoneH)*0.615*0.46*0.5 ";

			size = "0.7 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

	};
};

//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################

class CTI_RscTabletUpgradeMenu {
	movingEnable = 0;
	idd = 1100000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_upgrademenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_UpgradeMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_upgrademenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UpgradeMenu.sqf'";

	class controlsBackground {

		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		};

		class CTI_Menu_UpgradeListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH*0.436";
		};

		class CTI_Menu_UpgradeInfoFrame : CTI_Menu_UpgradeListFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			h = "SafeZoneH*0.365";
		};
		class CTI_Menu_UpgradeRunningFrame : CTI_Menu_UpgradeInfoFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			y = "SafeZoneY+safezoneH*0.654";
			h = "SafeZoneH * 0.03";
		};
		class CTI_Menu_UpgradeInfo_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			h = "SafeZoneH*0.365";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_UpgradeRunning_Background : CTI_Menu_UpgradeInfo_Background {
			y = "SafeZoneY+safezoneH*0.654";
			h = "SafeZoneH * 0.03";
		};
	}

	class controls {
		class CTI_Control_Upgrade : RscButton {
			idc = 250001;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			y = "SafeZoneY+safezoneH*0.689";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH * 0.03";

			text = "Upgrade";
			action = "['onUpgradePressed', lnbCurSelRow 250002] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UpgradeMenu.sqf'";
		};
		class CTI_Menu_Control_UpgradeList : RscListNBox {
			idc = 250002;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH*0.436";


			rowHeight = "1.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			// columns[] = {0.001, 0.26};
			columns[] = {0.001, 0.18};

			onLBDblClick = "['onUpgradePressed', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UpgradeMenu.sqf'";
			onLBSelChanged = "['onUpgradeListSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UpgradeMenu.sqf'";
		};
		class CTI_Menu_Upgrade_Label : RscText {
			idc = 250003;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.62";
			y = "SafeZoneY+safezoneH*0.285";
			w = "(3/4*SafeZoneH)*0.615*0.36";
			h = "SafeZoneH * 0.05";

			colorText[] = {0.258823529, 0.713725490, 1, 1};
			size = "1.2 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Upgrade_Info : RscStructuredText {
			idc = 250004;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.57";
			y = "SafeZoneY+safezoneH*0.325";
			w = "(3/4*SafeZoneH)*0.615*0.41";
			h = "SafeZoneH * 0.10";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Upgrade_DepLabel : CTI_Menu_Upgrade_Label {
			idc = 250005;

			y = "SafeZoneY + (SafezoneH * 0.39)";
		};
		class CTI_Menu_Upgrade_DepInfo : CTI_Menu_Upgrade_Info {
			idc = 250006;

			y = "SafeZoneY + (SafezoneH * 0.44)";
			h = "SafeZoneH * 0.10";
		};
		class CTI_Menu_Upgrade_DescLabel : CTI_Menu_Upgrade_Label {
			idc = 250007;

			y = "SafeZoneY + (SafezoneH * 0.49)";
		};
		class CTI_Menu_Upgrade_DescInfo : CTI_Menu_Upgrade_Info {
			idc = 250008;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			y = "SafeZoneY + (SafezoneH * 0.54)";
			h = "SafeZoneH * 0.105";
			size = "0.7 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

		};
		class CTI_Menu_Upgrade_RunInfo : RscStructuredText {
			idc = 250009;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.52";
			y = "SafeZoneY+safezoneH*0.654";
			h = "SafeZoneH * 0.03";
			w = "(3/4*SafeZoneH)*0.615*0.46";

			size = "0.79 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
	};
};
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################


class CTI_RscTabletWorkersMenu {
	movingEnable = 0;
	idd = 260000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_workersmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_WorkersMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_workersmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_WorkersMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame2 : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		};

		class CTI_Menu_InfoListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.96";
			h = "SafeZoneH*0.305";
		};

		class CTI_Menu_InfoResourcesFrame : CTI_Menu_InfoListFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.590";
			h = "SafeZoneH * 0.121";
			w = "(3/4*SafeZoneH)*0.615*0.67";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.590";
			h = "SafeZoneH * 0.121";
			w = "(3/4*SafeZoneH)*0.615*0.67";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		/*class CTI_Menu_CommanderFrame : CTI_Menu_InfoResourcesFrame {
			y = "SafeZoneY+safezoneH*(0.280+0.1825+0.005)";
			h = "SafeZoneH * 0.1825";
		};
		class CTI_Menu_Commander_Background : CTI_Menu_Info_Background {
			y = "SafeZoneY+safezoneH*(0.280+0.1825+0.005)";
			h = "SafeZoneH * 0.1825";
		};*/

	};

	class controls {
		class CTI_Menu_Map : RscMapControl {
			idc = 260001;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.96";
			h = "SafeZoneH*0.436*0.70";

			showCountourInterval = 0;
			onMouseButtonDown = "['onMapButtonDown', _this] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_WorkersMenu.sqf'";
		};
		class CTI_Menu_Control_WorkersList : RscListNBox {
			idc = 260002;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.590";
			h = "SafeZoneH * 0.121";
			w = "(3/4*SafeZoneH)*0.615*0.67";

			rowHeight = "1.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			columns[] = {0.001, 0.35};

			onLBSelChanged = "['onWorkersListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_WorkersMenu.sqf'";
			// onLBDblClick = "['onBuildStructure', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Control_Disband : RscButton {
			idc = 260003;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.71";
			y = "SafeZoneY+safezoneH*0.590";
			w = "(3/4*SafeZoneH)*0.615*0.27";
			h = "SafeZoneH * 0.04";

			text = "Disband Worker";
			action = "['onWorkerDisbandPressed', lnbCurSelRow 260002] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_WorkersMenu.sqf'";
		};
		class CTI_Menu_Control_Sell : CTI_Menu_Control_Disband {
			idc = 260004;

			y = "SafeZoneY+safezoneH*(0.590+0.005+0.04)";


			text = "Sell Structure";
			action = "['onStructureSellPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_WorkersMenu.sqf'";
		};
	};
};

//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################


class CTI_RscTabletDefenseMenu {
	movingEnable = 0;
	idd = 200000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_defensemenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_DefenseMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_defensemenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_DefenseMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame2 : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		};


		class CTI_Menu_DefenseListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.5";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.48";
			h = "SafeZoneH*0.441";
		};
		class CTI_Menu_Info : CTI_Menu_DefenseListFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH*0.06";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.46";

			h = "SafeZoneH*0.06";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
	};

	class controls {
		class CTI_Menu_Control_Undo : RscButton {
			idc = 200001;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*(0.280+0.06+0.005)";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH * 0.04";

			text = "Undo Structure";
			action = "['onUndoDefense'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_DefenseMenu.sqf'";
		};
		class CTI_Menu_Control_BuildStructure : CTI_Menu_Control_Undo {
			idc = 200002;

			y = "SafeZoneY+safezoneH*(0.280+0.06+0.005*2+0.04)";

			text = "Build Defense";
			action = "['onBuildDefense', lnbCurSelRow 200007] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_DefenseMenu.sqf'";
		};
		class CTI_Menu_Control_AutoAlign : CTI_Menu_Control_Undo {
			idc = 200003;

			y = "SafeZoneY+safezoneH*(0.280+0.06+0.005*3+0.04*2)";

			text = "";
			action = "['onAutoAlign'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_DefenseMenu.sqf'";
		};

		class CTI_Menu_Control_BuildingList : RscListNBox {
			idc = 200007;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.5";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.48";
			h = "SafeZoneH*0.441";

			rowHeight = "1.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			// columns[] = {0.001, 0.26};
			columns[] = {0.001, 0.18};

			onLBDblClick = "['onBuildDefense', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_DefenseMenu.sqf'";
		};
		class CTI_Menu_Control_Info : RscStructuredText {
			idc = 200008;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.280";
			w = "SafeZoneW * 0.275";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_InfoWorkers : CTI_Menu_Control_Info {
			idc = 200009;

			y = "SafeZoneY+safezoneH*(0.280+0.03)";
		};

	};
};



//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################


class CTI_RscTabletRequestMenu {
	movingEnable = 0;
	idd = 280000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_requestmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_RequestMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_requestmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_RequestMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscTablet {
						moving = 1;
		};


		class CTI_Menu_InfoListFrame : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";

		};

		class CTI_Menu_RequestsListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.196";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*(0.297)";
			h = "SafeZoneH*0.270";
		};
		class CTI_Menu_MapListFrame : CTI_Menu_RequestsListFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.503";
		};
		class CTI_Menu_RequestInfoFrame : CTI_Menu_RequestsListFrame {
			y = "SafeZoneY + (SafezoneH * 0.555)";
			w = "(3/4*SafeZoneH)*0.605";
			h = "SafeZoneH * 0.101";
		};
		class CTI_Menu_RequestInfo_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.196";
			y = "SafeZoneY + (SafezoneH * 0.555)";
			w = "(3/4*SafeZoneH)*0.605";
			h = "SafeZoneH * 0.101";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
	};

	class controls {
		class CTI_Menu_Control_Accept : RscButton {
			idc = 280001;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.196";
			y = "SafeZoneY+safezoneH*0.661";
			w = "(3/4*SafeZoneH)*(0.297)";
			h = "SafeZoneH * 0.04";

			text = "Accept";
			action = "['onRequestAccept', lnbCurSelRow 280005] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_RequestMenu.sqf'";
		};
		class CTI_Menu_Control_Deny : CTI_Menu_Control_Accept {
			idc = 280002;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.503";

			text = "Deny";
			action = "['onRequestDeny', lnbCurSelRow 280005] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_RequestMenu.sqf'";
		};
		class CTI_Menu_Map : RscMapControl {
			idc = 280003;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.503";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*(0.297)";
			h = "SafeZoneH*0.270";

			showCountourInterval = 0;
		};
		class CTI_Menu_Control_Info : RscStructuredText {
			idc = 280004;

			x = "SafeZoneX + (SafeZoneW * 0.525)";
			y = "SafeZoneY + (SafezoneH * 0.54)";
			w = "SafeZoneW * 0.285";
			h = "SafeZoneH * 0.21";

			size = "0.85 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_RequestsList : RscListNBox {
			idc = 280005;

			x = "SafeZoneX + (SafeZoneW * 0.225)";
			y = "SafeZoneY + (SafezoneH * 0.245)";
			w = "SafeZoneW * 0.285";
			h = "SafeZoneH * 0.505";

			rowHeight = "1.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			// columns[] = {0.001, 0.26};
			columns[] = {0.001, 0.26};

			onLBDblClick = "['onRequestAccept', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_RequestMenu.sqf'";
			onLBSelChanged = "['onRequestSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_RequestMenu.sqf'";
		};

	};
};




//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################



class CTI_RscTabletOnlineHelpMenu {
	movingEnable = 0;
	idd = 160000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_onlinehelpmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_OnlineHelpMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_onlinehelpmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_OnlineHelpMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscTablet {
		};
		class CTI_Menu_InfoListFrame2 : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.451";
			colorBackground[] = {0,0,0,1};
			text="";
		};

		class CTI_Menu_InfoListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*(0.275+0.005+0.03+0.005)";
			w = "(3/4*SafeZoneH)*0.615*0.36";
			h = "SafeZoneH*0.351";
		};

		class CTI_Menu_InfoResourcesFrame : CTI_Menu_InfoListFrame {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.42";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.56";
			h = "SafeZoneH*0.436";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.42";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.56";
			h = "SafeZoneH*0.436";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*(0.666+0.005)";
			w = "(3/4*SafeZoneH)*0.615*0.36";
			h = "SafeZoneH * 0.04";

			text = "Close";
			action = "closeDialog 0";
		};
		class CTI_Menu_Inter_text : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615*0.36";
			h = "SafeZoneH*0.03";
			colorBackground[] = {1,0,0,0.4};
			text="Inter. Key";
		};

	};

	class controls {
		class CTI_Menu_Help_Topics : RscListBox {
			idc = 160001;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.02";
			y = "SafeZoneY+safezoneH*(0.275+0.005+0.03+0.005)";
			w = "(3/4*SafeZoneH)*0.615*0.36";
			h = "SafeZoneH*0.351";

			rowHeight = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBSelChanged = "['onHelpLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_OnlineHelpMenu.sqf'";
		};

		class CTI_Menu_Help_ControlsGroup : RscControlsGroup {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.42";
			y = "SafeZoneY+safezoneH*0.280";
			w = "(3/4*SafeZoneH)*0.615*0.56";
			h = "SafeZoneH*0.436";

			class controls {
				class CTI_Menu_Help_Explanation : RscStructuredText {
					idc = 160002;
					x = 0;
					y = 0;
					w = "(3/4*SafeZoneH)*0.615*0.50";
					h = "SafeZoneH*0.600";

					size = "0.75 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					// text = "Your Resources: $8000";
				};
			};
		};
		class CTI_Menu_Funds_ResourcesPool : RscCombo {
			idc = 160003;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.191+(3/4*SafeZoneH)*0.615*0.18";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615*0.20";
			h = "SafeZoneH*0.03";

			onLBSelChanged = "['onKeyLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_OnlineHelpMenu.sqf'";
			sizeEx = "0.8 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
	};
};

//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################































class CTI_RscGearMenu {
	movingEnable = 0;
	idd = 70000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_gear', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_GearMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_gear', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH";

			colorBackground[] = {0, 0, 0, 1};
			moving = 0;
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH * 0.06";

			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Background_Footer : CTI_Background {
			x = "SafeZoneX";
			y = "SafeZoneY + (SafezoneH * 0.96)";
			w = "SafeZoneW";
			h = "SafeZoneH * 0.04";

			colorBackground[] = {0, 0, 0, 0.3};
		};
		class CTI_Menu_Title : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.007)";
			y = "SafeZoneY + (SafezoneH * 0.01)";
			w = "SafeZoneW * 0.5";
			h = "SafeZoneH * 0.037";

			text = "Gear Purchase Menu :";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Background_Gear : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.4)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.6";
			h = "SafeZoneH * 0.9";

			colorBackground[] = {0.5, 0.5, 0.5, 0.15};
		};
		class CTI_Menu_Icons_Frame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.01)";
			// x = "SafeZoneX + (SafeZoneW * 0.028)";
			y = "SafeZoneY + (SafezoneH * 0.07)";
			// w = "SafeZoneW * 0.344";
			w = "SafeZoneW * 0.38";
			h = "SafeZoneH * 0.08";
		};
		class CTI_Menu_Icons_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.07)";
			w = "SafeZoneW * 0.38";
			h = "SafeZoneH * 0.08";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};

		class CTI_Menu_ComboTarget_Frame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.17)";
			w = "SafeZoneW * 0.38";
			h = "SafeZoneH * 0.055";
		};
		class CTI_Menu_ComboTarget_Background : CTI_Menu_Icons_Background {
			y = "SafeZoneY + (SafezoneH * 0.17)";
			h = "SafeZoneH * 0.055";
		};
		class CTI_Menu_ComboTarget_Label : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.02)";
			y = "SafeZoneY + (SafezoneH * 0.18)";
			w = "SafeZoneW * 0.1";
			h = "SafeZoneH * 0.035";

			text = "Target :";

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_ShopList_Frame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.245)";
			w = "SafeZoneW * 0.38";
			h = "SafeZoneH * 0.48";
		};
		class CTI_Menu_LinkedList_Frame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.745)";
			w = "SafeZoneW * 0.38";
			h = "SafeZoneH * 0.2";
		};
		class CTI_Menu_ShopList_Background : CTI_Menu_ComboTarget_Background {
			y = "SafeZoneY + (SafezoneH * 0.245)";
			h = "SafeZoneH * 0.48";
		};
		class CTI_Menu_MagsList_Background : CTI_Menu_ComboTarget_Background {
			y = "SafeZoneY + (SafezoneH * 0.745)";
			h = "SafeZoneH * 0.2";
		};
	};

	class controls {
		//--- Interactive background controls
		class CTI_Gear_Container_Uniform : RscText {
			idc = 77001;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.07)";
			w = "SafeZoneW * 0.09";
			h = "SafeZoneH * 0.112";

			colorBackground[] = {1, 1, 1, 0.15};
		};
		class CTI_Gear_Container_Vest : CTI_Gear_Container_Uniform {
			idc = 77002;

			x = "SafeZoneX + (SafeZoneW * 0.505)";
		};
		class CTI_Gear_Container_Backpack : CTI_Gear_Container_Uniform {
			idc = 77003;

			x = "SafeZoneX + (SafeZoneW * 0.60)";
		};
		class CTI_Gear_Container_Helm : CTI_Gear_Container_Uniform {
			idc = 77004;

			x = "SafeZoneX + (SafeZoneW * 0.70)";
			w = "SafeZoneW * 0.07";
			h = "SafeZoneH * 0.09";
		};
		class CTI_Gear_Container_Glasses : CTI_Gear_Container_Helm {
			idc = 77005;

			x = "SafeZoneX + (SafeZoneW * 0.774)";
		};
		class CTI_Gear_Container_NVGoggles : CTI_Gear_Container_Helm {
			idc = 77006;

			x = "SafeZoneX + (SafeZoneW * 0.847)";
		};
		class CTI_Gear_Container_Binoculars : CTI_Gear_Container_Helm {
			idc = 77007;

			x = "SafeZoneX + (SafeZoneW * 0.921)";
		};
		class CTI_Gear_Container_Map : CTI_Gear_Container_Uniform {
			idc = 77008;

			x = "SafeZoneX + (SafeZoneW * 0.70)";
			y = "SafeZoneY + (SafezoneH * 0.17)";
			w = "SafeZoneW * 0.056";
			h = "SafeZoneH * 0.07";
		};
		class CTI_Gear_Container_GPS : CTI_Gear_Container_Map {
			idc = 77009;

			x = "SafeZoneX + (SafeZoneW * 0.759)";
		};
		class CTI_Gear_Container_Radio : CTI_Gear_Container_Map {
			idc = 77010;

			x = "SafeZoneX + (SafeZoneW * 0.818)";
		};
		class CTI_Gear_Container_Compass : CTI_Gear_Container_Map {
			idc = 77011;

			x = "SafeZoneX + (SafeZoneW * 0.877)";
		};
		class CTI_Gear_Container_Clock : CTI_Gear_Container_Map {
			idc = 77012;

			x = "SafeZoneX + (SafeZoneW * 0.936)";
		};

		class CTI_Gear_Container_Primary : CTI_Gear_Container_Uniform {
			idc = 77013;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.54)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.112";
		};

		class CTI_Gear_Container_Primary_Muzzle : CTI_Gear_Container_Map {
			idc = 77014;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.657)";
			//w = "SafeZoneW * 0.06775";
			w = "SafeZoneW * 0.054";
		};

		class CTI_Gear_Container_Primary_Flashlight : CTI_Gear_Container_Primary_Muzzle {
			idc = 77015;
			x = "SafeZoneX + (SafeZoneW * 0.4665)";

		};
		class CTI_Gear_Container_Primary_Optics : CTI_Gear_Container_Primary_Muzzle {
			idc = 77016;

			x = "SafeZoneX + (SafeZoneW * 0.523)";

		};
		class CTI_Gear_Container_Primary_Bipod : CTI_Gear_Container_Primary_Muzzle {
			idc = 77017;
			x = "SafeZoneX + (SafeZoneW * 0.5795)";

		};
		class CTI_Gear_Container_Primary_CurrentMagazine : CTI_Gear_Container_Primary_Muzzle {
			idc = 77901;

			x = "SafeZoneX + (SafeZoneW * 0.636)";
		};

		class CTI_Gear_Container_Secondary : CTI_Gear_Container_Primary {
			idc = 77018;

			x = "SafeZoneX + (SafeZoneW * 0.71)";
		};
		class CTI_Gear_Container_Secondary_Muzzle : CTI_Gear_Container_Map {
			idc = 77019;

			x = "SafeZoneX + (SafeZoneW * 0.71)";
			y = "SafeZoneY + (SafezoneH * 0.657)";
			w = "SafeZoneW * 0.06775";
		};
		class CTI_Gear_Container_Secondary_Flashlight : CTI_Gear_Container_Secondary_Muzzle {
			idc = 77020;

			x = "SafeZoneX + (SafeZoneW * 0.78075)";
		};
		class CTI_Gear_Container_Secondary_Optics : CTI_Gear_Container_Secondary_Muzzle {
			idc = 77021;

			x = "SafeZoneX + (SafeZoneW * 0.8515)";
		};
		class CTI_Gear_Container_Secondary_Bipod : CTI_Gear_Container_Secondary_Muzzle {
			idc = 77022;

			x = "SafeZoneX + (SafeZoneW * 0.8515)+100";
		};
		class CTI_Gear_Container_Secondary_CurrentMagazine : CTI_Gear_Container_Secondary_Muzzle {
			idc = 77902;

			x = "SafeZoneX + (SafeZoneW * 0.92225)";
		};

		class CTI_Gear_Container_Pistol : CTI_Gear_Container_Primary {
			idc = 77023;

			y = "SafeZoneY + (SafeZoneH * 0.756)";
		};
		class CTI_Gear_Container_Pistol_Muzzle : CTI_Gear_Container_Map {
			idc = 77024;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.873)";
			w = "SafeZoneW * 0.06775";
		};
		class CTI_Gear_Container_Pistol_Flashlight : CTI_Gear_Container_Pistol_Muzzle {
			idc = 77025;

			x = "SafeZoneX + (SafeZoneW * 0.48075)";
		};
		class CTI_Gear_Container_Pistol_Optics : CTI_Gear_Container_Pistol_Muzzle {
			idc = 77026;

			x = "SafeZoneX + (SafeZoneW * 0.5515)";
		};
		class CTI_Gear_Container_Pistol_Bipod : CTI_Gear_Container_Pistol_Muzzle {
			idc = 77027;

			x = "SafeZoneX + (SafeZoneW * 0.5515)+100";
		};
		class CTI_Gear_Container_Pistol_CurrentMagazine : CTI_Gear_Container_Pistol_Muzzle {
			idc = 77903;

			x = "SafeZoneX + (SafeZoneW * 0.62225)";
		};


		class CTI_Gear_Container_Items_Unit : CTI_Gear_Container_Pistol_Muzzle {
			idc = 77109;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.25)";
			w = "SafeZoneW * 0.58";
			h = "SafeZoneH * 0.28";
		};

		//--- Actual controls
		class CTI_Gear_Control_Items_Purchase : RscListNBox {
			idc = 70108;

			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.245)";
			w = "SafeZoneW * 0.38";
			h = "SafeZoneH * 0.48";

			rowHeight = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			columns[] = {0.26, 0.001};

			canDrag = 1;

			onLBDblClick = "['onShoppingListLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrag = "['onShoppingListLBDrag', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBSelChanged = "['onShoppingListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Linked_Items : CTI_Gear_Control_Items_Purchase {
			idc = 70601;

			y = "SafeZoneY + (SafezoneH * 0.745)";
			h = "SafeZoneH * 0.2";

			onLBDblClick = "['onLinkedListLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrag = "['onShoppingListLBDrag', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBSelChanged = "";
		};

		class CTI_Gear_Control_Items_Unit : RscListNBox {
			idc = 70109;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.25)";
			w = "SafeZoneW * 0.58";
			h = "SafeZoneH * 0.28";

			rowHeight = "1.65 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			itemSpacing = 0.001;
			columns[] = {0.01, 0.2};

			onLBDblClick = "['onUnitItemsLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'ListItems', 77109, ((_this select 4) select 0) select 2, -1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};

		class CTI_Gear_Control_Uniform: RscActiveText {
			idc = 70001;

			style = ST_KEEP_ASPECT_RATIO;
			soundDoubleClick[] = {"",0.1,1};

			colorBackground[] = {0.6, 0.83, 0.47, 1};
			colorBackgroundSelected[] = {0.6, 0.83, 0.47, 1};
			colorFocused[] = {0, 0, 0, 0};
			color[] = {0.85, 0.85, 0.85, 1};
			colorText[] = {0.85, 0.85, 0.85, 1};
			colorActive[] = {1, 1, 1, 1};

			canDrag = 1;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.07)";
			w = "SafeZoneW * 0.09";
			h = "SafeZoneH * 0.112";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_uniform_gs.paa";
			action = "['onItemContainerClicked', 0, 77001] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDown = "['onItemContainerMouseClicked', 0, 70001, _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDblClick = "['onItemContainerMouseDblClicked', 0] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Container', 77001, ((_this select 4) select 0) select 2, 0] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Vest: CTI_Gear_Control_Uniform {
			idc = 70002;

			x = "SafeZoneX + (SafeZoneW * 0.505)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_vest_gs.paa";
			action = "['onItemContainerClicked', 1, 77002] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDown = "['onItemContainerMouseClicked', 1, 70002, _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDblClick = "['onItemContainerMouseDblClicked', 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Container', 77002, ((_this select 4) select 0) select 2, 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Backpack: CTI_Gear_Control_Uniform {
			idc = 70003;

			x = "SafeZoneX + (SafeZoneW * 0.60)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_backpack_gs.paa";
			action = "['onItemContainerClicked', 2, 77003] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDown = "['onItemContainerMouseClicked', 2, 70003, _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDblClick = "['onItemContainerMouseDblClicked', 2] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Container', 77003, ((_this select 4) select 0) select 2, 2] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Helm: CTI_Gear_Control_Uniform {
			idc = 70004;

			x = "SafeZoneX + (SafeZoneW * 0.70)";
			w = "SafeZoneW * 0.07";
			h = "SafeZoneH * 0.09";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_helmet_gs.paa";
			action = "['onAccessoryClicked', 0, 70004, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_helmet_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'HeadAsset', 77004, ((_this select 4) select 0) select 2, [2,0]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDown = "";
			onMouseButtonDblClick = "";
		};
		class CTI_Gear_Control_Glasses: CTI_Gear_Control_Helm {
			idc = 70005;

			x = "SafeZoneX + (SafeZoneW * 0.774)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_glasses_gs.paa";
			action = "['onAccessoryClicked', 1, 70005, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_glasses_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'HeadAsset', 77005, ((_this select 4) select 0) select 2, [2,1]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_NVGoggles: CTI_Gear_Control_Helm {
			idc = 70006;

			x = "SafeZoneX + (SafeZoneW * 0.847)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_nvg_gs.paa";
			action = "['onItemClicked', [0,0], 70006, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_nvg_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Item', 77006, ((_this select 4) select 0) select 2, [3,0,0]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Binoculars: CTI_Gear_Control_Helm {
			idc = 70007;

			x = "SafeZoneX + (SafeZoneW * 0.921)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_binocular_gs.paa";
			action = "['onItemClicked', [0,1], 70007, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_binocular_gs.paa', [3,1]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Item', 77007, ((_this select 4) select 0) select 2, [3,0,1]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Map: CTI_Gear_Control_Uniform {
			idc = 70008;

			x = "SafeZoneX + (SafeZoneW * 0.70)";
			y = "SafeZoneY + (SafezoneH * 0.17)";
			w = "SafeZoneW * 0.056";
			h = "SafeZoneH * 0.07";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_map_gs.paa";
			action = "['onItemClicked', [1,0], 70008, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_map_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Item', 77008, ((_this select 4) select 0) select 2, [3,1,0]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDown = "";
			onMouseButtonDblClick = "";
		};
		class CTI_Gear_Control_GPS: CTI_Gear_Control_Map {
			idc = 70009;

			x = "SafeZoneX + (SafeZoneW * 0.759)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gps_gs.paa";
			action = "['onItemClicked', [1,1], 70009, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gps_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Item', 77009, ((_this select 4) select 0) select 2, [3,1,1]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Radio: CTI_Gear_Control_Map {
			idc = 70010;

			x = "SafeZoneX + (SafeZoneW * 0.818)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_radio_gs.paa";
			action = "['onItemClicked', [1,2], 70010, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_radio_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Item', 77010, ((_this select 4) select 0) select 2, [3,1,2]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Compass: CTI_Gear_Control_Map {
			idc = 70011;

			x = "SafeZoneX + (SafeZoneW * 0.877)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_compass_gs.paa";
			action = "['onItemClicked', [1,3], 70011, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_compass_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Item', 77011, ((_this select 4) select 0) select 2, [3,1,3]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Clock: CTI_Gear_Control_Map {
			idc = 70012;

			x = "SafeZoneX + (SafeZoneW * 0.936)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_watch_gs.paa";
			action = "['onItemClicked', [1,4], 70012, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_watch_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Item', 77012, ((_this select 4) select 0) select 2, [3,1,4]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};

		class CTI_Gear_Control_Primary: CTI_Gear_Control_Uniform {
			idc = 70013;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.54)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.112";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_primary_gs.paa";
			action = "['onWeaponClicked', 0] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Weapon', 77013, ((_this select 4) select 0) select 2, 0] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onMouseButtonDown = "";
			onMouseButtonDblClick = "";
		};
		class CTI_Gear_Control_Primary_Muzzle: CTI_Gear_Control_Map {
			idc = 70014;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.657)";
			w = "SafeZoneW * 0.054";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
			action = "['onWeaponAccessoryClicked', 0, 0, 70014, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77014, ((_this select 4) select 0) select 2, [0,0,1,0]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};

		class CTI_Gear_Control_Primary_Side: CTI_Gear_Control_Primary_Muzzle {
			idc = 70015;
			x = "SafeZoneX + (SafeZoneW * 0.4665)";


			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
			action = "['onWeaponAccessoryClicked', 0, 1, 70015, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77015, ((_this select 4) select 0) select 2, [0,0,1,1]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Primary_Optics: CTI_Gear_Control_Primary_Muzzle {
			idc = 70016;
			x = "SafeZoneX + (SafeZoneW * 0.523)";


			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
			action = "['onWeaponAccessoryClicked', 0, 2, 70016, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77016, ((_this select 4) select 0) select 2, [0,0,1,2]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Primary_Bipod: CTI_Gear_Control_Primary_Muzzle {
			idc = 70017;


			x = "SafeZoneX + (SafeZoneW * 0.5795)";

			text = "A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa";
			action = "['onWeaponAccessoryClicked', 0, 0, 70017, 'A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77017, ((_this select 4) select 0) select 2, [0,0,1,3]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Primary_CurrentMagazine: CTI_Gear_Control_Primary_Muzzle {
			idc = 70901;

			x = "SafeZoneX + (SafeZoneW * 0.636)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa";
			action = "['onWeaponCurrentMagazineClicked', 0, 70901] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'CurrentMagazine', 77901, ((_this select 4) select 0) select 2, 0] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};

		class CTI_Gear_Control_Secondary: CTI_Gear_Control_Primary {
			idc = 70018;

			x = "SafeZoneX + (SafeZoneW * 0.71)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_secondary_gs.paa";
			action = "['onWeaponClicked', 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Weapon', 77018, ((_this select 4) select 0) select 2, 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Secondary_Muzzle: CTI_Gear_Control_Map {
			idc = 70019;

			x = "SafeZoneX + (SafeZoneW * 0.71)";
			y = "SafeZoneY + (SafezoneH * 0.657)";
			w = "SafeZoneW * 0.06775";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
			action = "['onWeaponAccessoryClicked', 1, 0, 70019, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77019, ((_this select 4) select 0) select 2, [0,1,1,0]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Secondary_Side: CTI_Gear_Control_Secondary_Muzzle {
			idc = 70020;

			x = "SafeZoneX + (SafeZoneW * 0.78075)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
			action = "['onWeaponAccessoryClicked', 1, 1, 70020, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77020, ((_this select 4) select 0) select 2, [0,1,1,1]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Secondary_Optics: CTI_Gear_Control_Secondary_Muzzle {
			idc = 70021;

			x = "SafeZoneX + (SafeZoneW * 0.8515)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
			action = "['onWeaponAccessoryClicked', 1, 2, 70021, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77021, ((_this select 4) select 0) select 2, [0,1,1,2]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Secondary_Bipod: CTI_Gear_Control_Secondary_Muzzle {
			idc = 70022;

			x = "SafeZoneX + (SafeZoneW * 0.8515)+100";

		};
		class CTI_Gear_Control_Secondary_CurrentMagazine: CTI_Gear_Control_Secondary_Muzzle {
			idc = 70902;

			x = "SafeZoneX + (SafeZoneW * 0.92225)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa";
			action = "['onWeaponCurrentMagazineClicked', 1, 70902] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'CurrentMagazine', 77902, ((_this select 4) select 0) select 2, 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};

		class CTI_Gear_Control_Pistol: CTI_Gear_Control_Primary {
			idc = 70023;

			y = "SafeZoneY + (SafeZoneH * 0.756)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_hgun_gs.paa";
			action = "['onWeaponClicked', 2] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Weapon', 77023, ((_this select 4) select 0) select 2, 2] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Pistol_Muzzle: CTI_Gear_Control_Map {
			idc = 70024;

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.873)";
			w = "SafeZoneW * 0.06775";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa";
			action = "['onWeaponAccessoryClicked', 2, 0, 70024, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77024, ((_this select 4) select 0) select 2, [0,2,1,0]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Pistol_Side: CTI_Gear_Control_Pistol_Muzzle {
			idc = 70025;

			x = "SafeZoneX + (SafeZoneW * 0.48075)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa";
			action = "['onWeaponAccessoryClicked', 2, 1, 70025, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77025, ((_this select 4) select 0) select 2, [0,2,1,1]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Pistol_Optics: CTI_Gear_Control_Pistol_Muzzle {
			idc = 70026;

			x = "SafeZoneX + (SafeZoneW * 0.5515)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa";
			action = "['onWeaponAccessoryClicked', 2, 2, 70026, '\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'Accessory', 77026, ((_this select 4) select 0) select 2, [0,2,1,2]] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Pistol_Bipod: CTI_Gear_Control_Pistol_Muzzle {
			idc = 70027;

			x = "SafeZoneX + (SafeZoneW * 0.5515)+100";


		};
		class CTI_Gear_Control_Pistol_CurrentMagazine: CTI_Gear_Control_Pistol_Muzzle {
			idc = 70903;

			x = "SafeZoneX + (SafeZoneW * 0.62225)";

			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa";
			action = "['onWeaponCurrentMagazineClicked', 2, 70903] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
			onLBDrop = "['onShoppingListLBDrop', 'CurrentMagazine', 77903, ((_this select 4) select 0) select 2, 2] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Combo_Target : RscCombo {
			idc = 70201;

			x = "SafeZoneX + (SafeZoneW * 0.15)";
			y = "SafeZoneY + (SafezoneH * 0.18)";
			w = "SafeZoneW * 0.235";
			h = "SafeZoneH * 0.037";

			onLBSelChanged = "['onUnitLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};

		class CTI_Gear_Uniform_Progress_Load : RscProgress {
			idc = 70301;

			style = 0;
			texture = "";
			textureExt = "";
			colorBar[] = {0.9,0.9,0.9,0.9};
			colorExtBar[] = {1,1,1,1};
			colorFrame[] = {1,1,1,1};

			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.183)";
			w = "SafeZoneW * 0.09";
			h = "SafeZoneH * 0.016";
		};
		class CTI_Gear_Vest_Progress_Load : CTI_Gear_Uniform_Progress_Load {
			idc = 70302;

			x = "SafeZoneX + (SafeZoneW * 0.505)";
		};
		class CTI_Gear_Backpack_Progress_Load : CTI_Gear_Uniform_Progress_Load {
			idc = 70303;

			x = "SafeZoneX + (SafeZoneW * 0.60)";
		};

		class CTI_Icon_Primary : RscActiveText {
			idc = 70501;
			style = ST_KEEP_ASPECT_RATIO;
			x = "SafeZoneX + (SafeZoneW * 0.028)";
			y = "SafeZoneY + (SafezoneH * 0.07)";
			w = "SafeZoneW * 0.043";
			h = "SafeZoneH * 0.08";

			color[] = {0.75,0.75,0.75,0.7};
			colorActive[] = {1,1,1,0.7};
			colorBackground[] = {0.6, 0.8392, 0.4706, 0.7};
			colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 0.7};
			colorFocused[] = {0.0, 0.0, 0.0, 0};

			text = "Rsc\Pictures\icon_wf_gear_primary.paa";
			action = "['onShoppingTabClicked', CTI_GEAR_TAB_PRIMARY] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Icon_Secondary : CTI_Icon_Primary {
			idc = 70502;
			x = "SafeZoneX + (SafeZoneW * 0.071)";

			text = "Rsc\Pictures\icon_wf_gear_secondary.paa";
			action = "['onShoppingTabClicked', CTI_GEAR_TAB_SECONDARY] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Icon_Handgun : CTI_Icon_Primary {
			idc = 70503;
			x = "SafeZoneX + (SafeZoneW * 0.114)";

			text = "Rsc\Pictures\icon_wf_gear_handgun.paa";
			action = "['onShoppingTabClicked', CTI_GEAR_TAB_HANDGUN] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Icon_Accessories : CTI_Icon_Primary {
			idc = 70504;
			x = "SafeZoneX + (SafeZoneW * 0.157)";

			text = "Rsc\Pictures\icon_wf_gear_accessories.paa";
			action = "['onShoppingTabClicked', CTI_GEAR_TAB_ACCESSORIES] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Icon_Ammunitions : CTI_Icon_Primary {
			idc = 70505;
			x = "SafeZoneX + (SafeZoneW * 0.2)";

			text = "Rsc\Pictures\icon_wf_gear_ammunition.paa";
			action = "['onShoppingTabClicked', CTI_GEAR_TAB_AMMO] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Icon_Misc : CTI_Icon_Primary {
			idc = 70506;
			x = "SafeZoneX + (SafeZoneW * 0.243)";

			text = "Rsc\Pictures\icon_wf_gear_miscellaneous.paa";
			action = "['onShoppingTabClicked', CTI_GEAR_TAB_MISC] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Icon_Equipment : CTI_Icon_Primary {
			idc = 70507;
			x = "SafeZoneX + (SafeZoneW * 0.286)";

			text = "Rsc\Pictures\icon_wf_gear_equipment.paa";
			action = "['onShoppingTabClicked', CTI_GEAR_TAB_EQUIPMENT] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Icon_Template : CTI_Icon_Primary {
			idc = 70508;
			x = "SafeZoneX + (SafeZoneW * 0.329)";

			text = "Rsc\Pictures\icon_wf_building_barracks.paa";
			action = "['onShoppingTabClicked', CTI_GEAR_TAB_TEMPLATES] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};

		class CTI_Gear_Control_CreateTemplate : RscButton {
			idc = 70401;

			x = "SafeZoneX + (SafeZoneW * 0.71)";
			y = "SafeZoneY + (SafezoneH * 0.756)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.04";

			text = "Create Template";
			tooltip = "Create a template of the current gear setup";
			action = "['onTemplateCreation'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_DeleteTemplate : CTI_Gear_Control_CreateTemplate {
			idc = 70402;

			y = "SafeZoneY + (SafezoneH * 0.806)";

			text = "Delete Template";
			tooltip = "Remove an existing template";
			action = "['onTemplateDeletion', lnbCurSelRow 70108] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Buy : CTI_Gear_Control_CreateTemplate {
			idc = 70403;

			y = "SafeZoneY + (SafezoneH * 0.903)";

			text = "Buy";
			tooltip = "Purchase the current gear setup";
			action = "['onPurchase'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Menu_Control_Info : RscStructuredText {
			idc = 70028;
			x = "SafeZoneX + (SafeZoneW * 0.41)";
			y = "SafeZoneY + (SafezoneH * 0.21)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.06";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Gear_Control_Clear : RscButton_Lesser {
			idc = 70029;
			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.96)";
			w = "SafeZoneW * 0.185";
			h = "SafeZoneH * 0.04";

			text = "Clear";
			tooltip = "Clear the gear of the existing target";
			action = "['onInventoryClear'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Gear_Control_Reload : CTI_Gear_Control_Clear {
			idc = 70030;
			x = "SafeZoneX + (SafeZoneW * 0.205)";

			text = "Reload";
			tooltip = "Reload the last purchased gear for this target";
			action = "['onInventoryReload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'";
		};
		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.95)";
			y = "SafeZoneY + (SafezoneH * 0.01)";
			w = "SafeZoneW * 0.04";
			h = "SafeZoneH * 0.04";

			text = "X";
			action = "closeDialog 0";
		};
	};
};

class CTI_RscRespawnMenu {
	movingEnable = 0;
	idd = 120000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_respawnmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_RespawnMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_respawnmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_RespawnMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.15)";
			y = "SafeZoneY + (SafezoneH * 0.15)";
			w = "SafeZoneW * 0.7";
			h = "SafeZoneH * 0.7";
			colorBackground[] = {0, 0, 0, 0.7};
			moving = 1;
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX + (SafeZoneW * 0.15)";
			y = "SafeZoneY + (SafezoneH * 0.15)";
			w = "SafeZoneW * 0.7";
			h = "SafeZoneH * 0.05"; //0.06 stock
			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafeZoneW * 0.17)";
			y = "SafeZoneY + (SafezoneH * 0.155)";
			w = "SafeZoneW * 0.68";
			h = "SafeZoneH * 0.037";

			text = "Respawn Menu";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_MapFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.16)";
			y = "SafeZoneY + (SafezoneH * 0.21)";
			w = "SafeZoneW * 0.40";
			h = "SafeZoneH * 0.58";
		};
		class CTI_Menu_InfoFrame : CTI_Menu_MapFrame {
			y = "SafeZoneY + (SafezoneH * 0.8)";
			w = "SafeZoneW * 0.40";
			h = "SafeZoneH * 0.04";
		};
		class CTI_Menu_ListLabelFrame : CTI_Menu_MapFrame {
			x = "SafeZoneX + (SafeZoneW * 0.57)";
			w = "SafeZoneW * 0.27";
			h = "SafeZoneH * 0.04";
		};
		class CTI_Menu_ListFrame : CTI_Menu_ListLabelFrame {
			y = "SafeZoneY + (SafezoneH * 0.26)";
			h = "SafeZoneH * 0.58";
		};
		class CTI_Menu_ListInfo_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.57)";
			y = "SafeZoneY + (SafezoneH * 0.21)";
			w = "SafeZoneW * 0.27";
			h = "SafeZoneH * 0.04";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_ListInfo_Text : RscText {
			style = ST_CENTER;

			x = "SafeZoneX + (SafeZoneW * 0.57)";
			y = "SafeZoneY + (SafezoneH * 0.21)";
			w = "SafeZoneW * 0.27";
			h = "SafeZoneH * 0.04";

			text = "Available locations";
			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
	};

	class controls {
		class CTI_Menu_Map : RscMapControl {
			idc = 120001;

			x = "SafeZoneX + (SafeZoneW * 0.16)";
			y = "SafeZoneY + (SafezoneH * 0.21)";
			w = "SafeZoneW * 0.40";
			h = "SafeZoneH * 0.58";

			showCountourInterval = 1;

			onMouseMoving = "mouseX = (_this select 1);mouseY = (_this select 2)";
			onMouseButtonDown = "mouseButtonDown = _this select 1;";
			onMouseButtonUp = "mouseButtonUp = _this select 1;";
		};
		class CTI_Menu_Control_LocationList : RscListBox {
			idc = 120002;

			x = "SafeZoneX + (SafeZoneW * 0.57)";
			w = "SafeZoneW * 0.27";
			y = "SafeZoneY + (SafezoneH * 0.26)";
			h = "SafeZoneH * 0.58";

			rowHeight = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBSelChanged = "['onSpawnLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_RespawnMenu.sqf'";
			// onLBDblClick = "['onBuildStructureLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Menu_Respawn_Info : RscStructuredText {
			idc = 120003;

			x = "SafeZoneX + (SafeZoneW * 0.16)";
			y = "SafeZoneY + (SafezoneH * 0.805)";
			w = "SafeZoneW * 0.40";
			h = "SafeZoneH * 0.035";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
	};
};


class CTI_RscSatelitteCamera {
	movingEnable = 0;
	idd = 170000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_satcam', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_SatelitteCamera.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_satcam', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_SatelitteCamera.sqf'";

	class controlsBackground {
		class CTI_MouseArea : RscText {
			idc = 170001;
			style = ST_MULTI;

			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";

			text = "";
		};
	};

	class controls {
		class CTI_Background : RscText { //--- Render out.
			idc = 170002;

			x = "SafeZoneX + (SafeZoneW * 0.8)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.55";
			colorBackground[] = {0, 0, 0, 0.5};
		};
		class CTI_Menu_Control_UnitsList_Label : RscText { //--- Render out.
			idc = 170003;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafezoneH * 0.0605)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.03";

			text = "Teams :";
			colorText[] = {0.231372549, 0.580392157, 0.929411765, 1};
			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_UnitsList_Frame : RscFrame { //--- Render out.
			idc = 170004;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafeZoneH * 0.10)";
			h = "SafeZoneH * 0.3";
			w = "SafeZoneW * 0.18";
		};
		class CTI_Menu_Control_UnitsAIList_Label : CTI_Menu_Control_UnitsList_Label { //--- Render out.
			idc = 170005;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafezoneH * 0.41)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.03";

			text = "AI Members :";
		};
		class CTI_Menu_Control_UnitsAIList_Frame : CTI_Menu_Control_UnitsList_Frame { //--- Render out.
			idc = 170006;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafeZoneH * 0.45)";
			h = "SafeZoneH * 0.15";
			w = "SafeZoneW * 0.18";
		};
		class CTI_Menu_Control_ToggleGroups : RscButton_Opac {
			idc = 170007;

			x = "SafeZoneX + (SafeZoneW * 0.8)";
			y = "SafeZoneY + (SafeZoneH * 0.01)";
			h = "SafeZoneH * 0.04";
			w = "SafeZoneW * 0.19";

			text = "";
			action = "['onToggleGroup'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_SatelitteCamera.sqf'";
		};
		class CTI_Menu_Control_ToggleMap : CTI_Menu_Control_ToggleGroups {
			idc = 170008;

			y = "SafeZoneY + (SafeZoneH * 0.95)";

			text = "";
			action = "['onToggleMap'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_SatelitteCamera.sqf'";
		};
		class CTI_Background_Map : CTI_Background { //--- Render out.
			idc = 170009;

			y = "SafeZoneY + (SafezoneH * 0.62)";
			h = "SafeZoneH * 0.32";
		};
		class CTI_Menu_Map : RscMapControl { //--- Render out.
			idc = 170010;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafezoneH * 0.63)";
			w = "SafeZoneW * 0.18";
			h = "SafeZoneH * 0.30";

			showCountourInterval = 1;
			onMouseButtonDown = "nullReturn = _this call CTI_UI_SatelitteCamera_MapClicked";
		};
		class CTI_Background_Top : CTI_Background {
			idc = 170011;
			style = ST_CENTER;

			x = "SafeZoneX + (SafeZoneW * 0.33)";
			y = "SafeZoneY + (SafezoneH * 0.01)";
			w = "SafeZoneW * 0.34";
			h = "SafeZoneH * 0.04";

			text = "";
			sizeEx = "0.94 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_Exit : RscButton_Opac {
			idc = 170012;

			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafeZoneH * 0.95)";
			h = "SafeZoneH * 0.04";
			w = "SafeZoneW * 0.14";

			text = "Exit";
			action = "closeDialog 0";
		};
		class CTI_Menu_Control_Mode : CTI_Menu_Control_Exit {
			idc = 170013;

			x = "SafeZoneX + (SafeZoneW * 0.16)";

			text = "";
			action = "['onViewModeChanged'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_SatelitteCamera.sqf'";
		};
		class CTI_Menu_UnitCamJump : CTI_Menu_Control_Exit {
			idc = 170014;

			x = "SafeZoneX + (SafeZoneW * 0.31)";

			text = "Unit Camera";
			action = "['onUnitCameraJump'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_SatelitteCamera.sqf'";
		};
		class CTI_Menu_Control_ToggleInfo : CTI_Menu_Control_ToggleGroups {
			idc = 170015;

			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafeZoneH * 0.01)";

			text = "";
			action = "['onToggleInfo'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_SatelitteCamera.sqf'";
		};
		class CTI_Background_Info : CTI_Background { //--- Render out.
			idc = 170016;

			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.31";
			h = "SafeZoneH * 0.6";
		};
		class CTI_Menu_Help_ControlsGroup : RscControlsGroup { //--- Render out.
			idc = 170018;
			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.31";
			h = "SafeZoneH * 0.6";

			class controls {
				class CTI_Menu_Control_Info : RscStructuredText {
					idc = 170017;

					x = 0;
					y = 0;
					w = "SafeZoneW * 0.31";
					h = "SafeZoneH * 1";

					size = "0.75 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				};
			};
		};

		class CTI_Menu_Control_UnitsList : RscListBox { //--- Render out.
			idc = 170100;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafeZoneH * 0.10)";
			h = "SafeZoneH * 0.3";
			w = "SafeZoneW * 0.18";

			rowHeight = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBSelChanged = "['onUnitsLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_SatelitteCamera.sqf'";
		};
		class CTI_Menu_Control_UnitsAIList : CTI_Menu_Control_UnitsList { //--- Render out.
			idc = 170101;

			y = "SafeZoneY + (SafeZoneH * 0.45)";
			h = "SafeZoneH * 0.15";

			onLBSelChanged = "['onUnitsAILBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_SatelitteCamera.sqf'";
		};
	};
};

class CTI_RscUnitsCamera {
	movingEnable = 0;
	idd = 180000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_unitscam', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_UnitsCamera.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_unitscam', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";

	class controlsBackground {
		class CTI_MouseArea : RscText {
			idc = 180001;
			style = ST_MULTI;

			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";

			text = "";
		};
	};

	class controls {
		class CTI_Background : RscText { //--- Render out.
			idc = 180002;

			x = "SafeZoneX + (SafeZoneW * 0.8)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.55";

			colorBackground[] = {0, 0, 0, 0.5};
		};
		class CTI_Menu_Control_UnitsList_Label : RscText { //--- Render out.
			idc = 180003;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafezoneH * 0.0605)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.03";

			text = "Teams :";
			colorText[] = {0.231372549, 0.580392157, 0.929411765, 1};
			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_UnitsList_Frame : RscFrame { //--- Render out.
			idc = 180004;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafeZoneH * 0.10)";
			h = "SafeZoneH * 0.3";
			w = "SafeZoneW * 0.18";
		};
		class CTI_Menu_Control_UnitsAIList_Label : CTI_Menu_Control_UnitsList_Label { //--- Render out.
			idc = 180005;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafezoneH * 0.41)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.03";

			text = "AI Members :";
		};
		class CTI_Menu_Control_UnitsAIList_Frame : CTI_Menu_Control_UnitsList_Frame { //--- Render out.
			idc = 180006;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafeZoneH * 0.45)";
			h = "SafeZoneH * 0.15";
			w = "SafeZoneW * 0.18";
		};
		class CTI_Menu_Control_ToggleGroups : RscButton_Opac {
			idc = 180007;

			x = "SafeZoneX + (SafeZoneW * 0.8)";
			y = "SafeZoneY + (SafeZoneH * 0.01)";
			h = "SafeZoneH * 0.04";
			w = "SafeZoneW * 0.19";

			text = "";
			action = "['onToggleGroup'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Menu_Control_ToggleMap : CTI_Menu_Control_ToggleGroups {
			idc = 180008;

			y = "SafeZoneY + (SafeZoneH * 0.95)";

			text = "";
			action = "['onToggleMap'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Background_Map : CTI_Background { //--- Render out.
			idc = 180009;

			y = "SafeZoneY + (SafezoneH * 0.62)";
			h = "SafeZoneH * 0.32";
		};
		class CTI_Menu_Map : RscMapControl { //--- Render out.
			idc = 180010;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafezoneH * 0.63)";
			w = "SafeZoneW * 0.18";
			h = "SafeZoneH * 0.30";

			showCountourInterval = 1;
		};
		class CTI_Background_Top : CTI_Background {
			idc = 180011;
			style = ST_CENTER;

			x = "SafeZoneX + (SafeZoneW * 0.33)";
			y = "SafeZoneY + (SafezoneH * 0.01)";
			w = "SafeZoneW * 0.34";
			h = "SafeZoneH * 0.04";

			text = "";
			sizeEx = "0.94 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_Exit : RscButton_Opac {
			idc = 180012;

			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafeZoneH * 0.95)";
			h = "SafeZoneH * 0.04";
			w = "SafeZoneW * 0.14";

			text = "Exit";
			action = "closeDialog 0";
		};
		class CTI_Menu_Control_Mode : CTI_Menu_Control_Exit {
			idc = 180013;

			x = "SafeZoneX + (SafeZoneW * 0.16)";

			text = "";
			action = "['onViewModeChanged'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Menu_UnitCamJump : CTI_Menu_Control_Exit { //--- Render out
			idc = 180014;

			x = "SafeZoneX + (SafeZoneW * 0.31)";

			text = "Satellite Camera";
			action = "['onSatelliteCameraJump'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Menu_Control_ToggleInfo : CTI_Menu_Control_ToggleGroups {
			idc = 180015;

			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafeZoneH * 0.01)";

			text = "";
			action = "['onToggleInfo'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Background_Info : CTI_Background { //--- Render out.
			idc = 180016;

			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.31";
			h = "SafeZoneH * 0.6";
		};
		class CTI_Menu_Help_ControlsGroup : RscControlsGroup { //--- Render out.
			idc = 180018;
			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.31";
			h = "SafeZoneH * 0.6";

			class controls {
				class CTI_Menu_Control_Info : RscStructuredText {
					idc = 180017;

					x = 0;
					y = 0;
					w = "SafeZoneW * 0.31";
					h = "SafeZoneH * 1";

					size = "0.75 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				};
			};
		};
		class CTI_Menu_Control_IronSight : RscButton_Opac {
			idc = 180019;

			x = "SafeZoneX + (SafeZoneW * 0.01)";
			y = "SafeZoneY + (SafeZoneH * 0.90)";
			h = "SafeZoneH * 0.04";
			w = "SafeZoneW * 0.14";

			text = "Iron Sight";
			action = "['onCamChange', 'ironsight'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Menu_Control_Internal : CTI_Menu_Control_IronSight {
			idc = 180020;

			y = "SafeZoneY + (SafeZoneH * 0.85)";

			text = "Internal";
			action = "['onCamChange', 'internal'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Menu_Control_External : CTI_Menu_Control_IronSight { //--- Render out.
			idc = 180021;

			y = "SafeZoneY + (SafeZoneH * 0.80)";

			text = "External";
			action = "['onCamChange', 'external'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Menu_Control_Unflip : CTI_Menu_Control_IronSight {
			idc = 180022;

			y = "SafeZoneY + (SafeZoneH * 0.75)";

			text = "Unflip Unit";
			action = "['onUnitUnflip'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Menu_Control_Disband : CTI_Menu_Control_IronSight { //--- Render out.
			idc = 180023;

			y = "SafeZoneY + (SafeZoneH * 0.70)";

			text = "Disband Unit";
			action = "['onUnitDisband'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		/*class CTI_Menu_Control_Remote : CTI_Menu_Control_IronSight {
			idc = 180024;

			y = "SafeZoneY + (SafeZoneH * 0.65)";

			text = "Remote Control";
			action = "['onRemote'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};*/

		class CTI_Menu_Control_UnitsList : RscListBox { //--- Render out.
			idc = 180100;

			x = "SafeZoneX + (SafeZoneW * 0.805)";
			y = "SafeZoneY + (SafeZoneH * 0.10)";
			h = "SafeZoneH * 0.3";
			w = "SafeZoneW * 0.18";

			rowHeight = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBSelChanged = "['onUnitsLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
		class CTI_Menu_Control_UnitsAIList : CTI_Menu_Control_UnitsList { //--- Render out.
			idc = 180101;

			y = "SafeZoneY + (SafeZoneH * 0.45)";
			h = "SafeZoneH * 0.15";

			onLBSelChanged = "['onUnitsAILBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_UnitsCamera.sqf'";
		};
	};
};

class CTI_RscTeamsMenu {
	movingEnable = 0;
	idd = 190000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_teamsmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_TeamsMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_teamsmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.025)";//0.1
			y = "SafeZoneY + (SafezoneH * 0.025)";//0.105
			w = "SafeZoneW * 0.95";
			h = "SafeZoneH * 0.95";
			colorBackground[] = {0, 0, 0, 0.7};
			moving = 1;
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX + (SafeZoneW * 0.025)";
			y = "SafeZoneY + (SafezoneH * 0.025)";
			w = "SafeZoneW * 0.95";
			h = "SafeZoneH * 0.05"; //0.06 stock
			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafeZoneW * 0.045)";
			y = "SafeZoneY + (SafezoneH * 0.03)";
			w = "SafeZoneW * 0.93";
			h = "SafeZoneH * 0.037";

			text = "Teams";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_InfoListFrame : RscFrame {
			// x = "SafeZoneX + (SafeZoneW * 0.11)";
			x = "SafeZoneX + (SafeZoneW * 0.035)";
			// y = "SafeZoneY + (SafezoneH * 0.175)";
			y = "SafeZoneY + (SafezoneH * 0.09)";
			w = "SafeZoneW * 0.93";
			h = "SafeZoneH * 0.625";
		};
		class CTI_Menu_ActionListFrame : CTI_Menu_InfoListFrame {
			y = "SafeZoneY + (SafezoneH * 0.73)";
			w = "SafeZoneW * 0.22";
			h = "SafeZoneH * 0.23";
		};
		class CTI_Menu_ActionTeamListFrame : CTI_Menu_ActionListFrame {
			x = "SafeZoneX + (SafeZoneW * 0.265)";
			// x = "SafeZoneX + (SafeZoneW * 0.34)";
			w = "SafeZoneW * 0.7";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.035)";
			y = "SafeZoneY + (SafezoneH * 0.09)";
			w = "SafeZoneW * 0.93";
			h = "SafeZoneH * 0.04";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_Header_Team : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.04)";
			y = "SafeZoneY + (SafezoneH * 0.09)";
			w = "SafeZoneW * 0.1";
			h = "SafeZoneH * 0.04";

			colorText[] = {0.678431373, 0.815686275, 1};
			text = "Team";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class CTI_Menu_Header_Size : CTI_Menu_Header_Team {
			x = "SafeZoneX + (SafeZoneW * 0.271)";

			text = "Size";
		};
		class CTI_Menu_Header_Funds : CTI_Menu_Header_Team {
			x = "SafeZoneX + (SafeZoneW * 0.366)";

			text = "Resources";
		};
		class CTI_Menu_Header_Independent : CTI_Menu_Header_Team {
			x = "SafeZoneX + (SafeZoneW * 0.485)";

			text = "Independent";
		};
		class CTI_Menu_Header_Role : CTI_Menu_Header_Team {
			x = "SafeZoneX + (SafeZoneW * 0.597)";

			text = "Role";
		};
		class CTI_Menu_Header_Order : CTI_Menu_Header_Team {
			x = "SafeZoneX + (SafeZoneW * 0.782)";

			text = "Order";
		};

		class CTI_Menu_Action_Independent : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.27)";//.345
			y = "SafeZoneY + (SafezoneH * 0.75)";
			w = "SafeZoneW * 0.1";
			h = "SafeZoneH * 0.04";

			text = "Independent:";
			sizeEx = "0.84 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class CTI_Menu_Action_Role : CTI_Menu_Action_Independent {
			y = "SafeZoneY + (SafezoneH * 0.8)";

			text = "Role:";
		};
		class CTI_Menu_Action_Order : CTI_Menu_Action_Independent {
			y = "SafeZoneY + (SafezoneH * 0.85)";

			text = "Order:";
		};
		class CTI_Menu_Action_Transfer : CTI_Menu_Action_Independent {
			y = "SafeZoneY + (SafezoneH * 0.9)";

			text = "Transfer:";
		};

		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.925)";
			y = "SafeZoneY + (SafezoneH * 0.03)";
			w = "SafeZoneW * 0.04";
			h = "SafeZoneH * 0.04";

			text = "X";
			action = "closeDialog 0";
		};
		class CTI_Control_Back : CTI_Control_Exit {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.88)";

			text = "<<";
			action = "closeDialog 0; createDialog 'CTI_RscTablet_main';";
		};
	};

	class controls {
		class CTI_Menu_Control_TeamsList : RscListNBox {
			idc = 190001;

			x = "SafeZoneX + (SafeZoneW * 0.035)";
			y = "SafeZoneY + (SafezoneH * 0.13)";
			w = "SafeZoneW * 0.93";
			h = "SafeZoneH * 0.585";

			rowHeight = "1.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			columns[] = {0.001, 0.25, 0.35, 0.48, 0.6, 0.8};

			onLBSelChanged = "['onTeamListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
			// onLBDblClick = "['onBuildStructure', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'";
		};
		class CTI_Control_Button_AIIndependent : RscButton {
			idc = 190002;

			x = "SafeZoneX + (SafeZoneW * 0.045)";
			y = "SafeZoneY + (SafezoneH * 0.74)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.04";

			text = "All AI Independent";
			action = "['onAllAIIndependentPressed', 0] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_AINotIndependent : CTI_Control_Button_AIIndependent {
			idc = 190003;

			y = "SafeZoneY + (SafezoneH * 0.79)";

			text = "No AI Independent";
			action = "['onAllAIIndependentPressed', 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Menu_Control_Info : RscStructuredText {
			idc = 190004;

			x = "SafeZoneX + (SafeZoneW * 0.045)";
			y = "SafeZoneY + (SafezoneH * 0.85)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.03";

			// text = "Resources: $900000";
			size = "0.85 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Combo_Independent : RscCombo {
			idc = 190005;

			x = "SafeZoneX + (SafeZoneW * 0.37)";//.445
			y = "SafeZoneY + (SafezoneH * 0.75)";
			w = "SafeZoneW * 0.15";
			h = "SafeZoneH * 0.04";

			sizeEx = "0.78 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Combo_Role : CTI_Menu_Combo_Independent {
			idc = 190006;

			y = "SafeZoneY + (SafezoneH * 0.8)";

			sizeEx = "0.78 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Combo_Order : CTI_Menu_Combo_Independent {
			idc = 190016;

			y = "SafeZoneY + (SafezoneH * 0.85)";

			sizeEx = "0.78 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Combo_Funds : CTI_Menu_Combo_Independent {
			idc = 190007;

			y = "SafeZoneY + (SafezoneH * 0.9)";

			sizeEx = "0.78 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Control_Button_SetIndependent : RscButton {
			idc = 190008;

			x = "SafeZoneX + (SafeZoneW * 0.53)";//.605
			y = "SafeZoneY + (SafezoneH * 0.75)";
			w = "SafeZoneW * 0.21";//.12
			h = "SafeZoneH * 0.04";

			text = "Set";
			action = "['onSetTeamIndependentPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_SetRole : CTI_Control_Button_SetIndependent {
			idc = 190009;

			y = "SafeZoneY + (SafezoneH * 0.8)";

			text = "Set";
			action = "['onSetRolePressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_Order : CTI_Control_Button_SetIndependent {
			idc = 190010;

			y = "SafeZoneY + (SafezoneH * 0.85)";

			text = "Order";
			action = "['onOrderPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_SendFunds : CTI_Control_Button_SetIndependent {
			idc = 190014;

			y = "SafeZoneY + (SafezoneH * 0.9)";

			text = "Transfer";
			action = "['onTransferFundsPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_SetIndependentAll : CTI_Control_Button_SetIndependent {
			idc = 190011;

			x = "SafeZoneX + (SafeZoneW * 0.75)";
			y = "SafeZoneY + (SafezoneH * 0.75)";
			w = "SafeZoneW * 0.205";
			h = "SafeZoneH * 0.04";

			text = "Set to All";
			action = "['onSetAllTeamIndependentPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_SetRoleAll : CTI_Control_Button_SetIndependentAll {
			idc = 190012;

			y = "SafeZoneY + (SafezoneH * 0.8)";

			text = "Set to All";
			action = "['onSetAllRolePressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_OrderAll : CTI_Control_Button_SetIndependentAll {
			idc = 190015;

			y = "SafeZoneY + (SafezoneH * 0.85)";

			text = "Order to All";
			action = "['onOrderAllPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_TransferAll : CTI_Control_Button_SetIndependentAll {
			idc = 190013;

			y = "SafeZoneY + (SafezoneH * 0.9)";

			text = "Transfer to All";
			action = "['onTransferAllPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
		class CTI_Control_Button_Disbands : RscButton_Lesser {
			idc = 190017;
			x = "SafeZoneX + (SafeZoneW * 0.045)";
			y = "SafeZoneY + (SafezoneH * 0.9)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.04";

			text = "Disband Team";
			action = "['onTeamDisband', lnbCurSelRow 190001] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_TeamsMenu.sqf'";
		};
	};
};


class CTI_RscMapCommandMenu {
	movingEnable = 0;
	idd = 220000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_mapcommandmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_MapCommandMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_mapcommandmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH * 0.05";
			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafezoneH * 0.02)";
			y = "SafeZoneY + (SafezoneH * 0.005)";
			w = "SafeZoneW * 0.98";
			h = "SafeZoneH * 0.037";

			text = "Map Commanding";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Map : RscMapControl {
			idc = 220001;

			x = "SafeZoneX";
			y = "SafeZoneY + (SafezoneH * 0.05)";
			w = "SafeZoneW";
			h = "SafeZoneH * 0.95";

			// showCountourInterval = 1;
			onMouseButtonDown = "['onMapButtonDown', _this] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";
		};
	};

	class controls {
		class CTI_Background_List : RscText {
			idc = 220701;
			x = "SafeZoneX + (SafeZoneW * 0.78)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.21";
			h = "SafeZoneH * 0.9";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Menu_UnitsListFrame : RscFrame {
			idc = 220702;
			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.30";
		};
		class CTI_Menu_List_Background : RscText {
			idc = 220708;
			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.30";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_Control_UnitsList_Label : RscText { //--- Render out.
			idc = 220703;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.03";

			text = "Teams :";
			colorText[] = {0.231372549, 0.580392157, 0.929411765, 1};
			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_OrdersList_Label : CTI_Menu_Control_UnitsList_Label { //--- Render out.
			idc = 220704;

			y = "SafeZoneY + (SafezoneH * 0.405)";
			h = "SafeZoneH * 0.03";

			text = "Orders :";
		};
		class CTI_Menu_OrdersListFrame : CTI_Menu_UnitsListFrame {
			idc = 220705;

			y = "SafeZoneY + (SafezoneH * 0.44)";
			h = "SafeZoneH * 0.16";
		};
		class CTI_Menu_Orders_Background : CTI_Menu_List_Background {
			idc = 220709;

			y = "SafeZoneY + (SafezoneH * 0.44)";
			h = "SafeZoneH * 0.16";
		};
		class CTI_Menu_Control_OrdersParamList_Label : CTI_Menu_Control_UnitsList_Label { //--- Render out.
			idc = 220706;

			y = "SafeZoneY + (SafezoneH * 0.61)";
			h = "SafeZoneH * 0.03";

			text = "Order Parameters :";
		};
		class CTI_Menu_OrdersParamListFrame : CTI_Menu_UnitsListFrame {
			idc = 220707;

			y = "SafeZoneY + (SafezoneH * 0.645)";
			h = "SafeZoneH * 0.2";
		};
		class CTI_Menu_OrdersParam_Background : CTI_Menu_List_Background {
			idc = 220710;

			y = "SafeZoneY + (SafezoneH * 0.645)";
			h = "SafeZoneH * 0.2";
		};
		class CTI_Background_Intel : RscText {
			idc = 220711;
			x = "SafeZoneX + (SafeZoneW * 0.26)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.48";
			h = "SafeZoneH * 0.03";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Menu_Control_UnitsList : RscListNBox {
			idc = 220002;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.30";

			rowHeight = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.75 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			columns[] = {0.001, 0.4};

			onLBDblClick = "['onUnitListLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";
			onLBSelChanged = "['onUnitListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";
		};
		class CTI_Menu_Control_OrdersList : RscListBox {
			idc = 220009;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.44)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.16";

			rowHeight = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.75 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBSelChanged = "['onOrdersListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";
			onLBDblClick = "['onOrdersListLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";
		};
		class CTI_Menu_Control_OrdersParamList : CTI_Menu_Control_OrdersList {
			idc = 220010;

			y = "SafeZoneY + (SafezoneH * 0.645)";
			h = "SafeZoneH * 0.2";

			onLBDblClick = "['onOrdersParamLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";
			onLBSelChanged = "";
		};

		class CTI_Menu_Control_SetOrder : RscButton_Opac {
			idc = 220011;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafeZoneH * 0.86)";
			h = "SafeZoneH * 0.04";
			w = "SafeZoneW * 0.2";

			sizeEx = "0.85 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			text = "Set Order";
			action = "['onSetOrderPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";
		};
		class CTI_Menu_Control_SetMapOrder : CTI_Menu_Control_SetOrder {
			idc = 220012;

			y = "SafeZoneY + (SafeZoneH * 0.91)";

			text = "Set Order (Map Click)";
			action = "['onSetMapOrderPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_MapCommandMenu.sqf'";
		};
		class CTI_Menu_Control_IntelText : RscStructuredText {
			idc = 220013;

			x = "SafeZoneX + (SafeZoneW * 0.26)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.48";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.95)";
			y = "SafeZoneY + (SafezoneH * 0.005)";
			w = "SafeZoneW * 0.04";
			h = "SafeZoneH * 0.04";

			text = "X";
			action = "closeDialog 0";
		};
		class CTI_Control_Back : CTI_Control_Exit {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.905)";

			text = "<<";
			action = "closeDialog 0; createDialog 'CTI_RscTablet_main';";
		};
	};
};


class CTI_RscHookMenu {
	movingEnable = 0;
	idd = 240000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_hookmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_HookMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_hookmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_HookMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.2)";
			y = "SafeZoneY + (SafezoneH * 0.205)";
			w = "SafeZoneW * 0.3";
			h = "SafeZoneH * 0.56";
			colorBackground[] = {0, 0, 0, 0.7};
			moving = 1;
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX + (SafeZoneW * 0.2)";
			y = "SafeZoneY + (SafezoneH * 0.205)";
			w = "SafeZoneW * 0.3";
			h = "SafeZoneH * 0.05"; //0.06 stock
			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafeZoneW * 0.22)";
			y = "SafeZoneY + (SafezoneH * 0.21)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.037";

			text = "Hook Menu";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_InfoListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.21)";
			y = "SafeZoneY + (SafezoneH * 0.275)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.3";
		};
		class CTI_Menu_HookInfoFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.21)";
			y = "SafeZoneY + (SafezoneH * 0.64)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.06";
		};
		class CTI_Menu_HookInfo_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.21)";
			y = "SafeZoneY + (SafezoneH * 0.64)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.06";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
	};

	class controls {
		class CTI_Menu_Options_Hook : RscButton {
			idc = 240001;

			x = "SafeZoneX + (SafeZoneW * 0.21)";
			y = "SafeZoneY + (SafezoneH * 0.585)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.04";

			text = "Hook";
			action = "['onHookPressed', lbCurSel 240004] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_HookMenu.sqf'";
		};
		class CTI_Menu_Vehicle : RscText {
			idc = 240002;

			x = "SafeZoneX + (SafeZoneW * 0.21)";
			y = "SafeZoneY + (SafezoneH * 0.64)";
			h = "SafeZoneH * 0.03";
			w = "SafeZoneW * 0.28";

			text = "";

			sizeEx = "0.82 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Vehicle_Hooked : CTI_Menu_Vehicle {
			idc = 240003;

			y = "SafeZoneY + (SafezoneH * 0.67)";
		};
		class CTI_Menu_Control_TargetList : RscListBox { //--- Render out.
			idc = 240004;

			x = "SafeZoneX + (SafeZoneW * 0.21)";
			y = "SafeZoneY + (SafezoneH * 0.275)";
			w = "SafeZoneW * 0.28";
			h = "SafeZoneH * 0.3";

			rowHeight = "1.2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBDblClick = "['onHookPressed', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_HookMenu.sqf'";
		};
		class CTI_Menu_Options_Detach : CTI_Menu_Options_Hook {
			idc = 240005;

			y = "SafeZoneY + (SafezoneH * 0.71)";

			text = "Detach";
			action = "['onHookDetach'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_HookMenu.sqf'";
		};
		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.45)";
			y = "SafeZoneY + (SafezoneH * 0.21)";
			w = "SafeZoneW * 0.04";
			h = "SafeZoneH * 0.04";

			text = "X";
			action = "closeDialog 0";
		};
	};
};


class CTI_RscAIMicromanagementMenu {
	movingEnable = 0;
	idd = 270000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_aimicromenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_aimicromenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH * 0.05";
			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafezoneH * 0.02)";
			y = "SafeZoneY + (SafezoneH * 0.005)";
			w = "SafeZoneW * 0.98";
			h = "SafeZoneH * 0.037";

			text = "AI Micromanagement";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Map : RscMapControl {
			idc = 270001;

			x = "SafeZoneX";
			y = "SafeZoneY + (SafezoneH * 0.05)";
			w = "SafeZoneW";
			h = "SafeZoneH * 0.95";

			// showCountourInterval = 1;
			onMouseButtonDown = "['onMapButtonDown', _this] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
		};
	};

	class controls {
		class CTI_Background_List : RscText {
			idc = 270701;
			x = "SafeZoneX + (SafeZoneW * 0.78)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.21";
			h = "SafeZoneH * 0.9";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Menu_UnitsListFrame : RscFrame {
			idc = 270702;
			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.25";
		};
		class CTI_Menu_List_Background : RscText {
			idc = 270708;
			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.25";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_Control_UnitsList_Label : RscText {
			idc = 270703;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.03";

			text = "AI :";
			colorText[] = {0.231372549, 0.580392157, 0.929411765, 1};
			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_OrdersList_Label : CTI_Menu_Control_UnitsList_Label {
			idc = 270704;

			y = "SafeZoneY + (SafezoneH * 0.405)";
			h = "SafeZoneH * 0.03";

			text = "Orders :";
		};
		class CTI_Menu_OrdersListFrame : CTI_Menu_UnitsListFrame {
			idc = 270705;

			y = "SafeZoneY + (SafezoneH * 0.44)";
			h = "SafeZoneH * 0.16";
		};
		class CTI_Menu_Orders_Background : CTI_Menu_List_Background {
			idc = 270709;

			y = "SafeZoneY + (SafezoneH * 0.44)";
			h = "SafeZoneH * 0.16";
		};
		class CTI_Menu_Control_OrdersParamList_Label : CTI_Menu_Control_UnitsList_Label { //--- Render out.
			idc = 270706;

			y = "SafeZoneY + (SafezoneH * 0.61)";
			h = "SafeZoneH * 0.03";

			text = "Order Parameters :";
		};
		class CTI_Menu_OrdersParamListFrame : CTI_Menu_UnitsListFrame {
			idc = 270707;

			y = "SafeZoneY + (SafezoneH * 0.645)";
			h = "SafeZoneH * 0.2";
		};
		class CTI_Menu_OrdersParam_Background : CTI_Menu_List_Background {
			idc = 270710;

			y = "SafeZoneY + (SafezoneH * 0.645)";
			h = "SafeZoneH * 0.2";
		};
		class CTI_Background_Intel : RscText {
			idc = 270711;
			x = "SafeZoneX + (SafeZoneW * 0.26)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.48";
			h = "SafeZoneH * 0.03";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Menu_Control_UnitsList : RscListBox {
			idc = 270002;
			style = LB_MULTI;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.25";

			rowHeight = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.75 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBDblClick = "['onUnitListLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
			// onLBSelChanged = "['onUnitListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
		};
		class CTI_Menu_Control_OrdersList : RscListBox {
			idc = 270009;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.44)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.16";

			rowHeight = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.75 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBSelChanged = "['onOrdersListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
			onLBDblClick = "['onOrdersListLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
		};
		class CTI_Menu_Control_OrdersParamList : CTI_Menu_Control_OrdersList {
			idc = 270010;

			y = "SafeZoneY + (SafezoneH * 0.645)";
			h = "SafeZoneH * 0.2";

			// onLBDblClick = "['onOrdersParamLBDblClick', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
			onLBSelChanged = "";
		};

		class CTI_Menu_Control_SetOrder : RscButton_Opac {
			idc = 270011;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafeZoneH * 0.86)";
			h = "SafeZoneH * 0.04";
			w = "SafeZoneW * 0.2";

			sizeEx = "0.85 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			text = "Set Order";
			action = "['onSetOrderPressed', lbCurSel 270009] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
		};
		class CTI_Menu_Control_SetMapOrder : CTI_Menu_Control_SetOrder {
			idc = 270012;

			y = "SafeZoneY + (SafeZoneH * 0.91)";

			text = "Set Order (Map Click)";
			action = "['onSetMapOrderPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
		};
		class CTI_Menu_Control_Disband : CTI_Menu_Control_SetOrder {
			idc = 270014;

			y = "SafeZoneY + (SafeZoneH * 0.355)";

			text = "Disband";
			action = "['onUnitDisbandPressed', lbSelection ((uiNamespace getVariable 'cti_dialog_ui_aimicromenu') displayCtrl 270002)] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
		};
		class CTI_Menu_Control_IntelText : RscStructuredText {
			idc = 270013;

			x = "SafeZoneX + (SafeZoneW * 0.26)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.48";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_SelectAll : RscButton {
			idc = 270015;

			x = "SafeZoneX + (SafeZoneW * 0.935)";
			y = "SafeZoneY + (SafezoneH * 0.0625)";
			w = "SafeZoneW * 0.05";
			h = "SafeZoneH * 0.0275";

			text = "All";
			action = "['onSelectAll'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_AIMicromanagementMenu.sqf'";
		};

		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.95)";
			y = "SafeZoneY + (SafezoneH * 0.005)";
			w = "SafeZoneW * 0.04";
			h = "SafeZoneH * 0.04";

			text = "X";
			action = "closeDialog 0";
		};
		class CTI_Control_Back : CTI_Control_Exit {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.905)";

			text = "<<";
			action = "closeDialog 0; createDialog 'CTI_RscTablet_main';";
		};
	};
};

class CTI_RscArtilleryMenu {
	movingEnable = 0;
	idd = 290000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_artillerymenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_ArtilleryMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_artillerymenu', nil];['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ArtilleryMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH * 0.05";
			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafezoneH * 0.02)";
			y = "SafeZoneY + (SafezoneH * 0.005)";
			w = "SafeZoneW * 0.98";
			h = "SafeZoneH * 0.037";

			text = "Artillery";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Map : RscMapControl {
			idc = 290001;

			x = "SafeZoneX";
			y = "SafeZoneY + (SafezoneH * 0.05)";
			w = "SafeZoneW";
			h = "SafeZoneH * 0.95";

			showCountourInterval = 1;
			onMouseButtonDown = "['onMapButtonDown', _this] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ArtilleryMenu.sqf'";
		};
	};

	class controls {
		class CTI_Background_List : RscText {
			idc = 290002;
			x = "SafeZoneX + (SafeZoneW * 0.78)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.21";
			h = "SafeZoneH * 0.68";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Menu_FireMission_Frame : RscFrame {
			idc = 290003;
			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.215";
		};
		class CTI_Menu_FireMission_Background : RscText {
			idc = 290004;
			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.215";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_FireMission_Label : RscText {
			idc = 290005;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.06)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.03";

			text = "Fire Mission :";
			colorText[] = {0.231372549, 0.580392157, 0.929411765, 1};
			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_FireMission_Type_Label : CTI_Menu_FireMission_Label {
			idc = 290006;

			x = "SafeZoneX + (SafeZoneW * 0.788)";
			y = "SafeZoneY + (SafezoneH * 0.095)";
			w = "SafeZoneW * 0.18";
			h = "SafeZoneH * 0.03";

			text = "Artillery Type :";
			colorText[] = {0.537254902, 0.843137255, 1, 1};
			sizeEx = "0.8 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_FireMission_Type_Combo : RscCombo {
			idc = 290007;

			x = "SafeZoneX + (SafeZoneW * 0.79)";
			y = "SafeZoneY + (SafezoneH * 0.125)";
			w = "SafeZoneW * 0.19";
			h = "SafeZoneH * 0.035";

			sizeEx = "0.8 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onLBSelChanged = "['onArtilleryTypeChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ArtilleryMenu.sqf'";
		};
		class CTI_Menu_FireMission_Magazine_Label : CTI_Menu_FireMission_Type_Label {
			idc = 290008;

			y = "SafeZoneY + (SafezoneH * 0.165)";

			text = "Artillery Magazine :";
		};
		class CTI_Menu_FireMission_Magazine_Combo : CTI_Menu_FireMission_Type_Combo {
			idc = 290009;

			y = "SafeZoneY + (SafezoneH * 0.195)";
			onLBSelChanged = "['onArtilleryMagazineChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ArtilleryMenu.sqf'";
		};
		class CTI_Menu_FireMission_Burst_Label : CTI_Menu_FireMission_Type_Label {
			idc = 290010;

			y = "SafeZoneY + (SafezoneH * 0.235)";

			text = "Artillery Burst :";
		};
		class CTI_Menu_FireMission_Burst_Combo : CTI_Menu_FireMission_Type_Combo {
			idc = 290011;

			y = "SafeZoneY + (SafezoneH * 0.265)";
			onLBSelChanged = "";
		};
		class CTI_Menu_Units_Frame : RscFrame {
			idc = 290012;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.325)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.3";
		};
		class CTI_Menu_Units_Background : RscText {
			idc = 290013;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.325)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.3";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_Units_List : RscListBox {
			idc = 290014;
			style = LB_MULTI;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafezoneH * 0.325)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.3";

			rowHeight = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.75 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
		class CTI_Menu_FireMission_Call : RscButton {
			idc = 290015;

			x = "SafeZoneX + (SafeZoneW * 0.785)";
			y = "SafeZoneY + (SafeZoneH * 0.69)"; //--- Render out
			h = "SafeZoneH * 0.04";
			w = "SafeZoneW * 0.2";

			sizeEx = "0.85 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			text = "Call Fire Mission";
			action = "['onFireMissionCall'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ArtilleryMenu.sqf'";
		};
		class CTI_Menu_FireMission_SelectAll : CTI_Menu_FireMission_Call {
			idc = 290016;

			y = "SafeZoneY + (SafeZoneH * 0.64)";

			text = "Select All";
			action = "['onSelectAll'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_ArtilleryMenu.sqf'";
		};
		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.95)";
			y = "SafeZoneY + (SafezoneH * 0.005)";
			w = "SafeZoneW * 0.04";
			h = "SafeZoneH * 0.04";

			text = "X";
			action = "closeDialog 0";
		};
		class CTI_Control_Back : CTI_Control_Exit {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.905)";

			text = "<<";
			action = "closeDialog 0; createDialog 'CTI_RscTablet_main';";
		};
	};
};

















































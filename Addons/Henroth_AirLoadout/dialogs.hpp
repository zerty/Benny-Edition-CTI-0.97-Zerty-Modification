//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################




class CTI_RscTabletAircraftLoadoutMenu {
	movingEnable = 0;
	idd = 39000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_aircraftloadoutmenu', _this select 0];['onLoad'] execVM 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_aircraftloadoutmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

	class controlsBackground
	{
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
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191)";
			y = "SafeZoneY+safezoneH*0.275";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.03";
			text = "Aircraft loadout customisation by Henroth";
			colorText[] = {0.258823529, 0.713725490, 1, 1};
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
	};

	class controls
	{
		// Loadout select
		class loadout_select_label: RscText
		{
			idc = 39020;
			text = "Loadout"; //--- ToDo: Localize;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.15";
			h = "SafeZoneH*0.02";
			size = "0.75 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class loadout_select_frame: loadout_select_label
		{
			idc = 39003;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.15";
			h = "SafeZoneH*0.02";
			colorBackground[] = {1, 1, 1, 0.3};
		};
		class loadout_select_list: RscCombo
		{
			idc = 39021;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02+0.15+0.02)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.46";
			h = "SafeZoneH*0.02";

//			rowHeight = "1.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			// colorText[] = {1,1,1,1};
			// colorBackground[] = {0,0,0,0.7};
			// itemBackground[] = {1,1,1,0.1};
		//	columns[] = { 0.01 , .99 };

			onLBSelChanged = "['onLoadoutListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

		};

		// Weapon lists

		class weapon_list_1: RscCombo
		{
			idc = 39030;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 1 )+(0.02 * 0)) + (0.01*0)";
			w = "(3/4*SafeZoneH)*0.615*0.44";
			h = "SafeZoneH*0.02";

			rowHeight = "1.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.7};
			itemBackground[] = {1,1,1,0.1};
			columns[] = { 0.01 , .99 };

			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 0 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

		};

		class weapon_list_2: weapon_list_1
		{
			idc = 39031;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 3 )+(0.02 * 2)) + (0.01*1)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 1 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_3: weapon_list_1
		{
			idc = 39032;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 5 )+(0.02 * 4)) + (0.01*2)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 2 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_4: weapon_list_1
		{
			idc = 39033;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 7 )+(0.02 * 6)) + (0.01*3)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 3 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_5: weapon_list_1
		{
			idc = 39034;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 9 )+(0.02 * 8)) + (0.01*4)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 4 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_6: weapon_list_1
		{
			idc = 39035;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 11 )+(0.02 * 10)) + (0.01*5)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 5 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_7: weapon_list_1
		{
			idc = 39036;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 12)) + (0.01*6)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 6 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		// Magazine list

		class magazine_list_1: weapon_list_1
		{
			idc = 39040;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02+0.11)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 2 )+(0.02 * 1))";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 0 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

		};

		class magazine_list_2: magazine_list_1
		{
			idc = 39041;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 4 )+(0.02 * 3)) + (0.01*1)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 1 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_3: magazine_list_1
		{
			idc = 39042;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 6 )+(0.02 * 5)) + (0.01*2)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 2 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_4: magazine_list_1
		{
			idc = 39043;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 8 )+(0.02 * 7)) + (0.01*3)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 3 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_5: magazine_list_1
		{
			idc = 39044;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 10 )+(0.02 * 9)) + (0.01*4)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 4 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_6: magazine_list_1
		{
			idc = 39045;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 12 )+(0.02 * 11)) + (0.01*5)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 5 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_7: magazine_list_1
		{
			idc = 39046;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 13)) + (0.01*6)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 6 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		// Weapon check boxes
		class select_weapon_1: RscButton
		{
			idc = 39050;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 2 )+(0.02 * 1))";

			w = "(3/4*SafeZoneH)*0.615*0.09";
			h = 0.02 * safezoneH;

			colorBackgroundDisabled[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0};
			colorFocused[] = { 0 , 0, 0, 0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorText[] = {1,0.1,0.1,1};
			text = "NO";
			action = "[ 'onWeaponMountPressed' , 39050 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_2: select_weapon_1
		{
			idc = 39051;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 4 )+(0.02 * 3)) + (0.01*1)";
			action = "[ 'onWeaponMountPressed' , 39051 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_3: select_weapon_1
		{
			idc = 39052;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 6 )+(0.02 * 5)) + (0.01*2)";
			action = "[ 'onWeaponMountPressed' , 39052 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_4: select_weapon_1
		{
			idc = 39053;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 8 )+(0.02 * 7)) + (0.01*3)";
			action = "[ 'onWeaponMountPressed' , 39053 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_5: select_weapon_1
		{
			idc = 39054;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 10 )+(0.02 * 9)) + (0.01*4)";
			action = "[ 'onWeaponMountPressed' , 39054 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_6: select_weapon_1
		{
			idc = 39055;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 12 )+(0.02 * 11)) + (0.01*5)";
			action = "[ 'onWeaponMountPressed' , 39055 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_7: select_weapon_1
		{
			idc = 39056;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 13)) + (0.01*6)";
			action = "[ 'onWeaponMountPressed' , 39056 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		// Weapon costs
		class cost_weapon_1: RscText
		{
			idc = 39060;
			text = "--"; //--- ToDo: Localize;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02+0.44+0.02)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 1 )+(0.02 * 0)) + (0.01*0)";
			w = "(3/4*SafeZoneH)*0.615*0.17";
			h = "SafeZoneH*0.02";

		};
		class cost_weapon_2: cost_weapon_1
		{
			idc = 39061;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 3 )+(0.02 * 2)) + (0.01*1)";
		};
		class cost_weapon_3: cost_weapon_1
		{
			idc = 39062;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 5 )+(0.02 * 4)) + (0.01*2)";
		};
		class cost_weapon_4: cost_weapon_1
		{
			idc = 39063;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 7 )+(0.02 * 6)) + (0.01*3)";
		};
		class cost_weapon_5: cost_weapon_1
		{
			idc = 39064;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 9 )+(0.02 * 8)) + (0.01*4)";
		};
		class cost_weapon_6: cost_weapon_1
		{
			idc = 39065;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 11 )+(0.02 * 10)) + (0.01*5)";
		};
		class cost_weapon_7: cost_weapon_1
		{
			idc = 39066;
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 12)) + (0.01*6)";
		};


		// Current loadout elements
		class current_loadout_frame : RscFrame
		{
			idc = 39300;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.67)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.30";
			h = "SafeZoneH*(0.451-0.002-0.03)";
		};
		class current_loadout_background : RscText
		{
			idc = 39301;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.67)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.30";
			h = "SafeZoneH*(0.451-0.002-0.03)";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class current_loadout_ctrlgroup : RscControlsGroup
		{
			idc = 39302;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.67)";
			y = "SafeZoneY+safezoneH*(0.275+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.30";
			h = "SafeZoneH*(0.451-0.002-0.03-0.02)";

			class controls
			{
				class current_loadout_explanation : RscStructuredText {
					idc = 39303;

					x = "0";
					y = "0";
					w = "(3/4*SafeZoneH)*0.615*0.30";
					h = "SafeZoneH*(0.451-0.002-0.03-0.02)";

					size = "0.8 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					// text = "Your Resources: $8000";
				};
			};
		};

		// Buttons
		class accept_button: RscButton
		{
			idc = 39200;
			text = "Accept"; //--- ToDo: Localize;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*0.691";
			w = "(3/4*SafeZoneH)*0.615*0.305";
			h = "SafeZoneH*0.03";
			action = "['onAcceptPressed' ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class cancel_button: accept_button
		{
			idc = 39201;
			text = "Cancel"; //--- ToDo: Localize;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02+0.305+0.02)";
			action = "['onCancelPressed' ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
	};
};
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################




class CTI_RscAircraftLoadoutMenu {
	movingEnable = 0;
	idd = 39000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_aircraftloadoutmenu', _this select 0];['onLoad'] execVM 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_aircraftloadoutmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

	class controlsBackground
	{
		class aircraft_loadout_frame: RscText
		{
			idc = 39001;
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.74 * safezoneW;
			h = 0.63 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.4};
			moving = 1;
		};
		class CTI_Background_Header : RscText {
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.74 * safezoneW;
			h = 0.045 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.74 * safezoneW;
			h = 0.045 * safezoneH;
			text = "Aircraft loadout customisation";
			colorText[] = {0.258823529, 0.713725490, 1, 1};
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class current_loadout_frame : RscFrame
		{
			x = 0.175156 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.74 * safezoneW;
			h = 0.63 * safezoneH;
		};
		class vehicle_select_border : RscFrame
		{
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.495 * safezoneH;
		};
	};

	class controls
	{
		// Vehicle select list
		class vehicle_select_frame: RscText
		{
			idc = 39002;
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.495 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class vehicle_select_list: RscListNBox
		{
			idc = 39010;
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.495 * safezoneH;

			rowHeight = "1.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.7};
			itemBackground[] = {1,1,1,0.1};
			columns[] = { 0.01 , .99 };

			// On vehicle selected
			onLBSelChanged = "['onVehicleListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

		};
		class vehicle_select_label: RscText
		{
			idc = 39011;
			text = "Vehicle select"; //--- ToDo: Localize;
			x = 0.183407 * safezoneW + safezoneX;
			y = 0.2536 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};

		// Loadout select
		class loadout_select_label: RscText
		{
			idc = 39020;
			text = "Loadout"; //--- ToDo: Localize;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class loadout_select_frame: RscText
		{
			idc = 39003;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.345469 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class loadout_select_list: RscCombo
		{
			idc = 39021;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.345469 * safezoneW;
			h = 0.022 * safezoneH;

//			rowHeight = "1.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			// colorText[] = {1,1,1,1};
			// colorBackground[] = {0,0,0,0.7};
			// itemBackground[] = {1,1,1,0.1};
		//	columns[] = { 0.01 , .99 };

			onLBSelChanged = "['onLoadoutListLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

		};

		// Weapon lists
		class weapon_list_1_frame: RscText
		{
			idc = 39080;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class weapon_list_1: RscCombo
		{
			idc = 39030;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.022 * safezoneH;

			rowHeight = "1.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.7};
			itemBackground[] = {1,1,1,0.1};
			columns[] = { 0.01 , .99 };

			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 0 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

		};
		class weapon_list_2_frame: weapon_list_1_frame
		{
			idc = 39081;
			y = 0.423 * safezoneH + safezoneY;
		};
		class weapon_list_2: weapon_list_1
		{
			idc = 39031;
			y = 0.423 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 1 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_3_frame: weapon_list_1_frame
		{
			idc = 39082;
			y = 0.467 * safezoneH + safezoneY;
		};
		class weapon_list_3: weapon_list_1
		{
			idc = 39032;
			y = 0.467 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 2 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_4_frame: weapon_list_1_frame
		{
			idc = 39083;
			y = 0.511 * safezoneH + safezoneY;
		};
		class weapon_list_4: weapon_list_1
		{
			idc = 39033;
			y = 0.511 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 3 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_5_frame: weapon_list_1_frame
		{
			idc = 39084;
			y = 0.555 * safezoneH + safezoneY;
		};
		class weapon_list_5: weapon_list_1
		{
			idc = 39034;
			y = 0.555 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 4 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_6_frame: weapon_list_1_frame
		{
			idc = 39085;
			y = 0.599 * safezoneH + safezoneY;
		};
		class weapon_list_6: weapon_list_1
		{
			idc = 39035;
			y = 0.599 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 5 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_7_frame: weapon_list_1_frame
		{
			idc = 39086;
			y = 0.643 * safezoneH + safezoneY;
		};
		class weapon_list_7: weapon_list_1
		{
			idc = 39036;
			y = 0.643 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 6 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		// Magazine list
		class magazine_list_1_frame: RscText
		{
			idc = 39090;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class magazine_list_1: RscCombo
		{
			idc = 39040;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.022 * safezoneH;

			rowHeight = "1.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.7};
			itemBackground[] = {1,1,1,0.1};
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 0 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

		};
		class magazine_list_2_frame: magazine_list_1_frame
		{
			idc = 39091;
			y = 0.423 * safezoneH + safezoneY;
		};
		class magazine_list_2: magazine_list_1
		{
			idc = 39041;
			y = 0.423 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 1 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_3_frame: magazine_list_1_frame
		{
			idc = 39092;
			y = 0.467 * safezoneH + safezoneY;
		};
		class magazine_list_3: magazine_list_1
		{
			idc = 39042;
			y = 0.467 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 2 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_4_frame: magazine_list_1_frame
		{
			idc = 39093;
			y = 0.511 * safezoneH + safezoneY;
		};
		class magazine_list_4: magazine_list_1
		{
			idc = 39043;
			y = 0.511 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 3 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_5_frame: magazine_list_1_frame
		{
			idc = 39094;
			y = 0.555 * safezoneH + safezoneY;
		};
		class magazine_list_5: magazine_list_1
		{
			idc = 39044;
			y = 0.555 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 4 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_6_frame: magazine_list_1_frame
		{
			idc = 39095;
			y = 0.599 * safezoneH + safezoneY;
		};
		class magazine_list_6: magazine_list_1
		{
			idc = 39045;
			y = 0.599 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 5 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_7_frame: magazine_list_1_frame
		{
			idc = 39096;
			y = 0.643 * safezoneH + safezoneY;
		};
		class magazine_list_7: magazine_list_1
		{
			idc = 39046;
			y = 0.643 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 6 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		// Weapon check boxes
		class select_weapon_1: RscButton
		{
			idc = 39050;
			x = 0.62375 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.0174688 * safezoneW;
			h = 0.023 * safezoneH;

			colorBackgroundDisabled[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0};
			colorFocused[] = { 0 , 0, 0, 0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorText[] = {1,0.1,0.1,1};
			text = "NO";
			action = "[ 'onWeaponMountPressed' , 39050 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_2: select_weapon_1
		{
			idc = 39051;
			y = 0.423 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 39051 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_3: select_weapon_1
		{
			idc = 39052;
			y = 0.467 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 39052 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_4: select_weapon_1
		{
			idc = 39053;
			y = 0.511 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 39053 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_5: select_weapon_1
		{
			idc = 39054;
			y = 0.555 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 39054 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_6: select_weapon_1
		{
			idc = 39055;
			y = 0.599 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 39055 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_7: select_weapon_1
		{
			idc = 39056;
			y = 0.643 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 39056 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		// Weapon costs
		class cost_weapon_1: RscText
		{
			idc = 39060;
			text = "--"; //--- ToDo: Localize;
			x = 0.659844 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;

		};
		class cost_weapon_2: cost_weapon_1
		{
			idc = 39061;
			y = 0.423 * safezoneH + safezoneY;
		};
		class cost_weapon_3: cost_weapon_1
		{
			idc = 39062;
			y = 0.467 * safezoneH + safezoneY;
		};
		class cost_weapon_4: cost_weapon_1
		{
			idc = 39063;
			y = 0.511 * safezoneH + safezoneY;
		};
		class cost_weapon_5: cost_weapon_1
		{
			idc = 39064;
			y = 0.555 * safezoneH + safezoneY;
		};
		class cost_weapon_6: cost_weapon_1
		{
			idc = 39065;
			y = 0.599 * safezoneH + safezoneY;
		};
		class cost_weapon_7: cost_weapon_1
		{
			idc = 39066;
			y = 0.643 * safezoneH + safezoneY;
		};

		// Labels
		class weapon_label: RscText
		{
			idc = 39100;
			text = "Weapon / Equipment"; //--- ToDo: Localize;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class magazine_label: RscText
		{
			idc = 39101;
			text = "Magazine"; //--- ToDo: Localize;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0660937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class mount_label: RscText
		{
			idc = 39102;
			text = "Mount"; //--- ToDo: Localize;
			x = 0.618594 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class cost_label: RscText
		{
			idc = 39103;
			text = "Cost"; //--- ToDo: Localize;
			x = 0.659844 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};

		// Current loadout elements
		class current_loadout_frame : RscFrame
		{
			idc = 39300;
			x = 0.7 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.495 * safezoneH;
		};
		class current_loadout_background : RscText
		{
			idc = 39301;
			x = 0.7 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.495 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class current_loadout_ctrlgroup : RscControlsGroup
		{
			idc = 39302;
			x = 0.7 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.495 * safezoneH;

			class controls
			{
				class current_loadout_explanation : RscStructuredText {
					idc = 39303;

					x = "0";
					y = "0";
					w = 0.20 * safezoneW;
					h = 0.495 * safezoneH;

					size = "0.85 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					// text = "Your Resources: $8000";
				};
			};
		};

		// Buttons
		class accept_button: RscButton
		{
			idc = 39200;
			text = "Accept"; //--- ToDo: Localize;
			x = 0.38* safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			action = "['onAcceptPressed' ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class cancel_button: RscButton
		{
			idc = 39201;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.515 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			action = "['onCancelPressed' ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
	};
};

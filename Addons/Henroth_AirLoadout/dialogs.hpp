//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################
//#####################################################################################################################################




class CTI_RscTabletAircraftLoadoutMenu {
	movingEnable = 0;
	idd = 739000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_aircraftloadoutmenu', _this select 0];['onLoad'] execVM 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_aircraftloadoutmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

	class controlsBackground
	{
		class CTI_Background : RscExtendedTablet {
						moving = 1;
		};
		class CTI_Menu_InfoListFrame : RscText {
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *0.200";
			y = "SafeZoneY+safezoneH*0.050"; //.188
			w = "(3/4*SafeZoneH)*0.606";
			h = "SafeZoneH*0.905";
			colorBackground[] = {0,0,0,1};
			text="";

		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.200)";
			y = "SafeZoneY+safezoneH*0.050";
			w = "(3/4*SafeZoneH)*0.615";
			h = "SafeZoneH*0.03";
			text = "Aircraft loadout customisation by Henroth - Yoshi_E";
			colorText[] = {0.258823529, 0.713725490, 1, 1};
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
	};

	class controls
	{
		// Loadout select
		class loadout_select_label: RscText
		{
			idc = 739020;
			text = "Loadout"; //--- ToDo: Localize;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.200) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.15";
			h = "SafeZoneH*0.02";
			size = "0.75 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class loadout_select_frame: loadout_select_label
		{
			idc = 739003;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.200) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.15";
			h = "SafeZoneH*0.02";
			colorBackground[] = {1, 1, 1, 0.3};
		};
		class loadout_select_list: RscCombo
		{
			idc = 739021;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.200) + (3/4*SafeZoneH)*0.615*(0.02+0.15+0.02)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002)";
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
			idc = 730000;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.200) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 1 )+(0.02 * 0)) + (0.01*0)";
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
			idc = 730001;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 3 )+(0.02 * 2)) + (0.01*1)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 1 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_3: weapon_list_1
		{
			idc = 730002;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 5 )+(0.02 * 4)) + (0.01*2)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 2 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_4: weapon_list_1
		{
			idc = 730003;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 7 )+(0.02 * 6)) + (0.01*3)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 3 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_5: weapon_list_1
		{
			idc = 730004;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 9 )+(0.02 * 8)) + (0.01*4)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 4 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_6: weapon_list_1
		{
			idc = 730005;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 11 )+(0.02 * 10)) + (0.01*5)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 5 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_7: weapon_list_1
		{
			idc = 730006;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 12)) + (0.01*6)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 6 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		
	     class weapon_list_8: weapon_list_1
		{
			idc = 730007;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 14)) + (0.01*7)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 7 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		
	    class weapon_list_9: weapon_list_1
		{
			idc = 730008;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 16)) + (0.01*8)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 8 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		
		class weapon_list_10: weapon_list_1
		{
			idc = 730009;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 18)) + (0.01*9)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 9 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_11: weapon_list_1
		{
			idc = 730010;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 20)) + (0.01*10)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 10 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_12: weapon_list_1
		{
			idc = 730011;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 22)) + (0.01*11)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 11 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_13: weapon_list_1
		{
			idc = 730012;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 24)) + (0.01*12)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 12 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_14: weapon_list_1
		{
			idc = 730013;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 26)) + (0.01*13)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 13 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_15: weapon_list_1
		{
			idc = 730014;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 28)) + (0.01*14)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 14 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_16: weapon_list_1
		{
			idc = 730015;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 30)) + (0.01*15)";
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 15 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};


		// Magazine list

		class magazine_list_1: weapon_list_1
		{
			idc = 710000;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02+0.11)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 2 )+(0.02 * 1))";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 0 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

		};

		class magazine_list_2: magazine_list_1
		{
			idc = 710001;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 4 )+(0.02 * 3)) + (0.01*1)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 1 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_3: magazine_list_1
		{
			idc = 710002;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 6 )+(0.02 * 5)) + (0.01*2)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 2 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_4: magazine_list_1
		{
			idc = 710003;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 8 )+(0.02 * 7)) + (0.01*3)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 3 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_5: magazine_list_1
		{
			idc = 710004;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 10 )+(0.02 * 9)) + (0.01*4)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 4 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_6: magazine_list_1
		{
			idc = 710005;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 12 )+(0.02 * 11)) + (0.01*5)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 5 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class magazine_list_7: magazine_list_1
		{
			idc = 710006;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 13)) + (0.01*6)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 6 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		
		class magazine_list_8: magazine_list_1
		{
			idc = 710007;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 15)) + (0.01*7)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 7 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		
		class magazine_list_9: magazine_list_1
		{
			idc = 710008;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 17)) + (0.01*8)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 8 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		
		class magazine_list_10: magazine_list_1
		{
			idc = 710009;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 19)) + (0.01*9)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 9 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_11: magazine_list_1
		{
			idc = 710010;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 21)) + (0.01*10)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 10 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_12: magazine_list_1
		{
			idc = 710011;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 23)) + (0.01*11)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 11 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_13: magazine_list_1
		{
			idc = 710012;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 25)) + (0.01*12)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 12 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_14: magazine_list_1
		{
			idc = 710013;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 27)) + (0.01*13)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 13 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_15: magazine_list_1
		{
			idc = 710014;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 29)) + (0.01*14)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 14 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_16: magazine_list_1
		{
			idc = 710015;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 31)) + (0.01*15)";
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 15 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		// Weapon check boxes
		class select_weapon_1: RscButton
		{
			idc = 750000;

			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 2 )+(0.02 * 1))";

			w = "(3/4*SafeZoneH)*0.615*0.09";
			h = 0.02 * safezoneH;

			colorBackgroundDisabled[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0};
			colorFocused[] = { 0 , 0, 0, 0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorText[] = {1,0.1,0.1,1};
			text = "YES";
			action = "[ 'onWeaponMountPressed' , 750000 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_2: select_weapon_1
		{
			idc = 750001;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 4 )+(0.02 * 3)) + (0.01*1)";
			action = "[ 'onWeaponMountPressed' , 750001 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_3: select_weapon_1
		{
			idc = 750002;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 6 )+(0.02 * 5)) + (0.01*2)";
			action = "[ 'onWeaponMountPressed' , 750002 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_4: select_weapon_1
		{
			idc = 750003;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 8 )+(0.02 * 7)) + (0.01*3)";
			action = "[ 'onWeaponMountPressed' , 750003 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_5: select_weapon_1
		{
			idc = 750004;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 10 )+(0.02 * 9)) + (0.01*5)";
			action = "[ 'onWeaponMountPressed' , 750004 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_6: select_weapon_1
		{
			idc = 750005;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 12 )+(0.02 * 11)) + (0.01*5)";
			action = "[ 'onWeaponMountPressed' , 750005 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_7: select_weapon_1
		{
			idc = 750006;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 14 )+(0.02 * 13)) + (0.01*5)";
			action = "[ 'onWeaponMountPressed' , 750006 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_8: select_weapon_1
		{
			idc = 750007;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 16 )+(0.02 * 15)) + (0.01*6)";
			action = "[ 'onWeaponMountPressed' , 750007 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_9: select_weapon_1
		{
			idc = 750008;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 18 )+(0.02 * 17)) + (0.01*6)";
			action = "[ 'onWeaponMountPressed' , 750008 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_10: select_weapon_1
		{
			idc = 750009;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 20 )+(0.02 * 19)) + (0.01*7)";
			action = "[ 'onWeaponMountPressed' , 750009 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};		
		class select_weapon_11: select_weapon_1
		{
			idc = 750010;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 22 )+(0.02 * 21)) + (0.01*7)";
			action = "[ 'onWeaponMountPressed' , 750010 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_12: select_weapon_1
		{
			idc = 750011;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 22 )+(0.02 * 23)) + (0.01*8)";
			action = "[ 'onWeaponMountPressed' , 750011 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_13: select_weapon_1
		{
			idc = 750012;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 22 )+(0.02 * 25)) + (0.01*9)";
			action = "[ 'onWeaponMountPressed' , 750012 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_14: select_weapon_1
		{
			idc = 750013;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 22 )+(0.02 * 27)) + (0.01*10)";
			action = "[ 'onWeaponMountPressed' , 750013 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_15: select_weapon_1
		{
			idc = 750014;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 22 )+(0.02 * 29)) + (0.01*11)";
			action = "[ 'onWeaponMountPressed' , 750014 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
			class select_weapon_16: select_weapon_1
		{
			idc = 750015;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 22 )+(0.02 * 31)) + (0.01*11)";
			action = "[ 'onWeaponMountPressed' , 750015 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		

		// Weapon costs
		class cost_weapon_1: RscText
		{
			idc = 760000;
			text = "--"; //--- ToDo: Localize;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.02+0.44+0.02)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 1 )+(0.02 * 0)) + (0.01*0)";
			w = "(3/4*SafeZoneH)*0.615*0.17";
			h = "SafeZoneH*0.02";

		};
		class cost_weapon_2: cost_weapon_1
		{
			idc = 760001;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 3 )+(0.02 * 2)) + (0.01*1)";
		};
		class cost_weapon_3: cost_weapon_1
		{
			idc = 760002;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 5 )+(0.02 * 4)) + (0.01*2)";
		};
		class cost_weapon_4: cost_weapon_1
		{
			idc = 760003;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 7 )+(0.02 * 6)) + (0.01*3)";
		};
		class cost_weapon_5: cost_weapon_1
		{
			idc = 760004;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 9 )+(0.02 * 8)) + (0.01*4)";
		};
		class cost_weapon_6: cost_weapon_1
		{
			idc = 760005;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 11 )+(0.02 * 10)) + (0.01*5)";
		};
		class cost_weapon_7: cost_weapon_1
		{
			idc = 760006;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 13 )+(0.02 * 12)) + (0.01*5)";
		};
		class cost_weapon_8: cost_weapon_1
		{
			idc = 760007;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 15 )+(0.02 * 14)) + (0.01*5)";
		};
		class cost_weapon_9: cost_weapon_1
		{
			idc = 760008;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 17 )+(0.02 * 16)) + (0.01*6)";
		};
		class cost_weapon_10: cost_weapon_1
		{
			idc = 760009;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 19 )+(0.02 * 18)) + (0.01*6)";
		};
		class cost_weapon_11: cost_weapon_1
		{
			idc = 760010;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 21 )+(0.02 * 20)) + (0.01*7)";
		};		
		class cost_weapon_12: cost_weapon_1
		{
			idc = 760011;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 23 )+(0.02 * 22)) + (0.01*7)";
		};
		class cost_weapon_13: cost_weapon_1
		{
			idc = 760012;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 25 )+(0.02 * 24)) + (0.01*8)";
		};
		class cost_weapon_14: cost_weapon_1
		{
			idc = 760013;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 27 )+(0.02 * 26)) + (0.01*8)";
		};
		class cost_weapon_15: cost_weapon_1
		{
			idc = 760014;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 28 )+(0.02 * 28)) + (0.01*8)";
		};
		class cost_weapon_16: cost_weapon_1
		{
			idc = 760015;
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002+0.03+(0.002 * 30 )+(0.02 * 30)) + (0.01*8)";
		};




		// Current loadout elements
		class current_loadout_frame : RscFrame
		{
			idc = 739300;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.67)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.30";
			h = "SafeZoneH*(0.751-0.002-0.03)";
		};
		class current_loadout_background : RscText
		{
			idc = 739301;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.67)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.30";
			h = "SafeZoneH*(0.751-0.002-0.03)";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class current_loadout_ctrlgroup : RscControlsGroup
		{
			idc = 739302;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.615*(0.67)";
			y = "SafeZoneY+safezoneH*(0.050+0.03+0.002)";
			w = "(3/4*SafeZoneH)*0.615*0.30";
			h = "SafeZoneH*(0.751-0.002-0.03-0.02)";

			class controls
			{
				class current_loadout_explanation : RscStructuredText {
					idc = 739303;

					x = "0";
					y = "0";
					w = "(3/4*SafeZoneH)*0.615*0.30";
					h = "SafeZoneH*(0.751-0.002-0.03-0.02)";

					size = "0.8 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					// text = "Your Resources: $8000";
				};
			};
		};

		// Buttons
		class accept_button: RscButton
		{
			idc = 739200;
			text = "Accept"; //--- ToDo: Localize;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*1.015*(0.02)";
			y = "SafeZoneY+safezoneH*0.891";
			w = "(3/4*SafeZoneH)*0.615*0.305";
			h = "SafeZoneH*0.03";
			action = "['onAcceptPressed' ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class cancel_button: accept_button
		{
			idc = 739201;
			text = "Cancel"; //--- ToDo: Localize;
			x = "SafeZoneX + (SafeZoneW - (3/4*SafeZoneH))/2+ (3/4*SafeZoneH) *(0.191) + (3/4*SafeZoneH)*0.855*(0.02+0.305+0.02)";
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
	idd = 739000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_aircraftloadoutmenu', _this select 0];['onLoad'] execVM 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_aircraftloadoutmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";

	class controlsBackground
	{
		class aircraft_loadout_frame: RscText
		{
			idc = 739001;
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
			idc = 739002;
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.495 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class vehicle_select_list: RscListNBox
		{
			idc = 739010;
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
			idc = 739011;
			text = "Vehicle select"; //--- ToDo: Localize;
			x = 0.183407 * safezoneW + safezoneX;
			y = 0.2536 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};

		// Loadout select
		class loadout_select_label: RscText
		{
			idc = 739020;
			text = "Loadout"; //--- ToDo: Localize;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class loadout_select_frame: RscText
		{
			idc = 739003;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.345469 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class loadout_select_list: RscCombo
		{
			idc = 739021;
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
			idc = 740000;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class weapon_list_1: RscCombo
		{
			idc = 730000;
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
			idc = 740001;
			y = 0.423 * safezoneH + safezoneY;
		};
		class weapon_list_2: weapon_list_1
		{
			idc = 730001;
			y = 0.423 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 1 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_3_frame: weapon_list_1_frame
		{
			idc = 740002;
			y = 0.467 * safezoneH + safezoneY;
		};
		class weapon_list_3: weapon_list_1
		{
			idc = 730002;
			y = 0.467 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 2 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_4_frame: weapon_list_1_frame
		{
			idc = 740003;
			y = 0.511 * safezoneH + safezoneY;
		};
		class weapon_list_4: weapon_list_1
		{
			idc = 730003;
			y = 0.511 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 3 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_5_frame: weapon_list_1_frame
		{
			idc = 740004;
			y = 0.555 * safezoneH + safezoneY;
		};
		class weapon_list_5: weapon_list_1
		{
			idc = 730004;
			y = 0.555 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 4 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_6_frame: weapon_list_1_frame
		{
			idc = 740005;
			y = 0.599 * safezoneH + safezoneY;
		};
		class weapon_list_6: weapon_list_1
		{
			idc = 730005;
			y = 0.599 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 5 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_7_frame: weapon_list_1_frame
		{
			idc = 740006;
			y = 0.643 * safezoneH + safezoneY;
		};
		class weapon_list_7: weapon_list_1
		{
			idc = 730006;
			y = 0.643 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 6 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		
		class weapon_list_8_frame: weapon_list_1_frame
		{
			idc = 740007;
			y = 0.687 * safezoneH + safezoneY;
		};
		class weapon_list_8: weapon_list_1
		{
			idc = 730007;
			y = 0.687 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 7 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		
		class weapon_list_9_frame: weapon_list_1_frame
		{
			idc = 740008;
			y = 0.731 * safezoneH + safezoneY;
		};
		class weapon_list_9: weapon_list_1
		{
			idc = 730008;
			y = 0.731 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 8 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_10_frame: weapon_list_1_frame
		{
			idc = 740009;
			y = 0.775 * safezoneH + safezoneY;
		};
		class weapon_list_10: weapon_list_1
		{
			idc = 730009;
			y = 0.775 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 9 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_11_frame: weapon_list_1_frame
		{
			idc = 740010;
			y = 0.819 * safezoneH + safezoneY;
		};
		class weapon_list_11: weapon_list_1
		{
			idc = 730010;
			y = 0.819 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 10 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_12_frame: weapon_list_1_frame
		{
			idc = 740011;
			y = 0.863 * safezoneH + safezoneY;
		};
		class weapon_list_12: weapon_list_1
		{
			idc = 730011;
			y = 0.863 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 11 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_13_frame: weapon_list_1_frame
		{
			idc = 740012;
			y = 0.907 * safezoneH + safezoneY;
		};
		class weapon_list_13: weapon_list_1
		{
			idc = 730012;
			y = 0.907 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 12 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		class weapon_list_14_frame: weapon_list_1_frame
		{
			idc = 740013;
			y = 0.951 * safezoneH + safezoneY;
		};
		class weapon_list_14: weapon_list_1
		{
			idc = 730013;
			y = 0.951 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 13 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_15_frame: weapon_list_1_frame
		{
			idc = 740014;
			y = 0.995 * safezoneH + safezoneY;
		};
		class weapon_list_15: weapon_list_1
		{
			idc = 730014;
			y = 0.995 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 14 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class weapon_list_16_frame: weapon_list_1_frame
		{
			idc = 740015;
			y = 1.039 * safezoneH + safezoneY;
		};
		class weapon_list_16: weapon_list_1
		{
			idc = 730015;
			y = 1.039 * safezoneH + safezoneY;
			onLBSelChanged = "['onWeaponListLBSelChanged', _this , 14 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};


		// Magazine list
		class magazine_list_1_frame: RscText
		{
			idc = 720000;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class magazine_list_1: RscCombo
		{
			idc = 710000;
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
			idc = 720001;
			y = 0.423 * safezoneH + safezoneY;
		};
		class magazine_list_2: magazine_list_1
		{
			idc = 710001;
			y = 0.423 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 1 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_3_frame: magazine_list_1_frame
		{
			idc = 720002;
			y = 0.467 * safezoneH + safezoneY;
		};
		class magazine_list_3: magazine_list_1
		{
			idc = 710002;
			y = 0.467 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 2 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_4_frame: magazine_list_1_frame
		{
			idc = 720003;
			y = 0.511 * safezoneH + safezoneY;
		};
		class magazine_list_4: magazine_list_1
		{
			idc = 710003;
			y = 0.511 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 3 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_5_frame: magazine_list_1_frame
		{
			idc = 720004;
			y = 0.555 * safezoneH + safezoneY;
		};
		class magazine_list_5: magazine_list_1
		{
			idc = 710004;
			y = 0.555 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 4 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_6_frame: magazine_list_1_frame
		{
			idc = 720005;
			y = 0.599 * safezoneH + safezoneY;
		};
		class magazine_list_6: magazine_list_1
		{
			idc = 710005;
			y = 0.599 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 5 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_7_frame: magazine_list_1_frame
		{
			idc = 720006;
			y = 0.643 * safezoneH + safezoneY;
		};
		class magazine_list_7: magazine_list_1
		{
			idc = 710006;
			y = 0.643 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 6 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_8_frame: magazine_list_1_frame
		{
			idc = 720007;
			y = 0.687 * safezoneH + safezoneY;
		};
		class magazine_list_8: magazine_list_1
		{
			idc = 710007;
			y = 0.687 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 7 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};		
		class magazine_list_9_frame: magazine_list_1_frame
		{
			idc = 720008;
			y = 0.731 * safezoneH + safezoneY;
		};
		class magazine_list_9: magazine_list_1
		{
			idc = 710008;
			y = 0.731 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 8 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};		
		class magazine_list_10_frame: magazine_list_1_frame
		{
			idc = 720009;
			y = 0.775 * safezoneH + safezoneY;
		};
		class magazine_list_10: magazine_list_1
		{
			idc = 710009;
			y = 0.775 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 9 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_11_frame: magazine_list_1_frame
		{
			idc = 720010;
			y = 0.819 * safezoneH + safezoneY;
		};
		class magazine_list_11: magazine_list_1
		{
			idc = 710010;
			y = 0.819 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 10 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_12_frame: magazine_list_1_frame
		{
			idc = 720011;
			y = 0.863 * safezoneH + safezoneY;
		};
		class magazine_list_12: magazine_list_1
		{
			idc = 710011;
			y = 0.863 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 11 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_13_frame: magazine_list_1_frame
		{
			idc = 720012;
			y = 0.907 * safezoneH + safezoneY;
		};
		class magazine_list_13: magazine_list_1
		{
			idc = 710012;
			y = 0.907 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 12 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_14_frame: magazine_list_1_frame
		{
			idc = 720013;
			y = 0.951 * safezoneH + safezoneY;
		};
		class magazine_list_14: magazine_list_1
		{
			idc = 710013;
			y = 0.951 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 13 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_15_frame: magazine_list_1_frame
		{
			idc = 720014;
			y = 0.995 * safezoneH + safezoneY;
		};
		class magazine_list_15: magazine_list_1
		{
			idc = 710014;
			y = 0.995 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 14 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class magazine_list_16_frame: magazine_list_1_frame
		{
			idc = 720015;
			y = 1.039 * safezoneH + safezoneY;
		};
		class magazine_list_16: magazine_list_1
		{
			idc = 710015;
			y = 1.039 * safezoneH + safezoneY;
			onLBSelChanged = "['onAmmoListLBSelChanged', _this , 15 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		// Weapon check boxes
		class select_weapon_1: RscButton
		{
			idc = 750000;
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
			text = "YES";
			action = "[ 'onWeaponMountPressed' , 750000 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_2: select_weapon_1
		{
			idc = 750001;
			y = 0.423 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750001 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_3: select_weapon_1
		{
			idc = 750002;
			y = 0.467 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750002 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_4: select_weapon_1
		{
			idc = 750003;
			y = 0.511 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750003 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_5: select_weapon_1
		{
			idc = 750004;
			y = 0.555 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750004 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_6: select_weapon_1
		{
			idc = 750005;
			y = 0.599 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750005 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_7: select_weapon_1
		{
			idc = 750006;
			y = 0.643 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750006 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_8: select_weapon_1
		{
			idc = 750007;
			y = 0.687 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750007 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_9: select_weapon_1
		{
			idc = 750008;
			y = 0.731 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750008 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_10: select_weapon_1
		{
			idc = 750009;
			y = 0.755 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750009 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_11: select_weapon_1
		{
			idc = 750010;
			y = 0.819 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750010 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_12: select_weapon_1
		{
			idc = 750011;
			y = 0.863 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750011 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_13: select_weapon_1
		{
			idc = 750012;
			y = 0.907 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750012 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_14: select_weapon_1
		{
			idc = 750013;
			y = 0.951 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750013 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_15: select_weapon_1
		{
			idc = 750014;
			y = 0.995 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750014 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class select_weapon_16: select_weapon_1
		{
			idc = 750015;
			y = 1.039 * safezoneH + safezoneY;
			action = "[ 'onWeaponMountPressed' , 750015 ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};

		// Weapon costs
		class cost_weapon_1: RscText
		{
			idc = 760000;
			text = "--"; //--- ToDo: Localize;
			x = 0.659844 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;

		};
		class cost_weapon_2: cost_weapon_1
		{
			idc = 760001;
			y = 0.423 * safezoneH + safezoneY;
		};
		class cost_weapon_3: cost_weapon_1
		{
			idc = 760002;
			y = 0.467 * safezoneH + safezoneY;
		};
		class cost_weapon_4: cost_weapon_1
		{
			idc = 760003;
			y = 0.511 * safezoneH + safezoneY;
		};
		class cost_weapon_5: cost_weapon_1
		{
			idc = 760004;
			y = 0.555 * safezoneH + safezoneY;
		};
		class cost_weapon_6: cost_weapon_1
		{
			idc = 760005;
			y = 0.599 * safezoneH + safezoneY;
		};
		class cost_weapon_7: cost_weapon_1
		{
			idc = 760006;
			y = 0.643 * safezoneH + safezoneY;
		};
		class cost_weapon_8: cost_weapon_1
		{
			idc = 760007;
			y = 0.687 * safezoneH + safezoneY;
		};
		class cost_weapon_9: cost_weapon_1
		{
			idc = 760008;
			y = 0.731 * safezoneH + safezoneY;
		};
		class cost_weapon_10: cost_weapon_1
		{
			idc = 760009;
			y = 0.755 * safezoneH + safezoneY;
		};
		class cost_weapon_11: cost_weapon_1
		{
			idc = 760010;
			y = 0.819 * safezoneH + safezoneY;
		};
		class cost_weapon_12: cost_weapon_1
		{
			idc = 760011;
			y = 0.863 * safezoneH + safezoneY;
		};
		class cost_weapon_13: cost_weapon_1
		{
			idc = 760012;
			y = 0.907 * safezoneH + safezoneY;
		};
		class cost_weapon_14: cost_weapon_1
		{
			idc = 760013;
			y = 0.951 * safezoneH + safezoneY;
		};
		class cost_weapon_15: cost_weapon_1
		{
			idc = 760013;
			y = 0.995 * safezoneH + safezoneY;
		};
		class cost_weapon_16: cost_weapon_1
		{
			idc = 760013;
			y = 1.039 * safezoneH + safezoneY;
		};

		// Labels
		class weapon_label: RscText
		{
			idc = 739100;
			text = "Weapon / Equipment"; //--- ToDo: Localize;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class magazine_label: RscText
		{
			idc = 739101;
			text = "Magazine"; //--- ToDo: Localize;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0660937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class mount_label: RscText
		{
			idc = 739102;
			text = "Mount"; //--- ToDo: Localize;
			x = 0.618594 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class cost_label: RscText
		{
			idc = 739103;
			text = "Cost"; //--- ToDo: Localize;
			x = 0.659844 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};

		// Current loadout elements
		class current_loadout_frame : RscFrame
		{
			idc = 739300;
			x = 0.7 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.795 * safezoneH;
		};
		class current_loadout_background : RscText
		{
			idc = 739301;
			x = 0.7 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.795 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class current_loadout_ctrlgroup : RscControlsGroup
		{
			idc = 739302;
			x = 0.7 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.795 * safezoneH;

			class controls
			{
				class current_loadout_explanation : RscStructuredText {
					idc = 739303;

					x = "0";
					y = "0";
					w = 0.20 * safezoneW;
					h = 0.795 * safezoneH;

					size = "0.85 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					// text = "Your Resources: $8000";
				};
			};
		};

		// Buttons
		class accept_button: RscButton
		{
			idc = 739200;
			text = "Accept"; //--- ToDo: Localize;
			x = 0.138* safezoneW + safezoneX;
			y = 0.859 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			action = "['onAcceptPressed' ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
		class cancel_button: RscButton
		{
			idc = 739201;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.615 * safezoneW + safezoneX;
			y = 0.859 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			action = "['onCancelPressed' ] call compile preprocessFileLineNumbers 'Addons\Henroth_AirLoadout\Events_UI_AircraftLoadoutMenu.sqf'";
		};
	};
};

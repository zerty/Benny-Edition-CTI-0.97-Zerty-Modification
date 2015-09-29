//--- [Controls Style Preprocessors]
#define ST_LEFT 				0
#define ST_RIGHT 				1
#define ST_CENTER 				2
#define ST_MULTI 				16
#define ST_PICTURE 				48
#define ST_TEXT_BG 				128
#define ST_LINE 				176
#define ST_KEEP_ASPECT_RATIO	"0x30 + 0x800"

#define LB_MULTI 				0x20

#define HUD_IDC 				1500000




class RscTitles{
		class CTI_HUD_RSC {
			idd=-1;
			duration=1e+011;
			name="HUD_RSC";
			movingEnable = false;
			onLoad="uiNamespace setVariable ['HUD', _this select 0];";
			objects[]={};
			class RscProgress {
					idc = -1;
					type = 8;
					style = 0;
					colorFrame[] = {0,0,0,1};
					colorBar[] = {1,1,1,1};
					texture = "#(argb,8,8,3)color(1,1,1,1)";
			};

			class controls {


				class HUD_INFO: RscStructuredText {
					idc = HUD_IDC+1;
					x="-15 *(((safezoneW / safezoneH) min 1.2) / 40) +((profilenamespace getvariable ['IGUI_GRID_WEAPON_X',str ((safezoneX + safezoneW) - 		(12.4 *(((safezoneW / safezoneH) min 1.2) / 40)) - 0.5 *(((safezoneW / safezoneH) min 1.2) / 40))]))";
         			y="0.015+ 0 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +((profilenamespace getvariable ['IGUI_GRID_WEAPON_Y',str ((safezoneY + 0.5 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)))]))";
         			w="15 *(((safezoneW / safezoneH) min 1.2) / 40)";
          			h="6 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";


					colorBackground[] = {0, 0, 0, 0};
				};
				class HUD_Vehicle: RscStructuredText {
					idc = HUD_IDC+2;
					x = 0.80 * safezoneW + safezoneX;
					y = 0.60 * safezoneH + safezoneY;
					w = 0.2 * safezoneW;
					h = 0.20 * safezoneH;
					colorBackground[] = {0, 0, 0, 0};
				};
				class HUD_CAPTURE : RscProgress {
					idc = HUD_IDC+3;
					x = "-15 *(((safezoneW / safezoneH) min 1.2) / 40) +((profilenamespace getvariable ['IGUI_GRID_WEAPON_X',str ((safezoneX + safezoneW) - 		(12.4 *(((safezoneW / safezoneH) min 1.2) / 40)) - 0.5 *(((safezoneW / safezoneH) min 1.2) / 40))]))";
					y = "0 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +((profilenamespace getvariable ['IGUI_GRID_WEAPON_Y',str ((safezoneY + 0.5 * 			((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)))]))";
					w = "15 *(((safezoneW / safezoneH) min 1.2) / 40)";
					h = 0.01 * safezoneH;
				};
				class HUD_PB_Background : RscText {
					idc = HUD_IDC+4;
					x = 0.24 * safezoneW + safezoneX;
					y = 0.19* safezoneH + safezoneY;
					w = 0.52 * safezoneW;
					h = 0.07 * safezoneH;
					colorBackground[] = {0, 0, 0, 0.7};
				};

				class HUD_PB_BAR : RscProgress  {
					idc = HUD_IDC+5;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.20* safezoneH + safezoneY;
					w = 0.50 * safezoneW;
					h = 0.05 * safezoneH;
					colorBar[]={0.768627451, 0.89, 0.137254902, 0.7};
					colorBackground[] = {0, 0, 0, 0.7};
				};
				class HUD_PB_text: RscText {
					idc= HUD_IDC+6;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.20* safezoneH + safezoneY;
					w = 0.50 * safezoneW;
					h = 0.05 * safezoneH;
					text = "";
					colorText[]={1,1,1,1};
				};
				class HUD_N_Background : RscText {
					idc= HUD_IDC+7;
					x = 0.01 * safezoneW + safezoneX;
					y = 0.4* safezoneH + safezoneY;
					w = 0.002 * safezoneW;
					h = 0.3 * safezoneH;
					colorBackground[] = {0, 0, 0,0.7};
				};
				class HUD_N : RscStructuredText {
					idc= HUD_IDC+8;
					x = 0.015 * safezoneW + safezoneX;
					y = 0.4* safezoneH + safezoneY;
					w = 0.3 * safezoneW;
					h = 0.3 * safezoneH;
					colorBackground[] = {0, 0, 0,0};
					class Attributes {
						font = "PuristaLight";
						color = "#ffffff";
						align = "left";
						shadow = 1;
					};
				};
				class IconTown: RscText {
					idc=-1;
					colorText[]={1,1,1,1};
				};
				class LineTown: RscText {
					idc = -1;
					style = ST_LINE;
					x = 0;
					y = 0;
					w = 0;
					h = 0;
					text = "";
					colorBackground[] = {0,0,0,0};
					colorText[] = {1,1,1,1};
				};

				class IconTown0: IconTown {idc=HUD_IDC+400+0; };
				class LineTown0: LineTown {idc=HUD_IDC+500+0; };
				class IconTown1: IconTown {idc=HUD_IDC+400+1; };
				class LineTown1: LineTown {idc=HUD_IDC+500+1; };
				class IconTown2: IconTown {idc=HUD_IDC+400+2; };
				class LineTown2: LineTown {idc=HUD_IDC+500+2; };
				class IconTown3: IconTown {idc=HUD_IDC+400+3; };
				class LineTown3: LineTown {idc=HUD_IDC+500+3; };
				class IconTown4: IconTown {idc=HUD_IDC+400+4; };
				class LineTown4: LineTown {idc=HUD_IDC+500+4; };
				class IconTown5: IconTown {idc=HUD_IDC+400+5; };
				class LineTown5: LineTown {idc=HUD_IDC+500+5; };
				class IconTown6: IconTown {idc=HUD_IDC+400+6; };
				class LineTown6: LineTown {idc=HUD_IDC+500+6; };
				class IconTown7: IconTown {idc=HUD_IDC+400+7; };
				class LineTown7: LineTown {idc=HUD_IDC+500+7; };
				class IconTown8: IconTown {idc=HUD_IDC+400+8; };
				class LineTown8: LineTown {idc=HUD_IDC+500+8; };
				class IconTown9: IconTown {idc=HUD_IDC+400+9; };
				class LineTown9: LineTown {idc=HUD_IDC+500+9; };
				class IconTown10: IconTown {idc=HUD_IDC+400+10; };
				class LineTown10: LineTown {idc=HUD_IDC+500+10; };
				class IconTown11: IconTown {idc=HUD_IDC+400+11; };
				class LineTown11: LineTown {idc=HUD_IDC+500+11; };
				class IconTown12: IconTown {idc=HUD_IDC+400+12; };
				class LineTown12: LineTown {idc=HUD_IDC+500+12; };
				class IconTown13: IconTown {idc=HUD_IDC+400+13; };
				class LineTown13: LineTown {idc=HUD_IDC+500+13; };
				class IconTown14: IconTown {idc=HUD_IDC+400+14; };
				class LineTown14: LineTown {idc=HUD_IDC+500+14; };
				class IconTown15: IconTown {idc=HUD_IDC+400+15; };
				class LineTown15: LineTown {idc=HUD_IDC+500+15; };
				class IconTown16: IconTown {idc=HUD_IDC+400+16; };
				class LineTown16: LineTown {idc=HUD_IDC+500+16; };
				class IconTown17: IconTown {idc=HUD_IDC+400+17; };
				class LineTown17: LineTown {idc=HUD_IDC+500+17; };
				class IconTown18: IconTown {idc=HUD_IDC+400+18; };
				class LineTown18: LineTown {idc=HUD_IDC+500+18; };
				class IconTown19: IconTown {idc=HUD_IDC+400+19; };
				class LineTown19: LineTown {idc=HUD_IDC+500+19; };
			};
		};
	};


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

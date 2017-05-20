/*
x = (_xPos/100) * safezoneW + safezoneX;
y = (_yPos/100) * safezoneH + safezoneY;
w = (_width/100) * safezoneW;
h = (_height/100) * safezoneH;  
*/
class BTC_Hud
{
   	idd = 1000;
   	movingEnable=0;
   	duration=1e+011;
   	name = "BTC_Hud_Name";
   	onLoad = "uiNamespace setVariable [""HUD"", _this select 0];";
   	controlsBackground[] = {};
   	objects[] = {};
   	class controls 
	{
		class Radar
		{
			type = 0;
			idc = 1001;
			style = 48;
			x = (SafeZoneW+2*SafeZoneX) - 0.3;//safezonex + 0.1;//0.9//- 0.1
			y = (SafeZoneH+2*SafeZoneY) - 0.15;//safezoney + 0.1;//0.85
			w = 0.3;
			h = 0.4;
			font = "PuristaMedium";
			sizeEx = 0.03;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			text = "=BTC=_Logistic\=BTC=_Lift\img\igui_radar_air_ca.paa";
		};
		class Img_Obj
		{
			type = 0;
			idc = 1002;
			style = 48;
			x = (SafeZoneW+2*SafeZoneX) - 0.155;
			y = (SafeZoneH+2*SafeZoneY) + 0.045;
			w = 0.01;
			h = 0.01;
			font = "PuristaMedium";
			sizeEx = 0.04;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			text = "=BTC=_Logistic\=BTC=_Lift\img\=BTC=_Obj.paa";
		};
		class Pic_Obj
		{
			type = 0;
			idc = 1003;
			style = 48;
			x = (SafeZoneW+2*SafeZoneX) - 0.325;
			y = (SafeZoneH+2*SafeZoneY) - 0.23;
			w = 0.1;
			h = 0.1;
			font = "PuristaMedium";
			sizeEx = 0.03;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			text = "";
		};
		class Arrow
		{
			type = 0;
			idc = 1004;
			style = 48;
			x = (SafeZoneW+2*SafeZoneX) - 0.05;
			y = (SafeZoneH+2*SafeZoneY) - 0.15;
			w = 0.05;
			h = 0.05;
			font = "PuristaMedium";
			sizeEx = 0.03;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			text = "";
		};
		class Type_Obj
		{
			type = 0;
			idc = 1005;
			style = 0x00;
			x = (SafeZoneW+2*SafeZoneX) - 0.23;
			y = (SafeZoneH+2*SafeZoneY) - 0.335;
			w = 0.3;
			h = 0.3;
			font = "PuristaMedium";
			sizeEx = 0.03;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			text = "";
		};
	};   
 };
#define GUI_GRID_X      (0)
#define GUI_GRID_Y      (0)
#define GUI_GRID_W      (0.025)
#define GUI_GRID_H      (0.04)
#define GUI_GRID_WAbs   (1)
#define GUI_GRID_HAbs   (1)

class GOM_dialog_aircraftLoadout {
idd = 66;
movingEnable = 0;
class controls {
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Grumpy Old Man, v1.063, #Vajire)
////////////////////////////////////////////////////////

class RscStructuredText_1100: RscStructuredText
{
	idc = 1100;

	text = "<t align='center'>Current Loadout:"; //--- ToDo: Localize;
	x = 1 * GUI_GRID_W + GUI_GRID_X;
	y = 2 * GUI_GRID_H + GUI_GRID_Y;
	w = 38 * GUI_GRID_W;
	h = 7 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0};
			sizeEx = 0.03;

};
class RscStructuredText_1101: RscStructuredText
{
	idc = 1101;

	text = "<t align='center'>--- Grumpy Old Mans Pylon Loadout Station ---"; //--- ToDo: Localize;
	x = 1 * GUI_GRID_W + GUI_GRID_X;
	y = 0 * GUI_GRID_H + GUI_GRID_Y;
	w = 38 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0};
			sizeEx = 0.03;

};
class RscListbox_1500: RscListBox
{
	idc = 1500;

	x = 1 * GUI_GRID_W + GUI_GRID_X;
	y = 11 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 12 * GUI_GRID_H;
	sizeEx = 0.03;
};
class RscListbox_1501: RscListBox
{
	idc = 1501;

	x = 8 * GUI_GRID_W + GUI_GRID_X;
	y = 11 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 12 * GUI_GRID_H;
		sizeEx = 0.03;

};
class RscListbox_1502: RscListBox
{
	idc = 1502;

	x = 15 * GUI_GRID_W + GUI_GRID_X;
	y = 11 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 12 * GUI_GRID_H;
		sizeEx = 0.03;

};
class RscStructuredText_1102: RscStructuredText
{
	idc = 1102;

	text = "<t align='center'>Select Vehicle"; //--- ToDo: Localize;
	x = 1 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0};
			sizeEx = 0.03;

};
class RscStructuredText_1103: RscStructuredText
{
	idc = 1103;

	text = "<t align='center'>Select Pylon"; //--- ToDo: Localize;
	x = 8 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0};
			sizeEx = 0.03;

};
class RscStructuredText_1104: RscStructuredText
{
	idc = 1104;

	text = "<t align='center'>Select Weapon"; //--- ToDo: Localize;
	x = 15 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0};
			sizeEx = 0.03;

};
class RscButton_1600: RscButton
{
	idc = 1600;

	text = "Install Weapon"; //--- ToDo: Localize;
	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscButton_1601: RscButton
{
	idc = 1601;

	text = "Clear all pylons"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 23 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscStructuredText_1105: RscStructuredText
{
	idc = 1105;

	text = "<t align='center'>Amount:"; //--- ToDo: Localize;
	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0};
			sizeEx = 0.03;

};
class RscEdit_1400: RscEdit
{
	idc = 1400;

	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 11 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscButton_1602: RscButton
{
	idc = 1602;

	text = "Repair"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 10 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscButton_1603: RscButton
{
	idc = 1603;

	text = "Refuel"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscButton_1604: RscButton
{
	idc = 1604;

	text = "Rearm"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 13 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscCheckbox_2800: RscCheckBox
{
	idc = 2800;

	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 17 * GUI_GRID_H + GUI_GRID_Y;
	w = 1 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscCheckbox_2801: RscCheckBox
{
	idc = 2801;

	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 1 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscCheckbox_2802: RscCheckBox
{
	idc = 2802;

	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 20 * GUI_GRID_H + GUI_GRID_Y;
	w = 1 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscText_1003: RscText
{
	idc = 1003;

	text = "Report Remote Targets"; //--- ToDo: Localize;
	x = 23 * GUI_GRID_W + GUI_GRID_X;
	y = 17 * GUI_GRID_H + GUI_GRID_Y;
	w = 8.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscText_1004: RscText
{
	idc = 1004;

	text = "Receive Remote Targets"; //--- ToDo: Localize;
	x = 23 * GUI_GRID_W + GUI_GRID_X;
	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 8.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscText_1005: RscText
{
	idc = 1005;

	text = "Report Own Position"; //--- ToDo: Localize;
	x = 23 * GUI_GRID_W + GUI_GRID_X;
	y = 20 * GUI_GRID_H + GUI_GRID_Y;
	w = 9 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscFrame_1800: RscFrame
{
	idc = 1800;

	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 0 * GUI_GRID_H + GUI_GRID_Y;
	w = 39 * GUI_GRID_W;
	h = 24 * GUI_GRID_H;
	colorBackground[] = {-1,-1,-1,0.3};
	colorActive[] = {0,0,0,1};
};
class RscText_1009: RscText
{
	idc = 1009;

	text = "Operated by: Pilot"; //--- ToDo: Localize;
	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 14 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscButton_1605: RscButton
{
	idc = 1605;

	text = "Change to Gunner"; //--- ToDo: Localize;
	x = 22 * GUI_GRID_W + GUI_GRID_X;
	y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscCombo_2100: RscCombo
{
	idc = 2100;

	text = "Livery"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
		sizeEx = 0.03;

};
class RscFrame_1801: RscFrame
{
	idc = 1801;

	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 7 * GUI_GRID_W;
	h = 14 * GUI_GRID_H;
};
class RscFrame_1802: RscFrame
{
	idc = 1802;

	x = 7.5 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 7 * GUI_GRID_W;
	h = 14 * GUI_GRID_H;
};
class RscFrame_1803: RscFrame
{
	idc = 1803;

	x = 14.5 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 7 * GUI_GRID_W;
	h = 14 * GUI_GRID_H;
};
class RscFrame_1804: RscFrame
{
	idc = 1804;

	x = 21.5 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 7.5 * GUI_GRID_W;
	h = 4.5 * GUI_GRID_H;
};
class RscFrame_1805: RscFrame
{
	idc = 1805;

	x = 21.5 * GUI_GRID_W + GUI_GRID_X;
	y = 14 * GUI_GRID_H + GUI_GRID_Y;
	w = 7.5 * GUI_GRID_W;
	h = 3 * GUI_GRID_H;
};
class RscFrame_1806: RscFrame
{
	idc = 1806;

	x = 21.5 * GUI_GRID_W + GUI_GRID_X;
	y = 17 * GUI_GRID_H + GUI_GRID_Y;
	w = 10.5 * GUI_GRID_W;
	h = 4 * GUI_GRID_H;
};
class RscFrame_1807: RscFrame
{
	idc = 1807;

	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 0 * GUI_GRID_H + GUI_GRID_Y;
	w = 39 * GUI_GRID_W;
	h = 9.5 * GUI_GRID_H;
};
class RscCombo_2101: RscCombo
{
	idc = 2101;

	text = "Preset"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 16 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
		sizeEx = 0.03;

};
class RscFrame_1808: RscFrame
{
	idc = 1808;

	x = 32 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 7.5 * GUI_GRID_W;
	h = 6.5 * GUI_GRID_H;
};
class RscEdit_1401: RscEdit
{
	idc = 1401;

	text = "Your Preset"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscButton_1606: RscButton
{
	idc = 1606;

	text = "Save"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 21 * GUI_GRID_H + GUI_GRID_Y;
	w = 3 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscButton_1607: RscButton
{
	idc = 1607;

	text = "Delete"; //--- ToDo: Localize;
	x = 36 * GUI_GRID_W + GUI_GRID_X;
	y = 21 * GUI_GRID_H + GUI_GRID_Y;
	w = 3 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class RscFrame_1809: RscFrame
{
	idc = 1809;

	x = 32 * GUI_GRID_W + GUI_GRID_X;
	y = 16 * GUI_GRID_H + GUI_GRID_Y;
	w = 7.5 * GUI_GRID_W;
	h = 6.5 * GUI_GRID_H;
};
class RscButton_1608: RscButton
{
	idc = 1608;

	text = "Load Preset"; //--- ToDo: Localize;
	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
	y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 6.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////


};

};

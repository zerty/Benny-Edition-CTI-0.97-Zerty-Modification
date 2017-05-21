// made by Grumpy Old Man 17-5-2017
// feel free to use as you like, as long as I'm credited as the original author
createdialog "GOM_dialog_setPylonLoadout";
playSound "Click";
_vehicles = (getposasl player nearentities ["Air", 130])select {!isEngineOn _x};
player setVariable ["GOM_fnc_setPylonLoadoutVehicles", _vehicles];

lbclear 1500;
lbclear 1501;
lbclear 1502;
GOM_fnc_pylonCurrentSetup = {

	_vehicles = player getvariable ["GOM_fnc_setPylonLoadoutVehicles", []];
	if (_vehicles isequalto []) exitWith {false};
	if (lbCursel 1500 < 0) exitWith {systemchat "Select a vehicle first."};

	_veh		 = _vehicles select lbcursel 1500;
	_activePylonMags = GetPylonMagazines _veh;

	_dispName   = gettext (configfile >> "CfgVehicles" >> typeof _veh >> "displayName");
	_driverName = name assigneddriver _veh;

	_rank = [assignedDriver _veh, "displayName"] call BIS_fnc_rankParams;

	if (assigneddriver _veh isEqualTo objnull) then {_driverName = "No Pilot"};
	_allPylonMagazines	    = "toUpper (configname _x) find 'PYLON' >= 0" configClasses (configfile >> "CfgMagazines");
	_allPylonMagazinesDispNames = _allPylonMagazines apply {getText (configfile >> "CfgMagazines" >> configName _x >> "displayName")};
	_ind			    = lbCursel 1502;
	_mag			    = "N/A";

	if (lbcursel 1502 > -1) then {_mag = (_allPylonMagazinesDispNames select (lbCursel 1502));
		};

	_ind2 = lbcursel 1501;
	_pyl  = "N/A";
	if (_ind2 > -1) then {_ind2 = _ind2 + 1;
			      _pyl  = getText (configfile >> "CfgMagazines" >> _activePylonMags select lbCursel 1501 >> "displayName")} else {_ind2 = " N/A"};


	_text = format ["<t align='center'>%1 - Pilot: %2 %3<br /><br />Replace Pylon %4:<br />--- %5 ---<br />with<br />--- %6 ---", _dispName, _rank, _driverName, _ind2, _pyl, _mag];

	_br	  = "";
	_align	  = _align + 1;
	_getAlign = _aligns select _align;


	(finddisplay 66 displayctrl 1100) ctrlSetStructuredText parsetext _text;
};

{

	_dispName = gettext (configfile >> "CfgVehicles" >> typeof _x >> "displayName");
	_form	  = format ["%1 - %2", _dispName, name assigneddriver _x];
	lbAdd [1500, _form];
} forEach _vehicles;

GOM_fnc_setPylonLoadoutLBPylonsUpdate = {
	_vehicles = player getvariable ["GOM_fnc_setPylonLoadoutVehicles", []];
	if (_vehicles isequalto []) exitWith {false};
	if (lbCursel 1500 < 0) exitWith {systemchat "Select a vehicle first."};

	_veh		 = _vehicles select lbcursel 1500;
	_activePylonMags = GetPylonMagazines _veh;
	lbclear 1501;
	{

		lbAdd [1501, format ["Pylon %1", _foreachindex + 1]];
	} forEach _activePylonMags;
	_allPylonMagazines	    = "toUpper (configname _x) find 'PYLON' >= 0" configClasses (configfile >> "CfgMagazines");
	_allPylonMagazinesDispNames = _allPylonMagazines apply {getText (configfile >> "CfgMagazines" >> configName _x >> "displayName")};
	lbClear 1502;
	{

		lbAdd [1502, _x];
	} forEach _allPylonMagazinesDispNames;
	_updateText = [] call GOM_fnc_pylonCurrentSetup;
	playSound "Click";
};

GOM_fnc_setPylonLoadoutLBMagazinesCountUpdate = {
	_updateText = [] call GOM_fnc_pylonCurrentSetup;
	if (lbCursel 1500 < 0) exitWith {systemchat "Select a vehicle first."};

	_allPylonMagazines	     = "toUpper (configname _x) find 'PYLON' >= 0" configClasses (configfile >> "CfgMagazines");
	_allPylonMagazinesDispNames  = _allPylonMagazines apply {getText (configfile >> "CfgMagazines" >> configName _x >> "displayName")};
	_allPylonMagazinesClassNames = _allPylonMagazines apply {configName _x};
	_mag			     = _allPylonMagazinesClassNames select lbCursel 1502;
	_count			     = getNumber (configfile >> "CfgMagazines" >> _mag >> "count");

	ctrlSetText [1400, str _count];
	playSound "Click";
};

GOM_fnc_pylonInstallWeapon = {

	_vehicles = player getVariable ["GOM_fnc_setPylonLoadoutVehicles", []];
	if (lbCursel 1500 < 0) exitWith {systemchat "Select a vehicle first."};

	_veh = _vehicles select lbcursel 1500;

	_allPylonMagazines	     = "toUpper (configname _x) find 'PYLON' >= 0" configClasses (configfile >> "CfgMagazines");
	_allPylonMagazinesDispNames  = _allPylonMagazines apply {getText (configfile >> "CfgMagazines" >> configName _x >> "displayName")};
	_allPylonMagazinesClassNames = _allPylonMagazines apply {configName _x};

	_mag	     = (_allPylonMagazinesClassNames select lbCursel 1502);
	_magDispName = (_allPylonMagazinesDispNames select lbCursel 1502);

	_maxAmount = getNumber (configfile >> "CfgMagazines" >> _mag >> "count");

	_setAmount = if (count (ctrlText 1400) > 0) then {call compile (ctrlText 1400)} else {0};

	_finalAmount = _setAmount min _maxAmount;
	if (_setAmount > _maxAmount) then {systemchat "I see what you did there...";
					   playsound "Simulation_Fatal"};

	_pylonNum = lbCurSel 1501;
	systemchat format ["Installed %1 %2 on pylon %3", _finalAmount, _magDispName, _pylonNum];

	_veh setPylonLoadOut [_pylonNum, "", true];
	_veh setPylonLoadOut [_pylonNum, _mag, true];
	_veh SetAmmoOnPylon [_pylonNum, _finalAmount];
	[_veh, selectRandom ['FD_Target_PopDown_Large_F', 'FD_Target_PopDown_Small_F', 'FD_Target_PopUp_Small_F']] remoteExec ["say", 0];

	playSound "Click";
};

GOM_fnc_clearAllPylons = {

	if (lbCursel 1500 < 0) exitWith {systemchat "Select a vehicle first."};
	_vehicles	 = player getVariable ["GOM_fnc_setPylonLoadoutVehicles", []];
	_veh		 = _vehicles select lbcursel 1500;
	_activePylonMags = GetPylonMagazines _veh;
	{

		_veh setPylonLoadOut [_foreachIndex, "", true];
		_veh SetAmmoOnPylon [_foreachIndex, 0];
	} forEach _activePylonMags;
	playSound "Click";
	[_veh, selectRandom ['FD_Target_PopDown_Large_F', 'FD_Target_PopDown_Small_F', 'FD_Target_PopUp_Small_F']] remoteExec ["say", 0];
	systemchat "Vehicle pylons cleared!";
};

GOM_fnc_setPylonsRearm = {

	if (lbCursel 1500 < 0) exitWith {systemchat "Select a vehicle first."};
	_vehicles	 = player getVariable ["GOM_fnc_setPylonLoadoutVehicles", []];
	_veh		 = _vehicles select lbcursel 1500;
	_activePylonMags = GetPylonMagazines _veh;

	{

		_maxAmount = getNumber (configfile >> "CfgMagazines" >> _x >> "count");
		_veh SetAmmoOnPylon [_foreachIndex, _maxAmount];
	} forEach _activePylonMags;
	playSound "Click";
	systemchat "Vehicle pylons rearmed!";
	[_veh, selectRandom ['FD_Target_PopDown_Large_F', 'FD_Target_PopDown_Small_F', 'FD_Target_PopUp_Small_F']] remoteExec ["say", 0];
};

GOM_fnc_setPylonsRepair = {

	if (lbCursel 1500 < 0) exitWith {systemchat "Select a vehicle first."};
	_vehicles = player getVariable ["GOM_fnc_setPylonLoadoutVehicles", []];
	_veh	  = _vehicles select lbcursel 1500;
	_veh setDamage 0;
	playSound "Click";
	systemchat "Vehicle repaired!";
	[_veh, selectRandom ['FD_Target_PopDown_Large_F', 'FD_Target_PopDown_Small_F', 'FD_Target_PopUp_Small_F']] remoteExec ["say", 0];
};

GOM_fnc_setPylonsRefuel = {

	if (lbCursel 1500 < 0) exitWith {systemchat "Select a vehicle first."};
	_vehicles = player getVariable ["GOM_fnc_setPylonLoadoutVehicles", []];
	_veh	  = _vehicles select lbcursel 1500;
	playSound "Click";
	systemchat "Vehicle refueled!";
	[_veh, selectRandom ['FD_Target_PopDown_Large_F', 'FD_Target_PopDown_Small_F', 'FD_Target_PopUp_Small_F']] remoteExec ["say", 0];

	_veh setFuel 1;
};

finddisplay 66 displayCtrl 1500 ctrlAddEventHandler ["LBSelChanged", "[] call GOM_fnc_setPylonLoadoutLBPylonsUpdate"];
finddisplay 66 displayCtrl 1501 ctrlAddEventHandler ["LBSelChanged", "[] call GOM_fnc_pylonCurrentSetup"];
finddisplay 66 displayCtrl 1502 ctrlAddEventHandler ["LBSelChanged", "[] call GOM_fnc_setPylonLoadoutLBMagazinesCountUpdate"];

buttonSetAction [1600, "_nul = [] call GOM_fnc_pylonInstallWeapon"];
buttonSetAction [1601, "_nul = [] call GOM_fnc_clearAllPylons"];
buttonSetAction [1602, "_nul = [] call GOM_fnc_setPylonsRepair"];
buttonSetAction [1603, "_nul = [] call GOM_fnc_setPylonsRefuel"];
buttonSetAction [1604, "_nul = [] call GOM_fnc_setPylonsReArm"];
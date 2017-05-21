/*
GOM_fnc_aircraftLoadout V1.2 made by Grumpy Old Man 17-5-2017
feel free to use as you like, as long as I'm credited as the original author
this function is used to make one vehicle act as a loadout station
to add this to an ammo truck put this in the ammo trucks init:
_add = [this] call GOM_fnc_addAircraftLoadout
to have a player inside the jet be able to use it put this in the pilots init field:
_add = [vehicle player,"PILOT"] call GOM_fnc_addAircraftLoadout
should work on dedi and MP
Changelog:
V1.2
Added button to select who has control over the pylon (pilot or gunner)
Added customer presets saved individually for each vehicle for every player
 -Presets will be saved for each vehicle type, so you can equip multiple aircraft with the same loadout within a few clicks
 -Presets will contain the pylon loadout, ammo amount from each pylon, respective pylon owners (pilot, gunner) and the livery of the aircraft
 -Presets are stored in profileNamespace, so they'll persist everytime you use this loadout menu, no matter which server you're on
 -Delete button is locked by default, can only be used when holding CTRL to prevent mishaps
Added livery option, will change texture if the aircraft has any in the config
Added option to override the pylon compatibility check, yay 120 DAGR wipeout
Added option to make the presence of ammo/fuel/repair supplies necessary, no ammotruck? no fancy weapons!
Added duration to rearming an aircraft, fully rearming an empty 120 DAGR wipeout can take up to 2 minutes
Added duration to repairing an aircraft, default is set to 60s from 0 to 100% health
 -repair speed can be adjusted
Added duration to refuelling an aircraft, fillrate is set to 1800l/min as default and will be calculated accordingly (wipeout with 1000l fuel capacity will take 33s to refill to 100%)
 -refill rate can be adjusted
 -refuelling will abort when the aircraft is not stationary
 -you can only simultaneously refuel as much airplanes as you have fuel sources
Fixed 'clear all pylons' button now to properly remove all leftover weapon classes from the aircraft
Fixed 'rearm' button now to properly rearm all weapons, on board cannons, flare/chaff launchers


V1.1
Added compatibility check for magazines and pylons, so you can't add everything on every pylon.
Installing a pylon takes some time.
Added possibility to execute this for one pilot in a stationary aircraft or as an action from an ammo truck or whatever you'd like.
Added options for reporting and receiving of remote targets as well as reporting the aircrafts own position.
The 'clear all pylong' button now properly removes all pylons, no more leftovers

*/

GOM_fnc_aircraftLoadout_NeedsFuelSource = true; //(default: true) needs fuel supply within 50m of the aircraft or functions will be unavailable
GOM_fnc_aircraftLoadout_NeedsAmmoSource = true; //(default: true) needs ammo supply within 50m of the aircraft or functions will be unavailable
GOM_fnc_aircraftLoadout_NeedsRepairSource = true; //(default: true) needs repair supply within 50m of the aircraft or functions will be unavailable


GOM_fnc_allowAllPylons = false; //(default: false) removes check that only allows compatible pylons to be mounted

GOM_fnc_aircraftLoadoutRepairTime = 60; //(default: 60) time it takes to repair a vehicle from 0 to 100% health. Going from 50% to 100% will take half the time
GOM_fnc_aircraftLoadoutRefuelRate = 1800; //(default: 1800) rate in liters per minute a vehicle will be refuelled at. Going from 0 to 100% fuel will take 60 seconds if the vehicle holds 1800l max fuel. wipeout has 1000l max fuel as a measurement


//do not adjust anything below this line
GOM_fnc_addAircraftLoadout = {

	params [["_obj",objnull],["_pilot",""]];
	if (_pilot isEqualTo "PILOT" AND isPlayer driver _obj) exitWith {_add = [_obj,"PILOT"] call GOM_fnc_AircraftLoadout};

	[_obj,["Change Aircraft Loadout",{_this call GOM_fnc_aircraftLoadout}, [], 1, true, true, "", "isPlayer _this AND {_this isequalto vehicle _this} AND {speed _this isequalto 0}"]] remoteExec ["addAction",0,true];
	true

};
GOM_fnc_roundByDecimals = {

	params ["_num",["_digits",2]];
	round (_num * (10 ^ _digits)) / (10 ^ _digits)

};

GOM_fnc_updateDialog = {

	params ["_obj",["_preset",false]];

	_vehicles = _obj getvariable ["GOM_fnc_setPylonLoadoutVehicles",[]];


	if (lbCursel 1500 < 0) exitWith {

	_check = [_obj] call GOM_fnc_aircraftLoadoutResourcesCheck;

	_check params ["_flags","_vehs"];
	_flags params ["_canRefuel","_canRepair","_canRearm"];
	_vehs params ["_refuelVehs","_repairVehs","_rearmVehs"];

	_availableTexts = ["Not available","Available"];


	_text = format ["<t align='center'>Repairing: %1!<br />Refueling: %2!<br />Rearming: %3!",(_availableTexts select _canRepair),(_availableTexts select _canRefuel),(_availableTexts select _canRearm)];

	(finddisplay 66 displayctrl 1100) ctrlSetStructuredText parsetext _text;


	};

	if (_vehicles isequalto []) exitWith {false};
	private _veh = _vehicles select lbcursel 1500;
	_dispName = lbText [1500,lbCurSel 1500];


	if (_preset) exitWith {

	_presets = profileNamespace getVariable ["GOM_fnc_aircraftLoadoutPresets",[]];
	_preset = (_presets select {(_x select 0) isEqualTo typeOf _veh AND (_x select 1) isEqualTo lbText [2101,lbcursel 2101]}) select 0;
	_preset params ["_vehType","_presetName","_pylons","_pylonAmmoCounts","_textureParams","_pylonOwners"];
	_textureParams params ["_textureName","_textures"];

	_pylonInfoText = "";
	_sel = 0;
	_align = ["<t align='left'>","<t align='center'>","<t align='right'>"];
	_count = 0;
	{
		_count = _count + 1;
		_owner = "Pilot";
		if !(_pylonOwners isEqualTo []) then {

		_owner = if ((_pylonowners select _forEachIndex+1) isEqualTo []) then {"Pilot"} else {"Gunner"};
	};

	_pylonDispname = getText (configfile >> "CfgMagazines" >> _x >> "displayName");
	_setAlign = _align select _sel;
		_sel = _sel + 1;
	_break = "";
	if (_sel > 2) then {_sel = 0;_break = "<br />"};
	if (count _pylons <= 6) then {_setAlign = "<t align='left'>";_break = "<br />"};
		_pylonInfoText = _pylonInfoText + format ["%1Pylon %2: %3 - %4 (%5).%6",_setAlign,_count,_owner,_pylonDispname,_pylonAmmoCounts select _forEachIndex,_break];

	} forEach _pylons;

			_text = format ["<t align='center'>Selected %1 preset: %2<br /><br /><t align='left' t size='0.75'>Livery: %3<br />%4",_dispName,_presetName,_textureName,_pylonInfoText];

	(finddisplay 66 displayctrl 1100) ctrlSetStructuredText parsetext _text;



	};


	_driverName = name assigneddriver _veh;

	_rank = [assignedDriver _veh,"displayName"] call BIS_fnc_rankParams;

	if (assigneddriver _veh isEqualTo objnull) then {_driverName = "No Pilot"};


	_mag = "N/A";
	_get = "";
	if (lbcursel 1502 > -1) then {_get = (lbdata [1502,(lbCursel 1502)]);};
	_ind2 = "N/A";
	_pylonMagDispName = getText (configfile >> "CfgMagazines" >> _get >> "displayName");

	_pyl = "N/A";
	if (lbcursel 1501 > -1) then {_pyl = (lbdata [1501,(lbCursel 1501)]);};

	_curFuel = fuel _veh;

	_maxFuel = getNumber (configfile >> "CfgVehicles" >> typeof _veh >> "fuelCapacity");
	_fuel = [(_curFuel * _maxfuel),1] call GOM_fnc_roundByDecimals;

		_missingFuel = _maxfuel - _fuel;

	_pylonOwner = _veh getVariable ["GOM_fnc_aircraftLoadoutPylonOwner",[]];

	_pylonOwnerName = "Pilot";
	_nextOwnerName = "Gunner";
	if !(_pylonOwner isEqualTo []) then {_pylonOwnerName = "Gunner"};
	_ownerText = format ["Operated by: %1",_pylonOwnerName];

	_integrity = [((damage _veh * 100) - 100) * -1] call GOM_fnc_roundByDecimals;



	_text = format ["<t align='center'>%1, Integrity: %11%12<br />Pilot: %2 %3<br />Fuel: %4l / %5l<br />Mount %6 on %7<br />%8",_dispName,_rank,_driverName,_fuel,_maxFuel,_pylonMagDispName,_pyl,_ownerText,_integrity,"%"];

	(finddisplay 66 displayctrl 1100) ctrlSetStructuredText parsetext _text;

};

GOM_fnc_setPylonLoadoutLBPylonsUpdate = {

	params ["_obj"];
	_check = [_obj] call GOM_fnc_aircraftLoadoutResourcesCheck;

	_vehicles = _obj getvariable ["GOM_fnc_setPylonLoadoutVehicles",[]];

	if (_vehicles isequalto []) exitWith {false};

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};

	_veh = _vehicles select lbcursel 1500;
	_updateLB = [_obj] call GOM_fnc_updatePresetLB;

	_validPylons = (("isClass _x" configClasses (configfile >> "CfgVehicles" >> typeof _veh >> "Components" >> "TransportPylonsComponent" >> "Pylons")) apply {configname _x});
	lbClear 1501;
	{

		lbAdd [1501,_x];
		lbsetData [1501,_foreachIndex,_x];

	} forEach _validPylons;

		_colorConfigs = "true" configClasses (configfile >> "CfgVehicles" >> typeof _veh >> "textureSources");
		if (_colorConfigs isequalto []) then {lbclear 2100;lbAdd [2100,"No paintjobs available."];lbSetCurSel [2100,0]};

	findDisplay 66 displayCtrl 2800 cbSetChecked (vehicleReportRemoteTargets _veh);
	findDisplay 66 displayCtrl 2801 cbSetChecked (vehicleReceiveRemoteTargets _veh);
	findDisplay 66 displayCtrl 2802 cbSetChecked (vehicleReportOwnPosition _veh);

	playSound "Click";

};

GOM_fnc_setPylonLoadoutLBMagazinesCountUpdate = {


	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};


	_mag = lbdata [1502,lbCursel 1502];
	_count = getNumber (configfile >> "CfgMagazines" >> _mag >> "count");

	ctrlSetText [1400,str _count];
	playSound "Click";

};

GOM_fnc_pylonInstallWeapon = {

	params ["_obj"];

	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};

	_veh = _vehicles select lbcursel 1500;

	_mag = lbdata [1502,lbCurSel 1502];
	_magDispName = getText (configfile >> "CfgMagazines" >> _mag >> "displayName");

	_maxAmount = getNumber (configfile >> "CfgMagazines" >> _mag >> "count");

	_setAmount = if (count (ctrlText 1400) > 0) then {call compile (ctrlText 1400)} else {0};

	_finalAmount = _setAmount min _maxAmount;

	if (_setAmount > _maxAmount) then {systemchat "I see what you did there...";playsound "Simulation_Fatal"};

	_pylonNum = lbCurSel 1501 + 1;
	_pylonName = lbdata [1501,lbCurSel 1501];


	_add = [_veh,_pylonNum,_mag,_finalAmount,_magDispName,_pylonName] spawn GOM_fnc_installPylons;


	playSound "Click";

};
GOM_fnc_installPylons = {

	params ["_veh","_pylonNum","_mag","_finalAmount","_magDispName","_pylonName"];

	_check = _veh getVariable ["GOM_fnc_airCraftLoadoutPylonInstall",[]];

	if (_pylonNum in _check) exitWith {systemchat "Installation in progress!"};
	_pylonOwner = _veh getVariable ["GOM_fnc_aircraftLoadoutPylonOwner",[]];

	_pylonOwnerName = "Pilot";
	_nextOwnerName = "Gunner";
	if !(_pylonOwner isEqualTo []) then {_pylonOwnerName = "Gunner"};

	_storePylonOwners = _veh getVariable ["GOM_fnc_aircraftLoadoutPylonOwners",[]];
	_storePylonOwners set [_pylonNum,_pylonOwner];
	_veh setVariable ["GOM_fnc_aircraftLoadoutPylonOwners",_storePylonOwners,true];

	systemchat format ["Installing %1 %2 on %3, operated by %4!",_finalAmount,_magDispName,_pylonName,_pylonOwnerName];
	_check pushback _pylonNum;
	_veh setVariable ["GOM_fnc_airCraftLoadoutPylonInstall",_check,true];

sleep random [0.5,1,2.5];
	_veh setPylonLoadOut [_pylonNum,"",true,_pylonOwner];
	_veh setPylonLoadOut [_pylonNum,_mag,true,_pylonOwner];
	_veh SetAmmoOnPylon [_pylonNum,0];
	_sound = [_veh] call GOM_fnc_pylonSound;
sleep random [0.5,1,2.5];
	if (_finalamount <= 24) then {

	for "_i" from 1 to _finalamount do {

		_veh SetAmmoOnPylon [_pylonNum,_i];
		_sound = [_veh] call GOM_fnc_pylonSound;
		sleep random [0.5,1,2.5];

	};

	} else {

		_veh SetAmmoOnPylon [_pylonNum,_finalamount];
		_sound = [_veh] call GOM_fnc_pylonSound;
sleep random [0.5,1,2.5];
	};

	_checkOut = _veh getVariable ["GOM_fnc_airCraftLoadoutPylonInstall",[]];
	_checkOut = _checkOut - [_pylonNum];
	_veh setVariable ["GOM_fnc_airCraftLoadoutPylonInstall",_checkOut,true];

	systemchat format ["Successfully installed %1 %2 on %3!",_finalAmount,_magDispName,_pylonName];
};

GOM_fnc_clearAllPylons = {

	params ["_obj"];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};

	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];
	_veh = _vehicles select lbcursel 1500;
	_activePylonMags = GetPylonMagazines _veh;

	{

		_veh setPylonLoadOut [_foreachIndex + 1,"",true];
		_veh SetAmmoOnPylon [_foreachIndex + 1,0];

	} forEach _activePylonMags;

	playSound "Click";

	_pylonWeapons = [];
	{ _pylonWeapons append getArray (_x >> "weapons") } forEach ([_veh, configNull] call BIS_fnc_getTurrets);
	{ _veh removeWeaponGlobal _x } forEach ((weapons _veh) - _pylonWeapons);

	_sound = [_veh] call GOM_fnc_pylonSound;
	systemchat "All pylons cleared!";

};

GOM_fnc_aircraftLoadoutClear = {
	params ["_veh"];
	_activePylonMags = GetPylonMagazines _veh;

	{

		_veh setPylonLoadOut [_foreachIndex + 1,"",true];
		_veh SetAmmoOnPylon [_foreachIndex + 1,0];

	} forEach _activePylonMags;

	_pylonWeapons = [];
	{ _pylonWeapons append getArray (_x >> "weapons") } forEach ([_veh, configNull] call BIS_fnc_getTurrets);
	{ _veh removeWeaponGlobal _x } forEach ((weapons _veh) - _pylonWeapons);

};

GOM_fnc_setPylonsRearm = {

	params ["_obj",["_rearm",false],["_pylons",[]],["_pylonAmmoCounts",[]]];
_nul = [_obj,_rearm,_pylons,_pylonAmmoCounts] spawn {

	params ["_obj",["_rearm",false],["_pylons",[]],["_pylonAmmoCounts",[]]];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];
	_veh = _vehicles select lbcursel 1500;	_veh setVehicleAmmo 1;

	if (_veh getVariable ["GOM_fnc_aircraftLoadoutRearmingInProgress",false]) exitWith {systemchat "Aircraft is already currently being rearmed!"};
	_veh setVariable ["GOM_fnc_aircraftLoadoutRearmingInProgress",true,true];
	_activePylonMags = GetPylonMagazines _veh;
	if (_rearm) exitWith {

		[_obj] call GOM_fnc_clearAllPylons;


		sleep random [0,2,5];
	{


			_pylonOwners = _veh getVariable ["GOM_fnc_aircraftLoadoutPylonOwners",[]];
			_pylonOwner = if (_pylonOwners isequalto []) then {[]} else {_pylonOwners select (_foreachindex + 1)};
			_maxAmount = (_pylonAmmoCounts select _forEachIndex);
			_veh setPylonLoadOut [_foreachindex+1,_x,true,_pylonOwner];
			_veh SetAmmoOnPylon [_foreachIndex+1,0];
		sleep random [0,2,5];

		if (_maxamount < 24) then {

		for "_i" from 0 to _maxamount do {
		sleep random [0.5,1,1.5];
		_veh SetAmmoOnPylon [_foreachIndex+1,_i];
		_sound = [_veh] call GOM_fnc_pylonSound;
		};
		} else {

		_veh SetAmmoOnPylon [_foreachIndex+1,_maxamount];
		_sound = [_veh] call GOM_fnc_pylonSound;
		};


	} forEach _pylons;
	playSound "Click";
	_veh setVariable ["GOM_fnc_aircraftLoadoutRearmingInProgress",false,true];
	systemchat "All pylons and board guns rearmed!";
};


		sleep random [0,2,5];
	{


			_veh SetAmmoOnPylon [_foreachIndex+1,0];

			_mount = [_veh,_forEachIndex+1,_x] spawn {
				params ["_veh","_ind","_mag"];

	_maxAmount = getNumber (configfile >> "CfgMagazines" >> _mag >> "count");
		sleep random [0,2,5];

		if (_maxamount < 24) then {

		for "_i" from 0 to _maxamount do {
		sleep random [0.5,1,1.5];
		_veh SetAmmoOnPylon [_ind,_i];
		_sound = [_veh] call GOM_fnc_pylonSound;
		};
		} else {

		_veh SetAmmoOnPylon [_ind,_maxamount];
		_sound = [_veh] call GOM_fnc_pylonSound;
		};
	};


	} forEach _activePylonMags;
	playSound "Click";
	_veh setVariable ["GOM_fnc_aircraftLoadoutRearmingInProgress",false,true];
	systemchat "All pylons and board guns rearmed!";

};
true
};

GOM_fnc_setPylonsRepair = {

	params ["_obj","_repairSource"];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};

	_repairVehs = vehicles select {typeof _x isKindOf "All" AND {_x distance2d _obj <= 50} AND {speed _x < 1} AND {alive _x} AND {getNumber (configfile >> "CfgVehicles" >> typeof _x >> "transportRepair") > 0}};
	if (_repairVehs isEqualTo []) exitWith {systemchat "You have no valid repair sources!"};
	_notBusy = _repairVehs select {!(_x getVariable ["GOM_fnc_aircraftLoadoutBusyRepairSource",false])};
	if (_notBusy isEqualTo []) exitWith {systemchat "All repair sources are currently busy!"};
	_repairSource = _notBusy select 0;

	_repairSource setVariable ["GOM_fnc_aircraftLoadoutBusyRepairSource",true,true];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];
	_veh = _vehicles select lbcursel 1500;


	_refuel = [_veh,_repairSource,_obj] spawn {
		params ["_veh","_repairSource","_obj"];
		_curDamage = damage _veh;
		if (_curDamage isEqualTo 1) exitWith {systemchat "Aircraft is destroyed!"};

		_sourceDispname = getText (configfile >> "CfgVehicles" >> typeof _repairSource >> "displayName");
		_vehDispName = getText (configfile >> "CfgVehicles" >> typeof _veh >> "displayName");

			_repairTick = (1 / GOM_fnc_aircraftLoadoutRepairTime);
			_timeNeeded = ceil (_curDamage / _repairtick);

			_damDisp = [((_curDamage * 100) - 100) * -1] call GOM_fnc_roundByDecimals;
		systemchat "Aircraft has to remain stationary during repair procedure!";
		systemchat format ["Repairing %1 from %2%3! Total duration: %4s.",_vehDispName,_damDisp,"%",_timeNeeded];
		for "_i" from 1 to _timeneeded + 1 do {

			if (speed _veh > 3 OR speed _repairSource > 3) exitWith {systemchat "Aborting repair! Vehicle is moving!"};
		_curDamage = damage _veh;

			_timeNeeded = ceil (_curDamage / _repairtick);
		_veh setdamage _curDamage - _repairTick;
	_sound = [_veh] call GOM_fnc_pylonSound;

			_damDisp = [((_curDamage * 100) - 100) * -1] call GOM_fnc_roundByDecimals;
		if (_i % 10 isEqualTo 0) then {systemchat format ["%1 remaining: %2%3, %4s.",_vehDispName,_damDisp,"%",_timeNeeded];
};
			_timeout = time + 1;
			waituntil {time > _timeout OR speed _veh > 3 OR speed _repairSource > 3};
						_update = [_obj] call GOM_fnc_updateDialog;

		};
		_veh setdamage 0;
	_repairSource setVariable ["GOM_fnc_aircraftLoadoutBusyRepairSource",false,true];
	systemchat format ["%1 repaired: %2%3!",_vehDispName,_damDisp,"%"];
		playSound "Click";
	};

	playSound "Click";


};

GOM_fnc_setPylonsRefuel = {

	params ["_obj"];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};
	_refuelVehs = vehicles select {typeof _x isKindOf "All" AND {_x distance2d _obj <= 50} AND {speed _x < 1} AND {alive _x} AND {getNumber (configfile >> "CfgVehicles" >> typeof _x >> "transportFuel") > 0}};;

	if (_refuelVehs isEqualTo []) exitWith {systemchat "You have no valid refuelling sources!"};
	_notBusy = _refuelVehs select {!(_x getVariable ["GOM_fnc_aircraftLoadoutBusyFuelSource",false])};
	if (_notBusy isEqualTo []) exitWith {systemchat "All refuelling sources are currently busy!"};
	_refuelSource = _notBusy select 0;
	_refuelSource setVariable ["GOM_fnc_aircraftLoadoutBusyFuelSource",true,true];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];
	_veh = _vehicles select lbcursel 1500;

	_refuel = [_veh,_refuelSource,_obj] spawn {
		params ["_veh","_refuelSource","_obj"];
		_curFuel = fuel _veh;
		if (_curFuel isEqualTo 1) exitWith {systemchat "Aircraft is already at 100% fuel capacity!"};
		_maxFuel = getNumber (configfile >> "CfgVehicles" >> typeof _veh >> "fuelCapacity");
		_sourceDispname = getText (configfile >> "CfgVehicles" >> typeof _refuelSource >> "displayName");
		_vehDispName = getText (configfile >> "CfgVehicles" >> typeof _veh >> "displayName");
		_fuel = round(_curFuel * _maxfuel);

		_missingFuel = _maxfuel - _fuel;
		_fillrate = GOM_fnc_aircraftLoadoutRefuelRate;
		_timeNeeded = round ((_missingFuel / _fillrate) * 60);
		_fuelTick = ((1 - _curFuel) / _timeNeeded);
		systemchat "Aircraft has to remain stationary during refuelling procedure!";
		systemchat format ["Refuelling %1 from %2. %3l in %4s. Fillrate: 1800l/min.",_vehDispName,_sourceDispname,[_missingfuel,1] call GOM_fnc_roundByDecimals,_timeNeeded];
		for "_i" from 1 to _timeneeded do {
			_timeout = time + 1;
			waituntil {time > _timeout OR speed _veh > 3 OR speed _refuelSource > 3};
			if (speed _veh > 3 OR speed _refuelSource > 3) exitWith {systemchat "Aborting refuelling! Vehicle is moving!"};
		_curFuel = fuel _veh;

		_vehLocalTo = owner _veh;
		[_veh,(_curFuel + _fuelTick)] remoteExec ["setFuel",_vehLocalTo];


		_fuel = [(_curFuel * _maxfuel),1] call GOM_fnc_roundByDecimals;

		_missingFuel = _maxfuel - _fuel;

				_timeNeeded = round ((_missingFuel / _fillrate) * 60);

		if (_i % 10 isEqualTo 0) then {systemchat format ["%1 remaining: %2l, %3s.",_vehDispName,_missingFuel,_timeNeeded];
};
			_update = [_obj] call GOM_fnc_updateDialog;

		};

	_refuelSource setVariable ["GOM_fnc_aircraftLoadoutBusyFuelSource",false,true];
	_veh setfuel 1;
		playSound "Click";
		systemchat format ["%1 filled up!",_vehDispName];
	};
true

};

GOM_fnc_fillPylonsLB = {

	params ["_obj"];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};

	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];
	_veh = _vehicles select lbcursel 1500;

	_pylon = lbData [1501,lbcursel 1501];
	_getCompatibles = getArray (configfile >> "CfgVehicles" >> typeof _veh >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _pylon >> "hardpoints");

	if (_getCompatibles isEqualTo []) then {

		//darn BI for using "Pylons" and "pylons" all over the place as if it doesnt fucking matter ffs honeybadger

		_getCompatibles = getArray (configfile >> "CfgVehicles" >> typeof _veh >> "Components" >> "TransportPylonsComponent" >> "pylons" >> _pylon >> "hardpoints");

	};

	_allPylonMags = ("count( getArray (_x >> 'hardpoints')) > 0" configClasses (configfile >> "CfgMagazines")) apply {configname _x};
	_validPylonMags = _allPylonMags select {!((getarray (configfile >> "CfgMagazines" >> _x >> "hardpoints") arrayIntersect _getCompatibles) isEqualTo [])};
	_validDispNames = _validPylonMags apply {getText (configfile >> "CfgMagazines" >> _x >> "displayName")};
	lbClear 1502;

	if (GOM_fnc_allowAllPylons) then {

		_validPylonMags = _allPylonMags;
		_validDispNames = _validPylonMags apply {getText (configfile >> "CfgMagazines" >> _x >> "displayName")};

	} else {

	_validPylonMags = _allPylonMags select {!((getarray (configfile >> "CfgMagazines" >> _x >> "hardpoints") arrayIntersect _getCompatibles) isEqualTo [])};
	_validDispNames = _validPylonMags apply {getText (configfile >> "CfgMagazines" >> _x >> "displayName")};
	};

	{

		lbAdd [1502,_validDispNames select _foreachIndex];
		lbsetData [1502,_foreachIndex,_x];

	} forEach _validPylonMags;

};

GOM_fnc_pylonCam = {

	params ["_obj"];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];
	_veh = _vehicles select lbcursel 1500;

};

GOM_fnc_pylonSound = {

	params ["_veh"];

	_rndSound = selectRandom ['FD_Target_PopDown_Large_F','FD_Target_PopDown_Small_F','FD_Target_PopUp_Small_F'];
	_getPath = getArray (configfile >> "CfgSounds" >> _rndSound >> "sound");
	_path = _getPath select 0;
	_pos = getPosASL _veh;
	playSound3D [_path,_veh,false,_pos,random [0.8,1,1.2],random [0.8,1,1.2],180];
	//[_obj,_rndSound] remoteExec ["say",0];


};

GOM_fnc_CheckComponents = {

	params ["_ctrlParams","_obj"];
	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};

	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];
	_veh = _vehicles select lbcursel 1500;
	_vehDispName = getText (configfile >> "CfgVehicles" >> typeOf _veh >> "displayName");
	_ctrlParams params ["_ctrl","_state"];
	_set = [false,true] select _state;

	if (_set) then {

		if (str _ctrl find "2800" > -1) then {systemchat format ["%1 will now report remote targets!",_vehDispName];_veh setVehicleReportRemoteTargets _set};

		if (str _ctrl find "2801" > -1) then {systemchat format ["%1 will now receive remote targets!",_vehDispName];_veh setVehicleReceiveRemoteTargets _set};

		if (str _ctrl find "2802" > -1) then {systemchat format ["%1 will now report its own position!",_vehDispName];_veh setVehicleReportOwnPosition _set};

		} else {

		if (str _ctrl find "2800" > -1) then {systemchat format ["%1 will no longer report remote targets!",_vehDispName];_veh setVehicleReportRemoteTargets _set};

		if (str _ctrl find "2801" > -1) then {systemchat format ["%1 will no longer receive remote targets!",_vehDispName];_veh setVehicleReceiveRemoteTargets _set};

		if (str _ctrl find "2802" > -1) then {systemchat format ["%1 will no longer report its own position!",_vehDispName];_veh setVehicleReportOwnPosition _set};



	};
	playSound "Click";

};

GOM_fnc_setPylonOwner = {

	params ["_obj"];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};

	_veh = _vehicles select lbcursel 1500;

	_pylonOwner = _veh getVariable ["GOM_fnc_aircraftLoadoutPylonOwner",[]];

	if (_pylonOwner isEqualTo []) then {_pylonOwner = [0]} else {_pylonOwner = []};

	_pylonOwnerName = "Pilot";
	_nextOwnerName = "Gunner";
	if !(_pylonOwner isEqualTo []) then {_pylonOwnerName = "Gunner"};
	if (_pylonOwnerName isEqualTo "Gunner") then {_nextOwnerName = "Pilot"};
	ctrlSetText [1009,format ["Operator: %1",_pylonOwnerName]];
	ctrlSetText [1605,format ["Change to: %1",_nextOwnerName]];

	_veh setVariable ["GOM_fnc_aircraftLoadoutPylonOwner",_pylonOwner,true];
	_update = [_obj] call GOM_fnc_updateDialog;

};

GOM_fnc_aircraftLoadoutPaintjob = {

	params ["_obj",["_apply",false]];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first.
"};
	lbClear 2100;
	lbAdd [2100,"Livery"];
	_veh = _vehicles select lbcursel 1500;
		_colorConfigs = "true" configClasses (configfile >> "CfgVehicles" >> typeof _veh >> "textureSources");
		_vehDispName = getText (configfile >> "CfgVehicles" >> typeof _veh >> "displayName");
		_colorTextures = [""];
		if (count _colorConfigs > 0) then {

			_colorNames = [""];
			{
			_colorNames pushback (getText (configfile >> "CfgVehicles" >> typeof _veh >> "textureSources" >> configName _x >> "displayName"));
			lbAdd [2100,(getText (configfile >> "CfgVehicles" >> typeof _veh >> "textureSources" >> configName _x >> "displayName"))];
			_colorTextures pushback (getArray (configfile >> "CfgVehicles" >> typeof _veh >> "textureSources" >> configName _x >> "textures"));
		} foreach _colorConfigs;

		if (_apply AND lbCurSel 2100 > 0) then {

		{
		_index = (_colorTextures select (lbCurSel 2100)) find _x;
		_veh setObjectTextureGlobal [_index, (_colorTextures select (lbCurSel 2100)) select _index];
	} foreach (_colorTextures select (lbCurSel 2100));
	systemchat format ['%2: Changed color to %1.',(_colorNames select (lbCurSel 2100)),_vehDispName];
};
	playSound "Click";
};


};


GOM_fnc_aircraftLoadoutResourcesCheck = {

params ["_obj"];


	_refuelVehs = vehicles select {typeof _x isKindOf "All" AND {_x distance2d _obj <= 50} AND {speed _x < 1} AND {alive _x} AND {getNumber (configfile >> "CfgVehicles" >> typeof _x >> "transportFuel") > 0}};;
	_rearmVehs = vehicles select {typeof _x isKindOf "All" AND {_x distance2d _obj <= 50} AND {speed _x < 1} AND {alive _x} AND {getNumber (configfile >> "CfgVehicles" >> typeof _x >> "transportAmmo") > 0}};;
	_repairVehs = vehicles select {typeof _x isKindOf "All" AND {_x distance2d _obj <= 50} AND {speed _x < 1} AND {alive _x} AND {getNumber (configfile >> "CfgVehicles" >> typeof _x >> "transportRepair") > 0}};;
	_flags = [];

	if (GOM_fnc_aircraftLoadout_NeedsFuelSource) then {

	_flags set [0,count _refuelVehs > 0];

	} else {_flags set [0,!GOM_fnc_aircraftLoadout_NeedsFuelSource]};

	if (GOM_fnc_aircraftLoadout_NeedsAmmoSource) then {

		_flags set [2,count _rearmVehs > 0];

	} else {_flags set [2,!GOM_fnc_aircraftLoadout_NeedsAmmoSource]};

	if (GOM_fnc_aircraftLoadout_NeedsRepairSource) then {

		_flags set [1,count _repairVehs > 0];

	} else {_flags set [1,!GOM_fnc_aircraftLoadout_NeedsRepairSource]};

_flags params ["_canRefuel","_canRepair","_canRearm"];
_vehs = [_refuelVehs,_repairVehs,_rearmVehs];
{_x setAmmoCargo 0;_x setFuelCargo 0;_x setRepairCargo 0} foreach (_refuelvehs + _repairvehs + _rearmvehs);
_buttons = [1600,1602,1603,1604];
ctrlEnable [1600,_canRearm];
ctrlEnable [1602,_canRepair];
ctrlEnable [1603,_canRefuel];
ctrlEnable [1604,_canRearm];

[_flags,_vehs]

};

GOM_fnc_updatePresetLB = {

	params ["_obj"];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first."};
	_veh = _vehicles select lbcursel 1500;
	_presets = profileNamespace getVariable ["GOM_fnc_aircraftLoadoutPresets",[]];
	_validPresets = _presets select {_x select 0 isequalTo typeof _veh};
	lbClear 2101;
	{

		lbAdd [2101,_x select 1];

	} forEach _validPresets;

};

GOM_fnc_aircraftLoadoutSavePreset = {
	params ["_obj"];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first."};
	_veh = _vehicles select lbcursel 1500;
	_presets = profileNamespace getVariable ["GOM_fnc_aircraftLoadoutPresets",[]];
	_index = 0;
		_pylonOwners = _veh getVariable ["GOM_fnc_aircraftLoadoutPylonOwners",[]];

	_preset = [typeof _veh,ctrlText 1401,GetPylonMagazines _veh,((GetPylonMagazines _veh) apply {_index = _index + 1;_veh AmmoOnPylon _index}),[lbText [2100,lbCursel 2100],getObjectTextures _veh],_pylonOwners];

	if (!(_presets isEqualTo []) AND {count (_presets select {ctrlText 1401 isequalTo (_x select 1)}) > 0}) exitWith {systemchat "Preset exists! Chose another name!";playsound "Simulation_Fatal"};


	if (ctrlText 1401 isEqualTo "") exitWith {systemchat "Invalid name! Choose another one!";playSound "Simulation_Fatal"};
	_presets pushback _preset;
	profileNamespace setVariable ["GOM_fnc_aircraftLoadoutPresets",_presets];
			_vehDispName = getText (configfile >> "CfgVehicles" >> typeof _veh >> "displayName");

	systemchat format ["Saved %1 preset: %2!",_vehDispName,str ctrlText 1401];
	_updateLB = [_obj] call GOM_fnc_updatePresetLB;
	lbsetcursel [2101,((lbsize 2101) -1)];
	true
};

GOM_fnc_aircraftLoadoutDeletePreset = {

	params ["_obj"];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first."};
	_veh = _vehicles select lbcursel 1500;
	_presets = profileNamespace getVariable ["GOM_fnc_aircraftLoadoutPresets",[]];

	_toDelete = _presets select {(_x select 1) isEqualTo lbText [2101,lbcursel 2101]};
	if (count _toDelete isequalto 0)  exitWith {systemchat "Preset not found!";playsound "Simulation_Fatal"};
	_presets = _presets - [_toDelete select 0];
	profileNamespace setVariable ["GOM_fnc_aircraftLoadoutPresets",_presets];
		_vehDispName = getText (configfile >> "CfgVehicles" >> typeof _veh >> "displayName");

	Systemchat format ["Deleting %1 preset: %2",_vehDispName,str (_todelete select 0 select 1)];
	_updateLB = [_obj] call GOM_fnc_updatePresetLB;

};

GOM_fnc_aircraftLoadoutLoadPreset = {

	params ["_obj"];
	_vehicles = _obj getVariable ["GOM_fnc_setPylonLoadoutVehicles",[]];

	if (lbCursel 1500 < 0) exitWith {systemchat "Select an aircraft first."};
	if (lbCursel 2101 < 0) exitWith {systemchat "No preset selected."};
	_veh = _vehicles select lbcursel 1500;
	_presets = profileNamespace getVariable ["GOM_fnc_aircraftLoadoutPresets",[]];
	_preset = (_presets select {(_x select 0) isEqualTo typeOf _veh AND (_x select 1) isEqualTo lbText [2101,lbcursel 2101]}) select 0;
	_preset params ["_vehType","_presetName","_pylons","_pylonAmmoCounts","_textureParams"];
	[_obj,true,_pylons,_pylonAmmoCounts] call	GOM_fnc_setPylonsRearm;

	_textureParams params ["_textureName","_textures"];
	{

		_veh setObjectTextureGlobal [_foreachIndex,_x];

	} forEach _textures;


true
};

GOM_fnc_aircraftLoadout = {

	params ["_obj",["_pilot",""]];
	createdialog "GOM_dialog_aircraftLoadout";
	playSound "Click";

	_vehicles = vehicles select {typeof _x iskindof "Air" AND {_x distance2d _obj <= 50} AND {speed _x < 1} AND {alive _x}};

	if (_pilot isEqualTo "PILOT") then {_vehicles = [_obj]};

	_obj setVariable ["GOM_fnc_setPylonLoadoutVehicles",_vehicles];
	(finddisplay 66 displayctrl 1100) ctrlSetStructuredText parsetext "<t align='center'>Select an aircraft!";
	_resourceCheck = [_obj] call GOM_fnc_aircraftLoadoutResourcesCheck;
	lbclear 1500;
	lbclear 1501;
	lbclear 1502;




	{

		_dispName = gettext (configfile >> "CfgVehicles" >> typeof _x >> "displayName");
		_form = format ["%1",_dispName];
		lbAdd [1500,_form];

	} forEach _vehicles;

	lbadd [2100,"Livery"];
	lbSetCurSel [2100,0];


	_getvar = _obj call BIS_fnc_objectVar;
	finddisplay 66 displayCtrl 1500 ctrlAddEventHandler ["LBSelChanged",format ["[%1] call GOM_fnc_setPylonLoadoutLBPylonsUpdate; [%1] call GOM_fnc_updateDialog
;[%1] call GOM_fnc_aircraftLoadoutPaintjob;",_getvar]];
	finddisplay 66 displayCtrl 1501 ctrlAddEventHandler ["LBSelChanged",format ["[%1] call GOM_fnc_fillPylonsLB; [%1] call GOM_fnc_updateDialog
",_getvar]];
	finddisplay 66 displayCtrl 1502 ctrlAddEventHandler ["LBSelChanged",format ["[%1] call GOM_fnc_setPylonLoadoutLBMagazinesCountUpdate; [%1] call GOM_fnc_updateDialog
",_getvar]];

	finddisplay 66 displayCtrl 2100 ctrlAddEventHandler ["LBSelChanged",format ["[%1,true] call GOM_fnc_aircraftLoadoutPaintjob",_getvar]];
	finddisplay 66 displayCtrl 2101 ctrlAddEventHandler ["LBSelChanged",format ["[%1,true] call GOM_fnc_updateDialog",_getvar]];
	buttonSetAction [1600, format ["[%1] call GOM_fnc_pylonInstallWeapon",_getvar]];
	buttonSetAction [1601, format ["[%1] call GOM_fnc_clearAllPylons",_getvar]];
	buttonSetAction [1602, format ["[%1] call GOM_fnc_setPylonsRepair",_getvar]];
	buttonSetAction [1603, format ["[%1] call GOM_fnc_setPylonsRefuel",_getvar]];
	buttonSetAction [1604, format ["[%1] call GOM_fnc_setPylonsReArm",_getvar]];
	buttonSetAction [1605, format ["[%1] call GOM_fnc_setPylonOwner",_getvar]];
	buttonSetAction [1606, format ["[%1] call GOM_fnc_aircraftLoadoutSavePreset",_getvar]];
	buttonSetAction [1607, format ["[%1] call GOM_fnc_aircraftLoadoutDeletePreset",_getvar]];
	buttonSetAction [1608, format ["[%1] call GOM_fnc_aircraftLoadoutLoadPreset",_getvar]];

	findDisplay 66 displayAddEventHandler ["KeyDown",{if (_this select 3) then {ctrlEnable [1607,true];ctrlSetText [1607,"Delete"]};}];
	findDisplay 66 displayAddEventHandler ["KeyUp",{if (_this select 3) then {ctrlEnable [1607,false];ctrlSetText [1607,"CTRL"];};}];
	ctrlEnable [1607,false];
	ctrlSetText [1607,"CTRL"];

	findDisplay 66 displayCtrl 2800 ctrlAddEventHandler ["CheckedChanged",format ["[_this,%1] call GOM_fnc_CheckComponents",_getvar]];
	findDisplay 66 displayCtrl 2801 ctrlAddEventHandler ["CheckedChanged",format ["[_this,%1] call GOM_fnc_CheckComponents",_getvar]];
	findDisplay 66 displayCtrl 2802 ctrlAddEventHandler ["CheckedChanged",format ["[_this,%1] call GOM_fnc_CheckComponents",_getvar]];
	_color = [0,0,0,0.6];
	_dark = [1100,1103,1104,1105,1109,1101,1102,1103,1104,1105,1400,1401,1500,1501,1800,1801,1802,1803,1804,1805,1806,1807,1808,1809,2100,2101];
	{

		findDisplay 66 displayCtrl _x ctrlSetBackgroundColor _color;


	} forEach _dark;
	_check = [_obj] call GOM_fnc_updateDialog;
};

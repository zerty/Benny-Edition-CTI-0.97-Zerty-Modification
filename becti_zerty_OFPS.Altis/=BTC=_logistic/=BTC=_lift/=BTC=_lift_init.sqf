/*
Created by =BTC= Giallustio

Date: 20/03/2013
Visit us at: http://www.blacktemplars.altervista.org/
*/
waitUntil {!isNull player};
waitUntil {player == player};

_cond = true;
if ((count BTC_lift_pilot) > 0) then 
{
	if ((BTC_lift_pilot find (typeof player)) == - 1) exitWith {hint "No lift";_cond = false;};
};
if !(_cond) exitWith {hint "No lift";};
if (BTC_def_hud == 1) then 
{
	disableSerialization;
	cutRsc ["BTC_Hud","PLAIN"];
	_ui        = uiNamespace getVariable "HUD";
	_radar     = _ui displayCtrl 1001;
	_obj_img   = _ui displayCtrl 1002;
	_obj_pic   = _ui displayCtrl 1003;
	_arrow     = _ui displayCtrl 1004;
	_obj_name  = _ui displayCtrl 1005;
	_array_hud = [_radar,_obj_img,_obj_pic,_arrow,_obj_name];
	{_x ctrlShow false;} foreach _array_hud;
	BTC_arrow_up   = "=BTC=_Logistic\=BTC=_Lift\img\arrow_up_ca.paa";
	BTC_arrow_down = "=BTC=_Logistic\=BTC=_Lift\img\arrow_down_ca.paa";
	BTC_complete   = "=BTC=_Logistic\=BTC=_Lift\img\objective_complete_ca.paa";
	BTC_incomplete = "=BTC=_Logistic\=BTC=_Lift\img\objective_incomplete_ca.paa";
};
BTC_cargo      = ObjNull;
//Functions
/*ss83   BTC_lift_check =
{
	private ["_rel_pos"];
	if (!(vehicle player isKindOf "Helicopter") || BTC_lifted == 1) exitWith {false};
	_array = [vehicle player] call BTC_get_liftable_array;
	_chopper  = vehicle player;
	_can_lift = false;
	_cargo_array = nearestObjects [_chopper, _array, 50];
	if (count _cargo_array > 0) then {if (driver (_cargo_array select 0) == player) then {_cargo_array set [0,0];_cargo_array = _cargo_array - [0];};};
	if (count _cargo_array > 0) then {BTC_cargo = _cargo_array select 0;} else {BTC_cargo = objNull;_can_lift = false;};
	if (({BTC_cargo isKindOf _x} count _array) > 0 && speed BTC_cargo < 2) then {_can_lift = true;} else {_can_lift = false;};
	if (_can_lift && ((BTC_cargo isKindOf "Air" && getdammage BTC_cargo != 1) || (format ["%1", BTC_cargo getVariable "BTC_cannot_lift"] == "1"))) then {_can_lift = false;};
	if (!isNull BTC_cargo && _can_lift) then
	{
		_cargo_pos = getPosATL BTC_cargo;
		_rel_pos   = _chopper worldToModel _cargo_pos;
		BTC_cargo_x   = _rel_pos select 0;
		BTC_cargo_y   = _rel_pos select 1;
		BTC_cargo_z   = _rel_pos select 2;//hintSilent format ["%1 - %2 - %3",BTC_cargo_x,BTC_cargo_y,BTC_cargo_z];
	};
	if (((abs BTC_cargo_z) < BTC_lift_max_h) && ((abs BTC_cargo_z) > BTC_lift_min_h) && ((abs BTC_cargo_x) < BTC_lift_radius) && ((abs BTC_cargo_y) < BTC_lift_radius)) then
	{_can_lift = true;} else {_can_lift = false;};
	//hintSilent format ["%1 - %2", BTC_cargo,_cargo_array];
	_can_lift
};
  BTC_attach_cargo =
{
	private ["_cargo"];
	_chopper = vehicle player;
	_array = [vehicle player] call BTC_get_liftable_array;
	_cargo_array = nearestObjects [_chopper, _array, 50];
	if (count _cargo_array > 0 && driver (_cargo_array select 0) == player) then {_cargo_array set [0,0];_cargo_array = _cargo_array - [0];};
	if (count _cargo_array > 0) then {_cargo = _cargo_array select 0;} else {_cargo = objNull;};
	if (isNull _cargo) exitWith {};
	BTC_lifted    = 1;
	_cargo_pos    = getPosATL _cargo;
	_rel_pos      = _chopper worldToModel _cargo_pos;
	_height       = (_rel_pos select 2) + 2.5;
	_cargo attachTo [_chopper, [0,0,_height]];
	_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
	_chopper vehicleChat format ["%1 lifted", _name_cargo];
	BTC_cargo_lifted = _cargo;
};
BTC_detach_cargo =
{
	detach BTC_cargo_lifted;
	_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_lifted >> "displayName");
	vehicle player vehicleChat format ["%1 dropped", _name_cargo];
	if (BTC_cargo_lifted isKindOf "Strategic") then {_obj_fall = [BTC_cargo_lifted] spawn BTC_l_Obj_Fall;} else 
	{
		_vel = velocity (vehicle player);
		BTC_cargo_lifted setVelocity _vel;	
	};
	BTC_cargo_lifted = ObjNull;
	BTC_lifted = 0;
};
BTC_fnc_hud =
{
	private ["_can_lift"];
	disableSerialization;
	_ui        = uiNamespace getVariable "HUD";
	_radar     = _ui displayCtrl 1001;
	_obj_img   = _ui displayCtrl 1002;
	_obj_pic   = _ui displayCtrl 1003;
	_arrow     = _ui displayCtrl 1004;
	_obj_name  = _ui displayCtrl 1005;
	_array_hud = [_radar,_obj_img,_obj_pic,_arrow,_obj_name];
	{_x ctrlShow true;} foreach _array_hud;_obj_img ctrlShow false;
	_can_lift = false;
	while {(Alive player && vehicle player != player) && BTC_Hud_Cond} do
	{
		private ["_cargo"];
		_array = [vehicle player] call BTC_get_liftable_array;
		_cargo_array = nearestObjects [vehicle player, _array, 50];
		if (count _cargo_array > 0 && driver (_cargo_array select 0) == player) then {_cargo_array set [0,0];_cargo_array = _cargo_array - [0];};
		if (count _cargo_array > 0) then {_cargo = _cargo_array select 0;} else {_cargo = objNull;};
		if (({_cargo isKindOf _x} count _array) > 0) then {_can_lift = true;} else {_can_lift = false;};
		if (_can_lift && ((_cargo isKindOf "Air" && getdammage _cargo != 1) || !(isNil {_cargo getVariable "BTC_cannot_lift"}))) then {_can_lift = false;};
		if (!isNull _cargo) then
		{
			_cargo_pos = getPosATL _cargo;
			_rel_pos   = (vehicle player) worldToModel _cargo_pos;
			_cargo_x   = _rel_pos select 0;
			_cargo_y   = _rel_pos select 1;
			_cargo_z   = _rel_pos select 2;
			_obj_img ctrlShow true;
			_hud_x   = _cargo_x / 100;
			_hud_y   = 0;
			switch (true) do
			{
				case (_cargo_y < 0): {_hud_y = (abs _cargo_y) / 100};
				case (_cargo_y > 0): {_hud_y = (0 - _cargo_y) / 100};
			};
			_hud_x_1 = BTC_HUD_x + _hud_x;
			_hud_y_1 = BTC_HUD_y + _hud_y;
			_obj_img ctrlsetposition [_hud_x_1, _hud_y_1];
			_obj_img ctrlCommit 0;
			_pic_cargo = "";
			if (_cargo isKindOf "LandVehicle") then {_pic_cargo = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "picture");} else {_pic_cargo = "";};
			_name_cargo = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
			_obj_pic ctrlSetText _pic_cargo;
			_obj_name ctrlSetText _name_cargo;
			if ((abs _cargo_z) > BTC_lift_max_h) then {_arrow ctrlSetText BTC_arrow_down;};
			if ((abs _cargo_z) < BTC_lift_min_h) then {_arrow ctrlSetText BTC_arrow_up;};
			if ((abs _cargo_z) > BTC_lift_min_h && (abs _cargo_z) < BTC_lift_max_h) then {_arrow ctrlSetText BTC_complete;};
			if !(_can_lift) then {_arrow ctrlSetText BTC_incomplete;};
		} else {_obj_img ctrlShow false;_obj_pic ctrlSetText "";_obj_name ctrlSetText "";_arrow ctrlSetText "";};
		sleep 0.1;
	};
	{_x ctrlShow false;} foreach _array_hud;
};            */
BTC_l_camera =
{
	if (BTC_l_pip_cond) then 
	{
		BTC_l_pip_cond = false;
		[] call BIS_fnc_liveFeedTerminate;
	} 
	else 
	{
		hint "Activating camera...";
		BTC_l_pip_cond = true;
		BTC_l_feed_target = "Land_HelipadEmpty_F" createVehicle (position player);
		[] spawn {while {BTC_l_pip_cond} do {BTC_l_feed_target setpos [getPos (vehicle player) select 0,(getPos (vehicle player) select 1) + 1,0];sleep 0.1;};deleteVehicle BTC_l_feed_target;};
		[player, player, player] call BIS_fnc_liveFeed;
		waitUntil {!(isNil "BIS_liveFeed")};
		hintSilent "";
		BIS_liveFeed attachTo [vehicle player,[0, - 1, -3]];
		BTC_l_feed_target call BIS_fnc_liveFeedSetTarget;
		WaitUntil {sleep 1; (!(vehicle player isKindOf "Helicopter") || !Alive player)};
		if (BTC_l_pip_cond) then {BTC_l_pip_cond = false;[] call BIS_fnc_liveFeedTerminate;};
	};
};
[] spawn
{

	//ss83 if (BTC_def_hud == 1) then {player addAction [("<t color=""#ED2744"">" + ("Hud On\Off") + "</t>"),BTC_dir_action, [[],{if (BTC_Hud_Cond) then {BTC_Hud_Cond = false;} else {BTC_Hud_Cond = true;_hud = [] spawn BTC_fnc_hud;};}], -8, false, false, "", "(vehicle player) isKindOf ""Helicopter"" && driver (vehicle player) == player"];};
	if (BTC_def_pip == 1) then {player addAction [("<t color=""#ED2744"">" + ("Camera On\Off") + "</t>"),BTC_dir_action, [[],BTC_l_camera], -9, false, false, "", "typeOf (vehicle player) in BTC_l_def_veh_pip"];};
	//SS83 don't need it player addAction [("<t color=""#ED2744"">" + ("Lift") + "</t>"),BTC_dir_action, [[],BTC_attach_cargo], 9, true, false, "", "[] call BTC_lift_check"];
	//SS83 don't need this player addAction [("<t color=""#ED2744"">" + ("Release") + "</t>"),BTC_dir_action, [[],BTC_detach_cargo], -9, true, false, "", "BTC_lifted == 1"];
	player addEventHandler ["Respawn", 
	{
		[] spawn 
		{
			WaitUntil {sleep 1; Alive player};
			BTC_l_pip_cond = false;
			BTC_cargo    = ObjNull;
			BTC_Hud_Cond = false;
			BTC_lifted   = 0;
			//ss83 if (BTC_def_hud == 1) then {player addAction [("<t color=""#ED2744"">" + ("Hud On\Off") + "</t>"),BTC_dir_action, [[],{if (BTC_Hud_Cond) then {BTC_Hud_Cond = false;} else {BTC_Hud_Cond = true;_hud = [] spawn BTC_fnc_hud;};}], -8, false, false, "", "(vehicle player) isKindOf ""Helicopter"" && driver (vehicle player) == player"];};
			if (BTC_def_pip == 1) then {player addAction [("<t color=""#ED2744"">" + ("Camera On\Off") + "</t>"),BTC_dir_action, [[],BTC_l_camera], -9, false, false, "", "typeOf (vehicle player) in BTC_l_def_veh_pip"];};
			//SS83 don't need this player addAction [("<t color=""#ED2744"">" + ("Lift") + "</t>"),BTC_dir_action, [[],BTC_attach_cargo], 9, true, false, "", "[] call BTC_lift_check"];
			//SS83 don't need this  player addAction [("<t color=""#ED2744"">" + ("Release") + "</t>"),BTC_dir_action, [[],BTC_detach_cargo], -9, true, false, "", "BTC_lifted == 1"];
		};
	}];
};
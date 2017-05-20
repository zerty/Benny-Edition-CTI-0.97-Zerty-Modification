/*
Created by =BTC= Giallustio

Date: 20/03/2013
Visit us at: http://www.blacktemplars.altervista.org/
*/
//Cargo system
/* ss83         BTC_l_check_vehicle =
{
	//Open dlg
	_veh = objNull;_array = [];
	if (vehicle player == player) then {_array = nearestObjects [player, BTC_def_vehicles, 5];} else {_array = [vehicle player];};
	if (count _array > 0) then {_veh = _array select 0;};
	if (!isNull _veh) then
	{
		//if (!isNil {_veh getVariable "BTC_cargo_cont"}) then
		if (isNil {_veh getVariable "BTC_cargo_cont"}) then {_veh setVariable ["BTC_cargo_cont",[],false];};
		private ["_cargo"];
		_text = "";
		_cargo = _veh getVariable "BTC_cargo_cont";
		_text = _text + "Vehicle: " + getText (configFile >> "cfgVehicles" >> typeof _veh >> "displayName") + format ["<br/>CC: %1/%2",[_veh] call BTC_check_cc,[_veh] call BTC_get_cc] + "<br/>Cargo:<br/>";
		if (count _cargo > 0) then
		{
			{
				_text = _text + getText (configFile >> "cfgVehicles" >> typeof _x >> "displayName") + format [" [%1]",[_x] call BTC_get_rc] + "<br/>";
				[_x,_veh] spawn 
				{
					_obj = _this select 0;
					_veh = _this select 1;
					private ["_sleep"];
					//player sideChat format ["%1",_obj];
					_unload = _veh addaction [("<t color=""#ffcc00"">") + (format ["UnLoad %1",getText (configFile >> "cfgVehicles" >> typeof _obj >> "displayName")]) + "</t>",BTC_dir_action,[[_veh,_obj],BTC_l_unload],7,true,false,"","true"];
					_sleep = time + 15;
					waitUntil {BTC_action_cargo || (time > _sleep)};
					_veh removeAction _unload;
				};
			} foreach _cargo;
			hint parseText _text;
		} else {_text = _text + "Empty";hint parseText _text;};
	};
};
BTC_l_select =
{
	_array = nearestObjects [player, BTC_def_cargo, 5];
	if (count _array > 0) then 
	{
		BTC_cargo_selected = _array select 0;
		if (format ["%1", BTC_cargo_selected getVariable "BTC_cannot_load"] == "1") then 
		{hint "You can not load this object";BTC_cargo_selected = objNull;} else {hint parseText format ["%1 selected<br/>CR: %2",getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_selected >> "displayName"),[BTC_cargo_selected] call BTC_get_rc];};
	};
};
BTC_l_load =
{
	private ["_array","_veh_name","_obj_name"];
	_veh = objNull;_cargo_cont = [];_cond = true;
	if (count _this == 0) then {_array = nearestObjects [player, BTC_def_vehicles, 5];} else {_array = _this;};
	if (count _array > 0) then {_veh = _array select 0;} else {hint "Get closer";};
	if (!isNull _veh) then
	{
		_veh_name = getText (configFile >> "cfgVehicles" >> typeof _veh >> "displayName");
		_obj_name = getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_selected >> "displayName");
		if (([_veh] call BTC_check_cc) + ([BTC_cargo_selected] call BTC_get_rc) > ([_veh] call BTC_get_cc)) then {_cond = false;};
		if (BTC_cargo_selected distance _veh < 15 && speed _veh < 2 && _cond) then
		{
			hint format ["Loading %1 in %2",_obj_name,_veh_name];BTC_l_dragging = false;
			sleep 3;
			if (Alive BTC_cargo_selected && Alive _veh && BTC_cargo_selected distance _veh < 15 && speed _veh <= 2 && speed _veh >= -2) then
			{
				if (isNil {_veh getVariable "BTC_cargo_cont"}) then {_veh setVariable ["BTC_cargo_cont",[],false];};
				_cargo_cont = _veh getVariable "BTC_cargo_cont";
				_cargo_cont = _cargo_cont + [BTC_cargo_selected];
				_veh setVariable ["BTC_cargo_cont",_cargo_cont,true];
				BTC_cargo_selected attachTo [BTC_cargo_repo,[0,0,BTC_id_repo]];
				BTC_id_repo = BTC_id_repo + 15;publicVariable "BTC_id_repo";
				BTC_cargo_selected = objNull;
				hint format ["%1 has been loaded in %2",_obj_name,_veh_name];
			} else {hint format ["%1 has not been loaded",_obj_name];};
		} else {if (!_cond) then {hint "There is no enough space in the cargo!";} else {hint "The object is too far from the vehicle or the vehicle is moving!";};};
	};
};
BTC_l_unload =
{
	_veh = _this select 0;
	_obj = _this select 1;
	BTC_action_cargo = true;
	_cargo_cont = _veh getVariable "BTC_cargo_cont";
	_id = _cargo_cont find _obj;
	if (_id != -1) then
	{
		_veh_name = getText (configFile >> "cfgVehicles" >> typeof _veh >> "displayName");
		_obj_name = getText (configFile >> "cfgVehicles" >> typeof _obj >> "displayName");
		hint format ["Unloading %1 from %2",_obj_name,_veh_name];
		sleep 3;
		hint format ["%1 has been unloaded",_obj_name,_veh_name];
		_cargo_cont set [_id,0];
		_cargo_cont = _cargo_cont - [0];
		_veh setVariable ["BTC_cargo_cont",_cargo_cont,true];
		_height = getPos (vehicle player) select 2;
		deTach _obj;
		_obj setVelocity [0,0,0];
		_obj setpos (_veh modelToWorld [-3,0,0]);
		switch (true) do
		{
			case (_height >= 20):
			{
				_obj_para = [_veh,_obj,"B_Parachute_02_F"] spawn BTC_l_paradrop;
			};
			case ((_height < 20) && (_height >= 2)):
			{
				_obj setPos [getpos _veh select 0,getpos _veh select 1,(getpos _veh select 2) -1];
				sleep 0.1;
				if (_obj isKindOf "Strategic") then {_obj_fall = [_obj] spawn BTC_l_obj_fall;};
			};
			case (_height < 2):
			{
				_obj setpos (_veh modelToWorld [-3,0,0]);
			};
		};
	};
	sleep 1;
	BTC_action_cargo = false;
};               */
BTC_l_release =
{
	BTC_l_dragging = false;
};
BTC_l_drag =
{
	private ["_drag","_veh"];
	_array = nearestObjects [player, BTC_def_drag, 5];
	if (count _array > 0) then {_drag = _array select 0;};
	if (isNull _drag) exitWith {};
	if (format ["%1", _drag getVariable "BTC_cannot_drag"] == "1") exitWith {hint "You can't drag this object!";};
	if (_drag distance player > 4) exitWith {hint "Too distant from the object!";};
	if (BTC_l_dragging) exitWith {hint "You can't drag more than one object!";};
	if (format ["%1", _drag getVariable "BTC_being_drag"] == "1") exitWith {hint "You can't drag this object! It's being dragged!";};
	BTC_l_dragging = true;
	_drag setvariable ["BTC_Being_Drag",1,true];
	BTC_display_EH_l = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 45) then {_anim = [] spawn {sleep 0.01;player switchMove ""acinpknlmstpsraswrfldnon"";};};"];			
	player playMove "acinpknlmstpsraswrfldnon";
	_drag attachto [player,[0,2,0.2]];
	sleep 0.1;
	if ((position _drag select 2) < - 0.5) then {_drag attachto [player,[0,1,1.2]];};
	_release = player addaction [("<t color=""#00FF00"">") + ("Release Object") + "</t>",BTC_dir_action,[[],BTC_l_release],99,true,false,"","true"];  //ss83 increased priority
	WaitUntil {!Alive player || ((animationstate player == "acinpknlmstpsraswrfldnon") || (animationstate player == "acinpknlmwlksraswrfldb"))};
	_act  = 0;
	While {BTC_l_dragging && vehicle player == player && Alive player && ((animationstate player == "acinpknlmstpsraswrfldnon") || (animationstate player == "acinpknlmwlksraswrfldb"))} do
	{
		/*_array = nearestObjects [player, BTC_def_vehicles, 5];
		if (count _array == 0) then {_veh = objNull;};
		if (count _array > 0 && _veh != _array select 0) then 
		{
			_veh = _array select 0;
			_name_veh        = getText (configFile >> "cfgVehicles" >> typeof _veh >> "displayName");
			_text_action     = ("<t color=""#ED2744"">" + "Load in " + (_name_veh) + "</t>");
			_load = player addAction [_text_action,BTC_dir_action, [[_veh],BTC_l_load], 7, true, true];
			_act  = 1;
		};
		if (count _array == 0 && _act == 1) then {player removeAction _load;_act = 0;};*/
		sleep 0.1;
	};
	player playMoveNow "AmovPknlMstpSrasWrflDnon";BTC_l_dragging = false;
	player removeAction _release;//player removeAction _load;
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",BTC_display_EH_l];
	if !(isNull _drag) then 
	{
		detach _drag;
		//_rel_pos = player modelToWorld [0,1,0];
		//BTC_cargo_selected setpos _rel_pos;
		_drag setvariable ["BTC_Being_Drag",0,true];
	};
};
BTC_get_cc =
{
	private ["_n","_array_class"];
	_obj  = _this select 0;
	_type = typeOf _obj;
	_cc   = 0;_cond = false;
	for "_i" from 0 to (count BTC_def_cc - 1) do 
	{
		if (typeName (BTC_def_cc select _i) == "STRING" && !_cond) then
		{
			if (!_cond && _type == (BTC_def_cc select _i)) then {_cc = (BTC_def_cc select (_i + 1));_cond = true;};
		};
	};
	if (!_cond) then 
	{
		for "_i" from 0 to (count BTC_main_cc - 1) do 
		{
			if (typeName (BTC_main_cc select _i) == "STRING") then
			{
				if (!_cond && _type isKindOf (BTC_main_cc select _i)) then {_cc = (BTC_main_cc select (_i + 1));_cond = true;};
			};
		};
	};
	_cc
};
BTC_get_rc =
{
	private ["_n","_array_class"];
	_obj  = _this select 0;
	_type = typeOf _obj;
	_rc   = 0;_cond = false;
	for "_i" from 0 to (count BTC_def_rc - 1) do 
	{
		if (typeName (BTC_def_rc select _i) == "STRING" && !_cond) then
		{
			if (!_cond && _type == (BTC_def_rc select _i)) then {_rc = (BTC_def_rc select (_i + 1));_cond = true;};
		};
	};
	if (!_cond) then 
	{
		for "_i" from 0 to (count BTC_main_rc - 1) do 
		{
			if (typeName (BTC_main_rc select _i) == "STRING" && !_cond) then
			{
				if (!_cond && _type isKindOf (BTC_main_rc select _i)) then {_rc = (BTC_main_rc select (_i + 1));_cond = true;};
			};
		};
	};
	_rc
};
BTC_check_cc =
{
	private ["_n","_array_class","_cargo"];
	_veh  = _this select 0;
	if (isNil {_veh getVariable "BTC_cargo_cont"}) then {_veh setVariable ["BTC_cargo_cont",[],false];};
	_cargo = _veh getVariable "BTC_cargo_cont";
	_tot_rc   = 0;
	{_tot_rc = _tot_rc + ([_x] call BTC_get_rc);} foreach _cargo;
	_tot_rc
};
//Placement
/* ss83    BTC_l_placement =
{
	private ["_plac","_veh","_array"];
	_array = nearestObjects [player, BTC_def_placement, 5];
	if (count _array > 0) then {_plac = _array select 0;};
	if (isNull _plac) exitWith {};
	if (format ["%1", _plac getVariable "BTC_cannot_place"] == "1") exitWith {hint "You can't place this object!";};
	BTC_l_plac_obj = _plac;
	BTC_l_camera = objNull;
	BTC_l_end = false;
	BTC_l_camera_placement = false;
	BTC_l_camera_created = false;
	BTC_l_camera_nvg = false;
	BTC_l_camera_EH_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_keydown = _this spawn BTC_l_keydown"];
	BTC_l_central_pos = getposATL BTC_l_plac_obj;
	BTC_cam_rel_pos = [0,-6,15];
	BTC_l_plac_obj enableSimulation false;
	BTC_l_actions_cond = false;
	while {!BTC_l_end && Alive player} do
	{
		if (!BTC_l_camera_placement) then {player playMoveNow "amovpercmstpsraswrfldnon";};
		if (BTC_l_camera_placement && !BTC_l_camera_created) then {_cam = [BTC_l_plac_obj] spawn BTC_l_create_camera;};
		if (!BTC_l_camera_placement && BTC_l_camera_created) then {_cam = [BTC_l_plac_obj] spawn BTC_l_destroy_camera;};
		if (BTC_l_camera_nvg) then {camusenvg true;} else {camusenvg false;};
		BTC_l_camera camSetPos (BTC_l_plac_obj modelToWorld BTC_cam_rel_pos);
		BTC_l_camera camCommit 0;
		hintSilent parseText "Keys:<br/>W to move the object towards Nord<br/>A to move the object towards West<br/>S to move the object towards South<br/>D to move the object towards East<br/>Q and Z to modify the elevation<br/>ALT + A/D to modify the direction<br/>C to open/close the camera<br/>CTRL + WASDQZ to move the camera<br/>N to use the nightvision<br/>Back to get back to the game";
		sleep 0.01;
	};
	BTC_l_actions_cond = true;
	BTC_l_plac_obj enableSimulation true;
	BTC_l_plac_obj = objNull;
	hintSilent "";titleText ["", "PLAIN"];
	if (BTC_l_camera_placement) then {_cam = [BTC_l_plac_obj] spawn BTC_l_destroy_camera;};
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",BTC_l_camera_EH_keydown];
};
BTC_l_create_camera =
{
	_obj = _this select 0;
	BTC_l_camera = "camera" camCreate (position _obj);
	BTC_l_camera camSetTarget _obj;
	BTC_l_camera cameraEffect ["internal", "BACK"];
	BTC_l_camera camSetPos (_obj modelToWorld [0,-6,15]);
	BTC_l_camera camCommit 0;
	showCinemaBorder false;
	BTC_l_camera_created = true;
};
BTC_l_destroy_camera =
{
	player cameraEffect ["TERMINATE", "BACK"];
	camDestroy BTC_l_camera;	
	BTC_l_camera = objNull;
	BTC_l_camera_placement = false;
	BTC_l_camera_created = false;
	BTC_l_camera_nvg = false;
};
BTC_l_keydown =
{
	private ["_key","_dir"];
	if (count _this > 1) then
	{
		_key  = _this select 1;
		_ctrl = _this select 3;
		_alt  = _this select 4;
		//player globalchat format ["%1 - %2",_key,_this];
		switch (true) do
		{
			case (_key == 14) : {BTC_l_end = true;};
			case (_key == 30 && !_alt && !_ctrl) : {BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0) - 0.1,(getpos BTC_l_plac_obj select 1),(getposATL BTC_l_plac_obj select 2)];if ([BTC_l_central_pos,BTC_l_plac_obj] call BIS_fnc_distance2D > BTC_l_placement_area) then {player sideChat "Out of the placement zone!";BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0) + 0.1,(getpos BTC_l_plac_obj select 1),(getposATL BTC_l_plac_obj select 2)];};};
			case (_key == 32 && !_alt && !_ctrl) : {BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0) + 0.1,(getpos BTC_l_plac_obj select 1),(getposATL BTC_l_plac_obj select 2)];if ([BTC_l_central_pos,BTC_l_plac_obj] call BIS_fnc_distance2D > BTC_l_placement_area) then {player sideChat "Out of the placement zone!";BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0) - 0.1,(getpos BTC_l_plac_obj select 1),(getposATL BTC_l_plac_obj select 2)];};};
			case (_key == 31 && !_ctrl) : {BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0),(getpos BTC_l_plac_obj select 1) - 0.1,(getposATL BTC_l_plac_obj select 2)];if ([BTC_l_central_pos,BTC_l_plac_obj] call BIS_fnc_distance2D > BTC_l_placement_area) then {player sideChat "Out of the placement zone!";BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0),(getpos BTC_l_plac_obj select 1) + 0.1,(getposATL BTC_l_plac_obj select 2)];};};
			case (_key == 17 && !_ctrl) : {BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0),(getpos BTC_l_plac_obj select 1) + 0.1,(getposATL BTC_l_plac_obj select 2)];if ([BTC_l_central_pos,BTC_l_plac_obj] call BIS_fnc_distance2D > BTC_l_placement_area) then {player sideChat "Out of the placement zone!";BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0),(getpos BTC_l_plac_obj select 1) - 0.1,(getposATL BTC_l_plac_obj select 2)];};};
			case (_key == 44 && !_ctrl) : {BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0),(getpos BTC_l_plac_obj select 1),(getposATL BTC_l_plac_obj select 2) - 0.1];if (abs (((BTC_l_central_pos) select 2) - ((getposATL BTC_l_plac_obj) select 2)) > BTC_l_placement_area) then {BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0),(getpos BTC_l_plac_obj select 1),(getposATL BTC_l_plac_obj select 2) + 0.1];};};
			case (_key == 16 && !_ctrl) : {BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0),(getpos BTC_l_plac_obj select 1),(getposATL BTC_l_plac_obj select 2) + 0.1];if (abs (((BTC_l_central_pos) select 2) - ((getposATL BTC_l_plac_obj) select 2)) > BTC_l_placement_area) then {BTC_l_plac_obj setpos [(getpos BTC_l_plac_obj select 0),(getpos BTC_l_plac_obj select 1),(getposATL BTC_l_plac_obj select 2) - 0.1];};};
			case (_key == 30 && _alt && !_ctrl) : {_dir = getdir BTC_l_plac_obj;BTC_l_plac_obj setDir (_dir - 1);};
			case (_key == 32 && _alt && !_ctrl) : {_dir = getdir BTC_l_plac_obj;BTC_l_plac_obj setDir (_dir + 1);};
			case (_key == 46) : {if (BTC_l_camera_placement) then {BTC_l_camera_placement = false;} else {BTC_l_camera_placement = true;};};
			case (_key == 49) : {if (BTC_l_camera_nvg) then {BTC_l_camera_nvg = false;} else {BTC_l_camera_nvg = true;};};	
			
			case (BTC_l_camera_placement && _key == 30 && _ctrl) : {private ["_n"];_n = (BTC_cam_rel_pos select 0) - 0.5;if !((abs _n) > BTC_l_placement_area) then {BTC_cam_rel_pos = [_n,BTC_cam_rel_pos select 1,BTC_cam_rel_pos select 2];};};
			case (BTC_l_camera_placement && _key == 32 && _ctrl) : {private ["_n"];_n = (BTC_cam_rel_pos select 0) + 0.5;if !((abs _n) > BTC_l_placement_area) then {BTC_cam_rel_pos = [_n,BTC_cam_rel_pos select 1,BTC_cam_rel_pos select 2];};};
			case (BTC_l_camera_placement && _key == 31 && _ctrl) : {private ["_n"];_n = (BTC_cam_rel_pos select 1) - 0.5;if !((abs _n) > BTC_l_placement_area) then {BTC_cam_rel_pos = [BTC_cam_rel_pos select 0,_n,BTC_cam_rel_pos select 2];};};
			case (BTC_l_camera_placement && _key == 17 && _ctrl) : {private ["_n"];_n = (BTC_cam_rel_pos select 1) + 0.5;if !((abs _n) > BTC_l_placement_area) then {BTC_cam_rel_pos = [BTC_cam_rel_pos select 0,_n,BTC_cam_rel_pos select 2];};};
			case (BTC_l_camera_placement && _key == 44 && _ctrl) : {private ["_n"];_n = (BTC_cam_rel_pos select 2) - 0.5;if !((abs _n) > BTC_l_placement_area) then {BTC_cam_rel_pos = [BTC_cam_rel_pos select 0,BTC_cam_rel_pos select 1,_n];};};
			case (BTC_l_camera_placement && _key == 16 && _ctrl) : {private ["_n"];_n = (BTC_cam_rel_pos select 2) + 0.5;if !((abs _n) > BTC_l_placement_area) then {BTC_cam_rel_pos = [BTC_cam_rel_pos select 0,BTC_cam_rel_pos select 1,_n];};};
		};
	};
};   */
CTI_P_Repairing = false;
_respawn_reset={
	while {!CTI_GameOver} do {
		waitUntil {! (isNull player)&& ( alive player)};
		CTI_P_Repairing = false;
		waitUntil {! (alive player)}
	};
};

SM_repair_vehicle={
	_target = _this select 0;
	_caller = _this select 1;
	//[_target,_caller] call CTI_PVF_Request_Locality;

	_d=0;
	_count=count ("_d=_d+(_target getHitPointDamage (configName _x)); true" configClasses (configfile >> "CfgVehicles" >> (typeof _target) >> "HitPoints"));
	if (! isNil {_target getHitPointDamage "HitGun"}) then {_d=_d+(_target getHitPointDamage "HitGun");_count=_count+1;};
	if (! isNil {_target getHitPointDamage "HitTurret"}) then {_d=_d+(_target getHitPointDamage "HitTurret");_count=_count+1;};

	_rk = ({_x == "Toolkit"} count (backpackItems _caller)) +({_x == "Toolkit"} count (vestItems _caller));
	if (_rk > 0) then {
		CTI_P_Repairing = true ;
		_pos = getPos _caller;
		_caller switchMove "AinvPknlMstpSnonWrflDnon_medic4";
		["Starting Repairs",0,7,1] call HUD_PBar_start;
		_stime=time+7;
		while {alive _caller && alive _target  && (getdammage _target) > 0 && (_caller distance _target) <5 && (_caller distance _pos)<=1 && (vehicle _caller) ==_caller && time < _stime } do {
			(_stime - time) call HUD_PBar_update;
			sleep 1;
		};
		if ((_caller distance _target) >5 || (_caller distance _pos)>1 || !((vehicle _caller) ==_caller)) exitWith {_caller switchMove ""; hint "Failed";CTI_P_Repairing = false ;0 call HUD_PBar_stop;};
		_target setDammage (_d/_count);
		["Repairing",0,1,0] call HUD_PBar_start;
		while {alive _caller && alive _target  && (getDammage _target) > 0 && (_caller distance _target) <5 && (_caller distance _pos)<=1 && (vehicle _caller) ==_caller} do {
			sleep 1;
			/*"if ((_target getHitPointDamage (configName _x))>0) then {_target setHitPointDamage [(configName _x),(_target getHitPointDamage (configName _x))-0.007]} else {_target setHitPointDamage [(configName _x),0]}; true" configClasses (configfile >> "CfgVehicles" >> (typeof _target) >> "HitPoints");
			if (! isNil {_target getHitPointDamage "HitGun"}) then {if ((_target getHitPointDamage ("HitGun"))>0) then {_target setHitPointDamage ["HitGun",(_target getHitPointDamage "HitGun")-0.007]} else {_target setHitPointDamage ["HitGun",0]};};
			if (! isNil {_target getHitPointDamage "HitTurret"}) then {if ((_target getHitPointDamage ("HitTurret"))>0) then {_target setHitPointDamage ["HitTurret",(_target getHitPointDamage "HitGun")-0.007]} else {_target setHitPointDamage ["HitTurret",0]};};
			_d=0;
			"_d=_d+(_target getHitPointDamage (configName _x)); true" configClasses (configfile >> "CfgVehicles" >> (typeof _target) >> "HitPoints");
			if (! isNil {_target getHitPointDamage "HitGun"}) then {_d=_d+(_target getHitPointDamage "HitGun")};
			if (! isNil {_target getHitPointDamage "HitTurret"}) then {_d=_d+(_target getHitPointDamage "HitTurret")};
			*/
			(1-(getDammage _target)) call HUD_PBar_update;
			_target setDammage (getDammage _target) - 0.005;
		};
		if ((_caller distance _target) >5 || (_caller distance _pos)>1 || !((vehicle _caller) ==_caller)) exitWith {_caller switchMove ""; hint "Failed";CTI_P_Repairing = false ;0 call HUD_PBar_stop;};
		_caller switchMove "";
		//if (_d <= 0 && getDammage _target > 0.001) then {_target setDammage (0) };
		CTI_P_Repairing = false ;
		0 call HUD_PBar_stop;
	} else {
		hint parseText "<t size='1.3' color='#2394ef'>You need a ToolKit to perform this action</t>";
		sleep 5;
		hintsilent "";
	};
};

SM_Force_entry={
	_target = _this select 0;
	_caller = _this select 1;
	_rk=1;
	_rk = {_x == "Toolkit"} count (backpackItems _caller) +{_x == "Toolkit"} count (vestItems _caller);
	if ((_target getVariable "forced") ) exitWith { hint "This vehicle has already been forced";};
	_pos = getPos _caller;
	if (_rk > 0 ) then {
		_lock=1;
		CTI_P_Repairing = true ;
		_caller switchMove "AinvPknlMstpSnonWrflDnon_medic4";
		["Forcing vehicle lock",0,1,1] call HUD_PBar_start;
		while {_lock >0  && (_caller distance _target) <5 && (_caller distance _pos)<0.5 && (vehicle _caller) ==_caller} do
		{
				_lock=_lock-0.02;
				_percent=(1-_lock)*100;
				(_lock) call HUD_PBar_update;
		    //hint parseText format ["<t size='1.3' color='#2394ef'>Forcing Lock : %1 percent</t>",ceil (_percent)];
		    sleep 1;
		};
		if ((_caller distance _target) >5 || (_caller distance _pos)>0.5 || !((vehicle _caller) ==_caller)) exitWith { _caller switchMove ""; hint "Failed";CTI_P_Repairing = false ;0 call HUD_PBar_stop;};
		_target	setOwner (owner player);
		sleep 0.1;
		_caller switchMove "";
		_target lock 0;


		{
			_x action [ "eject", _target];
		} forEach crew _target;
		_target setVariable ["forced",false];
		if ( !(_target getVariable "forced") ) then {
			_target addAction ["<t color='#86F078'>Unlock</t>","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player && alive _target && locked _target == 2'];
			_target addAction ["<t color='#86F078'>Lock</t>","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player && alive _target && locked _target == 0'];
			_target setVariable ["v_keys",[getPlayerUID player,group player],true];
		};
		0 call HUD_PBar_stop;
		CTI_P_Repairing = false ;

	} else {
		hint parseText "<t size='1.3' color='#2394ef'>You need a ToolKit to perform this action</t>";
		sleep 5;
		hintsilent "";
	};
};
0 spawn _respawn_reset;
/*while {!CTI_GameOver} do {

	_vehicles=  (player nearEntities [["Car","Tank","Air","Ship"], 150]);
	{
			_hqs=[];
			{_hqs set [count _hqs, _x call CTI_CO_FNC_GetSideHQ];true} count [east,west];
			_prevent=false;
			if (_x getVariable "SM_Repairable") then { _prevent =true};
			if (! _prevent) then {
			//diag_log format ["adding repair for %1",_x];
			_x addAction ["<t color='#CC2222'>Repair Vehicle</t>",SM_repair_vehicle, [], 98, false, true,'', '!CTI_P_PreBuilding && ((getDammage _target) >0  ) && alive _target && vehicle _this == _this && ! CTI_P_Repairing'];
			//_x addAction ["<t color='#CC2222'>Force Lock</t>",SM_Force_entry, [], 98, false, true,'', ''];
			if !(_x in _hqs ) then { _x addAction ["<t color='#CC2222'>Force Lock</t>",SM_Force_entry, [], 98, false, true,'', '!CTI_P_PreBuilding  && alive _target && vehicle _this == _this && ! CTI_P_Repairing && !(_target getVariable ["cti_occupant",civilian] == CTI_P_SideJoined)']};
			 //_x addAction ["<t color='#CC2222'>Force Lock</t>",SM_Force_entry, [], 98, false, true,'', '!CTI_P_PreBuilding  && alive _target && vehicle _this == _this && ! CTI_P_Repairing '];
						//diag_log _rs;

				_x setVariable ["SM_Repairable",true,false];
			};
	} forEach _vehicles;
	sleep 20;
};
*/
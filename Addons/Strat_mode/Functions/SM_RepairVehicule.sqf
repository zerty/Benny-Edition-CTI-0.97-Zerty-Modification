CTI_P_Repairing = false;

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
		[localize "STR_StartingRepairsVehicle",0,7,1] call HUD_PBar_start;
		_stime=time+7;
		while {alive _caller && alive _target  && (getdammage _target) > 0 && (_caller distance _target) <5 && (_caller distance _pos)<=1 && (vehicle _caller) ==_caller && time < _stime } do {
			(_stime - time) call HUD_PBar_update;
			sleep 1;
		};
		if ((_caller distance _target) >5 || (_caller distance _pos)>1 || !((vehicle _caller) ==_caller)) exitWith {_caller switchMove ""; hint localize "STR_SM_RepairVehicule_Failed";CTI_P_Repairing = false ;0 call HUD_PBar_stop;};
		_target setDammage (_d/_count);
		[localize "STR_RepairingVehicle",0,1,0] call HUD_PBar_start;
		while {alive _caller && alive _target  && (getDammage _target) > 0 && (_caller distance _target) <5 && (_caller distance _pos)<=1 && (vehicle _caller) ==_caller} do {
			sleep 1;

			(1-(getDammage _target)) call HUD_PBar_update;
			_target setDammage (getDammage _target) - 0.005;
		};
		if ((_caller distance _target) >5 || (_caller distance _pos)>1 || !((vehicle _caller) ==_caller)) exitWith {_caller switchMove ""; hint localize "STR_SM_RepairVehicule_Failed";CTI_P_Repairing = false ;0 call HUD_PBar_stop;};
		_caller switchMove "";
		//if (_d <= 0 && getDammage _target > 0.001) then {_target setDammage (0) };
		CTI_P_Repairing = false ;
		0 call HUD_PBar_stop;
	} else {
		hint parseText localize "STR_RepairVehicle";
		sleep 5;
		hintsilent "";
	};
};

SM_Force_entry={
	_target = _this select 0;
	_caller = _this select 1;
	_rk=1;
	_rk = ({_x == "Toolkit"} count (backpackItems _caller)) +({_x == "Toolkit"} count (vestItems _caller));
	if ((_target getVariable ["forced",false]) ) exitWith { hintSilent localize "STR_ForcedVehicle";};
	_pos = getPos _caller;
	if (_rk > 0 ) then {
		_lock=1;
		CTI_P_Repairing = true ;
		_caller switchMove "AinvPknlMstpSnonWrflDnon_medic4";
		[localize "STR_ForcedVehicleLock",0,1,1] call HUD_PBar_start;
		while {_lock >0  && (_caller distance _target) <5 && (_caller distance _pos)<0.5 && alive _caller && (vehicle _caller) ==_caller && !(_target getVariable ["forced",false])} do
		{
				_lock=_lock-0.02;
				_percent=(1-_lock)*100;
				(_lock) call HUD_PBar_update;
		    //hint parseText format ["<t size='1.3' color='#2394ef'>Forcing Lock : %1 percent</t>",ceil (_percent)];
		    sleep 1;
		};
		if ((_caller distance _target) >5 || (_caller distance _pos)>0.5 || !((vehicle _caller) ==_caller) || (_target getVariable ["forced",false] || ! alive _caller)) exitWith {
			_caller switchMove "";
			hint localize "STR_SM_RepairVehicule_Failed";
			CTI_P_Repairing = false ;
			0 call HUD_PBar_stop;
		};


		["SERVER", "Request_Locality", [_target,player]] call CTI_CO_FNC_NetSend;
		sleep 0.1;
		_caller switchMove "";
		if (local _target ) then {_target lock 0;};


		{
			_x action [ "eject", _target];
		} forEach crew _target;

		_target addAction [localize "STR_Action_Unlock","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player && alive _target && locked _target == 2'];
		_target addAction [localize "STR_Action_Lock","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player && alive _target && locked _target == 0'];
		_target setVariable ["v_keys",[getPlayerUID player,group player],true];
		_target setVariable ["forced",true,true];

		0 call HUD_PBar_stop;
		CTI_P_Repairing = false ;

	} else {
		hint parseText localize "STR_RepairVehicle";
		sleep 5;
		hintsilent "";
	};
};

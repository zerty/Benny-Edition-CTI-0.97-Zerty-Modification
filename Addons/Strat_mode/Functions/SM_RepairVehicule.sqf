CTI_P_Repairing = false;

SM_repair_vehicle={
	_target = _this select 0;
	_caller = _this select 1;
	//["SERVER", "Request_Locality", [_target, _caller]] call CTI_CO_FNC_NetSend;

	_primary_weapon = primaryWeapon _caller;
	_caller selectWeapon _primary_weapon;

	_rk = ({_x == "Toolkit"} count (backpackItems _caller)) + ({_x == "Toolkit"} count (vestItems _caller)) + ({_x == "Toolkit"} count (itemCargo _target));
	if (_rk > 0) then {
		CTI_P_Repairing = true;
		_pos = getPos _caller;
		_caller switchMove "AinvPknlMstpSnonWrflDnon_medic4";
		[localize "STR_StartingRepairsVehicle",0,7,1] call HUD_PBar_start;
		_stime=time+7;
		_currentdamage = getdammage _target;
		_currentcallerdamage = getdammage _caller;
		_hps = {_x != 0} count (getAllHitPointsDamage _target select 2);
		while {alive _caller && alive _target  && _hps > 0 && (_caller distance2d _target) <5 && (_caller distance _target) <7 && (_caller distance _pos)<=1 && (vehicle _caller) ==_caller && time < _stime && _currentdamage > ((getdammage _target) - 0.01) && _currentcallerdamage > ((getdammage _caller) - 0.02)} do {
			(_stime - time) call HUD_PBar_update;
			_hps = {_x != 0} count (getAllHitPointsDamage _target select 2);
			_currentdamage = getdammage _target;
			sleep 1;
		};
		if ((_caller distance2d _target) >5 || (_caller distance _target) >7 || (_caller distance _pos)>1 || !((vehicle _caller) ==_caller)) exitWith {_caller switchMove ""; hint localize "STR_SM_RepairVehicule_Failed";CTI_P_Repairing = false ;0 call HUD_PBar_stop;};
		_currentdamage = getdammage _target;
		_hps = {_x != 0} count (getAllHitPointsDamage _target select 2);
		[localize "STR_RepairingVehicle",0,1,0] call HUD_PBar_start;

		["CLIENT", "Repair_vehicle",[_target,_caller,_pos],true] call CTI_CO_FNC_NetSend;
		["SERVER", "Repair_vehicle",[_target,_caller,_pos],true] call CTI_CO_FNC_NetSend;

		while {alive _caller && alive _target  && _hps > 0 && (_caller distance2d _target) <5 && (_caller distance _target) <7 && (_caller distance _pos)<=1 && (vehicle _caller) ==_caller && _currentdamage > ((getdammage _target) - 0.01) && _currentcallerdamage > ((getdammage _caller) - 0.02)} do {
			sleep 1;

			_avgdamage = (getAllHitPointsDamage _target select 2) call BIS_fnc_arithmeticMean;
			(1-(_avgdamage)) call HUD_PBar_update;
			_hps = {_x != 0} count (getAllHitPointsDamage _target select 2);
			_currentdamage = getdammage _target;
		};


		if ((_caller distance2d _target) >5 || (_caller distance _target) >7 || (_caller distance _pos)>1 || !((vehicle _caller) ==_caller)) exitWith {_caller switchMove ""; hint localize "STR_SM_RepairVehicule_Failed";CTI_P_Repairing = false ;0 call HUD_PBar_stop;};
		_caller switchMove "";
		CTI_P_Repairing = false;
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
	_primary_weapon = primaryWeapon _caller;
	_caller selectWeapon _primary_weapon;
	_currentcallerdamage = getdammage _caller;
	_rk=1;
	_rk = ({_x == "Toolkit"} count (backpackItems _caller)) +({_x == "Toolkit"} count (vestItems _caller));

	_rn = random (1);
	if (_target iskindOf "Tank" || _target iskindOf "Air") then {
		if (_rn >= 0.75) then {_target setVariable ["forced",true,true];};
		} else {
			if (_target iskindOf "Car" || _target iskindOf "Ship") then {
				if (_rn >= 0.85) then {_target setVariable ["forced",true,true];};
				} else {
					if (_rn >= 0.95) then {_target setVariable ["forced",true,true];};
				};
			};

	if (_target getVariable ["forced",false]) exitWith {hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />This vehicle has already been <t color='#F86363'>forced</t> or the <t color='#F86363'>Lock is broken</t>!";};
	_pos = getPos _caller;

	_rt=0;
	_heavy=0;
	_reptruck = [_target, CTI_SPECIAL_REPAIRTRUCK, 50] call CTI_CO_FNC_GetNearestSpecialVehicles;
	if (count _reptruck > 0) then {_rt=1};
	if (_target iskindOf "Tank" || _target iskindOf "Artillery" || _target iskindof "Air") then {_heavy=1};
	if (_heavy == 1 && (_rt == 0 || _rk == 0)) exitWith {
			hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You need a <t color='#ccffaf'>ToolKit</t> and a <t color='#ccffaf'>Repair truck</t> (closer than <t color='#beafff'>50m</t>) to perform this action.";
		};

	if (_rk > 0) then {
		_lock=1;
		CTI_P_Repairing = true ;
		_caller switchMove "AinvPknlMstpSnonWrflDnon_medic4";
		[localize "STR_ForcedVehicleLock",0,1,1] call HUD_PBar_start;
		while {_lock >0  && (_caller distance _target) <5 && (_caller distance _pos)<0.5 && alive _caller && (vehicle _caller) ==_caller && !(_target getVariable ["forced",false]) && _currentcallerdamage > ((getdammage _caller) - 0.02)} do
		{
				_lock=_lock-0.02;
				_percent=(1-_lock)*100;
				(_lock) call HUD_PBar_update;
		    //hint parseText format ["<t size='1.3' color='#2394ef'>Forcing Lock : %1 percent</t>",ceil (_percent)];
		    sleep 1;
		};
		if ((_caller distance _target) >5 || (_caller distance _pos)>0.5 || !((vehicle _caller) ==_caller) || (_target getVariable ["forced",false] || ! alive _caller) || _currentcallerdamage < ((getdammage _caller) - 0.02)) exitWith {
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
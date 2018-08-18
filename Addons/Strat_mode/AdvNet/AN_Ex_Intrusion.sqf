AN_E_INTRU=false;
AN_E_Intrusion_Loop={
	private ["_vehicle","_last_time","_hackers"];
	_vehicle=_this;
	_last_time=time;
	_hackers=[];
	diag_log format [":: HACK :: starting loop for %1", _vehicle];
	while {(_vehicle getVariable ["AN_Hacked",0])>0 && alive _vehicle} do {
		waitUntil {(_vehicle getvariable "CTI_NET") ==  (_vehicle getvariable "AN_iNET") &&( _vehicle getVariable ['AN_Hack_started',false])};
		_last_time=time;
		diag_log format [":: HACK ::  loop for %1 at %2 ", _vehicle,_last_time];
		{if (!alive _x || ! (vehicle _x == _vehicle)) then {_x setVariable ["CTI_NET",((side _x )   call CTI_CO_FNC_GetSideID),true];_hackers=_hackers-[_x];};true}  count _hackers;
		{if (!(_x getvariable "CTI_NET" == _vehicle getvariable "CTI_NET") && isplayer _x) then {_hackers set [count _hackers,_x];_x setVariable ["CTI_NET", _vehicle getvariable "CTI_NET",true];};true }count crew _vehicle;
		sleep 1;
		_vehicle setVariable ["AN_Hacked",((_vehicle getVariable "AN_Hacked")-(time- _last_time)),true];

	};
	_vehicle setVariable ["AN_Hack_handle",nil,true];
	_vehicle setVariable ['AN_Hack_started',false,true];
	diag_log format [":: HACK :: Stopping loop for %1", _vehicle];
	{_x setVariable ["CTI_NET",((side _x )   call CTI_CO_FNC_GetSideID),true];true}  count _hackers;
};


AN_E_Intrusion_Start={
	private ["_vehicle","_caller","_progress","_iup","_ht","_hh","_hackhandle"];
	_vehicle=_this select 0;
	_caller=_this select 1;
	_progress = 0;
	_iup=(CTI_P_SideJoined call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_EXPI;
	["Cracking public key (Do not move or exit Vehicle)",0,1,0] call HUD_PBar_start;
	AN_E_INTRU=true;
	while {!CTI_GameOver && alive _vehicle && alive _caller && (vehicle _caller) == _vehicle && speed _vehicle <1 && speed _vehicle > -1 && _progress <= 1} do {
		_progress = _progress + (1/(30/_iup));
		_progress call HUD_PBar_update;
		sleep 1;
	};
	if (_progress >=1) then {
			if (random(100)< (25*_iup)) then {
				_ht= _vehicle getVariable ["AN_Hacked",0];
				_hh= _vehicle getVariable ["AN_Hack_handle",0];
				if (isnil {_vehicle getVariable "AN_Hack_handle"}) then {
					_hackhandle=_vehicle spawn AN_E_Intrusion_Loop;
					_vehicle setVariable ["AN_Hack_handle",_hackhandle,true]
				};
				_vehicle setVariable ["AN_Hacked",(_ht+(_iup*5)),true];
				[format ["Succesfull (%1s added)",(_iup*5)],0,1,1] call HUD_PBar_start;
			} else {
				["Cracking Failed",0,1,1] call HUD_PBar_start;
			};
			sleep 1;
	} else {
		0 spawn {
			hintSilent "Intrusion Failed";
			sleep 3;
			hintSilent "";
		};
	};
	AN_E_INTRU=false;
	0 call HUD_PBar_stop;
	if !(isNil {uiNamespace getVariable 'cti_dialog_ui_interractions'}) then { ['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'};
};

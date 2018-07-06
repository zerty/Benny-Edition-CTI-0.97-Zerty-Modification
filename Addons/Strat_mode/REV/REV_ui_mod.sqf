#define	REVIVE_DELAY	20


private ["_main_disp","_ntime"];



inGameUISetEventHandler ["Action", "
	if (round(_this select 5) != 666 && player getVariable ['REV_UNC',false]) then {
		hint 'Sorry, You are down!';
		true
	}
"];


disableSerialization;
_main_disp = displayNull;
while {!CTI_GameOver } do {
	_main_disp=findDisplay 49;
	if (! isNull _main_disp) then {
		_ntime=time +REVIVE_DELAY;

		while {time < _ntime && ! (isNull _main_disp) && ! ( player getVariable ['REV_UNC',false] )} do {
			(_main_disp displayctrl 1010) ctrlEnable false;
			(_main_disp displayctrl 1010)  ctrlSetText format ["Respawn (%1)", (ceil (_ntime-time))];
			sleep 0.1;
		};

		(_main_disp displayctrl 1010) ctrlEnable true;
		(_main_disp displayctrl 1010) ctrlSetText "Respawn";
		waitUntil {isNull _main_disp};
	};
	sleep 0.1;
};

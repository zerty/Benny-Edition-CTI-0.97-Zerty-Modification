waitUntil {(["IsInitialized"] call BIS_fnc_dynamicGroups)};
diag_log ":: DYNG :: Starting server watchdog";
_current=[];
while {!CTI_Gameover} do {
	_current=_current-[grpNull];

	{
		_current pushBack _x;
		diag_log format [":: DYNG :: Found %1", _x];
		(_x) execFSM "Addons\Strat_mode\FSM\DYNG_Handle.fsm";
		true
	}count (("GetAllGroups" call BIS_fnc_dynamicGroups)-_current);

	sleep 2;
};


_side = _this select 0;
_v = _this select 1;
_t = _this select 2;
_p = _this select 3;
_f = _this select 4;
_m = _this select 5;
_c = _this select 6;
_s = _this select 7;

_squads = [];
for '_i' from 0 to (count _v)-1 do {
	_pool = [];
	{
		//--- Make sure that the pool contain valid units
		if (isClass(configFile >> "CfgVehicles" >> _x select 0)) then {
			_pool pushBack _x;
		} else {
			if (CTI_Log_Level >= CTI_Log_Error) then { ["ERROR", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["[%1] unit [%2] is not a valid CfgVehicles classname (Addons? Typo?).", _side, _x select 0]] call CTI_CO_FNC_Log };
		};
	} forEach (_p select _i);

	if (count _pool > 0) then {
		_cat = _c select _i;

		if (isNil {missionNamespace getVariable format ["CTI_SQUADS_%1_%2", _side, _cat]}) then {
			missionNamespace setVariable [format ["CTI_SQUADS_%1_%2", _side, _cat], [_v select _i]];
		} else {
			missionNamespace setVariable [format ["CTI_SQUADS_%1_%2", _side, _cat], (missionNamespace getVariable format ["CTI_SQUADS_%1_%2", _side, _cat]) + [_v select _i]];
		};

		missionNamespace setVariable [format ["CTI_SQUAD_%1_%2", _side, _v select _i], [_t select _i, _m select _i, _pool, _f select _i, _s select _i]];
		_squads pushBack (_v select _i);

		if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["[%1] Set Squad [%2] ", _side, _v select _i]] call CTI_CO_FNC_Log };
	};
};

missionNamespace setVariable [format ["CTI_SQUADS_%1", _side], _squads];
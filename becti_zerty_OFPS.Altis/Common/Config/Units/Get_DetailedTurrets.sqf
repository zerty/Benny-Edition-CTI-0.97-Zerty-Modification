private ["_classname", "_config", "_config_sub", "_found_commander", "_found_gunner", "_get", "_turrets"];

_classname = _this;
_found_gunner = false;
_found_commander = false;

_turrets = [];
_config = configFile >> "CfgVehicles" >> _classname >> "turrets";
for '_i' from 0 to (count _config)-1 do {
	_turret_main = _config select _i;

	_get = [[_i]];
	if (getNumber (_turret_main >> "dontCreateAI") > 0) then {_get=[];};
	_roleFound = false;
	if !(_found_gunner) then { if (getNumber (_turret_main >> "primaryGunner") > 0) then {_found_gunner = true; _roleFound = true; _get = [[_i], "Gunner"];}};
	if (!_found_commander && !_roleFound) then { if (getNumber (_turret_main >> "primaryObserver") > 0) then {_found_commander = true; _get = [[_i], "Commander"];}};
	_turrets = _turrets + [_get];

	_config_sub = _turret_main >> "turrets";
	for '_j' from 0 to (count _config_sub) -1 do {
		_turret_sub = _config_sub select _j;

		_get = [[_i, _j]];
		if (getNumber (_turret_sub >> "dontCreateAI") > 0) then {_get=[];};
		_roleFound = false;
		if !(_found_gunner) then { if (getNumber (_turret_sub >> "primaryGunner") > 0) then {_found_gunner = true; _roleFound = true; _get = [[_i, _j], "Gunner"];}};
		if (!_found_commander && !_roleFound) then { if (getNumber (_turret_sub >> "primaryObserver") > 0) then {_found_commander = true; _get = [[_i, _j], "Commander"];}};
		_turrets = _turrets + [_get];
	};
};

_turrets
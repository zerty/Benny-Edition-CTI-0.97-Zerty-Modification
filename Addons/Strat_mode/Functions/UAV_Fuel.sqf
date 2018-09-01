// base time around 170 minutes
// if fuel factor at 6 should be around 28 minutes

#define FUEL_FACTOR 6


private ["_uav","_last_fuel","_newfuel"];

_uav=_this;
_last_fuel=fuel _uav;
while {!CTI_GameOver && alive _uav} do {
	if (local _uav) then {
		if (fuel _uav <0.05) then {_uav setDammage 1};
		if (fuel _uav < _last_fuel) then {
			_newfuel=_last_fuel-(_last_fuel-(fuel _uav))*FUEL_FACTOR;
			//hint format ["_newfuel = %1 - (%1 - %2)* %3 = %4",_last_fuel,(fuel _uav),FUEL_FACTOR,_newfuel];
			//diag_log format ["%1,%2",_last_fuel,_newfuel];
			(vehicle _uav) setfuel _newfuel;
			_last_fuel=_newfuel;
		};
	} else {
		_last_fuel=fuel _uav;
	};

	sleep 10;
};

#define FUEL_FACTOR 5


private ["_uav","_last_fuel","_newfuel"];

_uav=_this;
if !(_uav isKindOf "UAV_01_base_F") exitWith {};
_last_fuel=fuel _uav;
while {!CTI_GameOver && alive _uav} do {
	if (fuel _uav <0.05) then {_uav setDammage 1};
	if (fuel _uav < _last_fuel) then {
		_newfuel=_last_fuel-(_last_fuel-(fuel _uav))*FUEL_FACTOR;
		if ((owner (vehicle _uav)) == 0 )then {
			(vehicle _uav) setfuel _newfuel;
		} else {
			[["CLIENT",side _uav], "SetFuel",[_uav,_newfuel]] call CTI_CO_FNC_NetSend;
		};
		_last_fuel=_newfuel;
	};

sleep 10;
};

#define FUEL_FACTOR 10

with missionnamespace do {
	CTI_PVF_SetFuel={
		diag_log format [":: Fuel :: setting %1 at %2", _this select 0 , _this select 1];
		(vehicle (_this select 0)) setfuel (_this select 1);
	};
};


if (CTI_isServer) then {
	while {!CTI_GameOver} do {
		{
			if (!(_x getVariable ["fuelhandled",false]) && _x isKindOf "UAV_01_base_F") then {
				_x spawn {
					_last_fuel=fuel _this;
					while {alive _this} do {
						if (fuel _this <0.05) then {_this setDammage 1};
						if (fuel _this < _last_fuel) then {
							_newfuel=_last_fuel-(_last_fuel-(fuel _this))*FUEL_FACTOR;
							if ((owner (vehicle _this)) == 0 )then {
								(vehicle _this) setfuel _newfuel;
							} else {
								[["CLIENT",side _this], "SetFuel",[_this,_newfuel]] call CTI_CO_FNC_NetSend;
							};
							_last_fuel=_newfuel;
						};

						sleep 10;

					};
				};
				_x setVariable ["fuelhandled",true,false];
			};
		} count allUnitsUAV;
	sleep 10;
	};
};
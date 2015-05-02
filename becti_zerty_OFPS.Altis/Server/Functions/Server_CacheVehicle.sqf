private ["_vehicle"];
_vehicle =_this;
_vehicle addEventHandler ["GetIn",{
		if !(simulationEnabled (_this select 0)) then {
			(_this select 0 ) enableSimulationGlobal true;
			(_this select 0 ) setVelocity (velocity (_this select 0 ));
			diag_log format [":: Cache :: Uncaching %1",(_this select 0 ) ];
		};
	}
];

while {!isNull _vehicle && ! CTI_GameOver} do {
	sleep 60;
	_areas=(CTI_EAST getVariable ["cti_structures_areas",[]]) + (CTI_WEST getVariable ["cti_structures_areas",[]]) ;
	if (alive _vehicle && simulationEnabled _vehicle && count (crew _vehicle) == 0 && !isnull  _vehicle && (getposatl _vehicle) select 2 < 2 && ((speed _vehicle)*(speed _vehicle))< 1 && ({(_vehicle distance _x ) < CTI_BASE_CONSTRUCTION_RANGE}count _areas) == 0) then {
		if (isEngineOn _vehicle) then {
			if (local _vehicle) then {
				_vehicle engineOn false;
			} else {
				[["CLIENT", _vehicle], "Client_Shutveh", _vehicle] call CTI_CO_FNC_NetSend;
			};
			diag_log format [":: Cache :: Trying to shutdown  %1",_vehicle ];
		} else {
			_vehicle enableSimulationGlobal false;
			diag_log format [":: Cache :: Caching %1",_vehicle ];
		};
	};
};

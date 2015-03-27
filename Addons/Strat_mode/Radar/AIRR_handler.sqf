#define Radar_Range 5000
#define Min_Alt 40

private ["_vehicle","_seed","_know_radars","_s","_logic","_structures","_radars"];
_vehicle = _this;

if !(_vehicle iskindof "Helicopter_Base_F" || _vehicle iskindof "Plane") exitwith {false};
//diag_log format [":: AIR Radar ::%1:: starting handling ",_vehicle];

_seed= diag_frameno-floor(random (10000000));
_know_radars=[];
while {!CTI_GameOver && alive _vehicle} do {
	_alt=((getposASL _vehicle) select 2 ) min ((getposATL _vehicle) select 2 );
	if (_alt >= Min_Alt) then {
		//diag_log format [":: AIR Radar ::%1:: Checking Radars ",_vehicle];
		{
			_s=_x;
			_logic=_x  call CTI_CO_FNC_GetSideLogic;
			_structures=_logic getvariable ["cti_structures",[]];
			_radars=[CTI_RADAR, _structures] call CTI_CO_FNC_GetSideStructuresByType;
			if ([_x, CTI_UPGRADE_AIRR, 1] call CTI_CO_FNC_HasUpgrade &&  !((_vehicle getvariable ["CTI_Net",-10]) == (_x  call CTI_CO_FNC_GetSideID))) then {_radars=[CTI_RADAR, _structures] call CTI_CO_FNC_GetSideStructuresByType;} else {_radars=[];};
			{if !(_x in _know_radars) then {[_x,_vehicle,_s,_seed] spawn AIRR_OBJ_HANDLER;_know_radars set [count _know_radars,_x];}; true} count _radars;
			true
		} count [east,west];
	};
	sleep 15;
};

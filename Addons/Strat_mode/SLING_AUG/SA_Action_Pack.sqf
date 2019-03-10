
#define packing_time 40
#define animation "ainvpknlmstpsnonwrfldnon_medic0s"
#define packs ["Land_Pod_Heli_Transport_04_box_F","B_Slingload_01_Cargo_F"]

private ["_caller","_started","_finished"];
_caller=_this select 0;
_target=_this select 1;


//prevent packing enemy HQ
if (_target == (CTI_P_EnemySide call CTI_CO_FNC_GetSideHQ)) exitwith{false};

_primary_weapon = primaryWeapon _caller;
_caller selectWeapon _primary_weapon;

_started=time;
_finished=time + packing_time;
_string =if (typeof _target in packs) then {localize "STR_UnpackingVehicle"} else {localize "STR_PackingVehicle"};

CTI_P_Repairing = true ;
_caller switchMove animation;
[_string,0,packing_time,0] call HUD_PBar_start;
while {alive _caller && alive _target && time < _finished && animationstate _caller == animation && {alive _x} count (crew _target) == 0 && abs (speed _target) <1 && locked _target <2} do {
			(time-_started) call HUD_PBar_update;
			sleep 0.5;
};
if !(alive _caller && alive _target && animationstate _caller == animation && {alive _x} count (crew _target) == 0 && abs (speed _target) <1 && locked _target <2) exitwith {
	_caller switchMove "";
	CTI_P_Repairing = false ;
	0 call HUD_PBar_stop;
	hintsilent localize "STR_ErrorPackVehicle";
	sleep 3;
	hintsilent "";
};
_caller switchMove "";
CTI_P_Repairing = false ;
0 call HUD_PBar_stop;
if !((typeof _target) in packs) then {_target spawn SA_PACK} else {_target spawn SA_UNPACK};
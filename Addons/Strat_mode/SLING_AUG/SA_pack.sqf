#define east_pack "Land_Pod_Heli_Transport_04_box_F"
#define west_pack "B_Slingload_01_Cargo_F"
#define stock_pos [100000,100000,100000]
#define random_pos 10000

private ["_initial_pos","_initial_dir","_side","_pack","_packobject"];
_target=_this;

if ({alive _x} count (crew _target) > 0) exitwith {hintsilent "The vehicle needs to be empty to perform that action";sleep 3;hintsilent "";};
_initial_pos=getposatl _target;
_initial_dir=getdir _target;
_side =CTI_P_sideJoined;
_pack=switch (_side) do {
    case west: {west_pack};
    case east: {east_pack};
    default {west_pack};
};


_target setpos [(stock_pos select 0) +random(random_pos),(stock_pos select 1) +random(random_pos),(stock_pos select 2) +random(random_pos)];
sleep 0.5;
["SERVER", "SERVER_SA_SIMU",[_target,false]] call CTI_CO_FNC_NetSend;
waitUntil {!(simulationEnabled _target)};
_target allowdamage false;



_packobject=[_pack, _initial_pos, _initial_dir, CTI_P_sideJoined, false, true, false, "CAN_COLLIDE"] call CTI_CO_FNC_CreateVehicle;

clearBackpackCargoGlobal _packobject;
clearMagazineCargoGlobal  _packobject;
clearWeaponCargoGlobal _packobject;
clearItemCargoGlobal  _packobject;
_packobject setmass [2000,0];

//if (_target iskindof "Tank") then {_packobject setmass 10000;};
_packobject setvariable ["SA_PACKED",_target,true];
if (_target == ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ)) then {

	_packobject setVariable ["cti_gc_noremove", true,true]; //--- HQ wreck cannot be removed nor salvaged
	_packobject setVariable ["cti_ai_prohib", true,true]; //--- HQ may not be used by AI as a commandable vehicle
	_packobject setVariable ["cti_occupant", _side,true];
	["SERVER", "SERVER_SA_PROTECT_HQ",[_packobject,_side]] call CTI_CO_FNC_NetSend;
	["CLIENT", "CLIENT_SA_PROTECT_HQ",[_packobject,_side],true] call CTI_CO_FNC_NetSend;
	CTI_P_SideLogic setVariable ["cti_hq", _packobject, true];
	//["SERVER", "SERVER_SA_SIMU",[_target,true]] call CTI_CO_FNC_NetSend;
	//waitUntil {(simulationEnabled _target)};
	deletevehicle _target;
} else {
	sleep 2;
	["SERVER", "SERVER_SA_LOOP",_target] call CTI_CO_FNC_NetSend;
};




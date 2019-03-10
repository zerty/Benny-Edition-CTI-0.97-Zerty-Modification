#define west_para "B_Parachute_02_F"
#define west_smoke "SmokeShellBlue"
#define east_para "O_Parachute_02_F"
#define east_smoke "SmokeShellRed"
#define east_smoke "SmokeShellRed"
private ["_drop","_paraclass","_paraalt","_minalt","_para"];
_drop = _this select 0;
_side = _this select 1;
_paraalt= _this select 2;
_minalt= _this select 3;
_paraclass=switch (_side) do {
    case west: {west_para};
    case east: {east_para};
    default {west_para};
};

_shellclass=switch (_side) do {
    case west: {west_smoke};
    case east: {east_smoke};
    default {west_smoke};
};

sleep 3;
if ((getposATL _drop select 2) min (getposASL _drop select 2) > 30) then  {
	waitUntil {(getposATL _drop select 2) min (getposASL _drop select 2) <= _paraalt };
	//sleep random (5);
	_para= createvehicle [_paraclass,getpos _drop,[],0, "CAN_COLLIDE"];
	_para setvelocity (velocity _drop);
	_drop attachto [_para,[0,0,0]];
};
waitUntil {(getposATL _drop select 2) min (getposASL _drop select 2) <= _minalt  || !alive _drop };

if !(alive _drop) exitwith {false};
if ! (isnil "_para") then  {
    detach _drop;
    playSound3D ["a3\sounds_f\weapons\Flare_Gun\flaregun_1_shoot.wss",_drop];
    _para setvelocity [0,0,10];
    _drop disableCollisionWith _para;
};
_shell= createvehicle [_shellclass,getpos _drop,[],0, "CAN_COLLIDE"];
if ! (isnil "_para") then {
sleep 10;
deletevehicle _para;
};
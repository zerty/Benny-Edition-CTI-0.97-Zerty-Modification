private ["_enemy_side","_initial_pos","_initial_dir","_side","_hq","_packed"];

_target=_this;


_enemy_side=switch (CTI_P_SideJoined) do {
    case west: {east};
    case east: {west};
    default {west};
};

if (!(alive _target) || _target == ((_enemy_side) call CTI_CO_FNC_GetSideHQ))  exitwith {false}; //prevent unpack from enemy or dead pack

_initial_pos=getpos _target;
_initial_pos set [2, (_initial_pos select 2)+1];
_initial_dir=getdir _target;

if (_target == ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ)) then {
	_side = _target getVariable "cti_occupant";
	deletevehicle _target;
	waitUntil {isNull _target};
	
	if ((_initial_pos select 2) <0) then {
		_hq = [missionNamespace getVariable Format["CTI_%1_HQ", _side], _initial_pos, _initial_dir, _side, true, true,false, "CAN_COLLIDE"] call CTI_CO_FNC_CreateVehicle; //if underwatter
	} else {
		_hq = [missionNamespace getVariable Format["CTI_%1_HQ", _side], _initial_pos, _initial_dir, _side, true, true,false, "FORM"] call CTI_CO_FNC_CreateVehicle; // if on ground
	};
	_hq allowdamage false;
	_hq setVariable ["cti_gc_noremove", true,true]; //--- HQ wreck cannot be removed nor salvaged
	_hq setVariable ["cti_ai_prohib", true,true]; //--- HQ may not be used by AI as a commandable vehicle
	//_hq addEventHandler ["getIn", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	//_hq addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	_hq setVariable ["cti_occupant", _side,true];
	["CLIENT", "CLIENT_SA_PROTECT_HQ",[_hq,_side],true] call CTI_CO_FNC_NetSend;
	["SERVER", "SERVER_SA_PROTECT_HQ",[_hq,_side]] call CTI_CO_FNC_NetSend;
	((_side) call CTI_CO_FNC_GetSideLogic) setVariable ["cti_hq", _hq, true];
	[["CLIENT", _side], "Client_givehqlock", [],true] call CTI_CO_FNC_NetSend;
	_hq setVelocity [0,0,1];
	sleep 5;
	_hq allowdamage true; //protection for glitching during server lag

}else {
	if (isnil {_target getvariable "SA_PACKED"}) exitwith {false};
	_packed=_target getvariable ["SA_PACKED",objnull];
	_target setvariable ["SA_PACKED",objnull,true];
	["SERVER", "SERVER_SA_SIMU",[_packed,true]] call CTI_CO_FNC_NetSend;
	waitUntil {simulationEnabled _packed};
	deletevehicle _target;
	waitUntil {isNull _target};
	_packed setdir _initial_dir;
	_packed setpos _initial_pos;

	_packed setVelocity [0,0,1];
	sleep 5;
	_packed allowdamage true;
};

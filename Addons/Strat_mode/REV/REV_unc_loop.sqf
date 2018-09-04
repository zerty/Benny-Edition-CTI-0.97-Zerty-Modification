#define BLEEDOUT_TIME 200

private ["_unit","_starting_time","_bleedout_time"];

_unit=_this;
_starting_time=time;
_bleedout_time=_starting_time+BLEEDOUT_TIME;
["Bleeding out ... Wait for a revive or suicide.",0,1,0] call HUD_PBar_start;
while {(!CTI_GameOver && alive _unit && _unit getVariable ["REV_UNC",false] && time <_bleedout_time) }do {
	if (cameraOn != _unit) then {
		_unit connectTerminalToUAV objNull;
		cameraOn action ["BackFromUAV", _unit];
	};

	if (vehicle _unit != _unit) then
	{
		(vehicle player) lock false;
		unAssignVehicle _unit;
		_unit action ["eject", vehicle _unit];
		_unit action ["getOut", (vehicle _unit)];
	};
	((time- _starting_time) / BLEEDOUT_TIME ) call HUD_PBar_update;
	if (_unit getVariable ["REV_REQREV",false]) then {_unit setVariable ["REV_UNC",false,true];}; // revive request has arrived
	sleep 0.1;
};
if (! (alive _unit) || CTI_GameOver) exitwith {
	if (player == _unit ) then {CTI_P_PreBuilding = false};
	player setCaptive false;
	_unit setVariable ["REV_UNC", false, true];
	_unit setvariable ["REV_REQREV",false,true];
	_unit setvariable ["REV_DRAGGED",false,true];
	0 call HUD_PBar_stop;
	false
};
if (time > _bleedout_time ) exitwith {0 call HUD_PBar_stop;_unit setdamage 1; _unit setVariable ["REV_UNC", false, true];_unit setvariable ["REV_DRAGGED",false,false];false};

0 call HUD_PBar_stop;
_unit enableSimulation true;
_unit setDamage 0.25;
_unit setCaptive false;
_unit setVariable ["REV_UNC", false, true];
_unit setvariable ["REV_REQREV",false,true];
_unit setvariable ["REV_DRAGGED",false,true];
if (player == _unit ) then {
	CTI_P_PreBuilding = false;
	vehicle (player) switchCamera 'Internal';
};

if ((getPos _unit) select 2 <0) then { _unit setPos (getPos _unit);};
_unit playMove "amovppnemstpsraswrfldnon";
_unit playMove "";



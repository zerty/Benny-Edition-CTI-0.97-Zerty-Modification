private ["_unit","_target"];

_unit = _this select 0;
_target=_this select 1;


_target playMoveNow "AcinPknlMstpSrasWrflDnon";
_target setvariable ["REV_DRAGGING",_unit,false];
["CLIENT", "REV_DRAGGED",[_unit,_target],true] call CTI_CO_FNC_NetSend;


[_unit,_target] spawn {
	_unit =_this select 0;
	_target=_this select 1;
	waituntil {!alive _target || _target getVariable ["REV_UNC",false] || ! alive _unit || !(_unit getVariable ["REV_UNC",false]) ||CTI_GameOver};
	["CLIENT", "REV_UNDRAGGED",_unit] call CTI_CO_FNC_NetSend;
	_target setvariable ["REV_DRAGGING",objnull,false];
	_target playMove "amovpknlmstpsraswrfldnon";
};
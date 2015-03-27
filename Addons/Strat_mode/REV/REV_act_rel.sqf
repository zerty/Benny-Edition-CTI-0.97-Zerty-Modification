private ["_unit","_target"];
_target=_this select 0;

_unit = _target getvariable ["REV_DRAGGING",objnull];
if (isnull _unit) exitwith {false};
["CLIENT", "REV_UNDRAGGED",_unit] call CTI_CO_FNC_NetSend;
_target setvariable ["REV_DRAGGING",objnull,false];
_target playMove "amovpknlmstpsraswrfldnon";
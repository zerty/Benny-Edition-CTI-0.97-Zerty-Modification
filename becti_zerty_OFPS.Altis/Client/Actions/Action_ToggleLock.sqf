private ["_lock", "_vehicle"];

_vehicle = _this select 0;
_lock = if (locked _vehicle == 0) then {2} else {0};

_vehicle lock _lock;
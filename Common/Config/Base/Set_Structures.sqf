private ["_classes", "_headers", "_placements", "_prices", "_side", "_specials", "_structures", "_times"];

_side = _this select 0;
_headers = _this select 1;
_classes = _this select 2;
_prices = _this select 3;
_times = _this select 4;
_placements = _this select 5;
_specials = _this select 6;

_old_s= missionNamespace getVariable format ["CTI_%1_STRUCTURES", _side];
if (isNil "_old_s") then {_old_s=[];};
_structures = [];
for '_i' from 0 to (count _headers) -1 do {
	_head = _headers select _i;

	_stored = [
		_headers select _i,
		_classes select _i,
		_prices select _i,
		_times select _i,
		_placements select _i,
		_specials select _i
	];

	missionNamespace setVariable [format ["CTI_%1_%2", _side, _head select 0], _stored];
	_structures pushBack (format ["CTI_%1_%2", _side, _head select 0]);

	missionNamespace setVariable [format ["CTI_%1_%2", _side, (_classes select _i) select 0], _stored];
};


missionNamespace setVariable [format ["CTI_%1_STRUCTURES", _side], _old_s+_structures];
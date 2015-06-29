private ["_categories", "_classes", "_defenses", "_headers", "_placements", "_prices", "_side"];

_side = _this select 0;
_headers = _this select 1;
_classes = _this select 2;
_prices = _this select 3;
_placements = _this select 4;
_categories = _this select 5;

_defenses = [];
for '_i' from 0 to (count _headers) -1 do {
	_header = _headers select _i;
	_classname = _classes select _i;

	if (isNil {missionNamespace getVariable format["CTI_%1_%2",_side,_classname]}) then {
		_label = "";
		_special = [];
		switch (typeName _header) do {
			case "STRING": { _label = _header };
			case "ARRAY": {
				_label = _header select 0;
				_special = _header select 1;
			};
		};

		_stored = [
			_label,
			_classname,
			_prices select _i,
			_categories select _i,
			_placements select _i,
			_special
		];

		missionNamespace setVariable [format["CTI_%1_%2",_side,_classname], _stored];
		_defenses pushBack (format["CTI_%1_%2",_side,_classname]);
	} else {
		if (CTI_Log_Level >= CTI_Log_Information) then {
			["TRIVIAL", "FILE: Common\Config\Base\Set_Defenses.sqf", format ["[%1] Defense [%2] was previously defined. Skipping this one.", _side, _classname]] call CTI_CO_FNC_Log
		};
	};
};

missionNamespace setVariable [format ["CTI_%1_DEFENSES", _side], _defenses];
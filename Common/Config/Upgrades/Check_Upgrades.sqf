//--- Auto Check the ai upgrade path for missing links.

private ["_add", "_enabled", "_levels", "_missing", "_orders", "_values"];

_side = _this;

_enabled = missionNamespace getVariable Format ["CTI_%1_UPGRADES_ENABLED", _side];
_orders = missionNamespace getVariable Format ["CTI_%1_UPGRADES_AI_ORDER", _side];
_levels = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", _side];

_values = [];
for '_i' from 0 to count(_levels)-1 do {
	_values pushBack [];
};

{
	_upgrade = _x select 0;
	_level = _x select 1;
	if (_enabled select _upgrade) then {
		if !(_level in (_values select _upgrade)) then {_values set [_upgrade, (_values select _upgrade) + [_level]]};
	};
} forEach _orders;

_add = [];
for '_i' from 0 to count(_values)-1 do {
	if (_enabled select _i) then {
		_found = _values select _i;
		_level = _levels select _i;

		for '_j' from 1 to _level do {
			if !(_j in _found) then { _add pushBack [_i, _j] };
		};
	};
};

if (count _add > 0) then {
	missionNamespace setVariable [Format ["CTI_%1_UPGRADES_AI_ORDER", _side], _orders + _add];
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Common\Config\Upgrades\Check_Upgrades.sqf", format ["[%1] AI Commander upgrade order has been completed with [%2]", _side, _add]] call CTI_CO_FNC_Log };
};
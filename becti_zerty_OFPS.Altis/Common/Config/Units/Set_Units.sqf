private ["_c", "_cpt", "_custom", "_f", "_faction", "_label", "_n", "_o", "_p", "_picture", "_s", "_scripts", "_stored", "_t", "_turrets", "_u", "_var_name"];

_side = _this select 0;
_faction = _this select 1;
_c = _this select 2;
_p = _this select 3;
_n = _this select 4;
_o = _this select 5;
_t = _this select 6;
_u = _this select 7;
_f = _this select 8;
_s = _this select 9;

_cpt = 0;

for '_i' from 0 to (count _c)-1 do {
	_classname = _c select _i;
	_var_name = _classname;

	//--- Is it a custom unit?
	_custom = false;
	if (typeName(_s select _i) == "ARRAY") then { _classname = (_s select _i) select 0; _custom = true };

	if (isClass (configFile >> "CfgVehicles" >> _classname)) then {
		_get = missionNamespace getVariable _var_name;
		if (isNil "_get") then {
			_stored = [];

			_picture = _p select _i;
			if (_picture == "") then {
				_picture = if (_classname isKindOf "Man") then { getText(configFile >> "CfgVehicles" >> _classname >> "portrait") } else { getText(configFile >> "CfgVehicles" >> _classname >> "picture") };
				if (_picture == "pictureThing") then {_picture=""};
			};
			_label = if ((_n select _i) == "") then { getText(configFile >> "CfgVehicles" >> _classname >> "displayName") } else { _n select _i };
			_turrets = if !(_classname isKindOf "Man") then { (_classname) call compile preprocessFileLineNumbers "Common\Config\Units\Get_DetailedTurrets.sqf" } else { "" };

			_scripts = _s select _i;
			if (_custom) then { //--- Custom vehicle are tracked by an ID to make it easier to spot on the network, we avoid the use of a string for our 56k modem friends.
				_scripts set [2, CTI_CO_CustomIterator];
				missionNamespace setVariable [format["CTI_CUSTOM_ENTITY_%1", CTI_CO_CustomIterator], _var_name];
				CTI_CO_CustomIterator = CTI_CO_CustomIterator + 1;
			};

			_stored = [_label, _picture, _o select _i, _t select _i, _u select _i, _f select _i, _turrets, _scripts];
			missionNamespace setVariable [_var_name, _stored];
			_cpt = _cpt + 1;

			if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Common\Config\Units\Set_Units.sqf", format ["[%1] Set unit [%2] using classname [%3]", _side, _var_name, _classname]] call CTI_CO_FNC_Log };
		} else {
			if (CTI_Log_Level >= CTI_Log_Warning) then { ["WARNING", "FILE: Common\Config\Units\Set_Units.sqf", format ["[%1] unit [%2] was skipped since it is already defined", _side, _var_name]] call CTI_CO_FNC_Log };
		};
	} else {
		if (CTI_Log_Level >= CTI_Log_Error) then { ["ERROR", "FILE: Common\Config\Units\Set_Units.sqf", format ["[%1] unit [%2] is not using a valid CfgVehicles classname [%3]. If it belong to an Addons, make sure that it is loaded.", _side, _var_name, _classname]] call CTI_CO_FNC_Log };
	};
};

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Common\Config\Units\Set_Units.sqf", format ["[%1] [%2/%3] units were defined", _side, _cpt, count _c]] call CTI_CO_FNC_Log };
_c = _this select 0;
_m = _this select 1;
_b = _this select 2;
_r = _this select 3;

_artillery = [];
for '_i' from 0 to count(_c)-1 do {
	_classname = _c select _i;

	//--- The artillery classname is valid
	if (isClass (configFile >> 'CfgVehicles' >> _classname)) then {
		//--- Set the artillery variable
		_label = getText(configFile >> "CfgVehicles" >> _classname >> "displayName");
		_mags_labels = [];
		{_mags_labels pushBack (getText(configFile >> "CfgMagazines" >> _x >> "displayName"))} forEach (_m select _i);

		_array = [_label, _mags_labels, _m select _i, _b select _i, _r select _i];
		missionNamespace setVariable [format ["CTI_ARTILLERY_%1", _classname], _array];

		//--- Append to our artillery pieces
		_artillery pushBack _classname;

		if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Common\Config\Artillery\Set_Artillery.sqf", format ["Set Artillery unit [%1]", _classname]] call CTI_CO_FNC_Log };
	} else {
		if (CTI_Log_Level >= CTI_Log_Error) then { ["ERROR", "FILE: Common\Config\Artillery\Set_Artillery.sqf", format ["Artillery unit [%1] is not a valid CfgVehicles classname. If it belong to an Addons, make sure that it is loaded.", _classname]] call CTI_CO_FNC_Log };
	};
};

missionNamespace setVariable ["CTI_ARTILLERY", _artillery];
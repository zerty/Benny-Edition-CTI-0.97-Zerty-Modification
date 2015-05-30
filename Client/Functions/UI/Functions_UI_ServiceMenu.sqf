CTI_UI_Service_GetBaseDepots = {
	private ["_available", "_range", "_structures", "_unit"];
	_unit = _this select 0;
	_structures = _this select 1;
	_range = _this select 2;

	_available = [];
	{if (_x distance _unit <= _range) then {[_available, _x] call CTI_CO_FNC_ArrayPush}} forEach _structures;
	_available
};
/*
CTI_UI_Service_GetGroupMobileSupports = {
	private ["_available", "_type"];
	_type = _this;

	_available = [];
	{
		if !(isNil {_x getVariable "cti_spec"}) then {
			_spec = _x getVariable "cti_spec";
			if (typeName _spec != "ARRAY") then {_spec = [_spec]};
			if (_type in _spec && getPos _x select 2 < 5) then {[_available, _x] call CTI_CO_FNC_ArrayPush};
		};
	} forEach units player;

	_available
};*/

CTI_UI_Service_GetGroupMobileSupports = {
	private ["_available", "_range", "_structures", "_unit"];
	_type =_this;
	_mobiles=[];
	{if ((_type in (_x getVariable ["cti_spec",[]]))&& alive _x && (_x getVariable ["cti_occupant",CTI_P_SideJoined])== CTI_P_SideJoined) then {_mobiles set [count _mobiles,_x]};true }count ((CTI_WEST getvariable ["cti_service", []]) + (CTI_EAST getvariable ["cti_service", []]));
	_mobiles
};

CTI_UI_Service_RangeStill = {
	private ["_content", "_index", "_match", "_range", "_unit"];
	_unit = _this select 0;
	_content = _this select 1;
	_ranges = _this select 2;
	_index = _this select 3;

	_match = [];
	{
		_range = _ranges select _forEachIndex;
		_source = _x select 0;
		_current_index = _forEachIndex;

		{
			if !(isNil '_x') then {
				if (alive _x) then {
					if (_x distance _unit <= _range && getPos _x select 2 < 5 && getPos _unit select 2 < 5) then {_match = [_x, _source, _current_index]};
				};
			};

			if (count _match > 0) exitWith {};
		} forEach (_x select 1);
		if (count _match > 0) exitWith {};
	} forEach (_content select _index);
	_match
};

CTI_UI_Service_ProcessRepair = {
	private ["_content", "_index", "_label", "_ranges", "_start_at", "_times", "_unit", "_var_classname", "_var_name"];
	_unit = _this select 0;
	_content = _this select 1;
	_ranges = _this select 2;
	_times = _this select 3;
	_index = _this select 4;

	_var_name = if (isNil {_unit getVariable "cti_customid"}) then {typeOf _unit} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _unit getVariable "cti_customid"]};
	_var_classname = missionNamespace getVariable _var_name;
	_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")};

	hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Repairing a <t color='#ccffaf'>%1</t>... Please stand by...", _label];

	_start_at = time;

	_repair = false;
	while {true} do {
		_ranged = [_unit, _content, _ranges, _index] call CTI_UI_Service_RangeStill;
		if (count _ranged == 0 || !alive _unit) exitWith {};

		_operative_index = _ranged select 2;
		_service_time = _times select _operative_index;

		if (time - _start_at > _service_time) exitWith {_repair = true};

		sleep 1;
	};

	if (_repair) then {
		_unit setDammage 0;
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />A <t color='#ccffaf'>%1</t> has been repaired!", _label];
	} else {
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Couldn't finish the repairs on a <t color='#ccffaf'>%1</t>...", _label];
	};
};

CTI_UI_Service_ProcessRearm = {
	private ["_content", "_index", "_label", "_ranges", "_start_at", "_times", "_unit", "_var_classname", "_var_name"];
	_unit = _this select 0;
	_content = _this select 1;
	_ranges = _this select 2;
	_times = _this select 3;
	_index = _this select 4;

	_var_name = if (isNil {_unit getVariable "cti_customid"}) then {typeOf _unit} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _unit getVariable "cti_customid"]};
	_var_classname = missionNamespace getVariable _var_name;
	_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")};
	if (_unit isKindOf "Air") then {
		{
			_times set [_forEachIndex,_x * CTI_AIR_REARM_RATIO];
		} forEach _times;
	};
	if (_unit isKindOf "MBT_01_arty_base_F" || _unit isKindOf "B_MBT_01_mlrs_base_F" || _unit isKindOf  "O_MBT_02_arty_base_F" ) then {
		{
			_times set [_forEachIndex,_x * CTI_ART_REARM_RATIO];
		} forEach _times;
	};
	hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Rearming a <t color='#ccffaf'>%1</t>... Please stand by ...", _label];
	_unit setVehicleAmmo 0;

	_start_at = time;

	_rearm = false;
	while {true} do {
		_ranged = [_unit, _content, _ranges, _index] call CTI_UI_Service_RangeStill;
		if (count _ranged == 0 || !alive _unit) exitWith {};

		_operative_index = _ranged select 2;
		_service_time = _times select _operative_index;

		if (time - _start_at > _service_time) exitWith {_rearm = true};
		hintsilent parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Rearming a <t color='#ccffaf'>%1</t><br />Done in <t color='#ccffaf'>%2s</t>.", _label,ceil (_service_time - (time - _start_at))];
		sleep 1;
	};

	if (_rearm) then {
		[_unit, CTI_P_SideJoined] call CTI_CO_FNC_RearmVehicle;
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />A <t color='#ccffaf'>%1</t> has been rearmed!", _label];
	} else {
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Couldn't finish the rearming of a <t color='#ccffaf'>%1</t>...", _label];
	};
};

CTI_UI_Service_ProcessRefuel = {
	private ["_content", "_index", "_label", "_ranges", "_start_at", "_times", "_unit", "_var_classname", "_var_name"];
	_unit = _this select 0;
	_content = _this select 1;
	_ranges = _this select 2;
	_times = _this select 3;
	_index = _this select 4;

	_var_name = if (isNil {_unit getVariable "cti_customid"}) then {typeOf _unit} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _unit getVariable "cti_customid"]};
	_var_classname = missionNamespace getVariable _var_name;
	_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")};

	hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Refueling a <t color='#ccffaf'>%1</t>... Please stand by...", _label];
	if !(_unit isKindOf "StaticWeapon") then {_unit setFuel 0};

	_start_at = time;

	_refuel = false;
	while {true} do {
		_ranged = [_unit, _content, _ranges, _index] call CTI_UI_Service_RangeStill;
		if (count _ranged == 0 || !alive _unit) exitWith {};

		_operative_index = _ranged select 2;
		_service_time = _times select _operative_index;

		if (time - _start_at > _service_time) exitWith {_refuel = true};

		sleep 1;
	};

	if (_refuel) then {
		if !(_unit isKindOf "StaticWeapon") then {_unit setFuel 1};
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />A <t color='#ccffaf'>%1</t> has been refueled!", _label];
	} else {
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Couldn't finish the refueling of a <t color='#ccffaf'>%1</t>...", _label];
	};
};

CTI_UI_Service_ProcessHeal = {
	private ["_content", "_index", "_label", "_ranges", "_start_at", "_times", "_unit", "_var_classname", "_var_name"];
	_unit = _this select 0;
	_content = _this select 1;
	_ranges = _this select 2;
	_times = _this select 3;
	_index = _this select 4;

	_crew = crew _unit;
	_var_name = if (isNil {_unit getVariable "cti_customid"}) then {typeOf _unit} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _unit getVariable "cti_customid"]};
	_var_classname = missionNamespace getVariable _var_name;
	_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")};

	hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Healing a <t color='#ccffaf'>%1</t>... Please stand by...", _label];

	_start_at = time;

	_repair = false;
	while {true} do {
		_ranged = [_unit, _content, _ranges, _index] call CTI_UI_Service_RangeStill;
		if (count _ranged == 0 || !alive _unit) exitWith {};

		_operative_index = _ranged select 2;
		_service_time = _times select _operative_index;

		if (time - _start_at > _service_time) exitWith {_repair = true};

		sleep 1;
	};

	if (_repair) then {
		if (_unit isKindOf "Man") then {_unit setDammage 0} else {{if (!isNil '_x') then {if (alive _x && _x in crew _unit) then {_x setDammage 0}}} forEach _crew};
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />A <t color='#ccffaf'>%1</t> has been healed!", _label];
	} else {
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br />Couldn't finish the healing of a <t color='#ccffaf'>%1</t>...", _label];
	};
};

CTI_UI_Service_GetPrice = {
	private ["_base_cost", "_cost", "_coefficient", "_unit"];
	_unit = _this select 0;
	_base_cost = _this select 1;
	_coefficient = if (count _this > 2) then {_this select 2} else {-1};

	_cost = _base_cost;
	if (!(isNil {missionNamespace getVariable typeOf _unit}) && _coefficient > -1) then {
		_cost = _cost +  ((missionNamespace getVariable typeOf _unit) select CTI_UNIT_PRICE) * _coefficient;
	};

	round(_cost)
};
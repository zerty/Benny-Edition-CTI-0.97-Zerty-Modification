CTI_FSM_RepairTruck_Construct = {
	private ["_addin", "_completion", "_group", "_target", "_vehicle"];
	_vehicle = _this select 0;
	_target = _this select 1;

	_completion = _target getVariable "cti_completion";
	if !(isNil '_completion') then {
		_addin = _completion + ((CTI_VEHICLES_REPAIRTRUCK_BASE_BUILD_COEFFICIENT/(_target getVariable "cti_structures_iteration")) * (_target getVariable "cti_completion_ratio"));
		if (_addin > 100) then {_addin = 100};
		_target setVariable ["cti_completion", _addin,true];
		if (_completion != _addin) then {
			_group = group driver _vehicle;
			if (isPlayer leader _group) then {[["CLIENT", leader _group], "Client_OnMessageReceived", ["build-by", [driver _vehicle, _target getVariable "cti_structure_type", round _addin]]] call CTI_CO_FNC_NetSend};
		};
	};
};

CTI_FSM_RepairTruck_Repair = {
	private ["_addin", "_target", "_vehicle", "_virtual_damages"];
	_vehicle = _this select 0;
	_target = _this select 1;

	_virtual_damages = _target getVariable "cti_altdmg";
	if (isNil '_virtual_damages') then {_virtual_damages = -1};

	_addin = 0;
	if (_virtual_damages < 0) then {
		_addin = getDammage _target - CTI_VEHICLES_REPAIRTRUCK_BASE_REPAIR;
		if (_addin < 0) then {_addin = 0};
		_target setDammage _addin;
	} else {
		_addin = _virtual_damages - CTI_VEHICLES_REPAIRTRUCK_BASE_REPAIR;
		if (_addin < 0) then {_addin = 0};
		if (_addin != _virtual_damages) then {_target setVariable ["cti_altdmg", _addin,true]};
	};

	_group = group driver _vehicle;
	if (isPlayer leader _group) then {[["CLIENT", leader _group], "Client_OnMessageReceived", ["repair-by", [driver _vehicle, _target getVariable "cti_structure_type", round((1 - _addin)*100)]]] call CTI_CO_FNC_NetSend};
};

private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		if (isNull CTI_P_HookVehicle) exitWith {closeDialog 0};

		_var_name = if (isNil {CTI_P_HookVehicle getVariable "cti_customid"}) then {typeOf CTI_P_HookVehicle} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", CTI_P_HookVehicle getVariable "cti_customid"]};
		_var_classname = missionNamespace getVariable _var_name;
		_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf CTI_P_HookVehicle >> "displayName")};

		((uiNamespace getVariable "cti_dialog_ui_hookmenu") displayCtrl 240002) ctrlSetText format["Source: %1", _label];

		_list = switch (true) do {
			case (CTI_P_HookVehicle isKindOf "Air"): {["Car", "Motorcycle", "Ship", "Tank"]};
			case (CTI_P_HookVehicle isKindOf "Ship"): {["Car", "Motorcycle", "Ship", "Tank", "Air"]};
			default {["Car", "Motorcycle", "Ship"]};
		};

		_hooked = CTI_P_HookVehicle getVariable "cti_hooked";
		if (isNil '_hooked') then {_hooked = objNull};

		_entities = [];
		{if (getPos _x select 2 < 5 && speed _x < 10 && count crew _x == 0) then {_entities pushBack _x}} forEach (CTI_P_HookVehicle nearEntities [_list, 15]);
		_entities = _entities - [_hooked, CTI_P_HookVehicle];
		uiNamespace setVariable ["cti_dialog_ui_hookmenu_list", _entities];

		{
			_var_name = if (isNil {_x getVariable "cti_customid"}) then {typeOf _x} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _x getVariable "cti_customid"]};
			_var_classname = missionNamespace getVariable _var_name;
			_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName")};
			((uiNamespace getVariable "cti_dialog_ui_hookmenu") displayCtrl 240004) lbAdd _label;
		} forEach _entities;

		uiNamespace setVariable ["cti_dialog_ui_hookmenu_hooked", objNull];
		execVM "Client\GUI\GUI_HookMenu.sqf";
	};
	case "onHookPressed": {
		_selected = _this select 1;

		if (_selected > -1) then {
			//--- Something is attached?
			_hooked = CTI_P_HookVehicle getVariable "cti_hooked";
			if (isNil '_hooked') then {_hooked = objNull};
			_has_something = false;
			if (alive _hooked) then {
				if (_hooked distance CTI_P_HookVehicle < 50) then {
					_has_something = true;
				};
			};

			if !(_has_something) then {
				_selected = (uiNamespace getVariable "cti_dialog_ui_hookmenu_list") select _selected;
				if !(isNil '_selected') then {
					_wreck_allow = if (typeOf CTI_P_HookVehicle in CTI_VEHICLES_HOOKERS_EX) then {true} else {false};
					if (((alive _selected && !_wreck_allow) || _wreck_allow && ! alive _selected) && _selected distance CTI_P_HookVehicle <= 15 && count crew _selected == 0 && speed _selected < 10 && getPos _selected select 2 < 5 && local CTI_P_HookVehicle) then {
						CTI_P_HookVehicle setVariable ["cti_hooked", _selected, true];
						[_selected, CTI_P_HookVehicle] spawn CTI_CL_FNC_HookVehicle;
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The vehicle has been attached";
					} else {
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The vehicles is either too far, dead, moving or manned and cannot be attached";
					};
				};
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Unable to attach the vehicle, something is already attached";
			};
		};
	};
	case "onHookDetach": {
		//--- Something is attached?
		_hooked = CTI_P_HookVehicle getVariable "cti_hooked";
		if (isNil '_hooked') then {_hooked = objNull};
		_has_something = false;
		if (_hooked distance CTI_P_HookVehicle < 50) then {
			_has_something = true;
		};

		if (_has_something) then {
			CTI_P_HookVehicle setVariable ["cti_hooked", nil, true];
			detach _hooked;
			_velocity = velocity CTI_P_HookVehicle;
			_velocity set [2, (_velocity select 2) - 1];
			_hooked setVelocity _velocity;
			hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The vehicle has been detached";
		} else {
			hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />There is nothing to detach";
		};
	};
	case "onUnload": {
		CTI_P_HookVehicle = objNull;
	};
};
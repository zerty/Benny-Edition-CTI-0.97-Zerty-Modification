_last_hook_check = -1;

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_hookmenu"}) exitWith {}; //--- Menu is closed.
	if !(alive CTI_P_HookVehicle) exitWith {closeDialog 0}; //--- Hooker is dead
	
	if (time - _last_hook_check > .75) then {
		_last_hook_check = time;
		_hooked = CTI_P_HookVehicle getVariable "cti_hooked";
		if (isNil '_hooked') then {_hooked = objNull};
		_has_something = false;
	
		if (_hooked distance CTI_P_HookVehicle < 50) then {
			_has_something = true;
		};
		
		if (_has_something) then {
			if ((uiNamespace getVariable "cti_dialog_ui_hookmenu_hooked") != _hooked) then {
				_var_name = if (isNil {_hooked getVariable "cti_customid"}) then {typeOf _hooked} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _hooked getVariable "cti_customid"]};
				_var_classname = missionNamespace getVariable _var_name;
				_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _hooked >> "displayName")};
				((uiNamespace getVariable "cti_dialog_ui_hookmenu") displayCtrl 240003) ctrlSetText format["Hooked: %1", _label];
				
				uiNamespace setVariable ["cti_dialog_ui_hookmenu_hooked", _hooked];
			};
		} else {
			if (((uiNamespace getVariable "cti_dialog_ui_hookmenu_hooked") == _hooked) || (isNull(uiNamespace getVariable "cti_dialog_ui_hookmenu_hooked") && isNull _hooked)) then {
				((uiNamespace getVariable "cti_dialog_ui_hookmenu") displayCtrl 240003) ctrlSetText "";
			};
		};
	};
	
	sleep .1;
};
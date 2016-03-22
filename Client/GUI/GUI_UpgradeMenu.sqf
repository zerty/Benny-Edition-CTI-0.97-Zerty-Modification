_last_funds = -1;
_last_running = -1;
_last_upgrades_check = -1;
_last_upgrades_tcheck = -1;

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_upgrademenu"}) exitWith {}; //--- Menu is closed.

	_selected = lnbCurSelRow ((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250002);
	if (_selected > -1) then {
		_selected = lnbValue [250002, [_selected, 1]];
		_funds = call CTI_CL_FNC_GetPlayerFunds;

		if (_last_funds != _funds) then {
			(_selected) call CTI_UI_Upgrade_LoadUpgradeInfo;
		};

		_last_funds = _funds;
	};

	if (time - _last_upgrades_check > .75) then {
		_last_upgrades_check = time;
		_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
		_need_reload = false;

		for '_i' from 0 to ((lnbSize 250002) select 0)-1 do {
			_value = lnbValue[250002, [_i, 0]];
			if ((_upgrades select _i) != _value) then {
				if (_i == _selected) then {_need_reload = true};
				((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250002) lnbSetText [[_i, 0], format["%1/%2", _upgrades select _i, (missionNamespace getVariable Format["CTI_%1_UPGRADES_LEVELS", CTI_P_SideJoined]) select _i]];
				((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250002) lnbSetValue [[_i, 0], _upgrades select _i];
			};
		};

		if (_need_reload) then {(_selected) call CTI_UI_Upgrade_LoadUpgradeInfo};
	};

	_running = CTI_P_SideLogic getVariable "cti_upgrade";
	if (_running != _last_running || (time - _last_upgrades_tcheck > 5)) then {
		_last_upgrades_tcheck = time;
		_last_running = _running;
		_html = "";
		if (_running > -1) then {
			_html = format [localize "STR_GUI_UPGRADES_LABELS", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select _running) select 0,CTI_P_SideLogic getVariable "cti_upgrade_lt"];
		};
		((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250009) ctrlSetStructuredText parseText _html;
	};

	sleep .1;
};
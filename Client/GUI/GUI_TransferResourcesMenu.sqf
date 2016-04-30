_last_funds = -1;
_last_infocheck = -100;
_last_grp_funds = -1;
_last_income_commander = -1;
_last_income_players = -1;

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu"}) exitWith {}; //--- Menu is closed.

	if (time - _last_infocheck > 1 || uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu_forceupdate") then {
		_last_infocheck = time;
		if (uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu_forceupdate") then { uiNamespace setVariable ["cti_dialog_ui_transferresourcesmenu_forceupdate", false] };

		{
			_funds = [_x, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
			if (((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140001) lnbText [_forEachIndex, 0] != format ["$%1", _funds]) then {
				((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140001) lnbSetText [[_forEachIndex, 0], format ["$%1", _funds]];
			};
		} forEach (uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu_groups");

		_incomes = call CTI_CL_FNC_GetIncomes;
		_income_commander = round(_incomes select 0);
		_income_players = round(_incomes select 1);

		if (_income_commander != _last_income_commander || _income_players != _last_income_players) then {
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140010) ctrlSetStructuredText (parseText format[localize "STR_Сmd_Pool", CTI_P_Coloration_Money, _income_commander]);
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140011) ctrlSetStructuredText (parseText format[localize "STR_Player_Pool", CTI_P_Coloration_Money, _income_players]);
			_last_income_commander = _income_commander;
			_last_income_players = _income_players;
		};
	};

	_funds = call CTI_CL_FNC_GetPlayerFunds;
	if (_funds != _last_funds) then {
		((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140008) sliderSetRange [0, _funds-(missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side group player])];
		((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140002) ctrlSetStructuredText (parseText format[localize "STR_Your_Rsc", CTI_P_Coloration_Money, _funds]);
		_last_funds = _funds;
	};

	if (!isNil {uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu_group"}) then {
		_funds = [uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu_group", CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
		if (_funds != _last_grp_funds) then {
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140003) ctrlSetStructuredText (parseText format[localize "STR_Player_Rsc", CTI_P_Coloration_Money, _funds]);
			_last_grp_funds = _funds;
		};
	};

	sleep .1;
};

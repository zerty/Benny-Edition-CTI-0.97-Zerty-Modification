_last_funds = -1;

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_teamsmenu"}) exitWith {}; //--- Menu is closed.
	
	{
		_funds = [_x, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
		_lives = {alive _x} count units _x;
		_independent = if (_x getVariable "cti_independent") then {"On"} else {"Off"};
		_squad = missionNamespace getVariable format ["CTI_SQUAD_%1_%2", CTI_P_SideJoined, _x getVariable "cti_role"];
		_squad = if !(isNil '_squad') then { _squad select 0 } else { _x getVariable "cti_role" };
		_order = _x getVariable "cti_order";
		
		// if (((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbValue [_forEachIndex, 1] != _lives) then {
		if (lnbValue [190001, [_forEachIndex, 1]] != _lives) then {
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetText [[_forEachIndex, 1], str(_lives)];
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetValue [[_forEachIndex, 1], _lives];
		};
		// if (((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbValue [_forEachIndex, 5] != _order) then {
		if (lnbValue [190001, [_forEachIndex, 5]] != _order) then {
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetText [[_forEachIndex, 5], (_order) call CTI_CL_FNC_GetOrderLabel];
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetValue [[_forEachIndex, 5], _order];
		};
		if (((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbText [_forEachIndex, 2] != format ["$%1", _funds]) then {((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetText [[_forEachIndex, 2], format ["$%1", _funds]]};
		if (((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbText [_forEachIndex, 3] != _independent) then {((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetText [[_forEachIndex, 3], _independent]};
		if (((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbText [_forEachIndex, 4] != _squad) then {((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetText [[_forEachIndex, 4], _squad]};
	} forEach (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups");
	
	_funds = call CTI_CL_FNC_GetPlayerFunds;
	if (_funds != _last_funds) then {
		((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190004) ctrlSetStructuredText (parseText format[localize "STR_GUI_Resources", CTI_P_Coloration_Money, _funds]);
	};
	_last_funds = _funds;
	
	sleep .1;
};

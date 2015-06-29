CTI_UI_AIMicromanagement_GetOrdersParameters = {
	_order = _this;

	lbClear ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010);

	switch (true) do {
		case (_order in [CTI_ORDER_CLIENT_TAKETOWNS, CTI_ORDER_CLIENT_TAKEHOLDTOWNS]): {
			_towns = (CTI_P_SideID) call CTI_CO_FNC_GetEnemyTowns;
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbAdd "* - Closest Town";
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbSetValue [0, -1];

			uiNamespace setVariable ["cti_dialog_ui_aimicromenu_order_targets", _towns];

			{
				((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbAdd format["TOWN: %1", _x getVariable "cti_town_name"];
				((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbSetValue [_forEachIndex+1, _forEachIndex];
			} forEach _towns;

			lbSort ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010);
		};
		case (_order in [CTI_ORDER_CLIENT_HOLDTOWNSBASES]): {
			_towns = (CTI_P_SideID) call CTI_CO_FNC_GetFriendlyTowns;
			_base = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbAdd "* - Closest";
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbSetValue [0, -1];

			uiNamespace setVariable ["cti_dialog_ui_aimicromenu_order_targets", _towns + _base];

			_u = 0;
			{
				((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbAdd format["TOWN: %1", _x getVariable "cti_town_name"];
				((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbSetValue [_u+1, _u];
				_u = _u + 1;
			} forEach _towns;

			{
				_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _x getVariable "cti_structure_type"];
				_value = (_var select 0) select 1;
				((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbAdd format["BASE: %1 (%2)", _value, mapGridPosition getPos _x];
				((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbSetValue [_u+1, _u];
				_u = _u + 1;
			} forEach _base;

			lbSort ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010);
		};
	};
};

CTI_UI_AIMicromanagement_TrySetOrder = {
	private ["_ai", "_order", "_order_pos", "_order_pos_new"];
	_ai = _this select 0;
	_order = _this select 1;
	_order_pos_new = _this select 2;

	if (_order != (_ai getVariable "cti_ai_order")) then {_ai setVariable ["cti_ai_order", _order]};
	if (typeName _order_pos_new != "BOOL") then {_ai setVariable ["cti_ai_order_pos", _order_pos_new]};
};

CTI_UI_AIMicromanagement_GetEffectiveUnits = {
	private ["_selection", "_units", "_units_effective"];
	_selection = _this;

	_units = uiNamespace getVariable "cti_dialog_ui_aimicromenu_units";
	_units_effective = [];
	{
		_value = ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002) lbValue _x;
		_who = _units select _value;
		if (alive _who) then {_units_effective pushBack _who};
	} forEach _selection;

	_units_effective
};

CTI_UI_AIMicromanagement_SetFormation = {
	private ["_units"];
	_units = _this;

	{_x setVariable ["cti_ai_formation", _units]} forEach _units;
};

CTI_UI_AIMicromanagement_UnregisterFormation = {
	private ["_units"];
	_units = _this;

	{
		_unit = _x;
		_formation = _x getVariable "cti_ai_formation";
		if (isNil '_formation') then {_formation = []};

		{
			_formation_sub = _x getVariable "cti_ai_formation";
			if (isNil '_formation_sub') then {_formation_sub = []};
			_x setVariable ["cti_ai_formation", _formation_sub - [_unit]];
			if !(isNil {_x getVariable "cti_ai_order_patrol_cn"}) then {_x setVariable ["cti_ai_order_patrol_cn", nil]};
		} forEach _formation;
	} forEach _units;
};
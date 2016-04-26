private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		_groups = if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 3 || CTI_P_SideJoined == west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 1 || CTI_P_SideJoined == east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 2 ) then {(CTI_P_SideJoined) call CTI_CO_FNC_GetSideGroups} else {(CTI_P_SideJoined) call CTI_CO_FNC_GetSidePlayerGroups};
		_commander = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideCommander;
		_groups = _groups - [_commander];
		// if (_commander != group player) exitWith {};

		uiNamespace setVariable ["cti_dialog_ui_teamsmenu_groups", _groups];

		{
			_squad = missionNamespace getVariable format ["CTI_SQUAD_%1_%2", CTI_P_SideJoined, _x getVariable "cti_role"];
			_squad = if !(isNil '_squad') then { _squad select 0 } else { _x getVariable "cti_role" };
			_order = (_x getVariable "cti_order") call CTI_CL_FNC_GetOrderLabel;
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbAddRow [format ["%1 (%2)", _x getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], if (isPlayer leader _x) then {
				name leader _x
			} else {
				"AI"
			}], str({alive _x} count units _x), format["$%1", [_x, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds], if (_x getVariable "cti_independent") then {
				"On"
			} else {
				"Off"
			}, _squad, _order];
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetValue [[_forEachIndex, 1], {alive _x} count units _x];
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001) lnbSetValue [[_forEachIndex, 5], _x getVariable "cti_order"];
		} forEach _groups;

		{((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190005) lbAdd _x} forEach ["On", "Off"];
		{
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016) lbAdd (_x select 0);
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016) lbSetValue [_forEachIndex, _x select 1];
		} forEach [["Take Towns", CTI_ORDER_TAKETOWNS],["Take Hold Towns", CTI_ORDER_TAKEHOLDTOWNS],["Hold Towns/Base", CTI_ORDER_HOLDTOWNSBASES],["Search and Destroy", CTI_ORDER_SAD],["Get In", CTI_ORDER_EMBARKCOMMANDVEH],["Get Out", CTI_ORDER_DISEMBARKCOMMANDVEH],["Get In (Cargo)", CTI_ORDER_EMBARKCARGOVEH],["Get Out (Cargo)", CTI_ORDER_DISEMBARKCARGOVEH]];

		{
			_get = missionNamespace getVariable format ["CTI_SQUAD_%1_%2", CTI_P_SideJoined, _x];
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006) lbAdd (_get select 0);
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006) lbSetData [_forEachIndex, _x];
		} forEach (missionNamespace getVariable format ["CTI_SQUADS_%1", CTI_P_SideJoined]);

		{
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190007) lbAdd format["$%1", _x];
			((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190007) lbSetValue [_forEachIndex, _x];
		} forEach [50, 100, 250, 500, 1000, 2500, 5000];
		((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190007) lbSetCurSel 3;

		execVM "Client\GUI\GUI_TeamsMenu.sqf";
	};
	case "onTeamListLBSelChanged": {
		_changeto = _this select 1;

		_who = (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups") select _changeto;
		_role = _who getVariable "cti_role";
		_order = _who getVariable "cti_order";

		((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190005) lbSetCurSel (if (_who getVariable "cti_independent") then {0} else {1});
		for '_i' from 0 to lbSize((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006)-1 do {
			if (((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006) lbData _i == _role) exitWith {((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006) lbSetCurSel _i};
		};
		for '_i' from 0 to lbSize((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016)-1 do {
			if (((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016) lbValue _i == _order) exitWith {((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016) lbSetCurSel _i};
		};
	};
	case "onSetTeamIndependentPressed": {
		_selected = lnbCurSelRow ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001);
		_independent_mode = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190005);

		if (_selected > -1 && _independent_mode > -1) then {
			_who = (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups") select _selected;
			_current_eta = if (_who getVariable "cti_independent") then {0} else {1};
			if (_independent_mode != _current_eta) then {_who setVariable ["cti_independent", if (_independent_mode == 0) then {true} else {false}, true]};
		};
	};
	case "onSetRolePressed": {
		_selected = lnbCurSelRow ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001);
		_role = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006);

		if (_selected > -1 && _role > -1) then {
			_who = (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups") select _selected;
			_role = ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006) lbData _role;
			if (_role != (_who getVariable "cti_role")) then {_who setVariable ["cti_role", _role, true]};
		};
	};
	case "onOrderPressed": {
		_selected = lnbCurSelRow ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001);
		_order = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016);

		if (_selected > -1 && _order > -1) then {
			_who = (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups") select _selected;
			_order = ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016) lbValue _order;
			if !(_order in CTI_AI_ORDERS_ONETIMERS) then {
				if (_order != (_who getVariable "cti_order")) then {_who setVariable ["cti_order", _order, true]};
			} else {
				if!(isPlayer leader _who) then {["SERVER", "Request_AIOrderAction", [_who, _order, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend};
			};
		};
	};
	case "onTransferFundsPressed": {
		_selected = lnbCurSelRow ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190001);
		_amount = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190007);

		if (_selected > -1 && _amount > -1) then {
			_who = (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups") select _selected;
			_amount = ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190007) lbValue _amount;
			_funds = call CTI_CL_FNC_GetPlayerFunds;

			if (_funds >= _amount && _who != group player) then {
				[_who, CTI_P_SideJoined, _amount] call CTI_CO_FNC_ChangeFunds;
				-(_amount) call CTI_CL_FNC_ChangePlayerFunds;
				hint parseText format [localize "STR_UI_Teams_Transfered", CTI_P_Coloration_Money, _amount, _who getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS]];
			};
		};
	};
	case "onSetAllTeamIndependentPressed": {
		_independent_mode = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190005);

		if (_independent_mode > -1) then {
			{
				_current_eta = if (_x getVariable "cti_independent") then {0} else {1};
				if (_independent_mode != _current_eta) then {_x  setVariable ["cti_independent", if (_independent_mode == 0) then {true} else {false}, true]};
			} forEach (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups");
		};
	};
	case "onSetAllRolePressed": {
		_role = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006);

		if (_role > -1) then {
			_role = ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190006) lbData _role;
			{if (_role != (_x getVariable "cti_role")) then {_x setVariable ["cti_role", _role, true]}} forEach (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups");
		};
	};
	case "onOrderAllPressed": { // todo: player?
		_order = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016);

		if (_order > -1) then {
			_order = ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190016) lbValue _order;
			if !(_order in CTI_AI_ORDERS_ONETIMERS) then {
				{if (_order != (_x getVariable "cti_order")) then {_x setVariable ["cti_order", _order, true]}} forEach (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups");
			} else {
				_ais = [];
				{if!(isPlayer leader _x) then {_ais pushBack _x}} forEach (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups");
				if (count _ais > 0) then {["SERVER", "Request_AIOrderAction", [_ais, _order, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend};
			};
		};
	};
	case "onTransferAllPressed": {
		_amount = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190007);

		if (_amount > -1) then {
			_amount = ((uiNamespace getVariable "cti_dialog_ui_teamsmenu") displayCtrl 190007) lbValue _amount;
			_funds = call CTI_CL_FNC_GetPlayerFunds;

			if (_funds >= (_amount * count(uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups"))) then {
				{[_x, CTI_P_SideJoined, _amount] call CTI_CO_FNC_ChangeFunds} forEach (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups");
				-(_amount * count(uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups")) call CTI_CL_FNC_ChangePlayerFunds;
				hint parseText format [localize "STR_UI_Teams_Transfered_Everyone", CTI_P_Coloration_Money, _amount];
			} else {
				hint parseText localize "STR_UI_Teams_Not_Resources";
			};
		};
	};
	case "onAllAIIndependentPressed": {
		_independent_mode = _this select 1;
		{
			_current_eta = if (_x getVariable "cti_independent") then {0} else {1};
			if (_independent_mode != _current_eta) then {_x  setVariable ["cti_independent", if (_independent_mode == 0) then {true} else {false}, true]};
		} forEach (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups");
	};
	case "onTeamDisband": {
		_selected = _this select 1;

		if (_selected > -1 && call CTI_CL_FNC_IsPlayerCommander) then {
			_selected = (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups") select _selected;
			if !(isPlayer leader _selected) then {
				_vehicles = [_selected, false] call CTI_CO_FNC_GetTeamVehicles;
				_units = (units _selected) call CTI_CO_FNC_GetLiveUnits;

				{_x setDammage 1} forEach (_vehicles + _units);
			};
		};
	};
};

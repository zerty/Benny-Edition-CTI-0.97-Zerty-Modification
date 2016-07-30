private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		_groups = if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 3 || CTI_P_SideJoined == west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 1 || CTI_P_SideJoined == east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 2 ) then {(CTI_P_SideJoined) call CTI_CO_FNC_GetSideGroups} else {(CTI_P_SideJoined) call CTI_CO_FNC_GetSidePlayerGroups};
		_percent_award = round((CTI_P_SideLogic getVariable "cti_pool_award") * 100);
		_percent_resources = round((CTI_P_SideLogic getVariable "cti_pool_resources") * 100);
		uiNamespace setVariable ["cti_dialog_ui_transferresourcesmenu_groups", _groups];
		uiNamespace setVariable ["cti_dialog_ui_transferresourcesmenu_group", nil];

		if !(call CTI_CL_FNC_IsPlayerCommander) then {
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140006) ctrlEnable false;
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140007) ctrlEnable false;
		};

		{
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140001) lnbAddRow [format["$%1", [_x, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds], format["[%1] %2", _x getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], if (isPlayer leader _x) then {name leader _x} else {"(AI)"}]];
		} forEach _groups;
		((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140001) lnbSetCurSelRow 0;

		_u = 0;
		for '_i' from (CTI_ECONOMY_POOL_RESOURCES_PERCENTAGE_MIN/10) to 10 do {
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140006) lbAdd format["%1", _i*10];
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140006) lbSetValue [_u, _i*10];
			if (_percent_resources == (_i*10)) then {((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140006) lbSetCurSel _u};
			_u = _u + 1;
		};

		for '_i' from 0 to 10 do {
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140007) lbAdd format["%1", _i*10];
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140007) lbSetValue [_i, _i*10];
			if (_percent_award == (_i*10)) then {((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140007) lbSetCurSel _i};
		};

		_funds = call CTI_CL_FNC_GetPlayerFunds;
		((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140008) sliderSetRange [0, _funds-(missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side group player]) ];
		((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140008) sliderSetPosition 0;

		uiNamespace setVariable ["cti_dialog_ui_transferresourcesmenu_forceupdate", false];

		execVM "Client\GUI\GUI_TransferResourcesMenu.sqf";
	};
	case "onGroupLBSelChanged": {
		_changeto = _this select 1;

		if (_changeto != -1) then {
			_group = (uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu_groups") select _changeto;
			_funds = [_group, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
			((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140003) ctrlSetStructuredText (parseText format[localize "STR_Group_Resources", CTI_P_Coloration_Money, _funds]);
			uiNamespace setVariable ["cti_dialog_ui_transferresourcesmenu_group", _group];
		};
	};
	case "onFundSliderChanged": {
		_amount = _this select 1;

		((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140009) ctrlSetText str round _amount;
	};
	case "onGivePlayerPressed": {
		_amount = floor parseNumber(ctrlText ((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140009));

		if (_amount > 0 && _amount <= (call CTI_CL_FNC_GetPlayerFunds - (missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side group player])) && ["PlayerHasGroup",[player]] call BIS_fnc_dynamicGroups) then {
			if (player == (leader group player)) then {
				_group = (uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu_groups") select (lnbCurSelRow 140001);
				if (_group != group player) then {
					/*_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid];
					[_group, CTI_P_SideJoined, _amount] call CTI_CO_FNC_ChangeFunds;
					-(_amount) call CTI_CL_FNC_ChangePlayerFunds;

					[["CLIENT", leader _group], "Client_OnMessageReceived", ["funds-transfer", [_amount ,(group player)]]] call CTI_CO_FNC_NetSend;
					hint parseText format [localize "STR_Transfered_To_Group", CTI_P_Coloration_Money, _amount, _group getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS]];
					uiNamespace setVariable ["cti_dialog_ui_transferresourcesmenu_forceupdate", true];

					_funds = call CTI_CL_FNC_GetPlayerFunds;*/
					["SERVER", "Server_Transfer_funds",[group player,((group player) getvariable "cti_funds"),  _group,_amount]] call CTI_CO_FNC_NetSend;
					hint parseText format[localize "STR_Request_Of_Transfer", CTI_P_Coloration_Money, _amount,name leader _group];
					0 spawn {sleep 5; hintSilent ""};
					/*if (_amount > _funds) then {
						((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140009) ctrlSetText str round _funds;
					};*/
				} else {
					hint parseText localize "STR_Transfered_To_Yourself";
				};
			}else {
				hint parseText localize "STR_Not_Leader";
			};
		} else {
			hint parseText localize "STR_Invalid_Operation";
		};
	};
	case "onAwardPoolLBSelChanged": {
		_changeto = _this select 1;

		if (call CTI_CL_FNC_IsPlayerCommander) then {
			_changeto = (((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140007) lbValue _changeto)/100;

			_percent_award = CTI_P_SideLogic getVariable "cti_pool_award";
			if (_changeto != _percent_award) then { CTI_P_SideLogic setVariable ["cti_pool_award", _changeto, true] };
		};
	};
	case "onResourcesPoolLBSelChanged": {
		_changeto = _this select 1;

		if (call CTI_CL_FNC_IsPlayerCommander) then {
			_changeto = (((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140006) lbValue _changeto)/100;

			_percent_resources = CTI_P_SideLogic getVariable "cti_pool_resources";
			if (_changeto != _percent_resources) then { CTI_P_SideLogic setVariable ["cti_pool_resources", _changeto, true] };
		};
	};
	case "onGoBack": {
		closeDialog 0;
		if (CTI_P_LastRootMenu == "Commanding") then {
			createDialog "CTI_RscCommandMenu";
		} else {
			createDialog "CTI_RscOptionsMenu";
		};
	};
};

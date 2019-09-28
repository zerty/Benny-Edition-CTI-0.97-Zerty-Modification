private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		_players= allPlayers- entities "HeadlessClient_F";
		uiNamespace setVariable ["cti_dialog_ui_comblacklist_players", _players];
		uiNamespace setVariable ["cti_dialog_ui_comblacklist_uuid", nil];
		lbClear ((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999001) ;
		{
			((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999001) lbAdd (name _x);
			if ((CTI_P_SideLogic getvariable ["CTI_COM_BLACKLIST_GLOBAL",[]]) find (getPlayerUID _x) >=0 ) then {
				((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999001) lbSetColor [_foreachindex, [1,0,0,1]];
			} else {
				((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999001) lbSetColor [_foreachindex, [0,1,0,1]];
			};
		} forEach _players;
		((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999001) lnbSetCurSelRow 0;
		((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999001) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999002) ctrlEnable false;
		((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999002) ctrlCommit 0;
	};
	case "onUnload": {};

	case "onLBSelChanged": {
		_changed= _this select 1;
		if (_changed >=0) then {
			_player= getPlayerUID( (uiNamespace getVariable ["cti_dialog_ui_comblacklist_players", []]) select _changed);
			if ((CTI_P_SideLogic getvariable ["CTI_COM_BLACKLIST_GLOBAL",[]]) find _player >=0 ) then {
				((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999002) ctrlSetText "Allow";
			} else {
				((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999002) ctrlSetText "Block";
			};
			uiNamespace setVariable ["cti_dialog_ui_comblacklist_uuid", _player];

			((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999002) ctrlEnable true;
			((uiNamespace getVariable "cti_dialog_ui_comblacklist") displayCtrl 999002) ctrlCommit 0;
		};
	};
	case "onBlacklist" :{

		if !(isnil {uiNamespace getVariable "cti_dialog_ui_comblacklist_uuid"}) then {
			hint format["%1",uiNamespace getVariable "cti_dialog_ui_comblacklist_uuid"];
			["SERVER", "Server_Update_BL", uiNamespace getVariable "cti_dialog_ui_comblacklist_uuid"] call CTI_CO_FNC_NetSend;
		};
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Old_Com_Eject\Events_UI_combl.sqf';
	};

};
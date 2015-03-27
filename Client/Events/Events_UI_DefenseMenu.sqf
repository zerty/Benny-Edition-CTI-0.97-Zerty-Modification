private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		execVM "Client\GUI\GUI_DefenseMenu.sqf";
		if (isNil 'CTI_P_WallsAutoAlign') then { CTI_P_WallsAutoAlign = true };
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [200003, "Auto-Align Walls: On"] } else { ctrlSetText [200003, "Auto-Align Walls: Off"] };

		{
			_var = missionNamespace getVariable _x;

			_condition = {true};
			{if (_x select 0 == "Condition") exitWith {_condition = _x select 1}} forEach (_var select 5);

			if (call _condition) then {
				_row = ((uiNamespace getVariable "cti_dialog_ui_defensemenu") displayCtrl 200007) lnbAddRow [format ["$%1", _var select 2], _var select 0];
				((uiNamespace getVariable "cti_dialog_ui_defensemenu") displayCtrl 200007) lnbSetData [[_row, 0], _x];
			};
		} forEach (missionNamespace getVariable format ["CTI_%1_DEFENSES", CTI_P_SideJoined]);

		if !(isNil {uiNamespace getVariable "cti_dialog_ui_defensemenu_lastdsel"}) then {((uiNamespace getVariable "cti_dialog_ui_defensemenu") displayCtrl 200007) lnbSetCurSelRow (uiNamespace getVariable "cti_dialog_ui_defensemenu_lastdsel")};
	};
	case "onBuildDefense": {
		_selected = _this select 1;

		//if (_selected != -1) then {
			if (typeName _selected == "SCALAR") then {_selected = lnbData[200007, [_selected, 0]];};

			_var = missionNamespace getVariable _selected;
			_funds = call CTI_CL_FNC_GetPlayerFunds;

			if (_funds >= (_var select 2)) then { //--- Check if we have enough funds to go in the construction mode.
				CTI_VAR_StructurePlaced = false;
				CTI_P_RapidDefence=_selected;
				{player removeAction _x;true}count CTI_P_RapidDefence_Actions;
				[_selected, uiNamespace getVariable "cti_dialog_ui_defensemenu_target", CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_PlacingDefense;
				_rdb= player addAction [format ["<t color='#ff9900'>Build %1<t>",_var select 0],"['onBuildDefense', (_this select 3)] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_DefenseMenu.sqf'",CTI_P_RapidDefence,10001,false,false,"","_target == player && !CTI_P_PreBuilding  && _this == player"];
				CTI_P_RapidDefence_Actions set [count CTI_P_RapidDefence_Actions,_rdb];
				_rdc= player addAction ["<t color='#ff9900'>Cancel Fast building<t>","{player removeAction _x;true}count CTI_P_RapidDefence_Actions;",CTI_P_RapidDefence,10000,false,false,"","_target == player && !CTI_P_PreBuilding &&  _this == player"];
				CTI_P_RapidDefence_Actions set [count CTI_P_RapidDefence_Actions,_rdc];
				closeDialog 0;
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to place that defense.";
			};
		//};
	};
	case "onAutoAlign": {
		CTI_P_WallsAutoAlign = !CTI_P_WallsAutoAlign;
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [200003, "Auto-Align Walls: On"] } else { ctrlSetText [200003, "Auto-Align Walls: Off"] };
	};
	case "onUndoDefense": {
		if !(isNull CTI_P_LastDefenseBuilt) then {
			deleteVehicle CTI_P_LastDefenseBuilt;
		};
	};
	case "onUnload": {
		//--- Memorize
		_curSelDefense = lnbCurSelRow 200007;

		if (_curSelDefense > -1) then {uiNamespace setVariable ["cti_dialog_ui_defensemenu_lastdsel", _curSelDefense]};
		//uiNamespace setVariable ["cti_dialog_ui_defensemenu_target", nil];
	};
};

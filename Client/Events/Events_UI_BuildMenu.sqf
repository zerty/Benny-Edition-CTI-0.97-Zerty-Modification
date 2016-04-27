private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		execVM "Client\GUI\GUI_BuildMenu.sqf";
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [100003, localize "STR_Walls_On"] } else { ctrlSetText [100003, localize "STR_Walls_Off"] };
		_def_count=count (units ((CTI_P_SideLogic getVariable ["cti_defensive_team",grpNull])));

		if (CTI_P_DefensesAutoManning) then { ctrlSetText [100011, format [localize "STR_Defenses_On",ctrlText ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100011),_def_count,CTI_BASE_DEFENSES_AUTO_LIMIT ]] } else { ctrlSetText [100011,ctrlSetText [100011, format [localize "STR_Defenses_Off",ctrlText ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100011),_def_count,CTI_BASE_DEFENSES_AUTO_LIMIT ]] ] };
		if ((missionnamespace getVariable "CTI_BASEBUILDING") < 1) then {
			((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100005) ctrlSetText format [localize "STR_Add_Worker", CTI_BASE_WORKERS_PRICE];
			((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100009) ctrlshow true;
			((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100005) ctrlshow true;
		} else {
			((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100009) ctrlshow false;
			((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100005) ctrlshow false;

		};
		{
			_var = missionNamespace getVariable _x;
			_row = ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100006) lnbAddRow [format ["$%1", _var select 2], (_var select 0) select 1];
			((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100006) lnbSetData [[_row, 0], _x];
		} forEach (missionNamespace getVariable format ["CTI_%1_STRUCTURES", CTI_P_SideJoined]);

		if !(isNil {uiNamespace getVariable "cti_dialog_ui_buildmenu_lastbsel"}) then {((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100006) lnbSetCurSelRow (uiNamespace getVariable "cti_dialog_ui_buildmenu_lastbsel")};

		{
			_var = missionNamespace getVariable _x;

			_condition = {true};
			{if (_x select 0 == "Condition") exitWith {_condition = _x select 1}} forEach (_var select 5);

			if (call _condition) then {
				_row = ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100007) lnbAddRow [format ["$%1", _var select 2], _var select 0];
				((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100007) lnbSetData [[_row, 0], _x];
			};
		} forEach (missionNamespace getVariable format ["CTI_%1_DEFENSES", CTI_P_SideJoined]);

		if !(isNil {uiNamespace getVariable "cti_dialog_ui_buildmenu_lastdsel"}) then {((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100007) lnbSetCurSelRow (uiNamespace getVariable "cti_dialog_ui_buildmenu_lastdsel")};

		//--- Set the worker price

		// CTI_BASE_WORKERS_LIMIT
		// 100005
	};
	case "onBuildStructure": {
		_selected = _this select 1;

		if (_selected != -1) then {
			_selected = lnbData[100006, [_selected, 0]];

			_var = missionNamespace getVariable _selected;
			_funds = call CTI_CL_FNC_GetPlayerFunds;

			if (_funds >= (_var select 2)) then { //--- Check if we have enough funds to go in the construction mode.
				CTI_VAR_StructurePlaced = false;
				[_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_PlacingBuilding;
				closeDialog 0;
			} else {
				hint parseText localize "STR_BuildMenu_Info";
			};
		};
	};
	case "onBuildDefense": {
		_selected = _this select 1;

		//if (_selected != -1) then {
			if (typeName _selected == "SCALAR") then {_selected = lnbData[100007, [_selected, 0]];};
			//_selected = lnbData[100007, [_selected, 0]];

			_var = missionNamespace getVariable _selected;
			_funds = call CTI_CL_FNC_GetPlayerFunds;

			if (_funds >= (_var select 2)) then { //--- Check if we have enough funds to go in the construction mode.
				CTI_P_RapidDefence=_selected;
				CTI_VAR_StructurePlaced = false;
				{player removeAction _x;true}count CTI_P_RapidDefence_Actions;
				[_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_PlacingDefense;
				_rdb= player addAction [format [localize "STR_Build",_var select 0],"['onBuildDefense', (_this select 3)] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_BuildMenu.sqf'",CTI_P_RapidDefence,10001,false,false,"","_target == player && !CTI_P_PreBuilding && CTI_Base_HQInRange && _this == player"];
				CTI_P_RapidDefence_Actions set [count CTI_P_RapidDefence_Actions,_rdb];
				_rdc= player addAction [localize "STR_Cancel_Build","{player removeAction _x;true}count CTI_P_RapidDefence_Actions;",CTI_P_RapidDefence,10000,false,false,"","_target == player && !CTI_P_PreBuilding && CTI_Base_HQInRange && _this == player"];
				CTI_P_RapidDefence_Actions set [count CTI_P_RapidDefence_Actions,_rdc];
				closeDialog 0;
			} else {
				hint parseText localize "STR_BuildMenu_Info";
			};
		//};
	};
	case "onAutoAlign": {
		// CTI_P_WallsAutoAlign = if (CTI_P_WallsAutoAlign) then {false} else {true};
		CTI_P_WallsAutoAlign = !CTI_P_WallsAutoAlign;
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [100003, localize "STR_Walls_On"] } else { ctrlSetText [100003, localize "STR_Walls_Off"] };
	};
	case "onAutoManning": {
		CTI_P_DefensesAutoManning = !CTI_P_DefensesAutoManning;
		_def_count=count (units ((CTI_P_SideLogic getVariable ["cti_defensive_team",grpNull])));
		if (CTI_P_DefensesAutoManning) then { ctrlSetText [100011, format [localize "STR_Defenses_On",ctrlText ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100011),_def_count,CTI_BASE_DEFENSES_AUTO_LIMIT ]] } else { ctrlSetText [100011,ctrlSetText [100011, format [localize "STR_Defenses_Off",ctrlText ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100011),_def_count,CTI_BASE_DEFENSES_AUTO_LIMIT ]] ] };
	};
	case "onAddWorker": {
		//--- Check the worker limit
		_workers = CTI_P_SideLogic getVariable "cti_workers";

		_count = 0;
		{
			switch (typeName _x) do {
				case "STRING": { _count = _count + 1 };
				case "OBJECT": { if (alive _x) then { _count = _count + 1 } };
			};
		} forEach _workers;

		if (_count < CTI_BASE_WORKERS_LIMIT) then {
			_funds = call CTI_CL_FNC_GetPlayerFunds;
			if (_funds >= CTI_BASE_WORKERS_PRICE) then {
				-(CTI_BASE_WORKERS_PRICE) call CTI_CL_FNC_ChangePlayerFunds;
				//CTI_P_SideLogic setVariable ["cti_workers", _workers + [""], true];

				["SERVER", "Request_Worker", [CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;
			} else {
				hint "not enough funds dude";
			};
		} else {
			hint "worker limit reached";
		};
	};
	case "onUndoDefense": {
		if !(isNull CTI_P_LastDefenseBuilt) then {
			deleteVehicle CTI_P_LastDefenseBuilt;
		};
	};
	case "onUndoStructure": {
		if !(isNull CTI_P_LastStructurePreBuilt) then {
			deleteVehicle CTI_P_LastStructurePreBuilt;
		};
	};
	case "onUnload": {
		//--- Memorize
		_curSelBuilding = lnbCurSelRow 100006;
		_curSelDefense = lnbCurSelRow 100007;

		if (_curSelBuilding > -1) then {uiNamespace setVariable ["cti_dialog_ui_buildmenu_lastbsel", _curSelBuilding]};
		if (_curSelDefense > -1) then {uiNamespace setVariable ["cti_dialog_ui_buildmenu_lastdsel", _curSelDefense]};
	};
};

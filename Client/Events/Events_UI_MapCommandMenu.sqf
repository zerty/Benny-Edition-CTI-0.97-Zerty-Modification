private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		_groups = if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 3 || CTI_P_SideJoined == west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 1 || CTI_P_SideJoined == east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 2 ) then {(CTI_P_SideJoined) call CTI_CO_FNC_GetSideGroups} else {(CTI_P_SideJoined) call CTI_CO_FNC_GetSidePlayerGroups};
		_commander = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideCommander;
		_groups = _groups - [_commander];

		uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_group_current", grpNull];
		uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_group_current_order", -1];
		uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_mapclick", false];

		uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_groups", _groups];

		((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220002) lnbAddRow ["All"];
		((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220002) lnbSetValue [[0, 0], -1];
		_markers = [];
		{
			_order = (_x getVariable "cti_order") call CTI_CL_FNC_GetOrderLabel;
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220002) lnbAddRow [_x getVariable ["cti_alias", CTI_PLAYER_DEFAULT_ALIAS], _order];
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220002) lnbSetValue [[_forEachIndex+1, 0], _forEachIndex];
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220002) lnbSetValue [[_forEachIndex+1, 1], _order];

			_markerLine = format["cti_commandline_%1", CTI_P_MarkerIterator];
			CTI_P_MarkerIterator = CTI_P_MarkerIterator + 1;
			_markers pushBack _markerLine;
			[_x, _markerLine] spawn CTI_UI_MapCommanding_TrackGroupOrder;
		} forEach _groups;

		uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_markers", _markers];

		{
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220009) lbAdd (_x select 0);
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220009) lbSetValue [_forEachIndex, _x select 1];
		} forEach [["Take Towns", CTI_ORDER_TAKETOWNS],["Take Hold Towns", CTI_ORDER_TAKEHOLDTOWNS],["Hold Towns/Base", CTI_ORDER_HOLDTOWNSBASES],["Move", CTI_ORDER_MOVE],["Search and Destroy", CTI_ORDER_SAD],["Get In", CTI_ORDER_EMBARKCOMMANDVEH],["Get Out", CTI_ORDER_DISEMBARKCOMMANDVEH],["Get In (Cargo)", CTI_ORDER_EMBARKCARGOVEH],["Get Out (Cargo)", CTI_ORDER_DISEMBARKCARGOVEH]];

		execVM "Client\GUI\GUI_MapCommandingMenu.sqf";
	};
	case "onUnitListLBSelChanged": {
		_selected = _this select 1;

		_value = lnbValue [220002, [_selected, 0]];

		_markers = uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_markers";
		if (_value > -1) then {
			_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
			_order = _who getVariable "cti_order";

			{if (markerAlpha _x >= 1) then {_x setMarkerAlphaLocal 0.2}} forEach _markers;
			(_markers select _value) setMarkerAlphaLocal 1;

			_current = uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_group_current";
			if (_current != _who) then { //--- Only refresh if needed
				uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_group_current", _who];
				for '_i' from 0 to lbSize(220009)-1 do {
					if (_order == (((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220009) lbValue _i)) exitWith {
						((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220009) lbSetCurSel _i;
					};
				};

				// (_who) spawn CTI_UI_MapCommanding_TrackGroupOrder;
				(_order) call CTI_UI_MapCommanding_GetOrdersParameters;
			};
		} else {
			{if (markerAlpha _x < 1) then {_x setMarkerAlphaLocal 1}} forEach _markers;
		};
	};
	case "onOrdersListLBSelChanged": {
		_selected = _this select 1;

		_selected = ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220009) lbValue _selected;
		uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_order", _selected];
		(_selected) call CTI_UI_MapCommanding_GetOrdersParameters;
	};
	case "onOrdersListLBDblClick": {
		_selected = _this select 1;
		_order = ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220009) lbValue _selected;

		_value = lnbCurSelRow 220002;
		if (_value > -1) then {
			_value = lnbValue [220002, [_value, 0]];
			_all = if (_value < 0) then {true} else {false};

			switch (true) do {
				case (_order in [CTI_ORDER_TAKETOWNS, CTI_ORDER_HOLDTOWNSBASES, CTI_ORDER_TAKEHOLDTOWNS]): {
					if (_all) then {
						{[_x, _order, [0,0]] call CTI_UI_MapCommanding_TrySetOrder} forEach (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups");
					} else {
						_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
						[_who, _order, [0,0]] call CTI_UI_MapCommanding_TrySetOrder;
					};
				};
				case (_order == CTI_ORDER_MOVE): {
					uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_mapclick", true];
					((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220013) ctrlSetStructuredText parseText format["<t color='#efa12b' align='center'>Click on the map to terminate the order assignment</t>"];
				};
				//todo SAD
				case (_order in CTI_AI_ORDERS_ONETIMERS): {
					if (_all) then {
						_ais = [];
						{if!(isPlayer leader _x) then {_ais pushBack _x}} forEach (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups");
						if (count _ais > 0) then {["SERVER", "Request_AIOrderAction", [_ais, _order, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend};
					} else {
						_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
						if!(isPlayer leader _who) then {["SERVER", "Request_AIOrderAction", [_who, _order, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend};
					};
				};
			};
		};
	};
	case "onUnitListLBDblClick": {
		_selected = _this select 1;

		_value = lnbValue [220002, [_selected, 0]];

		if (_value > -1) then {
			_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
			ctrlMapAnimClear ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220001);
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220001) ctrlMapAnimAdd [.65, .35, getPos leader _who];
			ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220001);
		};
	};
	case "onOrdersParamLBDblClick": {
		_selected = _this select 1;

		_selected = ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbValue _selected;

		if (_selected > -1) then {
			_selected = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_order_targets") select _selected;

			ctrlMapAnimClear ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220001);
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220001) ctrlMapAnimAdd [.65, .20, getPos _selected];
			ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220001);
		};
	};
	case "onMapButtonDown": {
		_event = _this select 1;
		_button = _event select 1;
		_mx = _event select 2;
		_my = _event select 3;

		if (_button == 0 && uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_mapclick") then {
			uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_mapclick", false];
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220013) ctrlSetStructuredText parseText "";

			_value = lnbCurSelRow 220002;
			if (_value > -1) then {
				_value = lnbValue [220002, [_value, 0]];
				_all = if (_value < 0) then {true} else {false};

				_order = uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_order";
				switch (_order) do { //--- Transform generic to singles
					case CTI_ORDER_TAKETOWNS: {_order = CTI_ORDER_TAKETOWN};
					case CTI_ORDER_TAKEHOLDTOWNS: {_order = CTI_ORDER_TAKEHOLDTOWN};
					case CTI_ORDER_HOLDTOWNSBASES: {_order = CTI_ORDER_HOLDTOWNSBASE};
				};
				_mappos = ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220001) ctrlMapScreenToWorld [_mx, _my];
				switch (true) do {
					case (_order in [CTI_ORDER_TAKETOWN, CTI_ORDER_TAKEHOLDTOWN]): {
						_nearest = [_mappos, CTI_P_SideID] call CTI_CO_FNC_GetClosestEnemyTown;
						if !(isNull _nearest) then {
							if (_mappos distance _nearest < 500) then {
								if (_all) then {
									{[_x, _order, _nearest] call CTI_UI_MapCommanding_TrySetOrder} forEach (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups");
								} else {
									_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
									[_who, _order, _nearest] call CTI_UI_MapCommanding_TrySetOrder;
								};
							};
						};
					};
					case (_order == CTI_ORDER_HOLDTOWNSBASE): {
						_closest_town = [_mappos, CTI_P_SideID] call CTI_CO_FNC_GetClosestFriendlyTown;
						_list = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
						if !(isNull _closest_town) then {_list pushBack _closest_town}; //--- Add the closest town
						_nearest = [_mappos, _list] call CTI_CO_FNC_GetClosestEntity;
						if !(isNull _nearest) then {
							if (_mappos distance _nearest < 500) then {
								if (_all) then {
									{[_x, _order, _nearest] call CTI_UI_MapCommanding_TrySetOrder} forEach (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups");
								} else {
									_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
									[_who, _order, _nearest] call CTI_UI_MapCommanding_TrySetOrder;
								};
							};
						};
					};
					case (_order == CTI_ORDER_MOVE): {
						if !(surfaceIsWater _mappos) then {
							if (_all) then {
								{[_x, _order, _mappos] call CTI_UI_MapCommanding_TrySetOrder} forEach (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups");
							} else {
								_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
								[_who, _order, _mappos] call CTI_UI_MapCommanding_TrySetOrder;
							};
						};
					};
				};
			};
		};
	};
	case "onSetOrderPressed": {
		_value = lnbCurSelRow 220002;
		if (_value > -1) then {
			_value = lnbValue [220002, [_value, 0]];

			_all = if (_value < 0) then {true} else {false};
			_order = uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_order";

			if !(isNil '_order') then {
				_blacklisted = [CTI_ORDER_MOVE];

				if (_order in _blacklisted) exitWith {}; //--- Prevent map-click orders only from being set here. todo: display a message to the client bout it

				//--- Parameters?
				_target = [];
				_setposition = false;
				_selected_param = lbCurSel 220010;
				if (lbSize 220010 > 0 && _selected_param > -1) then {
					_selected = ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbValue _selected_param;
					_setposition = true;
					if (_selected < 0 && _order in [CTI_ORDER_TAKETOWNS, CTI_ORDER_HOLDTOWNSBASES, CTI_ORDER_TAKEHOLDTOWNS]) exitWith {_target = [0,0]};
					switch (_order) do { //--- Transform generic to singles
						case CTI_ORDER_TAKETOWNS: {_order = CTI_ORDER_TAKETOWN};
						case CTI_ORDER_TAKEHOLDTOWNS: {_order = CTI_ORDER_TAKEHOLDTOWN};
						case CTI_ORDER_HOLDTOWNSBASES: {_order = CTI_ORDER_HOLDTOWNSBASE};
					};
					_target = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_order_targets") select _selected;
					if !(alive _target) exitWith {_setposition = false};
				};

				if !(_order in CTI_AI_ORDERS_ONETIMERS) then {
					_posto = if (_setposition) then {_target} else {false};
					if (_all) then {
						{[_x, _order, _posto] call CTI_UI_MapCommanding_TrySetOrder} forEach (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups");
					} else {
						_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
						[_who, _order, _posto] call CTI_UI_MapCommanding_TrySetOrder;
					};
				} else {
					if (_all) then {
						_ais = [];
						{if!(isPlayer leader _x) then {_ais pushBack _x}} forEach (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups");
						if (count _ais > 0) then {["SERVER", "Request_AIOrderAction", [_ais, _order, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend};
					} else {
						_who = (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups") select _value;
						if!(isPlayer leader _who) then {["SERVER", "Request_AIOrderAction", [_who, _order, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend};
					};
				};
			};
		};
		// _value = lnbValue [220002, [_selected, 0]];
	};
	case "onSetMapOrderPressed": {
		_value = lnbCurSelRow 220002;
		if (_value > -1) then {
			_value = lnbValue [220002, [_value, 0]];

			_all = if (_value < 0) then {true} else {false};
			_order = uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_order";

			if !(isNil '_order') then {
				uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_mapclick", true];
				((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220013) ctrlSetStructuredText parseText format["<t color='#efa12b' align='center'>Click on the map to terminate the order assignment</t>"];
			};
		};
	};
};
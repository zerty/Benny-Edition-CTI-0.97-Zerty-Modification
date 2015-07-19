private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		_units = (units player - [player]) call CTI_CO_FNC_GetLiveUnits;
		uiNamespace setVariable ["cti_dialog_ui_aimicromenu_units", _units];

		uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick", false];
		uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick_queued", []];

		{
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002) lbAdd format ["[%1] %2 - %3",(_x) call CTI_CL_FNC_GetAIDigit, getText(configFile >> "CfgVehicles" >> typeOf vehicle _x >> "displayName"), (_x getVariable "cti_ai_order") call CTI_CL_FNC_GetAIOrderLabel];
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002) lbSetValue [_forEachIndex, _forEachIndex];
		} forEach _units;

		{
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270009) lbAdd (_x select 0);
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270009) lbSetValue [_forEachIndex, _x select 1];
		} forEach [["Take Towns", CTI_ORDER_CLIENT_TAKETOWNS],["Take Hold Towns", CTI_ORDER_CLIENT_TAKEHOLDTOWNS],["Hold Towns/Base", CTI_ORDER_CLIENT_HOLDTOWNSBASES],["Move", CTI_ORDER_CLIENT_MOVE],["Patrol", CTI_ORDER_CLIENT_PATROL],["Search and Destroy", CTI_ORDER_CLIENT_SAD]];

		//todo add another list for orders since there's no lbSetText...
		// execVM "Client\GUI\GUI_AIMicromanagementMenu.sqf";
	};
	case "onOrdersListLBSelChanged": {
		_selected = _this select 1;
		_selected = ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270009) lbValue _selected;

		// uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_order", _selected];
		(_selected) call CTI_UI_AIMicromanagement_GetOrdersParameters;
	};
	case "onOrdersListLBDblClick": {
		_selected = _this select 1;
		_order = ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270009) lbValue _selected;

		_selection = lbSelection ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002);
		if (count _selection > 0) then {
			_units_effective = (_selection) call CTI_UI_AIMicromanagement_GetEffectiveUnits;
			switch (true) do {
				case (_order in [CTI_ORDER_CLIENT_TAKETOWNS, CTI_ORDER_CLIENT_HOLDTOWNSBASES, CTI_ORDER_CLIENT_TAKEHOLDTOWNS]): {
					(_units_effective) call CTI_UI_AIMicromanagement_UnregisterFormation; //--- Unregister the previous members if needed
					if (count _units_effective > 1) then {(_units_effective) call CTI_UI_AIMicromanagement_SetFormation}; //--- Register the new members

					{[_x, _order, [0,0]] call CTI_UI_AIMicromanagement_TrySetOrder} forEach _units_effective; //--- Assign a new order
				};
				case (_order == CTI_ORDER_CLIENT_MOVE): {
					uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_mapclick", true];
					((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270013) ctrlSetStructuredText parseText format["<t color='#efa12b' align='center'>Click on the map to terminate the order assignment</t>"];
				};
			};
		};
	};
	case "onSetOrderPressed": {
		_selected = _this select 1;

		_selection = lbSelection ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002);
		if (count _selection > 0 && _selected > -1) then {
			_order = ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270009) lbValue _selected;
			_units_effective = (_selection) call CTI_UI_AIMicromanagement_GetEffectiveUnits;
			if (_order in [CTI_ORDER_CLIENT_MOVE, CTI_ORDER_CLIENT_PATROL]) exitWith {}; //--- Skip the orders which requires a position

			//--- Parameters?
			_target = [];
			_setposition = false;
			_selected_param = lbCurSel 270010;
			if (lbSize 270010 > 0 && _selected_param > -1) then {
				_selected = ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270010) lbValue _selected_param;
				_setposition = true;
				if (_selected < 0 && _order in [CTI_ORDER_CLIENT_TAKETOWNS, CTI_ORDER_CLIENT_HOLDTOWNSBASES, CTI_ORDER_CLIENT_TAKEHOLDTOWNS]) exitWith {_target = [0,0]};
				switch (_order) do { //--- Transform generic to singles
					case CTI_ORDER_CLIENT_TAKETOWNS: {_order = CTI_ORDER_CLIENT_TAKETOWN};
					case CTI_ORDER_CLIENT_TAKEHOLDTOWNS: {_order = CTI_ORDER_CLIENT_TAKEHOLDTOWN};
					case CTI_ORDER_CLIENT_HOLDTOWNSBASES: {_order = CTI_ORDER_CLIENT_HOLDTOWNSBASE};
				};
				_target = (uiNamespace getVariable "cti_dialog_ui_aimicromenu_order_targets") select _selected;
				if !(alive _target) exitWith {_setposition = false};
			};

			_posto = if (_setposition) then {_target} else {false};

			(_units_effective) call CTI_UI_AIMicromanagement_UnregisterFormation; //--- Unregister the previous members if needed
			if (count _units_effective > 1) then {(_units_effective) call CTI_UI_AIMicromanagement_SetFormation}; //--- Register the new members

			{[_x, _order, _posto] call CTI_UI_AIMicromanagement_TrySetOrder} forEach _units_effective; //--- Assign a new order
		};
	};
	case "onSetMapOrderPressed": {
		_selection = lbSelection ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002);
		if (count _selection > 0) then {
			_order = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270009);
			if (_order > -1) then {
				uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick", true];
				((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270013) ctrlSetStructuredText parseText format["<t color='#efa12b' align='center'>Click on the map to terminate the order assignment</t>"];
			};
		};
	};
	case "onMapButtonDown": {
		_event = _this select 1;
		_button = _event select 1;
		_mx = _event select 2;
		_my = _event select 3;
		_ctrl = _event select 5;

		if (_button == 0 && uiNamespace getVariable "cti_dialog_ui_aimicromenu_mapclick") then {
			uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick", false];
			if !(_ctrl) then {((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270013) ctrlSetStructuredText parseText ""};

			_selection = lbSelection ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002);
			if (count _selection > 0) then {
				_order = lbCurSel ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270009);
				if (_order > -1) then {
					_order = ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270009) lbValue _order;

					switch (_order) do { //--- Transform generic to singles
						case CTI_ORDER_CLIENT_TAKETOWNS: {_order = CTI_ORDER_CLIENT_TAKETOWN};
						case CTI_ORDER_CLIENT_TAKEHOLDTOWNS: {_order = CTI_ORDER_CLIENT_TAKEHOLDTOWN};
						case CTI_ORDER_CLIENT_HOLDTOWNSBASES: {_order = CTI_ORDER_CLIENT_HOLDTOWNSBASE};
					};
					_mappos = ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270001) ctrlMapScreenToWorld [_mx, _my];
					_units_effective = (_selection) call CTI_UI_AIMicromanagement_GetEffectiveUnits;
					switch (true) do {
						case (_order in [CTI_ORDER_CLIENT_TAKETOWN, CTI_ORDER_CLIENT_TAKEHOLDTOWN]): {
							_nearest = [_mappos, CTI_P_SideID] call CTI_CO_FNC_GetClosestEnemyTown;
							if !(isNull _nearest) then {
								if (_mappos distance _nearest < 500) then {
									(_units_effective) call CTI_UI_AIMicromanagement_UnregisterFormation; //--- Unregister the previous members if needed
									if (count _units_effective > 1) then {(_units_effective) call CTI_UI_AIMicromanagement_SetFormation}; //--- Register the new members

									{[_x, _order, _nearest] call CTI_UI_AIMicromanagement_TrySetOrder} forEach _units_effective; //--- Assign a new order
								};
							};
						};
						case (_order == CTI_ORDER_CLIENT_HOLDTOWNSBASE): {
							_closest_town = [_mappos, CTI_P_SideID] call CTI_CO_FNC_GetClosestFriendlyTown;
							_list = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
							if !(isNull _closest_town) then {_list pushBack _closest_town}; //--- Add the closest town
							_nearest = [_mappos, _list] call CTI_CO_FNC_GetClosestEntity;
							if !(isNull _nearest) then {
								if (_mappos distance _nearest < 500) then {
									(_units_effective) call CTI_UI_AIMicromanagement_UnregisterFormation; //--- Unregister the previous members if needed
									if (count _units_effective > 1) then {(_units_effective) call CTI_UI_AIMicromanagement_SetFormation}; //--- Register the new members

									{[_x, _order, _nearest] call CTI_UI_AIMicromanagement_TrySetOrder} forEach _units_effective; //--- Assign a new order
								};
							};
						};
						case (_order == CTI_ORDER_CLIENT_MOVE): {
							if (_ctrl || count(uiNamespace getVariable "cti_dialog_ui_aimicromenu_mapclick_queued") > 0) then { //--- Order queued? (todo later move to the general scope)
								uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick", true];
								uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick_queued", (uiNamespace getVariable "cti_dialog_ui_aimicromenu_mapclick_queued") + [_mappos]];
							};

							if !(_ctrl) then { //--- Ctrl released
								_queue = uiNamespace getVariable "cti_dialog_ui_aimicromenu_mapclick_queued";

								_pos = _mappos; //--- By default we use the mappos.
								if (count _queue > 1) then {_pos = _queue}; //--- We only use queued order if we have more than 1 pos

								(_units_effective) call CTI_UI_AIMicromanagement_UnregisterFormation; //--- Unregister the previous members if needed
								if (count _units_effective > 1) then {(_units_effective) call CTI_UI_AIMicromanagement_SetFormation}; //--- Register the new members

								{[_x, _order, _pos] call CTI_UI_AIMicromanagement_TrySetOrder} forEach _units_effective; //--- Assign a new order
								uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick_queued", []];
							};
						};
						case (_order == CTI_ORDER_CLIENT_PATROL): {
							if (_ctrl || count(uiNamespace getVariable "cti_dialog_ui_aimicromenu_mapclick_queued") > 0) then { //--- Order queued? (todo later move to the general scope)
								uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick", true];
								uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick_queued", (uiNamespace getVariable "cti_dialog_ui_aimicromenu_mapclick_queued") + [_mappos]];
							};

							if !(_ctrl) then { //--- Ctrl released
								_queue = uiNamespace getVariable "cti_dialog_ui_aimicromenu_mapclick_queued";

								_pos = _mappos; //--- By default we use the mappos.
								if (count _queue > 1) then {_pos = _queue}; //--- We only use queued order if we have more than 1 pos

								(_units_effective) call CTI_UI_AIMicromanagement_UnregisterFormation; //--- Unregister the previous members if needed
								if (count _units_effective > 1) then {(_units_effective) call CTI_UI_AIMicromanagement_SetFormation}; //--- Register the new members

								{[_x, _order, _pos] call CTI_UI_AIMicromanagement_TrySetOrder} forEach _units_effective; //--- Assign a new order
								uiNamespace setVariable ["cti_dialog_ui_aimicromenu_mapclick_queued", []];
							};
						};
					};
				};
			};
		};
	};
	case "onUnitDisbandPressed": {
		_selection = _this select 1;

		if (count _selection > 0) then {
			_selection = (_selection) call CTI_CO_FNC_ArrayReverse; //--- Reverse the usual selection so that we may remove top-most values first
			{
				_value = ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002) lbValue _x;
				_who = (uiNamespace getVariable "cti_dialog_ui_aimicromenu_units") select _value;
				if (_who == effectiveCommander vehicle _who && vehicle _who != _who) then {(vehicle _who) setDammage 1};
				_who setDammage 1;
			} forEach _selection;
			{((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002) lbDelete _x} forEach _selection;


			// ((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002) lbDelete
		};
	};
	case "onSelectAll": {
		for '_i' from 0 to lbSize(270002)-1 do {
			((uiNamespace getVariable "cti_dialog_ui_aimicromenu") displayCtrl 270002) lbSetSelected [_i, true];
		};
	};
};
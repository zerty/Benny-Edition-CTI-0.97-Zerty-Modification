private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		// execVM "Client\GUI\GUI_OptionsMenu.sqf";
		{((uiNamespace getVariable "cti_dialog_ui_servicemenu") displayCtrl _x) ctrlEnable false} forEach [230001, 230002, 230003, 230004];

		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		_repair_depots = [CTI_REPAIR, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;
		_ammo_depots = [CTI_AMMO, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;

		_list = [group player, false] Call CTI_CO_FNC_GetTeamVehicles;
		{if (vehicle _x == _x) then {_list pushBack _x}} forEach units player;

		_player_support_repair = (CTI_SPECIAL_REPAIRTRUCK) call CTI_UI_Service_GetGroupMobileSupports;
		_player_support_ammo = (CTI_SPECIAL_AMMOTRUCK) call CTI_UI_Service_GetGroupMobileSupports;
		_available_repair_depots = [vehicle player, _repair_depots, CTI_SERVICE_REPAIR_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
		_available_ammo_depots = [vehicle player, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;

		//--- Get the outter vehicles near our mobile supports

		{
			_range = _x select 1;
			{
				{
					if !(_x in _list) then { _list pushBack _x};
				} forEach (_x nearEntities [["Car", "Ship", "Motorcycle", "Tank", "Air", "StaticWeapon"], _range]);
			} forEach (_x select 0);
		} forEach [[_available_repair_depots, CTI_SERVICE_REPAIR_DEPOT_RANGE],[_available_ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE],[_player_support_repair, CTI_SERVICE_REPAIR_TRUCK_RANGE],[_player_support_ammo, CTI_SERVICE_AMMO_TRUCK_RANGE]];

		_list_real = [];
		_list_content = [];
		{
			_load_content = false;
			_content = [[],[],[],[]]; // 0 Repair, 1: Rearm, 2: Refuel, 3: Heal
			if (_x isKindOf "Man") then { //--- Infantry
				_available_repair_depots = [_x, _repair_depots, CTI_SERVICE_REPAIR_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
				_available_repair_trucks = [_x, CTI_SPECIAL_REPAIRTRUCK, CTI_SERVICE_REPAIR_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
				if (count _available_repair_depots > 0 || count _available_repair_trucks > 0) then {
					_load_content = true;
					_content set [3, [["Base", _available_repair_depots], ["Mobile", _available_repair_trucks]]];
				};
			} else { //--- Vehicle
				_vehicle = vehicle _x;
				_available_repair_depots = [_vehicle, _repair_depots, CTI_SERVICE_REPAIR_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
				_available_repair_trucks = [_vehicle, CTI_SPECIAL_REPAIRTRUCK, CTI_SERVICE_REPAIR_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
				_available_ammo_depots = [_vehicle, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
				_available_ammo_trucks = [_vehicle, CTI_SPECIAL_AMMOTRUCK, CTI_SERVICE_AMMO_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
				_available_fuel_trucks = [_vehicle, CTI_SPECIAL_FUELTRUCK, CTI_SERVICE_AMMO_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
				if (count _available_repair_depots > 0 || count _available_repair_trucks > 0) then {
					_load_content = true;
					_content set [0, [["Base", _available_repair_depots], ["Mobile", _available_repair_trucks]]];
					//_content set [2, [["Base", _available_repair_depots], ["Mobile", _available_repair_trucks]]];
					_content set [3, [["Base", _available_repair_depots], ["Mobile", _available_repair_trucks]]];
				};
				if (count _available_repair_depots > 0 || count _available_fuel_trucks > 0) then {
					_load_content = true;
					_content set [2, [["Base", _available_repair_depots], ["Mobile", _available_fuel_trucks]]];

				};
				if (count _available_ammo_depots > 0 || count _available_ammo_trucks > 0) then {
					_load_content = true;
					_content set [1, [["Base", _available_ammo_depots], ["Mobile", _available_ammo_trucks]]];
				};
			};

			if (_load_content) then { //--- Load in the list
				_list_real pushBack _x;
				_list_content pushBack _content;
				if (_x isKindOf "Man") then {
					_digit = if (group _x == group player) then {format["[%1] ",(_x) call CTI_CL_FNC_GetAIDigit]} else {""};
					_var_name = if (isNil {_x getVariable "cti_customid"}) then {typeOf _x} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _x getVariable "cti_customid"]};
					_var_classname = missionNamespace getVariable _var_name;
					_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName")};
					((uiNamespace getVariable "cti_dialog_ui_servicemenu") displayCtrl 230005) lnbAddRow [_digit+_label, "N/A", "N/A", format["%1%2",round((1 - getDammage _x) * 100), "%"]];
				} else {
					_vehicle = vehicle _x;
					_var_name = if (isNil {_vehicle getVariable "cti_customid"}) then {typeOf _vehicle} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _vehicle getVariable "cti_customid"]};
					_var_classname = missionNamespace getVariable _var_name;
					_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")};
					_crew = crew _vehicle;
					_health = 0;
					{_health = _health + round((1 - getDammage _x) * 100)} forEach _crew;
					_health = if (count _crew > 0) then {format["%1%2", round(_health / count _crew), "%"]} else {"N/A"};
					_digits = "";
					if (count _crew > 0 && group _vehicle == group player) then {
						_digit_parsed = [];
						{if (group _x == group player) then {_digit_parsed pushBack (_x call CTI_CL_FNC_GetAIDigit)}} forEach _crew;
						{
							if (_forEachIndex >= 3) exitWith {_digits = _digits + "..."};
							_digits = _digits + (_x);
							if (_forEachIndex < (count _digit_parsed)-1 && _forEachIndex < 2) then {_digits = _digits + ","};
						} forEach _digit_parsed;
						if (_digits != "") then {_digits = format["[%1] ",_digits]};
					};
					((uiNamespace getVariable "cti_dialog_ui_servicemenu") displayCtrl 230005) lnbAddRow [_digits+_label, format["%1%2",round((1 - getDammage _vehicle) * 100), "%"], format["%1%2", round((fuel _vehicle) * 100), "%"], _health];
				};
			};
		} forEach _list;

		uiNamespace setVariable ["cti_dialog_ui_servicemenu_list", _list_real];
		uiNamespace setVariable ["cti_dialog_ui_servicemenu_content", _list_content];
	};
	case "onEntityListLBSelChanged": {
		_changeto = _this select 1;

		_selected = (uiNamespace getVariable "cti_dialog_ui_servicemenu_list") select _changeto;
		_selected_content = (uiNamespace getVariable "cti_dialog_ui_servicemenu_content") select _changeto;

		// 0 Repair, 1: Rearm, 2: Refuel, 3: Heal
		if !(isNil '_selected') then {
			if (alive _selected) then {
				_enables = [];
				if (count (_selected_content select 0) > 0) then {_enables pushBack 230001};
				if (count (_selected_content select 1) > 0) then {_enables pushBack 230002};
				if (count (_selected_content select 2) > 0) then {_enables pushBack 230003};
				if (count (_selected_content select 3) > 0) then {_enables pushBack 230004};
				{((uiNamespace getVariable "cti_dialog_ui_servicemenu") displayCtrl _x) ctrlEnable false} forEach ([230001, 230002, 230003, 230004] - _enables);
				{((uiNamespace getVariable "cti_dialog_ui_servicemenu") displayCtrl _x) ctrlEnable true} forEach (_enables);

				{
					if ((_x select 0) in _enables) then {
						_price = _x select 1;
						if ((_x select 0) != 230004) then {
							_price = [_selected, _x select 1, _x select 2] call CTI_UI_Service_GetPrice;
						} else {
							if (count crew _selected > 0) then {
								_price = round(_price * count crew _selected);
							};
						};
						((uiNamespace getVariable "cti_dialog_ui_servicemenu") displayCtrl (_x select 3)) ctrlSetStructuredText parseText format["<t align='right' color='#F56363'>$%1</t>", _price];
					} else {
						((uiNamespace getVariable "cti_dialog_ui_servicemenu") displayCtrl (_x select 3)) ctrlSetStructuredText parseText "";
					};
				} forEach [[230001, CTI_SERVICE_PRICE_REPAIR, CTI_SERVICE_PRICE_REPAIR_COEF, 230011],[230002, CTI_SERVICE_PRICE_REAMMO, CTI_SERVICE_PRICE_REAMMO_COEF, 230012],[230003, CTI_SERVICE_PRICE_REFUEL, CTI_SERVICE_PRICE_REFUEL_COEF, 230013],[230004, CTI_SERVICE_PRICE_HEAL, -1, 230014]];
			};
		};
	};
	case "onRepairPressed": {
		_chosen = _this select 1;

		if (_chosen > -1) then {
			_selected = (uiNamespace getVariable "cti_dialog_ui_servicemenu_list") select _chosen;
			_selected_content = (uiNamespace getVariable "cti_dialog_ui_servicemenu_content") select _chosen;

			//--- Do we still have something alive in range?
			if !(isNil '_selected') then {
				if (alive _selected) then {
					if (count ([_selected, _selected_content, [CTI_SERVICE_REPAIR_DEPOT_RANGE, CTI_SERVICE_REPAIR_TRUCK_RANGE], 0] call CTI_UI_Service_RangeStill) > 0) then {
						_funds = call CTI_CL_FNC_GetPlayerFunds;
						_price = [_selected, CTI_SERVICE_PRICE_REPAIR, CTI_SERVICE_PRICE_REPAIR_COEF] call CTI_UI_Service_GetPrice;
						if (_funds >= _price) then {
							-(_price) call CTI_CL_FNC_ChangePlayerFunds;
							[_selected, _selected_content, [CTI_SERVICE_REPAIR_DEPOT_RANGE, CTI_SERVICE_REPAIR_TRUCK_RANGE], [CTI_SERVICE_REPAIR_DEPOT_TIME, CTI_SERVICE_REPAIR_TRUCK_TIME], 0] spawn CTI_UI_Service_ProcessRepair;
						} else {
							hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to perform this opertion";
						};
					} else {
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on this unit, check the service range";
					};
				} else {
					hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a destroyed unit";
				};
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a destroyed unit";
			};
		};
	};
	case "onRearmPressed": {
		_chosen = _this select 1;

		if (_chosen > -1) then {
			_selected = (uiNamespace getVariable "cti_dialog_ui_servicemenu_list") select _chosen;
			_selected_content = (uiNamespace getVariable "cti_dialog_ui_servicemenu_content") select _chosen;

			//--- Do we still have something alive in range?
			if !(isNil '_selected') then {
				if (alive _selected) then {
					if (count ([_selected, _selected_content, [CTI_SERVICE_AMMO_DEPOT_RANGE, CTI_SERVICE_AMMO_TRUCK_RANGE], 1] call CTI_UI_Service_RangeStill) > 0) then {
						_funds = call CTI_CL_FNC_GetPlayerFunds;
						_price = [_selected, CTI_SERVICE_PRICE_REAMMO, CTI_SERVICE_PRICE_REAMMO_COEF] call CTI_UI_Service_GetPrice;
						if (_funds >= _price) then {
							-(_price) call CTI_CL_FNC_ChangePlayerFunds;
							[_selected, _selected_content, [CTI_SERVICE_AMMO_DEPOT_RANGE, CTI_SERVICE_AMMO_TRUCK_RANGE], [CTI_SERVICE_AMMO_DEPOT_TIME, CTI_SERVICE_AMMO_TRUCK_TIME], 1] spawn CTI_UI_Service_ProcessRearm;
						} else {
							hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to perform this opertion";
						};
					} else {
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on this unit, check the service range";
					};
				} else {
					hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a destroyed unit";
				};
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a destroyed unit";
			};
		};
	};
	case "onRefuelPressed": {
		_chosen = _this select 1;

		if (_chosen > -1) then {
			_selected = (uiNamespace getVariable "cti_dialog_ui_servicemenu_list") select _chosen;
			_selected_content = (uiNamespace getVariable "cti_dialog_ui_servicemenu_content") select _chosen;

			//--- Do we still have something alive in range?
			if !(isNil '_selected') then {
				if (alive _selected) then {
					if (count ([_selected, _selected_content, [CTI_SERVICE_REPAIR_DEPOT_RANGE, CTI_SERVICE_REPAIR_TRUCK_RANGE], 2] call CTI_UI_Service_RangeStill) > 0) then {
						_funds = call CTI_CL_FNC_GetPlayerFunds;
						_price = [_selected, CTI_SERVICE_PRICE_REFUEL, CTI_SERVICE_PRICE_REFUEL_COEF] call CTI_UI_Service_GetPrice;
						if (_funds >= _price) then {
							-(_price) call CTI_CL_FNC_ChangePlayerFunds;
							[_selected, _selected_content, [CTI_SERVICE_REPAIR_DEPOT_RANGE, CTI_SERVICE_REPAIR_TRUCK_RANGE], [CTI_SERVICE_REPAIR_DEPOT_TIME, CTI_SERVICE_REPAIR_TRUCK_TIME], 2] spawn CTI_UI_Service_ProcessRefuel;
						} else {
							hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to perform this opertion";
						};
					} else {
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on this unit, check the service range";
					};
				} else {
					hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a destroyed unit";
				};
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a destroyed unit";
			};
		};
	};
	case "onHealPressed": {
		_chosen = _this select 1;

		if (_chosen > -1) then {
			_selected = (uiNamespace getVariable "cti_dialog_ui_servicemenu_list") select _chosen;
			_selected_content = (uiNamespace getVariable "cti_dialog_ui_servicemenu_content") select _chosen;

			//--- Do we still have something alive in range?
			if !(isNil '_selected') then {
				if (alive _selected) then {
					if (count ([_selected, _selected_content, [CTI_SERVICE_REPAIR_DEPOT_RANGE, CTI_SERVICE_REPAIR_TRUCK_RANGE], 3] call CTI_UI_Service_RangeStill) > 0) then {
						_funds = call CTI_CL_FNC_GetPlayerFunds;
						_price = CTI_SERVICE_PRICE_HEAL;
						if (count crew _selected > 0) then {_price = CTI_SERVICE_PRICE_HEAL * count crew _selected};
						if (_funds >= _price) then {
							-(_price) call CTI_CL_FNC_ChangePlayerFunds;
							[_selected, _selected_content, [CTI_SERVICE_REPAIR_DEPOT_RANGE, CTI_SERVICE_REPAIR_TRUCK_RANGE], [CTI_SERVICE_REPAIR_DEPOT_TIME, CTI_SERVICE_REPAIR_TRUCK_TIME], 3] spawn CTI_UI_Service_ProcessHeal;
						} else {
							hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to perform this opertion";
						};
					} else {
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on this unit, check the service range";
					};
				} else {
					hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a destroyed unit";
				};
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a destroyed unit";
			};
		};
	};
};
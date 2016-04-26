_action = _this select 0;
_target= uiNamespace getVariable ['GEAR_TARG',objnull];
switch (_action) do {
	case "onLoad": { //--- Triggered on the very first loading of the UI
		//-- Load the list.
		if !(uiNamespace getVariable ['GEAR_TARG_F',false]) then {
			_possible=call CTI_UI_Gear_LoadAvailableUnits;
			_id=0;
			{
				if (_x isKindOf "Man") then {
					((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbAdd Format["[%1] %2 (%3m)", _x call CTI_CL_FNC_GetAIDigit, getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName"),ceil (_x distance player)];
				} else {
					((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbAdd Format["%1 (%2m)", getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName"),ceil (_x distance player)];
				};
				//if (!isnull _target && _target ==_x) then {_id =_forEachIndex;};

			} forEach _possible;
			uiNamespace setVariable ["cti_dialog_ui_gear_units",_possible];
			if (count _possible == 0) then {((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70403) ctrlEnable false} else {((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70403) ctrlEnable true};
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbSetCurSel _id;
		} else {
			_possible=[_target];
			{
				if (_x isKindOf "Man") then {
					((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbAdd Format["[%1] %2 (%3m)", _x call CTI_CL_FNC_GetAIDigit, getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName"),ceil (_x distance player)];
				} else {
					((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbAdd Format["%1 (%2m)", getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName"),ceil (_x distance player)];
				};
				//if (!isnull _target && _target ==_x) then {_id =_forEachIndex;};

			} forEach _possible;
			uiNamespace setVariable ["cti_dialog_ui_gear_units",_possible];
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbSetCurSel 0;
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) ctrlEnable false;
		};
		execVM "Client\GUI\GUI_GearMenu.sqf";

		//--- Handle drag stop //todo check the getVariable modification.
		_dragging = if (isNil{uiNamespace getVariable "cti_dialog_ui_gear_dragging"}) then {false} else {uiNamespace getVariable "cti_dialog_ui_gear_dragging"};
		// if (uiNamespace getVariable ["cti_dialog_ui_gear_dragging", false]) then {uiNamespace setVariable ["cti_dialog_ui_gear_dragging", false]};
		if (_dragging) then {uiNamespace setVariable ["cti_dialog_ui_gear_dragging", false]};
		// (findDisplay 70000) displaySetEventHandler ["mouseButtonUp", "if (uiNamespace getVariable ['cti_dialog_ui_gear_dragging', false]) then {['onShoppingListMouseUp', _this select 1] call compile preprocessFileLineNumbers 'Client\Functions\UI\Function_UI_Gear_Events.sqf'}"];
		(findDisplay 70000) displaySetEventHandler ["mouseButtonUp", "_dragging = if (isNil{uiNamespace getVariable 'cti_dialog_ui_gear_dragging'}) then {false} else {uiNamespace getVariable 'cti_dialog_ui_gear_dragging'}; if (_dragging) then {['onShoppingListMouseUp', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_GearMenu.sqf'}"];
	};
	case "onShoppingTabClicked": { //--- A shopping tab was clicked upon
		//--- New tab
		_changedto = _this select 1;

		(_changedto) call CTI_UI_Gear_DisplayShoppingItems;
		uiNamespace setVariable ["cti_dialog_ui_gear_shop_tab", _changedto];
	};
	case "onUnitLBSelChanged": { //--- The units combo was changed
		_changedto = _this select 1;

		if (_changedto <0) exitwith {false};
		_target = (uiNamespace getVariable "cti_dialog_ui_gear_units") select _changedto;
		//--- The target
		uiNamespace setVariable ["cti_dialog_ui_gear_target", _target];

		//--- Get the target's equipment
		_gear = (_target) call CTI_UI_Gear_GetUnitEquipment;

		//--- Calculate the initial mass
		_mass = (_gear) call CTI_UI_Gear_GetTotalMass;

		//--- Default
		uiNamespace setVariable ["cti_dialog_ui_gear_target_staticgear", +_gear];
		uiNamespace setVariable ["cti_dialog_ui_gear_target_gear", _gear];
		uiNamespace setVariable ["cti_dialog_ui_gear_target_gear_mass", _mass];

		//--- Progress UI Updates.
		{[_forEachIndex, _x] call CTI_UI_Gear_UpdateContainerProgress} forEach [70301,70302,70303];

		//--- Do we have a default gear tab? if not we give the template one to the player
		if (isNil {uiNamespace getVariable "cti_dialog_ui_gear_shop_tab"}) then {uiNamespace setVariable ["cti_dialog_ui_gear_shop_tab", CTI_GEAR_TAB_TEMPLATES]};
		(uiNamespace getVariable "cti_dialog_ui_gear_shop_tab") call CTI_UI_Gear_DisplayShoppingItems;

		if (_target isKindOf "Man") then {
		  	for "_i" from  70000 to 70027  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow true;
			};
			for "_i" from  77000 to 77027  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow true;
			};
			for "_i" from  77900 to 77904  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow true;
			};
			for "_i" from  70900 to 70904  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow true;
			};
			for "_i" from  70301 to 70303  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow true;
			};
			for "_i" from  70401 to 70402  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow true;
			};
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 77109) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.41),SafeZoneY + (SafezoneH * 0.25),SafeZoneW * 0.58,SafeZoneH * 0.28];
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 77109) ctrlCommit 0;
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70109) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.41),SafeZoneY + (SafezoneH * 0.25),SafeZoneW * 0.58,SafeZoneH * 0.28];
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70109) ctrlCommit 0;
		} else {
		//if !(_target isKindOf "Man") then {
		  	//77001-77026
		  	//77109
		  	// 70000 - 70027
		  	for "_i" from  70000 to 70027 /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow false;
			};
			for "_i" from  77000 to 77027  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow false;
			};
			for "_i" from  77900 to 77904  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow false;
			};
			for "_i" from  70900 to 70904  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow false;
			};
			for "_i" from  70301 to 70303  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow false;
			};
			for "_i" from  70401 to 70402  /* step +1 */ do {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _i) ctrlshow false;
			};

			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70303) ctrlshow true;
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 77003) ctrlshow true;
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70003) ctrlshow true;
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 77109) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.41),SafeZoneY + (SafezoneH * 0.25),SafeZoneW * 0.58,SafeZoneH * 0.65];
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 77109) ctrlCommit 0;
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70109) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.41),SafeZoneY + (SafezoneH * 0.25),SafeZoneW * 0.58,SafeZoneH * 0.65];
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70109) ctrlCommit 0;

		};



		call CTI_UI_Gear_UpdatePrice;
		(_gear) call CTI_UI_Gear_DisplayInventory;
	};
	case "onShoppingListLBDblClick": {
		//--- Item
		_selected = _this select 1;

		//--- Get the current tab
		if (uiNamespace getVariable "cti_dialog_ui_gear_shop_tab" != 7) then {
			_updated = (lbData [70108,_selected]) call CTI_UI_Gear_AddItem;
			if (_updated) then { call CTI_UI_Gear_UpdatePrice };
		} else {
			_selected = lbValue[70108, _selected];
			(_selected) call CTI_UI_Gear_EquipTemplate;
		};
	};
	case "onShoppingListLBDrag": {
		//--- Item (Data)

		_selected = ((_this select 1) select 0) select 2;

		uiNamespace setVariable ["cti_dialog_ui_gear_dragging", true];
		(_selected) call CTI_UI_Gear_OnShoppingItemDrag;
	};
	case "onShoppingListLBDrop": {
		_kind = _this select 1;
		_idc = _this select 2;
		_dropped = _this select 3;
		_path = _this select 4;

		_updated = [_idc, _dropped, _kind, _path] call CTI_UI_Gear_OnShoppingItemDrop;
		if (_updated) then { call CTI_UI_Gear_UpdatePrice };
	};
	case "onShoppingListLBSelChanged": {
		//--- Item
		_selected = _this select 1;

		(lbData [70108, _selected]) call CTI_UI_Gear_UpdateLinkedItems;
	};
	case "onShoppingListMouseUp": {
		_idcs = if (isNil {uiNamespace getVariable "cti_dialog_ui_gear_drag_colored_idc"}) then {[]} else {uiNamespace getVariable "cti_dialog_ui_gear_drag_colored_idc"};
		{
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _x) ctrlSetBackgroundColor [1, 1, 1, 0.15];
		} forEach _idcs;

		//--- Todo: highlight current container.
		((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl (77001 + (uiNamespace getVariable "cti_dialog_ui_gear_items_tab"))) ctrlSetBackgroundColor [1, 1, 1, 0.4];

		uiNamespace setVariable ["cti_dialog_ui_gear_dragging", false];
	};
	case "onLinkedListLBDblClick": {
		//--- Item
		_selected = _this select 1;

		_updated = (lbData [70601, _selected]) call CTI_UI_Gear_AddItem;
		if (_updated) then { call CTI_UI_Gear_UpdatePrice };
	};
	case "onItemContainerClicked": { //--- Uniform (0), vest (1) or backpack (2) container was clicked upon
		//--- The container
		_container = _this select 1;
		_background = _this select 2;

		//--- Get the target's gear
		_gear = uiNamespace getVariable "cti_dialog_ui_gear_target_gear";

		//--- Make sure that the container is present.
		if ((((_gear select 1) select _container) select 0) != "") then {
			(((_gear select 1) select _container) select 1) call CTI_UI_Gear_DisplayContainerItems;

			//--- Change the color
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _background) ctrlSetBackgroundColor [1, 1, 1, 0.4];
			{((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _x) ctrlSetBackgroundColor [1, 1, 1, 0.15]} forEach ([77001,77002,77003] - [_background]);

			//--- Set the current items tab
			uiNamespace setVariable ["cti_dialog_ui_gear_items_tab", _container];
		};
	};
	case "onItemContainerMouseClicked": { //--- Uniform (0), vest (1) or backpack (2) container was clicked upon
		//--- The container
		_container = _this select 1;
		_idc = _this select 2;
		_mouse = _this select 3;

		//--- Remove the container & its content if needed
		if (_mouse == 1 && ((uiNamespace getVariable ["cti_dialog_ui_gear_target", objnull]) isKindOf "Man")) then { //--- Right click
			_updated = ["", _container] call CTI_UI_Gear_ReplaceContainer;
			if (_updated) then { call CTI_UI_Gear_UpdatePrice };
		};
	};
	case "onAccessoryClicked": { //--- Helm or Goggles were clicked upon
		//--- The array slot, idc and default picture
		_slot = _this select 1;
		_idc = _this select 2;
		_default = _this select 3;

		_gear = uiNamespace getVariable "cti_dialog_ui_gear_target_gear";

		if ((_gear select 2) select _slot != "") then {
			//--- Apply the default picture and release the tooltip
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _idc) ctrlSetText _default;
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _idc) ctrlSetTooltip "";

			(_gear select 2) set [_slot, ""];
			call CTI_UI_Gear_UpdatePrice;
		};
	};
	case "onItemClicked": { //--- NVG, Binocular or items were clicked upon
		//--- The array slot, idc and default picture
		_slot = _this select 1;
		_idc = _this select 2;
		_default = _this select 3;

		_gear = uiNamespace getVariable "cti_dialog_ui_gear_target_gear";

		if ((((_gear select 3) select (_slot select 0)) select (_slot select 1)) != "") then {
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _idc) ctrlSetText _default;
			((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _idc) ctrlSetTooltip "";

			((_gear select 3) select (_slot select 0)) set [(_slot select 1), ""];
			call CTI_UI_Gear_UpdatePrice;
		};
	};
	case "onWeaponClicked": { //--- Primary, Secondary or Handgun was clicked upon
		//--- The array slot, idc and default picture
		_slot = _this select 1;
		_idc = _this select 2;

		["", _slot] call CTI_UI_Gear_ReplaceWeapon;
		call CTI_UI_Gear_UpdatePrice;
	};
	case "onUnitItemsLBDblClick": { //--- Item container
		_row = _this select 1;

		_item = lnbData[70109, [_row,0]];
		_count = lnbValue[70109, [_row,0]];

		_gear = uiNamespace getVariable "cti_dialog_ui_gear_target_gear";
		_container = uiNamespace getVariable "cti_dialog_ui_gear_items_tab";
		_items = ((_gear select 1) select _container) select 1;

		_items set [_items find _item, "!nil!"];
		_items = _items - ["!nil!"];
		(_gear select 1) select (uiNamespace getVariable "cti_dialog_ui_gear_items_tab") set [1, _items];

		//--- Update the mass.
		["ContainerItem", _item, "", [_container]] call CTI_UI_Gear_UpdateMass;

		//--- Update the Mass RscProgress
		[_container, 70301+_container] call CTI_UI_Gear_UpdateContainerProgress;

		if (_count > 1) then { //--- Decrement
			lnbSetText[70109, [_row,0], Format["x%1",_count - 1]];
			lnbSetValue[70109, [_row,0], _count - 1];
		} else { //--- Remove
			lnbDeleteRow[70109, _row];
		};

		call CTI_UI_Gear_UpdatePrice;
	};

	case 'onWeaponAccessoryClicked': { //--- Primary, Secondary or Handgun accessory was clicked upon
		//--- The array slot, idc and default picture
		_slot_type = _this select 1;
		_slot = _this select 2;
		_idc = _this select 3;
		_default = _this select 4;

		_gear = uiNamespace getVariable "cti_dialog_ui_gear_target_gear";
		if (count(((_gear select 0) select _slot_type) select 1) > 0) then {
			if (((((_gear select 0) select _slot_type) select 1) select _slot) != "") then {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _idc) ctrlSetText _default;
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl _idc) ctrlSetTooltip "";

				(((_gear select 0) select _slot_type) select 1) set [_slot, ""];
				call CTI_UI_Gear_UpdatePrice;
			};
		};
	};

	case "onWeaponCurrentMagazineClicked": { //--- Primary, Secondary or Handgun current magazine was clicked upon
		_slot_type = _this select 1;
		_idc = _this select 2;

		_updated = ["", _slot_type, _idc] call CTI_UI_Gear_ChangeCurrentMagazine;
		if (_updated) then {call CTI_UI_Gear_UpdatePrice};
	};

	case "onPurchase": {
		_funds = call CTI_CL_FNC_GetPlayerFunds;
		_cost = uiNamespace getVariable "cti_dialog_ui_gear_tradein";
		_target=uiNamespace getVariable "cti_dialog_ui_gear_target";
		if (_funds >= _cost) then {
			[uiNamespace getVariable "cti_dialog_ui_gear_target", uiNamespace getVariable "cti_dialog_ui_gear_target_gear"] call CTI_CO_FNC_EquipUnit;
			uiNamespace setVariable ["cti_dialog_ui_gear_target_staticgear", +(uiNamespace getVariable "cti_dialog_ui_gear_target_gear")];
			call CTI_UI_Gear_UpdatePrice;
			-(_cost) call CTI_CL_FNC_ChangePlayerFunds;
		// --- zerty edit
			if ( ((uiNamespace getVariable "cti_dialog_ui_gear_target") == player ) && (CTI_PLAYER_REEQUIP == 1 ) ) then {
				CTI_P_LastPurchase = uiNamespace getVariable "cti_dialog_ui_gear_target_gear";
			};
			if ((uiNamespace getVariable ["cti_dialog_ui_gear_target", objnull]) isKindOf "Man") then {
				missionNamespace setVariable ["cti_gear_lastpurchased", uiNamespace getVariable "cti_dialog_ui_gear_target_gear"];
			};
			if ( uiNamespace getVariable ['GEAR_TARG_F',false]) then {
				_target setVariable ["CTI_last_purchase_time",time,true];
			} ;
		} else {
			hint "not enough funds";
		};
	};

	case "onInventoryClear": {
		_gear = [
			[["", [], []], ["", [], []], ["", [], []]],
			[["", []], ["", []], ["", []]],
			["", ""],
			[["", ""], ["", "", "", "", ""]]
		];
		uiNamespace setVariable ["cti_dialog_ui_gear_target_gear", _gear];

		_mass = (_gear) call CTI_UI_Gear_GetTotalMass;
		uiNamespace setVariable ["cti_dialog_ui_gear_target_gear_mass", _mass];

		{[_forEachIndex, _x] call CTI_UI_Gear_UpdateContainerProgress} forEach [70301,70302,70303];

		call CTI_UI_Gear_UpdatePrice;
		(_gear) call CTI_UI_Gear_DisplayInventory;
	};

	case "onInventoryReload": {
		_gear = missionNamespace getVariable "cti_gear_lastpurchased";
		if !(isNil '_gear') then {
			uiNamespace setVariable ["cti_dialog_ui_gear_target_gear", _gear];

			_mass = (_gear) call CTI_UI_Gear_GetTotalMass;
			uiNamespace setVariable ["cti_dialog_ui_gear_target_gear_mass", _mass];

			{[_forEachIndex, _x] call CTI_UI_Gear_UpdateContainerProgress} forEach [70301,70302,70303];

			call CTI_UI_Gear_UpdatePrice;
			(_gear) call CTI_UI_Gear_DisplayInventory;
		};
		//todo reload from config if nil
	};

	case "onTemplateCreation": {
		_gear = +(uiNamespace getVariable "cti_dialog_ui_gear_target_gear");

		_cost = 0;
		_picture = "";
		_label = "";
		_haspic = false;
		_upgrade = 0;
		_has_nil = false;
		_dontbelong = false;

		_side_gear = missionNamespace getVariable "cti_gear_all";
		_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
		_upgrade_gear = _upgrades select CTI_UPGRADE_GEAR;

		{
			_var = missionNamespace getVariable _x;
			if !(isNil '_var') then {
				_cost = _cost + ((_var select 0) select 1);
				if (((_var select 0) select 0) > _upgrade) then {_upgrade = (_var select 0) select 0};
			} else {
				_has_nil = true;
			};
			//if !(_x in _side_gear) then {_dontbelong = true};
			if (_has_nil || _dontbelong) exitWith {};
		} forEach (_gear call CTI_CO_FNC_ConvertGearToFlat);

		if (_upgrade > _upgrade_gear) exitWith {
			hint parseText localize "STR_UI_GearMenu";
		};

		if (_dontbelong) exitWith {
			hint parseText localize "STR_UI_GearMenu_2";
		};
		//todo: items belong to side gear?

		if (_cost != 0) then {
			{
				if (_x select 0 != "") then {
					if (_label != "") then { _label = _label + " | " };
					_label = _label + getText(configFile >> "CfgWeapons" >> (_x select 0) >> "displayName");
					if !(_haspic) then { _picture = getText(configFile >> "CfgWeapons" >> (_x select 0) >> "picture"); _haspic = true};
				};
			} forEach (_gear select 0);
		};

		_seed = round(time + random 10000 - random 500 + diag_frameno);

		[missionNamespace getVariable "cti_gear_list_templates", [_label, _picture, _cost, _gear, _upgrade, _seed]] call CTI_CO_FNC_ArrayPush;

		_templates = if !(isNil {profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined]}) then {profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined]} else {+(missionNamespace getVariable "cti_gear_list_templates")};
		_templates pushBack [_label, _picture, _cost, _gear, _upgrade, _seed];
		profileNamespace setVariable [format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined], _templates];
		saveProfileNamespace;

		if (uiNamespace getVariable "cti_dialog_ui_gear_shop_tab" == CTI_GEAR_TAB_TEMPLATES) then { //--- Reload the template tab if needed
			(CTI_GEAR_TAB_TEMPLATES) call CTI_UI_Gear_DisplayShoppingItems;
		};

		hint parseText format [localize "STR_UI_GearMenu_3", _label];
	};

	case "onTemplateDeletion": {
		//todo: lnbvalue later when they're hidden

		_index = _this select 1;
		if (uiNamespace getVariable "cti_dialog_ui_gear_shop_tab" == CTI_GEAR_TAB_TEMPLATES) then {
			//_seed = lnbValue[70108, [_index,0]];
			_seed =( (missionNamespace getVariable "cti_gear_list_templates") select _index) select 5;
			if (_index > -1 && _index < (lbSize ((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70108) )) then {
				_index = lbValue [70108,_index];
				_templates = missionNamespace getVariable "cti_gear_list_templates";
				_templates set [_index, "!nil!"];
				_templates = _templates - ["!nil!"];
				missionNamespace setVariable ["cti_gear_list_templates", _templates];

				//--- Persistent!
				//todo: finds the ID that matches
				// if (isNil {profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined]}) then {call CTI_UI_Gear_InitializeProfileTemplates};
				// _templates = profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined];
				(_seed) call CTI_UI_Gear_RemoveProfileTemplate;
				// _templates set [_index, "!nil!"];
				// _templates = _templates - ["!nil!"];
				// profileNamespace setVariable [format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined], _templates];
				// saveProfileNamespace;

				if (uiNamespace getVariable "cti_dialog_ui_gear_shop_tab" == CTI_GEAR_TAB_TEMPLATES) then { //--- Reload the template tab if needed
					(CTI_GEAR_TAB_TEMPLATES) call CTI_UI_Gear_DisplayShoppingItems;
				};
			};
		} else {
			hint parseText localize "STR_UI_GearMenu_4";
		};
	};

	case "onItemContainerMouseDblClicked": {
		_container = _this select 1;

		_gear = uiNamespace getVariable "cti_dialog_ui_gear_target_gear";
		_container_type = ((_gear select 1) select _container) select 0;

		if (_container_type != "") then {
			if (uiNamespace getVariable "cti_dialog_ui_gear_items_tab" == _container) then {lnbClear 70109};

			["Container", "", _container_type, [_container, ((_gear select 1) select _container) select 1]] call CTI_UI_Gear_UpdateMass;
			((_gear select 1) select _container) set [1, []];
			[_container, 70301+_container] call CTI_UI_Gear_UpdateContainerProgress;

			call CTI_UI_Gear_UpdatePrice;
		};
	};
};
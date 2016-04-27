CTI_UI_Upgrade_LoadUpgradeInfo = {
	private ["_funds", "_index", "_upgrade_current", "_upgrade_label", "_upgrade_labels", "_upgrade_level", "_upgrade_price", "_upgrade_time", "_upgrades"];
	_index = _this;
	
	_upgrade_labels = missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined];
	_upgrade_label = _upgrade_labels select _index;
	_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
	_upgrade_current = _upgrades select _index;
	_funds = call CTI_CL_FNC_GetPlayerFunds;
	_upgrade_price = ((missionNamespace getVariable Format["CTI_%1_UPGRADES_COSTS", CTI_P_SideJoined]) select _index) select _upgrade_current;
	_upgrade_time = ((missionNamespace getVariable Format["CTI_%1_UPGRADES_TIMES", CTI_P_SideJoined]) select _index) select _upgrade_current;
	_upgrade_level = (missionNamespace getVariable Format["CTI_%1_UPGRADES_LEVELS", CTI_P_SideJoined]) select _index;
	((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250003) ctrlSetText (_upgrade_label select 0);
	((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250005) ctrlSetText localize "STR_UI_Dependencies";
	((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250007) ctrlSetText localize "STR_UI_Description";
	((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250008) ctrlSetStructuredText parseText (_upgrade_label select 1);
	if (_upgrade_current < _upgrade_level) then {
		private ["_clink", "_count", "_html", "_links", "_linkto"];
		((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250004) ctrlSetStructuredText parseText format[localize "STR_UI_Others", _upgrade_current, _upgrade_level, _upgrade_price, if(_funds >= _upgrade_price) then {'#76F563'} else {'#F56363'}, _funds, _upgrade_time];
		
		_links = ((missionNamespace getVariable Format["CTI_%1_UPGRADES_LINKS", CTI_P_SideJoined]) select _index) select _upgrade_current;
		_html = "";
		if (count _links > 0) then {
			if (typeName (_links select 0) == "ARRAY") then {
				_count = count(_links);
				for '_i' from 0 to _count-1 do {
					_coma = if (_i+1 < _count) then {", "} else {""};
					_clink = _links select _i;
					_linkto = _upgrades select (_clink select 0);
					_html = _html + format ["<t shadow='1'><t color='%1'>%2 </t><t color='#F5D363'>%3</t>%4</t>",if (_linkto >= (_clink select 1)) then {'#76F563'} else {'#F56363'},(_upgrade_labels select (_clink select 0)) select 0, _clink select 1,_coma];
				};
			} else {
				_linkto = _upgrades select (_links select 0);
				if (_linkto >= (_links select 1)) then {_html = _html + localize "STR_UI_All_Dependencies"} else {_html = _html + Format ["<t shadow='1'><t color='#F56363'>%1 </t><t color='#F5D363'>%2</t></t>",(_upgrade_labels select (_links select 0)) select 0, _links select 1]};
			};
		} else {
			_html = "<t color='#76F563' shadow='1'>None</t>";
		};
		((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250006) ctrlSetStructuredText parseText _html;
	} else {
		((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250004) ctrlSetStructuredText parseText localize "STR_UI_Max_Level";
		((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250006) ctrlSetStructuredText parseText "<t color='#76F563' shadow='1'>None</t>";
	};
};
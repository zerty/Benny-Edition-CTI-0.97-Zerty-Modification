_last_size = -1;
_last_funds = -1;
_show_inuse = false;
_lb_queued_content = [];

// ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110901) ctrlSetStructuredText parseText "<t>Producing: Soldier</t>";
while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_purchasemenu"}) exitWith {}; //--- Menu is closed.
	if (Client_AN_Connected) then {
		for "_i" from 110000 to 110007 /* step +1 */ do { ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl _i) ctrlEnable true};
	}else{
		for "_i" from 110000 to 110007 /* step +1 */ do { ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl _i) ctrlEnable false};
	};
	_factory = uiNamespace getVariable "cti_dialog_ui_purchasemenu_factory";
	if !(isNil '_factory') then {
		_in_use = _factory getVariable "cti_inuse";
		if (isNil '_in_use') then { _in_use = false };
		if !(_in_use) then {
			if (_show_inuse) then {	_show_inuse = false; ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110901) ctrlSetStructuredText parseText "" };
		} else {
			if !(_show_inuse) then { _show_inuse = true; ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110901) ctrlSetStructuredText parseText "Factory in use" };
		};
	} else {
		if (_show_inuse) then {	_show_inuse = false; ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110901) ctrlSetStructuredText parseText "" };
	};

	_group = uiNamespace getVariable "cti_dialog_ui_purchasemenu_team";
	_size = (count units _group) - ({isplayer _x } count (units _group )) ;
	if (_size != _last_size) then {
		((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110902) ctrlSetStructuredText (parseText format[localize "STR_GUI_Group_Size", _size, if (isPlayer leader _group) then {CTI_PLAYERS_GROUPSIZE} else {CTI_AI_TEAMS_GROUPSIZE}]);
	};

	//--- Remove old content.
	{
		_request = _x;

		_req_seed = _x select 0;
		_req_classname = _x select 1;

		_is_present = false;
		{
			if (_x select 0 == _req_seed && _x select 1 == _req_classname) exitWith {_is_present = true};
		} forEach +CTI_P_PurchaseRequests;

		if !(_is_present) then {
			((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110013) lbDelete _forEachIndex;
			_lb_queued_content set [_forEachIndex, "!nil!"];
		};
	} forEach _lb_queued_content;

	_lb_queued_content = _lb_queued_content - ["!nil!"];

	//--- Check for new content
	{
		_request = _x;

		_req_seed = _x select 0;
		_req_classname = _x select 1;
		_req_manning = _x select 2;
		_req_to = _x select 4;

		_var = missionNamespace getVariable _req_classname;

		_is_present = false;
		{
			if (_x select 0 == _req_seed && _x select 1 == _req_classname) exitWith {_is_present = true};
		} forEach _lb_queued_content;

		if !(_is_present) then {
			_lb_queued_content pushBack _request;
			_name = _var select CTI_UNIT_LABEL;

			_label = "";
			if (_req_classname isKindOf "Man") then {
				_label = _name;
				if (_req_to != group player) then {_label = _label + format [" To %1", _req_to]};
			} else {
				_empty = false;
				if (count _req_manning > 0) then {
					if !(_req_manning select 0 || _req_manning select 1 || _req_manning select 2 || _req_manning select 3) then { _empty = true };
				};
				if (_empty) then {_label = "Empty "};
				_label = _label + _name;
				if (_req_to != group player) then {_label = _label + format [" To %1", _req_to]};
			};

			((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110013) lbAdd _label;
			((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110013) lbSetValue [(lbSize ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110013)) - 1, round _req_seed];
			((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110013) lbSetData [(lbSize ((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110013)) - 1, _req_classname];
		};
	} forEach +CTI_P_PurchaseRequests;

	_funds = call CTI_CL_FNC_GetPlayerFunds;

	if (_last_funds != _funds) then {
		((uiNamespace getVariable "cti_dialog_ui_purchasemenu") displayCtrl 110015) ctrlSetStructuredText (parseText format["<t align='right'>Resources: <t color='%2'>$%1</t></t>", _funds, CTI_P_Coloration_Money]);
	};

	_last_funds = _funds;
	_last_size = _size;

	// _lb_queued_content = CTI_P_PurchaseRequests;
	sleep .1;
};

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_requestmenu"}) exitWith {}; //--- Menu is closed.
	
	//--- Some requests are no longer valid?
	for '_i' from 0 to ((lnbSize((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005)) select 0) do {
		_seed = lnbValue[280005, [_i, 0]];
		_found = false;
		{
			if (typeName _x == "ARRAY") then {if ((_x select 3) == _seed) then {_found = true}};
			if (_found) exitWith {};
		} forEach +CTI_P_TeamsRequests;
		
		if !(_found) then {
			((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005) lnbDeleteRow _i;
		};
	};
	
	//--- We've had some new requests inbetween?
	{
		if (typeName _x == "ARRAY") then {
			_seed = _x select 3;
			_found = false;
			
			for '_i' from 0 to ((lnbSize((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005)) select 0) do {
				_seed_lb = lnbValue[280005, [_i, 0]];
				if (_seed == _seed_lb) exitWith {_found = true};
			};
			
			if !(_found) then {
				_row = ((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005) lnbAddRow [format ["%1",(_x select 0) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS]], (_x select 1) call CTI_UI_Request_GetRequestLabel];
				((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005) lnbSetValue [[_row, 0], _seed];
			};
		};
	} forEach +CTI_P_TeamsRequests;
	
	sleep .1;
};
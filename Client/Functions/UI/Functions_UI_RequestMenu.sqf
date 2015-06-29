CTI_UI_Request_OnRequestAnswered = {
	private ["_answer", "_request"];

	_answer = _this select 0;
	_request = _this select 1;

	//--- ALTER: CTI_REQUEST
	if (_answer == "accept") then { //--- The request was granted by the com
		switch (_request) do {
			case CTI_REQUEST_FOB: {
				CTI_P_ChatID sideChat "Your FOB construction request has been accepted by the commander";
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Your FOB construction request has been accepted by the commander";
				CTI_P_TeamsRequests_FOB = 1;
			};
			case CTI_REQUEST_FOB_DISMANTLE: {
				CTI_P_ChatID sideChat "Your FOB dismantling request has been accepted by the commander";
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Your FOB dismantling request has been accepted by the commander";
				CTI_P_TeamsRequests_FOB_Dismantle = 1;
			};
		};
	} else { //--- The request was denied by the com
		switch (_request) do {
			case CTI_REQUEST_FOB: {
				CTI_P_ChatID sideChat "Your FOB construction request has been denied by the commander";
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Your FOB construction request has been denied by the commander";
			};
			case CTI_REQUEST_FOB_DISMANTLE: {
				CTI_P_ChatID sideChat "Your FOB dismantling request has been denied by the commander";
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Your FOB dismantling request has been denied by the commander";
			};
		};
	};
};

CTI_UI_Request_OnRequestReceived = {
	private ["_name", "_request", "_type", "_who"];
	_request = _this;

	_who = _request select 0;
	_type = _request select 1;
	_name = _this select 4;

	//--- ALTER: CTI_REQUEST
	switch (_type) do {
		case CTI_REQUEST_FOB: {
			CTI_P_ChatID commandChat format["A FOB construction has been requested by group %1 lead by %2", _who getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], _name];
			hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br />A FOB construction has been requested by group <t color='#55bcfc'>%1</t> lead by <t color='#55bcfc'>%2</t>", _who getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], _name];
		};
		case CTI_REQUEST_FOB_DISMANTLE: {
			CTI_P_ChatID commandChat format["A FOB dismantling has been requested by group %1 lead by %2", _who getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], _name];
			hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br />A FOB dismantling has been requested by group <t color='#55bcfc'>%1</t> lead by <t color='#55bcfc'>%2</t>", _who getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], _name];
		};
	};

	CTI_P_TeamsRequests pushBack _request;
	(_request) spawn CTI_UI_Request_HandleRequest;
};

CTI_UI_Request_GetRequestLabel = {
	private ["_request"];
	_request = _this;

	switch (_request) do {
		case CTI_REQUEST_FOB: {"FOB Construction"};
		case CTI_REQUEST_FOB_DISMANTLE: {"FOB Dismantling"};
		default {"Unknown"};
	};
};

CTI_UI_Request_SetRequestDescription = {
	private ["_name", "_origin", "_position", "_request", "_seed"];
	_origin = _this select 0;
	_request = _this select 1;
	_position = _this select 2;
	_name = _this select 4;

	//--- ALTER: CTI_REQUEST
	_structured = switch (_request) do {
		case CTI_REQUEST_FOB: {format["The group <t color='#55bcfc'>%1</t> lead by <t color='#55bcfc'>%2</t> has requested the permission to construct a single <t color='#bcff70'>Forward Observation Base</t>",_origin getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS],_name]};
		case CTI_REQUEST_FOB_DISMANTLE: {format["The group <t color='#55bcfc'>%1</t> lead by <t color='#55bcfc'>%2</t> has requested the permission to dismantle a single <t color='#bcff70'>Forward Observation Base</t>",_origin getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS],_name]};
		default {""};
	};

	((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280004) ctrlSetStructuredText parseText _structured;
};

CTI_UI_Request_HandleRequest = {
	private ["_request"];
	_request = _this;

	_seed = _request select 3;

	_remove = false;
	_start = time;
	while {true} do {
		if (time - _start > CTI_REQUESTS_TIMEOUT) exitWith {_remove = true};

		_found = false;
		{
			if (typeName _x == "ARRAY") then {
				if (_seed == (_x select 3)) then {_found = true};
			};
			if (_found) exitWith {};
		} forEach +CTI_P_TeamsRequests;

		if !(_found) exitWith {};

		sleep 1;
	};

	if (_remove) then {
		_id = -1;
		{if (typeName _x == "ARRAY") then {if ((_x select 3) == _seed) exitWith {_id = _forEachIndex}}} forEach CTI_P_TeamsRequests;
		if (_id > -1) then {
			CTI_P_TeamsRequests set [_id, "!nil!"];
			CTI_P_TeamsRequests = CTI_P_TeamsRequests - ["!nil!"];
		};
	};
};
private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		// a request: [who (group), what (integer), position (array/object), seed (integer), who's name (string)]
		_removes = [];
		{
			_origin = _x select 0;
			_request = _x select 1;
			_position = _x select 2;
			_seed = _x select 3;
			_name = _x select 4;

			if !(isNil '_origin') then {
				if (_name == name leader _origin) then {
					_row = ((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005) lnbAddRow [format ["%1",_origin getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS]], (_request) call CTI_UI_Request_GetRequestLabel];
					((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005) lnbSetValue [[_row, 0], _seed];
				} else {
					_removes pushBack _forEachIndex;
				};
			} else {
				_removes pushBack _forEachIndex;
			};
		} forEach CTI_P_TeamsRequests;

		{CTI_P_TeamsRequests set [_forEachIndex, "!nil!"]} forEach _removes;
		CTI_P_TeamsRequests = CTI_P_TeamsRequests - ["!nil"];

		// ([group player, 0, [], round(random 200 + random 10000 - random 5000), "Benny"]) call CTI_PVF_Client_OnRequestReceived;
		// CTI_P_TeamsRequests = CTI_P_TeamsRequests + [[group player, 0, [], round(random 200 + random 10000 - random 5000), "Benny"]];

		execVM "Client\GUI\GUI_RequestMenu.sqf";
	};
	case "onRequestSelChanged": {
		_selected = _this select 1;

		if (_selected > -1 && _selected < ((lnbSize((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005)) select 0)) then {
			_seed = lnbValue [280005, [_selected, 0]];
			// player sidechat format ["%1",_seed];

			_request = [];
			{if (typeName _x == "ARRAY") then {if ((_x select 3) == _seed) exitWith {_request = CTI_P_TeamsRequests select _forEachIndex}}} forEach CTI_P_TeamsRequests;
			if (count _request > 0) then {
				(_request) call CTI_UI_Request_SetRequestDescription;
			};
		} else {
			((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280004) ctrlSetStructuredText parseText "";
		};
	};
	case "onRequestAccept": {
		_selected = _this select 1;

		if (_selected > -1 && _selected < ((lnbSize((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005)) select 0)) then {
			_seed = lnbValue [280005, [_selected, 0]];
			_requests = +CTI_P_TeamsRequests;
			_request = [];
			_id = -1;
			{if ((_x select 3) == _seed) exitWith {_request = _requests select _forEachIndex;_id = _forEachIndex}} forEach _requests;

			if (count _request > 0) then { //--- We check if the request is still valid
				//--- Make sure that the request is still valid
				_origin = _request select 0;
				_type = _request select 1;
				_name = _request select 4;

				if !(isNil '_origin') then {
					if (_name == name leader _origin) then {
						if (isPlayer leader _origin) then { //--- Answer the client
							[["CLIENT", leader _origin], "Client_OnRequestAnswered", ["accept", _type]] call CTI_CO_FNC_NetSend;
						} else { //--- Answer the server (AI)
							//tbd
						};
					};
				};

				CTI_P_TeamsRequests set [_id, "!nil!"];
				CTI_P_TeamsRequests = CTI_P_TeamsRequests - ["!nil!"];
			};

			//--- Delete the entry whether it failed or not
			((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005) lnbDeleteRow _selected;
		};
	};
	case "onRequestDeny": {
		_selected = _this select 1;

		if (_selected > -1 && _selected < ((lnbSize((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005)) select 0)) then {
			_seed = lnbValue [280005, [_selected, 0]];
			_requests = +CTI_P_TeamsRequests;
			_request = [];
			_id = -1;
			{if ((_x select 3) == _seed) exitWith {_request = _requests select _forEachIndex;_id = _forEachIndex}} forEach _requests;

			if (count _request > 0) then { //--- We check if the request is still valid
				//--- Make sure that the request is still valid
				_origin = _request select 0;
				_type = _request select 1;
				_name = _request select 4;

				if !(isNil '_origin') then {
					if (_name == name leader _origin) then {
						if (isPlayer leader _origin) then { //--- Answer the client
							[["CLIENT", leader _origin], "Client_OnRequestAnswered", ["deny", _type]] call CTI_CO_FNC_NetSend;
						} else { //--- Answer the server (AI)
							//tbd
						};
					};
				};

				CTI_P_TeamsRequests set [_id, "!nil!"];
				CTI_P_TeamsRequests = CTI_P_TeamsRequests - ["!nil!"];
			};

			//--- Delete the entry whether it failed or not
			((uiNamespace getVariable "cti_dialog_ui_requestmenu") displayCtrl 280005) lnbDeleteRow _selected;
		};
	};
};
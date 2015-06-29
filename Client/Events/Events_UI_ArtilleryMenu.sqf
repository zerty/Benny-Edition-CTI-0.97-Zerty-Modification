private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		if ((missionNamespace getVariable "CTI_ARTILLERY_SETUP") < 0) exitWith {closeDialog 0};

		((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.785), SafeZoneY + (SafezoneH * 0.69), SafeZoneW * 0.2, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlEnable (if (time - CTI_P_LastFireMission > CTI_ARTILLERY_TIMEOUT) then {true} else {false});

		_artillery = call CTI_UI_Artillery_GetTeamArtillery;

		uiNamespace setVariable ["cti_dialog_ui_artillerymenu_marker", ""];
		uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery", []];
		uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_magazine", ""];
		uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_range", -1];

		_marker_last = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker_lastcoord";
		if !(isNil '_marker_last') then {(_marker_last) call CTI_UI_Artillery_CreateArtilleryTargetMarker};

		//--- Don't bother if there's nothing
		if (count _artillery > 0) then {
			//--- Retrieve the label of the artillery pieces and add it to the combo
			_types = (_artillery) call CTI_UI_Artillery_GetText;

			{
				((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007) lbAdd (_x select 0);
				((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007) lbSetData [_forEachIndex, _x select 1];
			} forEach _types;

			lbSort ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007);

			if (count _types > 0) then {((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007) lbSetCurSel 0};
		};

		execVM "Client\GUI\GUI_ArtilleryMenu.sqf";
	};
	case "onMapButtonDown": {
		_event = _this select 1;
		_button = _event select 1;
		_mx = _event select 2;
		_my = _event select 3;
		// _ctrl = _event select 5;

		if (_button == 0) then {
			_mappos = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290001) ctrlMapScreenToWorld [_mx, _my];
			_marker = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker";

			if (_marker == "") then {(_mappos) call CTI_UI_Artillery_CreateArtilleryTargetMarker};

			_marker setMarkerPosLocal _mappos;
		};
	};
	case "onArtilleryTypeChanged": {
		_selected = _this select 1;

		if (_selected > -1) then {
			_selected = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007) lbData _selected;

			lbClear ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009);
			lbClear ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011);

			_get = missionNamespace getVariable format ["CTI_ARTILLERY_%1", _selected];

			//--- Stop tracking thread and remove current tracking markers
			{
				if !(scriptDone (_x select 2)) then {terminate (_x select 2)};
				{deleteMarkerLocal _x} forEach (_x select 1);
			} forEach (uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery");

			if !(isNil '_get') then {
				//--- Magazines
				_magazines_labels = _get select 1;
				_magazines = _get select 2;
				for '_i' from 0 to count(_magazines)-1 do {
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009) lbAdd (_magazines_labels select _i);
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009) lbSetData [_i, _magazines select _i];
				};

				if (count _magazines > 0) then {((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009) lbSetCurSel 0};

				//--- Burst
				{
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011) lbAdd str _x;
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011) lbSetValue [_forEachIndex, _x];
				} forEach (_get select 3);

				if (count (_get select 3) > 0) then {((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011) lbSetCurSel 0};

				//--- Range
				_range = (_get select 4) call CTI_UI_Artillery_GetArtilleryRange;
				uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_range", _range];

				//--- Available units.
				_artillery = (_selected) call CTI_UI_Artillery_GetGivenTeamArtillery;
				_artillery_array = [];
				//todo: stop tracking.

				lbClear ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014);
				{
					_row = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014) lbAdd format ["[%1] - %2", _x call CTI_CL_FNC_GetAIDigit, _get select 0];
					_markers = [_x, _range select 0, _range select 1] call CTI_UI_Artillery_CreateArtilleryMarker;
					_thread = [_x, _markers] spawn CTI_UI_Artillery_UpdateArtilleryMarker;
					_artillery_array pushBack [_x, _markers, _thread];
				} forEach _artillery;

				uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery", _artillery_array];
			};
		};
	};
	case "onArtilleryMagazineChanged": {
		_selected = _this select 1;

		//--- Update the selection of the desired magazine (initSpeed differs on different mags?)
		if (_selected > -1) then {
			_selected = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009) lbData _selected;
			uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_magazine", _selected];
		};
	};
	case "onFireMissionCall": {
		_artillery = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery";
		_artillery_marker = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker";
		_artillery_magazine = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_magazine";
		_artillery_range = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_range";

		//todo timeout!
		if (_artillery_magazine != "" && _artillery_marker != "" && time - CTI_P_LastFireMission > CTI_ARTILLERY_TIMEOUT) then {
			//--- We only grab the selected artillery pieces
			_artillery = (_artillery) call CTI_UI_Artillery_GetSelectedArtilleryArray;

			//--- Don't bother if we have nothing
			if (count _artillery > 0) then {
				_artillery_burst = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011) lbValue (lbCurSel 290011);
				_target = getMarkerPos _artillery_marker;
				{
					_artillery_piece = _x select 0;
					if (alive _artillery_piece) then { //--- The artillery piece is alive and kicking
						if ([_artillery_piece, _artillery_magazine, _target, _artillery_range select 0, _artillery_range select 1] call CTI_UI_Artillery_CanFire) then { //--- Ultimate check about ranges
							_artillery_piece doArtilleryFire [_target, _artillery_magazine, _artillery_burst];
						};
					};
				} forEach _artillery;

				CTI_P_LastFireMission = time;
			};
		};
	};
	case "onSelectAll": {
		for '_i' from 0 to lbSize(290014)-1 do {
			((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014) lbSetSelected [_i, true];
		};
	};
	case "onUnload": {
		//--- Stop tracking thread and remove current tracking markers
		{
			if !(scriptDone (_x select 2)) then {terminate (_x select 2)};
			{deleteMarkerLocal _x} forEach (_x select 1);
		} forEach (uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery");

		//--- Remove the target marker
		_marker = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker";
		if (_marker != "") then {
			uiNamespace setVariable ["cti_dialog_ui_artillerymenu_marker_lastcoord", getMarkerPos _marker];
			deleteMarkerLocal _marker;
		};
	};
};
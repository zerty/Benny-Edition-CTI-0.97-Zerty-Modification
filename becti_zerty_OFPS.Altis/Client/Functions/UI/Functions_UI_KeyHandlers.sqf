CTI_UI_KeyHandler_BuildMenu = {
	private ["_alt", "_control", "_key", "_shift"];
	_key = _this select 1;
	_shift = _this select 2;
	_control = _this select 3;
	_alt = _this select 4;
	
	switch (true) do {
		case (_key in actionKeys "User1"): {
			if (_alt) then {
				CTI_P_KeyDistance = CTI_P_KeyDistance + 1;
				if (CTI_P_KeyDistance >= CTI_P_KeyDistance_Max) then { CTI_P_KeyDistance = CTI_P_KeyDistance_Max };
			} else {
				_rotate = switch (true) do { case (_shift): {45}; case (_control): {5};	default {1} };
				CTI_P_KeyRotate = CTI_P_KeyRotate + _rotate;
			};
		};
		case (_key in actionKeys "User2"): {
			if (_alt) then {
				CTI_P_KeyDistance = CTI_P_KeyDistance - 1;
				if (CTI_P_KeyDistance <= CTI_P_KeyDistance_Min) then { CTI_P_KeyDistance = CTI_P_KeyDistance_Min };
			} else {
				_rotate = switch (true) do { case (_shift): {45}; case (_control): {5};	default {1} };
				CTI_P_KeyRotate = CTI_P_KeyRotate - _rotate;
			};
		};
		case (_key in actionKeys "User3"): {
			CTI_P_KeyRotate = 0;
			CTI_P_KeyDistance = 0;
		};
	};
};

CTI_UI_KeyHandler_SatelitteCamera = {
	private ["_alt", "_control", "_key", "_shift"];
	_key = _this select 1;
	_shift = _this select 2;
	_control = _this select 3;
	_alt = _this select 4;
	
	switch (true) do {
		case (_key in (actionKeys "MoveForward")): {
			if !(isNil {uiNamespace getVariable "cti_dialog_ui_satcam_focus"}) then {
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170011) ctrlSetText "Feed: No Target";
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170017) ctrlSetStructuredText parseText "";
				uiNamespace setVariable ["cti_dialog_ui_satcam_focus", nil];
			};
			_camZ = ((getpos CTI_SatelitteCamera select 2) max 1 min 256)*0.4;
			_pos = getPos CTI_SatelitteCamera;
			_pos set [1, (_pos select 1) + _camZ];
			
			CTI_SatelitteCamera setPos _pos;
		};
		case (_key in (actionKeys "MoveBack")): {
			if !(isNil {uiNamespace getVariable "cti_dialog_ui_satcam_focus"}) then {
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170011) ctrlSetText "Feed: No Target";
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170017) ctrlSetStructuredText parseText "";
				uiNamespace setVariable ["cti_dialog_ui_satcam_focus", nil];
			};
			_camZ = ((getpos CTI_SatelitteCamera select 2) max 1 min 256)*0.4;
			_pos = getPos CTI_SatelitteCamera;
			_pos set [1, (_pos select 1) - _camZ];
			
			CTI_SatelitteCamera setPos _pos;
		};
		case (_key in (actionKeys "TurnLeft")): {
			if !(isNil {uiNamespace getVariable "cti_dialog_ui_satcam_focus"}) then {
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170011) ctrlSetText "Feed: No Target";
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170017) ctrlSetStructuredText parseText "";
				uiNamespace setVariable ["cti_dialog_ui_satcam_focus", nil];
			};
			_camZ = ((getpos CTI_SatelitteCamera select 2) max 1 min 256)*0.4;
			_pos = getPos CTI_SatelitteCamera;
			_pos set [0, (_pos select 0) - _camZ];
			
			CTI_SatelitteCamera setPos _pos;
		};
		case (_key in (actionKeys "TurnRight")): {
			if !(isNil {uiNamespace getVariable "cti_dialog_ui_satcam_focus"}) then {
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170011) ctrlSetText "Feed: No Target";
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170017) ctrlSetStructuredText parseText "";
				uiNamespace setVariable ["cti_dialog_ui_satcam_focus", nil];
			};
			_camZ = ((getpos CTI_SatelitteCamera select 2) max 1 min 256)*0.4;
			_pos = getPos CTI_SatelitteCamera;
			_pos set [0, (_pos select 0) + _camZ];
			
			CTI_SatelitteCamera setPos _pos;
		};
	};
};

//--- Change the zoom level of the satelitte camera
CTI_UI_KeyHandler_SatelitteCamera_MouseZChanged = {
	_change = _this select 1;
	
	_pos = getPos CTI_SatelitteCamera;
	_level = _pos select 2;
	
	_change = if (_change > 0) then { _level - (_level * 0.2) } else { _level + (_level * 0.2) };
	if (_change > CTI_SATCAM_ZOOM_MAX) then { _change = CTI_SATCAM_ZOOM_MAX };
	if (_change < CTI_SATCAM_ZOOM_MIN) then { _change = CTI_SATCAM_ZOOM_MIN };
	
	if (_change != _level) then {
		_pos set [2, _change];
		CTI_SatelitteCamera setPos _pos;
	};
};

//--- The mouse is in a "down" state
CTI_UI_KeyHandler_SatelitteCamera_MouseButtonDown = {
	_button = _this select 1;
	_coord_x = _this select 2;
	_coord_y = _this select 3;
	
	switch (_button) do {
		case 0: { //--- Left clicked
			_position = screenToWorld [_coord_x, _coord_y];
			_nearestObjects = [_position, _position nearEntities [["AllVehicles"], 40]] call CTI_CO_FNC_SortByDistance;
			
			_swapto = objNull;
			_groups = uiNamespace getVariable "cti_dialog_ui_satcam_groups";
			{
				if (_x isKindOf "Man") then {
					if (group _x in _groups) exitWith { _swapto = _x };
				} else {
					{if (group _x in _groups) exitWith { _swapto = _x }} forEach crew _x;
				};
				if !(isNull _swapto) exitWith {};
			} forEach _nearestObjects;
			
			if !(isNull _swapto) then {
				uiNamespace setVariable ["cti_dialog_ui_satcam_focus", _swapto];
				
				if (_swapto != leader group _swapto) then {uiNamespace setVariable ["cti_dialog_ui_satcam_mapselect", _swapto]};
				
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170100) lbSetCurSel (_groups find group _swapto);
			};
		};
		case 1: { //--- Right clicked
			uiNamespace setVariable ["cti_dialog_ui_satcam_anchor", [_coord_x, _coord_y]];
			if !(isNil {uiNamespace getVariable "cti_dialog_ui_satcam_focus"}) then {
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170011) ctrlSetText "Feed: No Target";
				((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170017) ctrlSetStructuredText parseText "";
				uiNamespace setVariable ["cti_dialog_ui_satcam_focus", nil];
			};
		};
	};
};

//--- The mouse is in a "up" state
CTI_UI_KeyHandler_SatelitteCamera_MouseButtonUp = {
	_button = _this select 1;
	
	if (_button == 1) then { //--- Right clicked
		uiNamespace setVariable ["cti_dialog_ui_satcam_anchor", nil];
	};
};

//--- The mouse is being moved/held
CTI_UI_KeyHandler_SatelitteCamera_MouseMoving = {
	private ["_coord_x", "_coord_y"];
	_coord_x = _this select 1;
	_coord_y = _this select 2;
	
	_anchor = uiNamespace getVariable "cti_dialog_ui_satcam_anchor";
	if (!isNil '_anchor') then { //--- Make sure that the mouse is still being held
		_origin_x = _anchor select 0;
		_origin_y = _anchor select 1;
		
		_camZ = (getpos CTI_SatelitteCamera select 2) max 1 min 256;
		_dX = (_coord_x - _origin_x) * _camZ / 2;
		_dY = -(_coord_y - _origin_y) * _camZ / 2;
		
		_pos = getPos CTI_SatelitteCamera;
		_pos = [_pos,_dY,direction CTI_SatelitteCamera] call bis_fnc_relpos;
		_pos = [_pos,_dX,direction CTI_SatelitteCamera + 90] call bis_fnc_relpos;
		
		CTI_SatelitteCamera setPos _pos;
	};
};







//--- The mouse is in a "up" state
CTI_UI_KeyHandler_UnitsCam_MouseButtonUp = {
	_button = _this select 1;
	
	if (_button == 1) then { //--- Right clicked
		uiNamespace setVariable ["cti_dialog_ui_unitscam_anchor", nil];
	};
};

//--- The mouse is in a "up" state
CTI_UI_KeyHandler_UnitsCam_MouseButtonDown = {
	_button = _this select 1;
	_coord_x = _this select 2;
	_coord_y = _this select 3;
	
	switch (_button) do { 
		case 0: { //--- Left clicked
			_position = screenToWorld [_coord_x, _coord_y];
			_nearestObjects = [_position, _position nearEntities [["AllVehicles"], 40]] call CTI_CO_FNC_SortByDistance;
			
			_swapto = objNull;
			_groups = uiNamespace getVariable "cti_dialog_ui_unitscam_groups";
			{
				if (_x isKindOf "Man") then {
					if (group _x in _groups) exitWith { _swapto = _x };
				} else {
					{if (group _x in _groups) exitWith { _swapto = _x }} forEach crew _x;
				};
				if !(isNull _swapto) exitWith {};
			} forEach _nearestObjects;
			
			if !(isNull _swapto) then {
				uiNamespace setVariable ["cti_dialog_ui_unitscam_focus", _swapto];
				
				if (_swapto != leader group _swapto) then {uiNamespace setVariable ["cti_dialog_ui_unitscam_screenselect", _swapto]};
				
				((uiNamespace getVariable "cti_dialog_ui_unitscam") displayCtrl 180100) lbSetCurSel (_groups find group _swapto);
			};
		};
		case 1: { //--- Right clicked
			uiNamespace setVariable ["cti_dialog_ui_unitscam_anchor", [_coord_x, _coord_y]];
		};
	};
};

//--- The mouse is being moved/held
CTI_UI_KeyHandler_UnitsCam_MouseMoving = {
	private ["_coord_x", "_coord_y"];
	_coord_x = _this select 1;
	_coord_y = _this select 2;
	
	_anchor = uiNamespace getVariable "cti_dialog_ui_unitscam_anchor";
	if (!isNil '_anchor') then { //--- Make sure that the mouse is still being held
		_origin_x = _anchor select 0;
		_origin_y = _anchor select 1;
		
		_dX = ((_coord_x - _origin_x) * 180) / 20;
		_dY = (-(_coord_y - _origin_y) * 180) / 20;
		
		uiNamespace setVariable ["cti_dialog_ui_unitscam_dir", (uiNamespace getVariable "cti_dialog_ui_unitscam_dir") + _dX];
		_pitch = ((uiNamespace getVariable "cti_dialog_ui_unitscam_pitch") + _dY) max -90 min +90;
		uiNamespace setVariable ["cti_dialog_ui_unitscam_pitch", _pitch];
	};
};

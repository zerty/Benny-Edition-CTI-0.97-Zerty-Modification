CTI_UI_MapCommanding_GetOrdersParameters = {
	_order = _this;
	
	lbClear ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010);
	
	switch (true) do {
		case (_order in [CTI_ORDER_TAKETOWNS, CTI_ORDER_TAKEHOLDTOWNS]): {
			_towns = (CTI_P_SideID) call CTI_CO_FNC_GetEnemyTowns;
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbAdd "* - Closest Town";
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbSetValue [0, -1];
			
			uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_order_targets", _towns];
			
			{
				((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbAdd format["TOWN: %1", _x getVariable "cti_town_name"];
				((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbSetValue [_forEachIndex+1, _forEachIndex];
			} forEach _towns;
			
			lbSort ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010);
		};
		case (_order in [CTI_ORDER_HOLDTOWNSBASES]): {
			_towns = (CTI_P_SideID) call CTI_CO_FNC_GetFriendlyTowns;
			_base = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbAdd "* - Closest";
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbSetValue [0, -1];
			
			uiNamespace setVariable ["cti_dialog_ui_mapcommandmenu_order_targets", _towns + _base];
			
			_u = 0;
			{
				((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbAdd format["TOWN: %1", _x getVariable "cti_town_name"];
				((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbSetValue [_u+1, _u];
				_u = _u + 1;
			} forEach _towns;
			
			{
				_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _x getVariable "cti_structure_type"];
				_value = (_var select 0) select 1;
				((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbAdd format["BASE: %1 (%2)", _value, mapGridPosition getPos _x];
				((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010) lbSetValue [_u+1, _u];
				_u = _u + 1;
			} forEach _base;
			
			lbSort ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220010);
		};
	};
};

CTI_UI_MapCommanding_TrySetOrder = {
	private ["_assign", "_group", "_order", "_order_pos", "_order_pos_new"];
	_group = _this select 0;
	_order = _this select 1;
	_order_pos_new = _this select 2;

	if (_order != (_group getVariable "cti_order")) then {_group setVariable ["cti_order", _order, true]};
	if (typeName _order_pos_new != "BOOL") then {
		_order_pos = _group getVariable "cti_order_pos";
		_assign = true;
		switch (true) do {
			case (typeName _order_pos_new == "ARRAY" && typeName _order_pos == "ARRAY"): {if (_order_pos_new select 0 == _order_pos select 0 && _order_pos_new select 1 == _order_pos select 1) then {_assign = false}};
			case (typeName _order_pos_new == "OBJECT" && typeName _order_pos == "OBJECT"): {if (_order_pos_new == _order_pos || isNull _order_pos_new && isNull _order_pos) then {_assign = false}};
		};
		if (_assign) then {_group setVariable ["cti_order_pos", _order_pos_new, true]};
	};
};

CTI_UI_MapCommanding_TrackGroupOrder = {
	_track = _this select 0;
	_marker = _this select 1;
	
	_markerLine = createMarkerLocal [_marker, [0,0,0]];
	CTI_P_MarkerIterator = CTI_P_MarkerIterator + 1;
	_markerLine setMarkerColorLocal CTI_P_SideColor;
	_markerLine setMarkerShapeLocal "rectangle";
	_markerLine setMarkerBrushLocal "solid";
	_markerLine setMarkerAlphaLocal 0.2;
	
	while {!isNil {uiNamespace getVariable "cti_dialog_ui_mapcommandmenu"}} do {
		if (isNil '_track') exitWith {};
		_ppos = getPos leader _track;
		_mpos = _track getVariable "cti_order_pos";
		
		// if (leader _track == bravo) then {player sidechat format ["BEFORE   %1 %2",_ppos, _mpos]};
		if (typeName _mpos == "ARRAY") then {if (_mpos select 0 == 0 && _mpos select 1 == 0) then {_mpos = _ppos}};
		if (typeName _mpos == "OBJECT") then {_mpos = if (isNull _mpos) then {_ppos} else {getPos _mpos}};
		// if (leader _track == bravo) then {player sidechat format ["AFTER   %1 %2",_ppos, _mpos]};
		
		
		_difX = (_mpos select 0) - (_ppos select 0) +0.1;
		_difY = (_mpos select 1) - (_ppos select 1) +0.1;
		_lx = (_ppos select 0) + _difX / 2;
		_ly = (_ppos select 1) + _difY / 2;
		_dis = sqrt(_difX^2 + _difY^2);
		_dir = atan (_difX / _difY);
		_width = ctrlMapScale ((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220001) * 6.66 * 2;
		_markerLine setMarkerPosLocal [_lx,_ly];
		_markerLine setMarkerSizeLocal [_width,_dis/2];
		_markerLine setMarkerDirLocal _dir;
		
		sleep .01;
	};
	
	deleteMarkerLocal _markerLine;
};
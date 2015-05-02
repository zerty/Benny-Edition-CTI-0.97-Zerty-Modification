_last_campos = [0,0,0];
while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_satcam"}) exitWith {}; //--- Menu is closed.
	
	_track = uiNamespace getVariable "cti_dialog_ui_satcam_focus";
	if !(isNil '_track') then {
		if (isNull _track) then {
			uiNamespace setVariable ["cti_dialog_ui_satcam_focus", nil];
			((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170011) ctrlSetText "Feed: No Target";
		} else {
			_pos = visiblePosition vehicle _track;
			_pos set [2, getPos CTI_SatelitteCamera select 2];
			CTI_SatelitteCamera setPos _pos;
		};
	};
	
	if (uiNamespace getVariable "cti_dialog_ui_satcam_showmap") then {
		if (CTI_SatelitteCamera distance _last_campos > 1) then { //--- Only move the camera when there is a change
			_zoffset = getPos CTI_SatelitteCamera select 2;
			((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170010) ctrlMapAnimAdd [0, _zoffset/1500, getPos CTI_SatelitteCamera]; //.35
			ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_satcam") displayCtrl 170010);
			_last_campos = getPos CTI_SatelitteCamera;
		};
	};
	
	sleep .01;
};
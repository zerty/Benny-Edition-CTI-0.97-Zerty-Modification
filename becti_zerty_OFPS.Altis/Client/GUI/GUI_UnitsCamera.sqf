_last_tracked = objNull;
_last_campos = [0,0,0];
_thirdperson = if (difficultyEnabled "3rdPersonView") then {true} else {false};

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_unitscam"}) exitWith {}; //--- Menu is closed.
	
	_track = uiNamespace getVariable "cti_dialog_ui_unitscam_focus";
	if !(isNil "_track") then {
		if (isNull _track) then {
			uiNamespace setVariable ["cti_dialog_ui_unitscam_focus", player];
			//--- todo select the player back in the LB.
		} else {
			if (_thirdperson) then { //--- No need to do that with 3rd person disabled heh
				if (vehicle _track == _track) then { //--- On Foot.
					// _ep = _track weaponDirection currentWeapon _track; //--- If it has no weapons then 0 is returned.
					// _pitch = (_ep) call CTI_UI_UnitsCamera_GetPitchFromDirectionVector;
					// _pitch = _pitch + (uiNamespace getVariable "cti_dialog_ui_unitscam_pitch");
					_pitch = uiNamespace getVariable "cti_dialog_ui_unitscam_pitch";
					_dir = uiNamespace getVariable "cti_dialog_ui_unitscam_dir";
					
					_distance = 2.5;
					_relPos = [(sin _dir)*(cos _pitch * _distance),(cos _pitch) * (cos _dir * _distance),1.5-(sin _pitch * _distance)]; //--- Orbit
					if (camTarget CTI_UnitsCamera != _track || _last_tracked != _track) then { CTI_UnitsCamera camSetTarget _track; CTI_UnitsCamera camSetRelPos _relPos; CTI_UnitsCamera camCommit 0 };
					CTI_UnitsCamera camSetRelPos _relPos;
				} else {
					_vehicle = vehicle _track;
					// _pitch = (vectorDir _vehicle) call CTI_UI_UnitsCamera_GetPitchFromDirectionVector;
					// _pitch = _pitch + (uiNamespace getVariable "cti_dialog_ui_unitscam_pitch");
					_pitch = uiNamespace getVariable "cti_dialog_ui_unitscam_pitch";
					_dir = uiNamespace getVariable "cti_dialog_ui_unitscam_dir";
					
					_distance = switch (true) do {case (_vehicle isKindOf "Car" || _vehicle isKindOf "Motorcycle"): {13.5}; case (_vehicle isKindOf "Tank"): {15}; default {22.5} };
					_relPos = [(sin _dir)*(cos _pitch * _distance),(cos _pitch) * (cos _dir * _distance),1.5-(sin _pitch * _distance)]; //--- Orbit
					if (camTarget CTI_UnitsCamera != _vehicle || _last_tracked != _track) then { CTI_UnitsCamera camSetTarget vehicle _track; CTI_UnitsCamera camSetRelPos _relPos; CTI_UnitsCamera camCommit 0 };
					CTI_UnitsCamera camSetRelPos _relPos;
				};
			};
			
			if (uiNamespace getVariable "cti_dialog_ui_unitscam_showmap") then {
				if (CTI_UnitsCamera distance _last_campos > 1) then { //--- Only move the camera when there is a change
					_zoffset = (getPos vehicle _track) select 2;
					((uiNamespace getVariable "cti_dialog_ui_unitscam") displayCtrl 180010) ctrlMapAnimAdd [0, (_zoffset/10) max 0.2 min 0.8, getPos _track]; //.35
					ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_unitscam") displayCtrl 180010);
					_last_campos = getPos CTI_UnitsCamera;
				};
			};
			CTI_UnitsCamera camCommit 0.001;
			_last_tracked = _track;
		};
	};
	
	// sleep .01;
	// sleep .005;
	sleep .001;
};
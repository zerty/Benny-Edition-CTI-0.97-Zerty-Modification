private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		//--- View distance
		_distance = profileNamespace getVariable "CTI_PERSISTENT_VIEW_DISTANCE";
		_distance_max = missionNamespace getVariable "CTI_GRAPHICS_VD_MAX";

		if (isNil '_distance') then { _distance = viewDistance };

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150002) sliderSetRange [500, _distance_max];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150002) sliderSetPosition _distance;

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150001) ctrlSetText format [localize "STR_View_Distance_VSM", _distance];

		//--- Object distance
		_distance = profileNamespace getVariable "CTI_PERSISTENT_OBJECT_DISTANCE";
		_distance_max = missionNamespace getVariable "CTI_GRAPHICS_VD_MAX";

		if (isNil '_distance') then { _distance = viewDistance };
		if (_distance > viewDistance) then { _distance = viewDistance };

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150004) sliderSetRange [500, viewDistance];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150004) sliderSetPosition _distance;

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150003) ctrlSetText format [localize "STR_Object_Distance_VSM", _distance];

		//--- Shadows Distance. (doesn't even work anyway)
		_distance = profileNamespace getVariable "CTI_PERSISTENT_SHADOWS_DISTANCE";
		// if (isNil '_distance') then { _distance = getShadowDistance }; //--- This command is bistified, do not use it yet.
		if (isNil '_distance') then { _distance = 100 };

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150006) sliderSetRange [50, 200];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150006) sliderSetPosition _distance;

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150005) ctrlSetText format [localize "STR_Shadows_Distance_VSM", _distance];

		//--- Terrain Grid
		_grid = profileNamespace getVariable "CTI_PERSISTENT_TG";
		_grid_max = missionNamespace getVariable "CTI_GRAPHICS_TG_MAX";

		if (isNil '_grid') then { _grid = 25 };
		if (typeName _grid != "SCALAR") then { _grid = 0 };
		if (_grid > _grid_max) then { _grid = _grid_max };

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150008) sliderSetRange [0, _grid_max];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150008) sliderSetPosition _grid;

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150007) ctrlSetText format [localize "STR_Terrain_Grid_VSM", _grid];

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150009) ctrlSetText (if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {localize "STR_Hints_On_VSM"} else {localize "STR_Hints_Off_VSM"});
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150009) ctrlSetToolTip (if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {localize "STR_Hints_Enabled_VSM"} else {localize "STR_Hints_Disabled_VSM"});
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150010) ctrlSetText (if (profileNamespace getVariable ["HUD_Normal",true]) then {localize "STR_InfoHUD_On_VSM"} else {localize "STR_InfoHUD_Off_VSM"});
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150011) ctrlSetText (if (profileNamespace getVariable ["HUD_Tactical",true]) then {localize "STR_TacHUD_On_VSM"} else {localize "STR_TacHUD_Off_VSM"});
	};
	case "onViewSliderChanged": {
		_changeto = round(_this select 1);

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150001) ctrlSetText format [localize "STR_View_Distance_VSM", _changeto];
		profileNamespace setVariable ["CTI_PERSISTENT_VIEW_DISTANCE", _changeto];

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150004) sliderSetRange [500, _changeto];
		_object_vd = round(sliderPosition ((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150004));
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150003) ctrlSetText format [localize "STR_Object_Distance_VSM", _object_vd];
		profileNamespace setVariable ["CTI_PERSISTENT_OBJECT_DISTANCE", _object_vd];

		setObjectViewDistance _object_vd;
		setViewDistance _changeto;
	};
	case "onObjectSliderChanged": { //--- Match up to 2k
		_changeto = round(_this select 1);

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150003) ctrlSetText format [localize "STR_Object_Distance_VSM", _changeto];
		profileNamespace setVariable ["CTI_PERSISTENT_OBJECT_DISTANCE", _changeto];
		setObjectViewDistance _changeto;
	};
	case "onShadowsSliderChanged": {
		_changeto = round(_this select 1);

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150005) ctrlSetText format [localize "STR_Shadows_Distance_VSM", _changeto];
		profileNamespace setVariable ["CTI_PERSISTENT_SHADOWS_DISTANCE", _changeto];
		setShadowDistance _changeto;
	};
	case "onGridSliderChanged": {
		_changeto = round(_this select 1);

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150007) ctrlSetText format [localize "STR_Terrain_Grid_VSM", _changeto];
		profileNamespace setVariable ["CTI_PERSISTENT_TG", _changeto];
		setTerrainGrid _changeto;
	};
	case "onHintsPressed": {
		_changeto = !(profileNamespace getVariable "CTI_PERSISTENT_HINTS");
		profileNamespace setVariable ["CTI_PERSISTENT_HINTS", _changeto];

		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150009) ctrlSetText (if (_changeto) then {localize "STR_Hints_On_VSM"} else {localize "STR_Hints_Off_VSM"});
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150009) ctrlSetToolTip (if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {localize "STR_Hints_Enabled_VSM"} else {localize "STR_Hints_Disabled_VSM"});

		saveProfileNamespace;
	};
	case "onHudBasicPressed": {
		_changeto = !(profileNamespace getVariable ["HUD_Normal",true]);
		profileNamespace setVariable ["HUD_Normal", _changeto];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150010) ctrlSetText (if (_changeto) then {localize "STR_InfoHUD_On_VSM"} else {localize "STR_InfoHUD_Off_VSM"});
		saveProfileNamespace;
	};
	case "onHudTacPressed": {
		_changeto = !(profileNamespace getVariable ["HUD_Tactical",true]);
		profileNamespace setVariable ["HUD_Tactical", _changeto];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150011) ctrlSetText (if (_changeto) then {localize "STR_TacHUD_On_VSM"} else {localize "STR_TacHUD_Off_VSM"});
		saveProfileNamespace;
	};

	case "onUnload": {
		saveProfileNamespace;
	};
};
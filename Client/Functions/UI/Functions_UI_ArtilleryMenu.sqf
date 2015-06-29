CTI_UI_Artillery_GetTeamArtillery = {
	private ["_available", "_types", "_vehicles"];
	_available = [];

	//--- Retrieve the artillery pieces defined in the mission
	_types = missionNamespace getVariable ["CTI_ARTILLERY", []];

	//--- Retrieve the valid vehicles, damaged one are skipped
	_vehicles = [group player, true] call CTI_CO_FNC_GetTeamVehicles;

	//--- Attempt to get the artillery pieces that may be present
	{if (typeOf _x in _types) then {_available pushBack _x}} forEach _vehicles;

	_available
};

CTI_UI_Artillery_GetText = {
	private ["_artillery", "_get", "_kind", "_processed", "_texts"];

	_artillery = _this;

	_processed = [];
	_texts = [];

	{
		_kind = typeOf _x;
		if !(_kind in _processed) then {
			_get = missionNamespace getVariable format ["CTI_ARTILLERY_%1", _kind];

			if !(isNil '_get') then {
				_texts pushBack [_get select 0, _kind];
			};

			_processed pushBack _kind;
		};
	} forEach _artillery;

	_texts
};

CTI_UI_Artillery_GetGivenTeamArtillery = {
	private ["_artillery", "_available", "_type"];
	_type = _this;

	_available = [];
	_artillery = call CTI_UI_Artillery_GetTeamArtillery;

	{if (typeOf _x == _type) then {_available pushBack _x}} forEach _artillery;
	_available
};

CTI_UI_Artillery_CanFire = {
	private ["_artillery", "_magazine", "_range_min", "_range_max", "_target"];
	_artillery = _this select 0;
	_magazine = _this select 1;
	_target = _this select 2;
	_range_min = _this select 3;
	_range_max = _this select 4;

	//--- Make sure that the artillery can fire with the engine (min-max) and that it's within the allowed CTI defined range.
	if (_target inRangeOfArtillery [[_artillery], _magazine] && _target distance _artillery >= _range_min && _target distance _artillery <= _range_max) then {true} else {false}
};

CTI_UI_Artillery_GetArtilleryRange = {
	_range = _this;

	_range select (missionNamespace getVariable "CTI_ARTILLERY_SETUP");
};

CTI_UI_Artillery_CreateArtilleryTargetMarker = {
	private ["_marker", "_position"];
	_position = _this;

	_marker = createMarkerLocal ["CTI_MarkerArtillery", _position];
	_marker setMarkerTypeLocal "mil_destroy";
	_marker setMarkerColorLocal "ColorBlack";
	_marker setMarkerSizeLocal [0.75, 0.75];
	uiNamespace setVariable ["cti_dialog_ui_artillerymenu_marker", _marker];
};

CTI_UI_Artillery_CreateArtilleryMarker = {
	private ["_artillery", "_marker_max", "_marker_min", "_range_max", "_range_min"];

	_artillery = _this select 0;
	_range_min = _this select 1;
	_range_max = _this select 2;

	//--- Min Range
	_marker_min = createMarkerLocal [Format ["cti_artillery_%1", CTI_P_MarkerIterator], getPos _artillery];CTI_P_MarkerIterator = CTI_P_MarkerIterator + 1;
	_marker_min setMarkerAlphaLocal 0;
	_marker_min setMarkerColorLocal "ColorBlack";
	_marker_min setMarkerShapeLocal "ELLIPSE";
	_marker_min setMarkerBrushLocal "SOLID";
	_marker_min setMarkerSizeLocal [_range_min, _range_min];

	//--- Max Range
	_marker_max = createMarkerLocal [Format ["cti_artillery_%1", CTI_P_MarkerIterator], getPos _artillery];CTI_P_MarkerIterator = CTI_P_MarkerIterator + 1;
	_marker_max setMarkerAlphaLocal 0;
	_marker_max setMarkerColorLocal "ColorBlack";
	_marker_max setMarkerShapeLocal "ELLIPSE";
	_marker_max setMarkerBrushLocal "BORDER";
	_marker_max setMarkerSizeLocal [_range_max, _range_max];

	[_marker_min, _marker_max]
};

CTI_UI_Artillery_UpdateArtilleryMarker = {
	private ["_artillery", "_marker_max", "_marker_min", "_markers"];

	_artillery = _this select 0;
	_markers = _this select 1;

	_marker_min = _markers select 0;
	_marker_max = _markers select 1;

	while {alive _artillery} do {
		{_x setMarkerPosLocal getPos _artillery} forEach [_marker_min, _marker_max];
	};

	{deleteMarkerLocal _x} forEach [_marker_min, _marker_max];
};

CTI_UI_Artillery_GetSelectedArtilleryArray = {
	private ["_artillery_array", "_return"];
	_artillery_array = _this;

	_return = [];
	{_return pushBack  (_artillery_array select _x)} forEach (lbSelection ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014));

	_return
};
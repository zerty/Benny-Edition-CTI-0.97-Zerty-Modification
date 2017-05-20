private ["_sideID", "_town", "_town_name", "_town_side", "_town_value"];
waitUntil {! isnil "CTI_InitTowns"};
waitUntil {CTI_InitTowns};
_town = _this select 0;
_town_name = _this select 1;
_town_side = _this select 2;
_town_value = _this select 3;

_CENTER_POS=getMarkerPos "CENTER_POS";
_CENTER_RADIUS=(getMarkerSize "CENTER_POS")select 0;

if ((_town distance _CENTER_POS)>_CENTER_RADIUS) exitwith {true};

if (count _this > 4) then {
	_forced_neigh= _this select 4;
	_town setVariable ["cti_town_fneigh", _forced_neigh];
};
_town setVariable ["cti_town_name", _town_name];


waitUntil {!isNil 'CTI_Init_JIP' && !isNil 'CTI_Init_Common'};

_sideID = _town_side call CTI_CO_FNC_GetSideID;
if (CTI_IsServer || CTI_IsHeadless) then {
	if CTI_IsServer then {
		_town setVariable ["cti_town_owner", "0", true];
		_town setVariable ["cti_town_sideID", _sideID, true];
		_town setVariable ["cti_town_lastSideID", _sideID, true];
		_town setVariable ["cti_town_value", _town_value, true];
		_town setVariable ["cti_structure_type",CTI_FTOWN,true],
		_current_side = _sideID call CTI_CO_FNC_GetSideFromID;
		_town setFlagTexture ( _current_side call CTI_CO_FNC_GetSideFlag);
		/*if (missionNamespace getVariable "CTI_SM_STRATEGIC" == 0) then {
			(_town) execFSM "Server\FSM\town_capture.fsm";
		} else {*/
			(_town) execFSM "Addons\Strat_mode\FSM\town_capture.fsm";
		//};
	};
	/*if (missionNamespace getVariable "CTI_SM_STRATEGIC" == 0) then {
		(_town) execFSM "Server\FSM\town_resistance.fsm";
		if (missionNamespace getVariable "CTI_TOWNS_OCCUPATION" > 0) then {(_town) execFSM "Server\FSM\town_occupation.fsm"};
	} else {*/
		(_town) execFSM "Addons\Strat_mode\FSM\town_resistance.fsm";
		if (missionNamespace getVariable "CTI_TOWNS_OCCUPATION" > 0) then {(_town) execFSM "Addons\Strat_mode\FSM\town_occupation.fsm"};
	//};
};

if (CTI_IsClient) then {
	//--- The client awaits for the MP variable to be available
	waitUntil {CTI_Init_Client};

	waitUntil {!(isNil {_town getVariable "cti_town_sideID"}) && !(isNil {_town getVariable "cti_town_lastSideID"})};

	//--- We retrieve the current side
	_current_side = (_town getVariable "cti_town_sideID") call CTI_CO_FNC_GetSideFromID;

	_coloration = CTI_RESISTANCE_COLOR;

	if (CTI_P_SideID in [_town getVariable "cti_town_lastSideID", _town getVariable "cti_town_sideID"] && !(CTI_P_SideJoined == resistance)) then { //--- Environment awareness
		_coloration = _current_side call CTI_CO_FNC_GetSideColoration;
	};

	//--- Area marker
	_marker = createMarkerLocal [format ["cti_town_areaMarker_%1", _town], getPos _town];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "SolidBorder";
	_marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE];
	_marker setMarkerColorLocal _coloration;
	_marker setMarkerAlphaLocal 0;


	//--- Area marker
	_marker = createMarkerLocal [format ["cti_town_capareaMarker_%1", _town], getPos _town];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "Border";
	_marker setMarkerSizeLocal [CTI_TOWNS_CAPTURE_RANGE, CTI_TOWNS_CAPTURE_RANGE];
	_marker setMarkerColorLocal "ColorBlack";
	_marker setMarkerAlphaLocal 1;

	//--- Center marker
	_marker = createMarkerLocal [format ["cti_town_marker_%1", _town], getPos _town];
	_marker setMarkerTypeLocal "mil_flag";
	_marker setMarkerTextLocal format["%1 :: %2",_town_name, _town_value];
	_marker setMarkerColorLocal _coloration;
	_marker setMarkerSizeLocal [0.3, 0.3];
	// _marker setMarkerAlphaLocal CTI_MARKERS_OPACITY;
	// --- ZertyWasHere basejumps

	_marker = createMarkerLocal [format ["cti_town_HALLOMarker_%1", _town], getPos _town];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "Border";
	_marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE*CTI_HALO_RATIO, CTI_MARKERS_TOWN_AREA_RANGE*CTI_HALO_RATIO];
	_marker setMarkerColorLocal "ColorYellow";
	_marker setMarkerAlphaLocal 0;


};
/*
  # HEADER #
	Script: 		Client\Functions\Client_OnTownCaptured.sqf
	Alias:			CTI_CL_FNC_OnTownCaptured
	Description:	Called by the server whenever a town is captured by either side
					Note this function is called automatically by the PVF "Client_OnTownCaptured"
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Object]: The Town
    1	[Integer]: The new Side ID
    2	[Integer]: The previous Side ID

  # RETURNED VALUE #
	None

  # SYNTAX #
	[TOWN, NEW SIDE ID, OLD SIDE ID] call CTI_CL_FNC_OnTownCaptured

  # DEPENDENCIES #
	Common Function: CTI_CL_FNC_ChangePlayerFunds
	Common Function: CTI_CL_FNC_DisplayMessage
	Common Function: CTI_CO_FNC_GetLiveUnits
	Common Function: CTI_CO_FNC_GetSideColoration
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
	[_structure, _variable] call CTI_CL_FNC_OnTownCaptured
*/

private ["_color", "_in_range", "_last_capture", "_score", "_side_new", "_sideID_new", "_sideID_old", "_town", "_value"];

_town = _this select 0;
_sideID_new = _this select 1;
_sideID_old = _this select 2;

if !(CTI_P_SideID in [_sideID_new, _sideID_old]) exitWith {}; //--- Make sure that the client need an update

_side_new = (_sideID_new) call CTI_CO_FNC_GetSideFromID;
if ((CTI_P_SideJoined == resistance)&& _side_new == CTI_P_SideJoined) exitWith {CTI_P_ChatID commandChat format["%1 has been captured!", _town getVariable "cti_town_name"];};
if (_side_new == CTI_P_SideJoined) then { //--- The player's side has captured it
	//todo move to displaymessage
	CTI_P_ChatID commandChat format["%1 has been captured!", _town getVariable "cti_town_name"];
/*
	_in_range = false;
	{if (_x distance _town < CTI_MARKERS_TOWN_AREA_RANGE) exitWith {_in_range = true}} forEach ((units player) call CTI_CO_FNC_GetLiveUnits);

	if (_in_range) then { //--- The player or one of his unit was in range of the town.
		_last_capture = _town getVariable "cti_town_lastcap";
		_value = _town getVariable "cti_town_value";
		_value = _value *CTI_TOWNS_CAPTURE_RATIO;
		if !(isNil '_last_capture') then {
			if (time - _last_capture <= CTI_TOWNS_CAPTURE_BOUNTY_DELAY) then { _value = round(_value / 4) };
		};

		_score = round(_value / CTI_SCORE_TOWN_VALUE_PERPOINT);
		if (_score > 0) then {["SERVER", "Request_AddScore", [player, _score]] call CTI_CO_FNC_NetSend}; //--- Award some score
		(_value) call CTI_CL_FNC_ChangePlayerFunds; //--- Award some money
		["town-capture", [_town, _value]] call CTI_CL_FNC_DisplayMessage;
	};

	_town setVariable ["cti_town_lastcap", time];
	*/
} else { //--- The player's side has lost it
	//todo move to displaymessage

	if !(CTI_P_SideJoined == resistance) then{ CTI_P_ChatID commandChat format["%1 has been lost!", _town getVariable "cti_town_name"]};
};

//--- Paint it
if !(CTI_P_SideJoined == resistance) then {
	_color = (_side_new) call CTI_CO_FNC_GetSideColoration;
	(format ["cti_town_marker_%1", _town]) setMarkerColorLocal _color;
	(format ["cti_town_areaMarker_%1", _town]) setMarkerColorLocal _color;
};
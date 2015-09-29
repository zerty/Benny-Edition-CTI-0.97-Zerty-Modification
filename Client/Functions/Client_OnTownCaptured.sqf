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
	HUD_NOTIFICATIONS pushBack [ format["%1 has been captured!", _town getVariable "cti_town_name"],time+180000,"ffffff"];

} else { //--- The player's side has lost it
	//todo move to displaymessage

	if !(CTI_P_SideJoined == resistance) then{ HUD_NOTIFICATIONS pushBack [ format["%1 has been lost!", _town getVariable "cti_town_name"],time+18000,"ffff00"]};
};

//--- Paint it
if !(CTI_P_SideJoined == resistance) then {
	_color = (_side_new) call CTI_CO_FNC_GetSideColoration;
	(format ["cti_town_marker_%1", _town]) setMarkerColorLocal _color;
	(format ["cti_town_areaMarker_%1", _town]) setMarkerColorLocal _color;
};
/*
  # HEADER #
	Script: 		Server\Functions\Server_OnTownCaptured.sqf
	Alias:			CTI_SE_FNC_OnTownCaptured
	Description:	Triggered when town is captured by a given side
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	23-09-2013

  # PARAMETERS #
    0	[Object]: The Town
    1	[Side]: The side which captured the town

  # RETURNED VALUE #
	None

  # SYNTAX #
	[TOWN, SIDE] call CTI_SE_FNC_OnTownCaptured

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_ChangeFunds
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_AddScore

  # EXAMPLE #
    [Town0, West] call CTI_SE_FNC_OnTownCaptured
	  -> Town0 is now captured by West
*/



private ["_award_teams", "_currentSideID", "_last_capture", "_newSide", "_newSideID", "_town"];

_town = _this select 0;
_newSide = _this select 1;



_newSideID = (_newSide) call CTI_CO_FNC_GetSideID;
_currentSideID = _town getVariable "cti_town_sideID";

_town setVariable ["cti_town_sideID", _newSideID, true];
_town setVariable ["cti_town_lastSideID", _currentSideID, true];

_town setVariable ["CTI_Net", _newSideID, true];

_town setFlagTexture ( _newSide call CTI_CO_FNC_GetSideFlag);


["CLIENT", "Client_OnTownCaptured", [_town, _newSideID, _currentSideID]] call CTI_CO_FNC_NetSend;

_award_teams = [];
{
	if (({alive _x && (_x distance _town) <= CTI_MARKERS_TOWN_AREA_RANGE} count (units _x))>0) then {_award_teams set [count _award_teams, _x]};
	true
} count ((_newSide call CTI_CO_FNC_GetSideLogic) getVariable "cti_teams");


if !(((_newSide) call CTI_CO_FNC_GetSideCommander) in _award_teams) then {_award_teams set [count _award_teams,((_newSide) call CTI_CO_FNC_GetSideCommander)]};
if (count _award_teams > 0) then {
	_last_capture = _town getVariable format["cti_town_lastcap_%1", _newSide];
	_value = (_town getVariable "cti_town_value") *CTI_TOWNS_CAPTURE_RATIO;

	if !(isNil '_last_capture') then {
		if (time - _last_capture <= CTI_TOWNS_CAPTURE_BOUNTY_DELAY) then { _value = round(_value / 4) };
	};

	_score = round(_value / CTI_SCORE_TOWN_VALUE_PERPOINT);
	{
		if (_score > 0) then {[leader _x, _score] spawn CTI_SE_FNC_AddScore};
	} forEach _award_teams;

	if !(((_newSide) call CTI_CO_FNC_GetSideCommander) in _award_teams) then {_award_teams set [count _award_teams,((_newSide) call CTI_CO_FNC_GetSideCommander)]};
	{
		_mult=if ((missionNamespace getVariable "CTI_GROUP_AWARD_MULT") == 1) then {{isplayer _x}count (units _x)} else {1};
		{if (isplayer _x )then {[["CLIENT", _x], "Client_OnMessageReceived", ["town_award",[( _value*_mult), (_town getVariable "cti_town_name")]],true] call CTI_CO_FNC_NetSend};true} count (units _x);
		[_x, _newSide,( _value*_mult)] call CTI_CO_FNC_ChangeFunds;
	} count _award_teams;
};



_town setVariable [format["cti_town_lastcap_%1", _newSide], time];




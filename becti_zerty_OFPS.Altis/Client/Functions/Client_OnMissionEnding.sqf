/*
  # HEADER #
	Script: 		Client\Functions\Client_OnMissionEnding.sqf
	Alias:			CTI_CL_FNC_OnMissionEnding
	Description:	Triggered upon the mission ending
					Note this function is automatically called by the server (PVF)
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Side]: The side
    1	[String]: The result
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, RESULT] spawn CTI_CL_FNC_OnMissionEnding
	
  # DEPENDENCIES #
	BIS Function: BIS_fnc_endMission
	
  # EXAMPLE #
	[West, "win"] spawn CTI_CL_FNC_OnMissionEnding
	[West, "loose"] spawn CTI_CL_FNC_OnMissionEnding
*/

private ["_result", "_side", "_win"];

_side = _this select 0;
_result = _this select 1;

CTI_GameOver = true;
// player sidechat "%1 lost!!! booo! brit sucks btw.";
//todo camera work and shitz

sleep 10;

_win = false;
switch (_result) do {
	case "win": {if (CTI_P_SideJoined == _side) then {_win = true}};
	case "loose": {if (CTI_P_SideJoined != _side) then {_win = true}};
};

if (_win) then {["END1", true, 0] call BIS_fnc_endMission} else {["END2", false, 0] call BIS_fnc_endMission};
/*
  # HEADER #
	Script: 		Server\Functions\Server_AddScore.sqf
	Alias:			CTI_SE_FNC_AddScore
	Description:	Add score to a given playable unit
					Note that this function only works in MP
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013
	
  # PARAMETERS #
    0	[String]: The entity classname
    1	[Object]: The Factory to use
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[PLAYABLE UNIT, SCORE] call CTI_SE_FNC_AddScore
	
  # EXAMPLE #
    [player, 5] call CTI_SE_FNC_AddScore;
	  -> Adds 5 points to the player on the leaderboard
*/

private ["_who", "_value"];

_who = _this select 0;
_value = _this select 1;

_who addScore _value;
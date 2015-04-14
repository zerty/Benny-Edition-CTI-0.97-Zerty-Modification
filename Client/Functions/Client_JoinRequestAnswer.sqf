/*
  # HEADER #
	Script: 		Client\Functions\Client_JoinRequestAnswer.sqf
	Alias:			CTI_CL_FNC_JoinRequestAnswer
	Description:	Determine whether the client can join a game in progress
					Note that this function is called by a PVF "CTI_PVF_Client_JoinRequestAnswer"
					which is defined in:
					 - Client\Init\Init_Client.sqf
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Boolean]: This is the server answer about the JIP validity
    1	[Boolean]: Determine if the client was removing kebab in jail or not

  # RETURNED VALUE #
	None

  # SYNTAX #
	[JIP ANSWER, JAILED] call CTI_CL_FNC_JoinRequestAnswer

  # EXAMPLE #
    [true, false] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client can join, he wasn't jailed
	[true, true] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client can join, he was jailed
	[false, false] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client cannot join
*/

_teamswap = _this select 0;
_teamstack = _this select 1;

if !(_teamswap || _teamstack) then {
	CTI_P_CanJoin = true;
} else {
	if (_teamswap) then {failMission "END6"}; //--- Teamswap
	if (_teamstack) then {failMission "END7"}; //--- Teamsstack
};

//CTI_P_CanJoin = true;
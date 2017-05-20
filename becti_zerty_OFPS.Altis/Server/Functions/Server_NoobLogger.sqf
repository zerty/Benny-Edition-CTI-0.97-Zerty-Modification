/*
  # HEADER #
	Script: 		Server\Functions\Server_NoobLogger.sqf
	Alias:			CTI_SE_FNC_NoobLogger
	Description:	Log the "score" of the top-most players!
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013

  # PARAMETERS #
    0	[Object]: The 1337 player
    1	[Integer]: The score

  # RETURNED VALUE #
	None

  # SYNTAX #
	[PROPLAYER, SCORE] spawn CTI_SE_FNC_NoobLogger

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    [player, 2] spawn CTI_SE_FNC_NoobLogger;
	  -> Add 2 points!
*/

//--- Register the best players ingame!
_proplayer = _this select 0;
_score = _this select 1;
//--- Try to get the score of that marvelous players.
if !(isPlayer _proplayer) exitWith {False};
_uid = getPlayerUID _proplayer;
_get = missionNamespace getVariable [format ["CTI_SERVER_CLIENT_ELITE_%1", _uid],[0, 0,-1000]];
if ((_get select 0) == 0 ) then {diag_log format [":: JAIL :: Starting TK protection for Player %1 (%2) ", _proplayer,_uid]};
diag_log format [":: JAIL :: Checking TK score for Player %1 (%2) ", _proplayer,_uid];
if ((time - (_get select 2))>0.5 && _score >0) then {
	diag_log format [":: JAIL :: Player %1 (%2) Adding %3 points", (name _proplayer),_uid,_score];
	_get set [0, (_get select 0) + _score];
	_get set [2, time];
	[_uid,time,_score,(name _proplayer)] spawn {
		if ((_this select 2) == 0 ) exitWith {false};
		waitUntil {time-(_this select 1)>300};
		diag_log format [":: JAIL :: Player %1 (%2) Removing %3 points", (_this select 3),(_this select 0),(_this select 2)];
		_get = missionNamespace getVariable [format ["CTI_SERVER_CLIENT_ELITE_%1", (_this select 0)],[0, 0,0]];
		_get set [0, (_get select 0) - (_this select 2)];
		missionNamespace setVariable [format ["CTI_SERVER_CLIENT_ELITE_%1", (_this select 0)], _get];
	};
};

//--- Did the pro player reached the top?
if ((_get select 0) > 1 && (_get select 1) <1) then {
	//--- Send to mcfly dungeon
	_time=60*(_get select 0);
	[_uid,_time] spawn {
		_unit=objNull;
		while {isNull _unit || ! alive _unit} do {
			diag_log format ["::JAIL:: Trying to locate %1", _this select 0];
			_unit = (_this select 0) call BIS_fnc_getUnitByUid;
			sleep 0.5;
		};
		diag_log format ["::JAIL:: Found %1 as %2", _this select 0,_unit];
		[["CLIENT", _unit], "Client_OnUbernessReached",(_this select 1)] call CTI_CO_FNC_NetSend;
	};
	_get set [1, 1];
	diag_log format [":: JAIL :: Player %1 (%2) Sent to jail", (name _proplayer),_uid];
	["CLIENT", "Client_OnMessageReceived", ["jailed", [(name _proplayer), (_get select 0)]]] call CTI_CO_FNC_NetSend;
};


missionNamespace setVariable [format ["CTI_SERVER_CLIENT_ELITE_%1", _uid], _get];
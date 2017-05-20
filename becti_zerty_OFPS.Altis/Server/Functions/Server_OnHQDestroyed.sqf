/*
  # HEADER #
	Script: 		Server\Functions\Server_OnHQDestroyed.sqf
	Alias:			CTI_SE_FNC_OnHQDestroyed
	Description:	Triggered by the Killed EH whenever the HQ get destroyed
					Note this function shall be called by an Event Handler (EH) but can also be called manually
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	23-09-2013

  # PARAMETERS #
    0	[Object]: The Killed defense
    1	[Object]: The Killer
    2	[Integer]: The Side ID of the defense

  # RETURNED VALUE #
	None

  # SYNTAX #
	[KILLED, KILLER, SIDE ID] spawn CTI_SE_FNC_OnHQDestroyed

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    _hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideID]];
*/

_killed = _this select 0;
_killer = _this select 1;
_sideID = _this select 2;

diag_log format ["::HQ DESTROYED:: %1 killed by %2 sideid %3", _this select 0, _this select 1, _this select 2 ];
if !(simulationEnabled _killed) then {_killed enableSimulationGlobal true;};


[["CLIENT", leader group _killer], "Client_AwardBounty", [(typeOf _killed), 30000]] call CTI_CO_FNC_NetSend;

[["CLIENT", _sideID call CTI_CO_FNC_GetSideFromID], "Client_OnMessageReceived", ["hq-destroyed"]] call CTI_CO_FNC_NetSend;
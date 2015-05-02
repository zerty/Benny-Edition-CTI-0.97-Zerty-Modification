/*
  # HEADER #
	Script: 		Server\Functions\Server_OnPlayerDisconnected.sqf
	Alias:			CTI_SE_FNC_OnPlayerDisconnected
	Description:	Triggered when a player leave the server
					Note this function is MP only.
					Also note that the server (in MP) will also trigger this script with a name of __SERVER__
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	15-10-2013

  # PARAMETERS #
    0	[String]: The Player's UID
    1	[String]: The Player's name
    2	[Number]: The Player's seed ID

  # RETURNED VALUE #
	None

  # SYNTAX #
	[UID, NAME, ID] call CTI_SE_FNC_OnPlayerDisconnected

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetClosestEntity
	Common Function: CTI_CO_FNC_GetFunds
	Common Function: CTI_CO_FNC_GetRandomPosition
	Common Function: CTI_CO_FNC_GetSideCommander
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideStructures
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    onPlayerDisconnected {[_uid, _name, _id] call CTI_SE_FNC_OnPlayerDisconnected};
*/

_uid = _this select 0;
_name = _this select 1;
_id = _this select 2;

if (_name == '__SERVER__' || _uid == '') exitWith {}; //--- We don't care about the server!
waitUntil {!isNil 'CTI_Init_Common'};
if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] [%2] has joined the current session", _name, _uid]] call CTI_CO_FNC_Log};

// BLacklists CleanUp
//====================

if (_uid in ((CTI_WEST getvariable ["CTI_COM_BLACKLIST",[]])+(CTI_EAST getvariable ["CTI_COM_BLACKLIST",[]]))) then {
	CTI_EAST setvariable ["CTI_COM_BLACKLIST",(CTI_EAST getvariable ["CTI_COM_BLACKLIST",[]])-[_uid],true];
	CTI_WEST setvariable ["CTI_COM_BLACKLIST",(CTI_WEST getvariable ["CTI_COM_BLACKLIST",[]])-[_uid],true];
};


{
	if ((_x getVariable ["CTI_UID",""]) == _uid) then {
		_g=group _x;
		_s= side _g;
		_sl= _s call CTI_CO_FNC_GetSideLogic;
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] [%2] previous unit has been found as %3 from %4", _name, _uid,_x,_g]] call CTI_CO_FNC_Log};
		[_x] joinsilent (group (missionNamespace getvariable format ["CTI_%1_DEFAULT_GROUP",_s] )) ;
		_x setDamage 1;
		if !(isNull _g) then {
			[_g,_sl] spawn {
				_g=_this select 0;
				_sl=_this select 1;
				sleep 30;
				_teams= (_sl getVariable ["cti_teams",[]]);
				if ((_g in _teams) && !(isplayer leader _g)) then {
					_teams = _teams -[_g];
					{
						if !(vehicle _x == _x ) then {
							unAssignVehicle _x;
  	 						_x action ["eject", vehicle _x];
   							_x action ["getOut", (vehicle _x)];
   						};
   						deleteVehicle _x;
   						true
   					}count (units _g);
   					_sl setVariable ["cti_teams",_teams,true];
				};
			};
		};



	};
	true
}count (switchableUnits + playableUnits +allDead)

//--- Get the disconnected group
/*_team = grpNull;
{if ((group _x getVariable "cti_uid") == _uid) exitWith {_team = group _x}} forEach playableUnits;
if (isNull _team) exitWith {if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["Disconnected Player [%1] [%2] group couldn't be found among the current playable units", _name, _uid]] call CTI_CO_FNC_Log}};

_side = _get select 3; //--- Get the last side joined
//_funds = [_team, _side] call CTI_CO_FNC_GetFunds;
_funds=_team getVariable ["cti_funds",(missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", _side])];
_commander = (_side) call CTI_CO_FNC_GetSideCommander;
_is_commander = if (_commander == _team) then {true} else {false};

_get set [1, _funds];

//--- Was it the commander?
if (_is_commander && !isNull _team) then {
	[_side,false] call CTI_COM_UNSET_SERVER;

};
*/

// To rethink because fo Dynamic group system
/*
if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 3 || _side == west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 1 || _side == east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 2 ) then { //--- Place the leader back at base
	_leader enablefatigue false;
	_leader enableAI "Move";
	_hq = (_side) call CTI_CO_FNC_GetSideHQ;
	_structures = (_side) call CTI_CO_FNC_GetSideStructures;

	_spawn_at = _hq;
	if (count _structures > 0) then { _spawn_at = [_hq, _structures] call CTI_CO_FNC_GetClosestEntity };

	if (_is_commander) then {if (alive _hq) then { _spawn_at = _hq }}; //--- AI commander will prefer to spawn at HQ if it's alive
	_spawn_at = [_spawn_at, 8, 30] call CTI_CO_FNC_GetRandomPosition;
	_leader setPos _spawn_at;



	if (!_is_commander && !isNull _team) then { //--- AI Leader Takeover
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["AI Leader is taking over [%1] [%2] slot since he/she left the current session. The team is [%3]", _name, _uid, _team]] call CTI_CO_FNC_Log};
		[_team, _side] execFSM "Server\FSM\update_ai.fsm";
	};
} else { //--- Place the leader at the respawn island and disable his movements
	_leader setPos ([getMarkerPos format["CTI_%1Respawn",_side], 3, 15] call CTI_CO_FNC_GetRandomPosition);
	_leader disableAI "MOVE";
};

_team setVariable ["cti_uid", nil]; //--- Release the uid.
*/

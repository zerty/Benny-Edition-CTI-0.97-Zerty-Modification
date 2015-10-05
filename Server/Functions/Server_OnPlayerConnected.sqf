/*
  # HEADER #
	Script: 		Server\Functions\Server_OnPlayerConnected.sqf
	Alias:			CTI_SE_FNC_OnPlayerConnected
	Description:	Triggered when a player joins the server
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
	[UID, NAME, ID] spawn CTI_SE_FNC_OnPlayerConnected

  # EXAMPLE #
    onPlayerConnected {[_uid, _name, _id] spawn CTI_SE_FNC_OnPlayerConnected};
*/

_uid = _this select 0;
_name = _this select 1;
_id = _this select 2;

//if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] [%2] has joined the current session", _name, _uid]] call CTI_CO_FNC_Log};
["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] [%2] has joined the current session", _name, _uid]] call CTI_CO_FNC_Log;
if (_name == '__SERVER__' || _uid == '') exitWith {}; //--- We don't care about the server!

waitUntil {!isNil 'CTI_Init_Common'};


//Find Unit
//==========
_try=0;
_unit=objnull;
while {isNull _unit && !((side _unit) in [east,west]) && _try <10} do {
	//waitUntil {! isnull (_uid call BIS_fnc_getUnitByUid)};
	sleep 10;
	{
		if (getPlayerUid _x == _uid) then
		{
		_unit = _x;
		};
	} forEach allUnits + allDead ;



	["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Unit for  [%1]  found : [%2] ",_uid,_unit]] call CTI_CO_FNC_Log;
	_try=_try+1;

	//if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Unit for  [%1]  found : [%2] ",_uid,_unit]] call CTI_CO_FNC_Log};
};

if (_try >=10) exitWith {false};



//Sanitize
//==========
_unit setDamage 0;
if !(isNull assignedVehicle _unit) then { unassignVehicle _unit; [_unit] orderGetIn false; [_unit] allowGetIn false };

_side=side _unit;
//_default_funds = (missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", _side]);
["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] [%2] sanitized", _name, _side]] call CTI_CO_FNC_Log;
//Save data
//==========
_get = missionNamespace getVariable [format["CTI_SERVER_CLIENT_%1", _uid],["",civilian,-1,grpNull]];
_get set [0,_uid];
//if ((_get select 1) == civilian || (missionNamespace getVariable "CTI_TEAMSWAP" == 0)) then {_get set [1,_side_joinned]};
if (isNil {missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid]}) then {
	missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _uid],_get];
	CTI_PLAYER_VARIABLES pushBack  (format["CTI_SERVER_CLIENT_%1", _uid]);
};

["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] info found %2", _name, _get]] call CTI_CO_FNC_Log;
if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Sent to   [%1]  found : [%2] ",(owner _unit),_get]] call CTI_CO_FNC_Log};


_teamswap = false;
_teamstack=false;

waitUntil {!isNil {missionNamespace getVariable Format["CTI_SERVER_CLIENT_%1",_uid];}};

_get = missionNamespace getVariable Format["CTI_SERVER_CLIENT_%1",_uid];
_side_origin = _get select 1; //--- Get the original side.


// TEAMSWAP
if (_side_origin != _side && (_side_origin in [east,west]) && CTI_TEAMSWAP == 1) then { //--- The joined side differs from the original one.
	_teamswap = true;
	//["CLIENT", "Client_OnMessageReceived", ["teamswap", _name]] call CTI_CO_FNC_NetSend;
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Request_Join", format["Player [%1] [%2] tried to teamswap from it's original side [%3] to side [%4]. The server explicitely answered that he should be sent back to the lobby.", _name, _uid, _side_origin, _side]] call CTI_CO_FNC_Log};
};
//TEAWSTACK

_teamstack=if ((_side_origin == civilian) && CTI_TEAMSTACK == 1 &&((_side == west && CTI_TEAMSTACK_WEST >=(CTI_TEAMSTACK_EAST +2)) ||	(_side == east && CTI_TEAMSTACK_EAST >=(CTI_TEAMSTACK_WEST +2)))) then {true} else {false};

//SAVE
if !(_teamstack || _teamswap ) then {
	_get set [1,_side];
	missionNamespace setVariable [Format["CTI_SERVER_CLIENT_%1",_uid],_get];
};
["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] check finished TStack %2 Tswap %3", _name, _teamstack, _teamswap]] call CTI_CO_FNC_Log;
//jail
if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Request_Join", format["Player [%1] [%2] can join? -> teamswap [%3] | teawstack [%4].", _name, _uid, _teamswap,_teamstack]] call CTI_CO_FNC_Log};

_was_jailed = false;
_get = missionNamespace getVariable format ["CTI_SERVER_CLIENT_ELITE_%1", _uid];
if !(isNil '_get') then {if (_get select 1 == 1) then {_was_jailed = true}};
_unit setVariable ["CTI_SERVER_ANWSER",[_teamswap,_teamstack],true];
["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] sending confirmation",_name]] call CTI_CO_FNC_Log;
["CLIENT", "Client_OnMessageReceived", ["player_joined",[_name,_side]],true] call CTI_CO_FNC_NetSend;
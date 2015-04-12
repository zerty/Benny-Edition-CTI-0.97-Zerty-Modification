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

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Player [%1] [%2] has joined the current session", _name, _uid]] call CTI_CO_FNC_Log};

if (_name == '__SERVER__' || _uid == '') exitWith {}; //--- We don't care about the server!

waitUntil {!isNil 'CTI_Init_Common'};


//Find Unit
//==========
_unit=objnull;
while {!((side _unit) in [east,west]) } do {
	waitUntil {! isnull (_uid call BIS_fnc_getUnitByUid)};
	_unit=_uid call BIS_fnc_getUnitByUid;
	sleep 0.5;
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Unit for  [%1]  found : [%2] ",_uid,_unit]] call CTI_CO_FNC_Log};
};



//Sanitize
//==========
_unit setDamage 0;
if !(isNull assignedVehicle _unit) then { unassignVehicle _unit; [_unit] orderGetIn false; [_unit] allowGetIn false };

_side_joinned=side _unit;
_default_funds = (missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", _side_joinned]);

//Save data
//==========
_get = missionNamespace getVariable [format["CTI_SERVER_CLIENT_%1", _uid],["",civilian,_default_funds,grpNull]];
_get set [0,_uid];
//if ((_get select 1) == civilian || (missionNamespace getVariable "CTI_TEAMSWAP" == 0)) then {_get set [1,_side_joinned]};
if (isNil {missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid]}) then {
	missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _uid],_get];
	CTI_PLAYER_VARIABLES pushBack  (format["CTI_SERVER_CLIENT_%1", _uid]);
};

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerConnected.sqf", format["Sent to   [%1]  found : [%2] ",(owner _unit),_get]] call CTI_CO_FNC_Log};



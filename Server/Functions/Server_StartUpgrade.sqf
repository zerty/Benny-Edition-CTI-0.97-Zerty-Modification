/*
  # HEADER #
	Script: 		Server\Functions\Server_StartUpgrade.sqf
	Alias:			CTI_SE_FNC_StartUpgrade
	Description:	Start upgrading an element, The server-side can spawn it straigh away.
					Use the PVF "CTI_PVF_Request_Upgrade" for a client-request
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	23-09-2013

  # PARAMETERS #
    0	[Side]: The side which requested the upgrade
    1	[Integer]: The upgrade element
    2	[Integer]: The upgrade current level

  # RETURNED VALUE #
	None

  # SYNTAX #
	[SIDE, UPGRADE, LEVEL] spawn CTI_SE_FNC_StartUpgrade

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_GetSideUpgrades
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    [West, CTI_UPGRADE_BARRACKS, 0] spawn CTI_SE_FNC_StartUpgrade
	  -> Will bring the barracks on level 1 after the upgrade completion
*/

private ["_level", "_side", "_upgrade"];

_side = _this select 0;
_upgrade = _this select 1;
_level = _this select 2;

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_upgrades = (_side) call CTI_CO_FNC_GetSideUpgrades;

_upgrade_time = ((missionNamespace getVariable Format["CTI_%1_UPGRADES_TIMES", _side]) select _upgrade) select _level;
if (CTI_DEBUG) then {_upgrade_time =0};
[["CLIENT", _side], "Client_OnMessageReceived", ["upgrade-started", [_upgrade, _level+1]]] call CTI_CO_FNC_NetSend;
if ((_logic getVariable ["cti_upgrade_lt",-1]) <0) then {_logic setVariable ["cti_upgrade_lt",_upgrade_time,true];};
_logic  setVariable ["cti_upgrade", _upgrade,true];
_logic  setVariable ["cti_upgrade_level", _level];

while {(_logic getVariable "cti_upgrade_lt") >0 } do{
	sleep 10;
	_logic setVariable ["cti_upgrade_lt", (_logic getVariable "cti_upgrade_lt") -10 , true];
};
_logic setVariable ["cti_upgrade_lt",-1, true];

_upgrades set [_upgrade, (_upgrades select _upgrade) + 1];

_logic setVariable ["cti_upgrades", _upgrades, true];
_logic setVariable ["cti_upgrade", -1, true];

[["CLIENT", _side], "Client_OnMessageReceived", ["upgrade-ended", [_upgrade, _level+1]]] call CTI_CO_FNC_NetSend;

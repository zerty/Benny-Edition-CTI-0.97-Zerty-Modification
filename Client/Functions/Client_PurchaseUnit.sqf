/*
  # HEADER #
	Script: 		Client\Functions\Client_PurchaseUnit.sqf
	Alias:			CTI_CL_FNC_PurchaseUnit
	Description:	Triggered whenever the client purchase a unit/vehicle from a factory
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013

  # PARAMETERS #
    0	[String]: The entity classname
    1	[Object]: The Factory to use
    2	[Group]: The "destination" group
    3	[Array]: The vehicle information (Crew, Lock)

  # RETURNED VALUE #
	None

  # SYNTAX #
	[DEFENSE VARIABLE, CENTER, RADIUS] call CTI_CL_FNC_PurchaseUnit

  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_IsPlayerCommander
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    [_classname, uiNamespace getVariable "cti_dialog_ui_purchasemenu_factory", _selected_group, _veh_info] call CTI_CL_FNC_PurchaseUnit;
*/

private ["_classname", "_factory", "_seed", "_team", "_veh_infos"];

_classname = _this select 0;
_factory = _this select 1;
_team = _this select 2;
_veh_infos = _this select 3;

if !(call CTI_CL_FNC_IsPlayerCommander) then {
	if (_team != group player) then {_team = group player};
};

_seed = time + random 10000 - random 500 + diag_frameno;

CTI_P_PurchaseRequests pushBack [_seed, _classname, _veh_infos, _factory, _team, true]; // seed, classname, can be canceled
["SERVER", "Request_Purchase", [_team, player, CTI_P_SideJoined, _classname, _factory, _veh_infos, _seed]] call CTI_CO_FNC_NetSend;

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Client\Functions\Client_PurchaseUnit.sqf", format["Purchased a [%1] to team [%2] from factory [%3 (%4)] with a generated seed of [%5]. Target is us -> [%6]", _classname, _team, _factory, _factory getVariable "cti_structure_type", _seed, _team == group player]] call CTI_CO_FNC_Log };

if (_team != group player && isPlayer leader _team) then { //--- The target is not our own group, it's also a player. We "forward" the request
	[["CLIENT", leader _team], "Client_OnPurchaseDelegationReceived", [_seed, _classname, group player, _veh_infos, _factory]] call CTI_CO_FNC_NetSend;
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Client\Functions\Client_PurchaseUnit.sqf", format["Notify team [%1] with leader [%2] that a [%3] is being purchased for him with seed [%4]", _team, leader _team, _classname, _seed]] call CTI_CO_FNC_Log };
};
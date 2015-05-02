/*
  # HEADER #
	Script: 		Server\Functions\Server_OnClientPurchaseCancelled.sqf
	Alias:			CTI_SE_FNC_OnClientPurchaseCancelled
	Description:	Called whenever a client cancel a purchase from a factory
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013
	
  # PARAMETERS #
    0	[Number]: The purchase seed
    1	[String]: The purchased classname
    2	[Object]: The factory
    3	[Group]: The targeted group
    4	[Group]: The buyer's group
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SEED, CLASSNAME, FACTORY, TARGET, BUYER] call CTI_SE_FNC_OnClientPurchase
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    [_team, group player, CTI_P_SideJoined, _classname, _factory, _veh_infos, _seed] call CTI_SE_FNC_OnClientPurchase
*/

private ["_factory", "_index", "_list", "_req_buyer", "_req_classname", "_req_seed", "_req_target"];

_req_seed = _this select 0;
_req_classname = _this select 1;
_factory = _this select 2;
_req_target = _this select 3;
_req_buyer = _this select 4;

_list = _factory getVariable "cti_queue_processing";

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_OnClientPurchaseComplete.sqf", format["Request from group [%1] to group [%2] concerning classname [%3] with seed [%4] on factory [%5 (%6)] has been canceled", _req_buyer, _req_target, _req_classname, _req_seed, _factory, _factory getVariable "cti_structure_type"]] call CTI_CO_FNC_Log };

if (isNil '_list') exitWith {}; //--- Thread ended of factory's dead.

_index = -1;
{
	if ((_x select 0) == _req_seed && (_x select 1) == _req_classname) exitWith {_index = _forEachIndex};
} forEach _list;

if (_index != -1) then {
	_list set [_index, "!REMOVE!"];
	_list = _list - ["!REMOVE!"];
	_factory setVariable ["cti_queue_processing", _list];
};

if (_req_target != _req_buyer && isPlayer leader _req_target) then { //--- Notify the remote target
	[["CLIENT", leader _req_target], "Client_OnPurchaseOrderCancelled", [_req_seed, _req_classname, _factory]] call CTI_CO_FNC_NetSend;
};
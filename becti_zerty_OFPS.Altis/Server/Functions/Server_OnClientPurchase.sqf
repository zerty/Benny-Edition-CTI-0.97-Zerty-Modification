/*
  # HEADER #
	Script: 		Server\Functions\Server_OnClientPurchase.sqf
	Alias:			CTI_SE_FNC_OnClientPurchase
	Description:	Called whenever a client make a purchase from a factory
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013

  # PARAMETERS #
    0	[Group]: The destination team
    1	[Group]: The buyer
    2	[Side]: The side of the destination team
    3	[String]: The model classname
    4	[Object]: The factory to buy from
    5	[Array]: The vehicle information (if applicable)
    6	[Number]: The purchase seed

  # RETURNED VALUE #
	None

  # SYNTAX #
	[DESTINATION, BUYER, SIDE, CLASSNAME, FACTORY, VEHICLE INFORMATION, SEED] call CTI_SE_FNC_OnClientPurchase

  # DEPENDENCIES #
	Server Function: CTI_SE_FNC_StartFactoryQueue

  # EXAMPLE #
    [_team, group player, CTI_P_SideJoined, _classname, _factory, _veh_infos, _seed] call CTI_SE_FNC_OnClientPurchase
*/

private ["_buyer", "_buyto_ai", "_classname", "_factory", "_locked", "_request", "_seed", "_side", "_team", "_var", "_veh_infos"];

_team = _this select 0;
_buyer = _this select 1;
_side = _this select 2;
_classname = _this select 3;
_factory = _this select 4;
_veh_infos = _this select 5;
_seed = _this select 6;

_buyto_ai = false;
if (typeName _team == "SIDE") then {
	_buyto_ai = true;
} else {
	if !(isPlayer leader _team) then {_buyto_ai = true};
};

//--- Determine the time needed to construct the unit (in case of d/c or timeout).
_var = missionNamespace getVariable _classname;
_required_time = _var select CTI_UNIT_TIME;
if (CTI_Debug) then {_required_time=0;};

//--- Compose the request
//_request = [[46441351.1385, "blowdoll", 10, Group Benny, Group McFly, false, [...], West]];
_request = [[_seed, _classname, _required_time, _buyer, _team, _buyto_ai, _veh_infos, _side]];

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_OnClientPurchase.sqf", format["[%1] Received a purchase request from team [%2] to team [%3] for a [%4] with seed [%5] on factory [%6 (%7)]. Target is AI -> [%8]", _side, _buyer, _team, _classname, _seed, _factory, _factory getVariable "cti_structure_type", _buyto_ai]] call CTI_CO_FNC_Log };

//--- Is there a queue thread running on the factory?
if (isNil {_factory getVariable "cti_queue_processing"}) then {
	_factory setVariable ["cti_queue_processing", _request];
	_factory setVariable ["cti_queue_processing_count", 1];
	(_factory) spawn CTI_SE_FNC_StartFactoryQueue;
} else { //--- The thread exists
	_factory setVariable ["cti_queue_processing", (_factory getVariable "cti_queue_processing") + _request];
	_factory setVariable ["cti_queue_processing_count", (_factory getVariable "cti_queue_processing_count") + 1];
};
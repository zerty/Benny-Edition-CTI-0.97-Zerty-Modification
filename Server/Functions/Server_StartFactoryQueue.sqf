/*
  # HEADER #
	Script: 		Server\Functions\Server_StartFactoryQueue.sqf
	Alias:			CTI_SE_FNC_StartFactoryQueue
	Description:	This function will spawn a factory's queu and exit when the request
					are all dealt with
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	22-10-2013

  # PARAMETERS #
    0	[Object]: The factory

  # RETURNED VALUE #
	None

  # SYNTAX #
	(FACTORY) spawn CTI_SE_FNC_StartFactoryQueue

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_HandleAIPurchase

  # EXAMPLE #
    (_factory) spawn CTI_SE_FNC_StartFactoryQueue
	  -> Will create a queue for _factory and listen to the incoming requests until none remains
*/

private ["_factory", "_list", "_req_buyer", "_req_classname", "_req_seed", "_req_side", "_req_time", "_req_time_out", "_req_toai", "_request", "_thread_id"];

_factory = _this;
_factory setVariable ["cti_inuse", true, true];

_thread_id = round(time + random 200 - random 50 + diag_frameno);
if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_StartFactoryQueue.sqf", format["Started a factory queue thread for factory [%1 (%2)] with ID [%3]", _factory, _factory getVariable "cti_structure_type", _thread_id]] call CTI_CO_FNC_Log };

//_request = [[46441351.1385, "soldier", 10, group Benny, true]];
//_request = [[46441351.1385, "soldierAT", 10, [group Benny, group Brit], true]]; // leader _team != _buyer

//--- Listen to purchase requests
while { alive _factory } do {
	_list = _factory getVariable "cti_queue_processing";
	if (count _list == 0) exitWith { _factory setVariable ["cti_queue_processing", nil] }; //--- No requests, exit.

	_request = +(_list select 0);
	_req_seed = _request select 0;
	_req_classname = _request select 1;
	_req_time = _request select 2;
	_req_buyer = _request select 3;
	_req_target = _request select 4;
	_req_toai = _request select 5;
	_req_veh_infos = _request select 6;
	_req_side = _request select 7;

	_req_time_out = time + _req_time + 15;
	if (CTI_Debug) then {_req_time_out=0; };
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_StartFactoryQueue.sqf", format["Processing Request from group [%1] to group [%2] concerning classname [%3] with seed [%4] in queue thread [%5]. Server AI -> [%6]", _req_buyer, _req_target, _req_classname, _req_seed, _thread_id, _req_toai]] call CTI_CO_FNC_Log };

//todo req_toai for indep salvager from client!
	if (_req_toai) then { //--- Send a purchase request to the client if the target is not an AI.
		if (isPlayer (leader _req_buyer) && typeName _req_target != "SIDE") then {
			if (group (_req_buyer) != _req_target) then {[["CLIENT",  _req_buyer], "Client_PurchaseDelegationStart", [_req_seed, _req_classname, _req_target, _factory]] call CTI_CO_FNC_NetSend};
		};

		[_req_seed, _req_classname, _req_buyer, _req_target, _factory, _req_side] spawn CTI_SE_FNC_HandleAIPurchase;
	} else {
		//--- Target != source? notify the source that his remote req is being handled.
		if (typeName _req_target != "SIDE") then {
			if (group(_req_buyer) != _req_target) then {[["CLIENT", _req_buyer], "Client_PurchaseDelegationStart", [_req_seed, _req_classname, _req_target, _factory]] call CTI_CO_FNC_NetSend};

			[["CLIENT", _req_buyer], "Client_OnPurchaseOrderReceived", [_req_seed, _req_classname, _req_buyer, _factory, _req_veh_infos]] call CTI_CO_FNC_NetSend;
			if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_StartFactoryQueue.sqf", format["Request from group [%1] concerning classname [%2] with seed [%3] in queue thread [%4] was forwarded to team [%5]", _req_buyer, _req_classname, _req_seed, _thread_id, _req_target]] call CTI_CO_FNC_Log };
		};
	};

	while { true } do {
		//--- the request is no longer in queu, the client has ended it's job.
		_is_present = false;

		{
			if ((_x select 0) == _req_seed && (_x select 1) == _req_classname && (_x select 2) == _req_time) exitWith {_is_present = true};
		} forEach (_factory getVariable "cti_queue_processing");

		if (time > _req_time_out || !_is_present) exitWith { //--- Request timed out or the client already finished processing it's order.
			if (_is_present) then {
				_list = +(_factory getVariable "cti_queue_processing");
				_list set [0, "!REMOVE!"];
				_list = _list - ["!REMOVE!"];
				_factory setVariable ["cti_queue_processing", _list];
			};

			if (time > _req_time_out) then {
				if (CTI_Log_Level >= CTI_Log_Warning) then { ["WARNING", "FILE: Server\Functions\Server_StartFactoryQueue.sqf", format["Request from group [%1] to group [%2] concerning classname [%3] with seed [%4] in queue thread [%5] has timed out. The target didn't answer in the given time (disconnected? factory got destroyed?)", _req_buyer, _req_target, _req_classname, _req_seed, _thread_id]] call CTI_CO_FNC_Log };
				//todo: send queue delete order to the destination to remove it from the local queu

			};

			_factory setVariable ["cti_queue_processing_count", (_factory getVariable "cti_queue_processing_count") - 1];
		};

		sleep 1;
	};
};

if (alive _factory) then {
	_factory setVariable ["cti_inuse", nil, true];
	_factory setVariable ["cti_queue_processing_count", nil];
};

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_StartFactoryQueue.sqf", format["Ended the factory queue thread with ID [%1]. Factory is alive -> [%2]", _thread_id, alive _factory]] call CTI_CO_FNC_Log };
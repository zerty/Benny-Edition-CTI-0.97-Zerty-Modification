/*
  # HEADER #
	Script: 		Common\Functions\Common_NetSend.sqf
	Alias:			CTI_CO_FNC_NetSend
	Description:	Send a message over the network to one or multiple targets (Clients, Client, Server)
					The content of the message is executed by the function CTI_CO_FNC_OnPVFReceived
					Public Functions (PVF) are defined in:
					 - Client\Init\Init_PublicVariables.sqf
					 - Server\Init\Init_PublicVariables.sqf
					Note that the local execution is only available for a wide broadcast (all)
	Author: 		Benny
	Creation Date:	13-05-2013
	Revision Date:	13-05-2013

  # PARAMETERS #
    0	[String / Array]: The destination
    1	[String]: The PVF which we want to call without the prefix
    2	[Array]: The parameters of the PVF
    3	{[Boolean]}: Also perform a local execution on the caller (PV only)

  # SYNTAX #
	[DESTINATION, FUNCTION] call CTI_CO_FNC_NetSend
	[DESTINATION, FUNCTION, PARAMETERS] call CTI_CO_FNC_NetSend
	[DESTINATION, FUNCTION, PARAMETERS, LOCAL EXEC] call CTI_CO_FNC_NetSend

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_OnPVFReceived

  # EXAMPLE #
	["CLIENT", "Client_OnTownCaptured", [_town, _newSideID, _currentSideID]] call CTI_CO_FNC_NetSend
	  -> Execute the Function "CTI_PVF_Client_OnTownCaptured" on all clients with some parameters
	["CLIENT", "Client_RemoveRuins", [_position, _ruins]] call CTI_CO_FNC_NetSend
	  -> Execute the Function "CTI_PVF_Client_RemoveRuins" on all clients with some parameters

	[["CLIENT", _side_killed], "Client_OnMessageReceived", ["penalty", [_var_name, _group_killer, _penalty]], _show_local] call CTI_CO_FNC_NetSend;
	  -> Execute the Function "CTI_PVF_Client_OnMessageReceived" on all clients of the given side with some parameters and call a local execution for the sender
	[["CLIENT", _killer], "Client_OnTeamkill"] call CTI_CO_FNC_NetSend
	  -> Execute the Function "CTI_PVF_Client_OnTeamkill" on a single player

	["SERVER", "Request_AddScore", [player, _score]] call CTI_CO_FNC_NetSend
	  -> Execute the Function "CTI_PVF_Request_AddScore" on the server with some parameters
	["SERVER", "Request_Building", [_placed, CTI_CL_VAR_SideJoined, getPos _preview, getDir _preview]] call CTI_CO_FNC_NetSend
	  -> Execute the Function "CTI_PVF_Request_Building" on the server with some parameters
	["SERVER", "Request_HQRepair", CTI_P_SideJoined] call CTI_CO_FNC_NetSend
	  -> Execute the Function "CTI_PVF_Request_HQRepair" on the server with a single parameter
*/

private ["_pv_destination", "_pv_exec_local", "_pv_filter_exec", "_pv_name", "_pv_parameters", "_pv_target", "_pv_who"];

_pv_destination = _this select 0;
_pv_name = _this select 1;
_pv_parameters = if (count _this > 2) then {_this select 2} else {[]};
_pv_exec_local = if (count _this > 3) then {_this select 3} else {false};

_pv_target = "";
//if (CTI_isServer) then {diag_log format ["::PVNET :: %3 :: %1 to %2 :: %4",_pv_name,_pv_destination,diag_tickTime,_pv_parameters];};
CTI_NetCom = [_pv_destination, _pv_name, _pv_parameters]; //--- Compose the net message
if !(isMultiplayer) exitWith { CTI_NetCom call CTI_CO_FNC_OnPVFReceived }; //--- In singleplayer, it's simple!

//--- Parse the header
_pv_filter_exec = "";
switch (typeName _pv_destination) do {
	case "STRING": {
		switch (_pv_destination) do { case "CLIENT": { _pv_target = "all" }; case "SERVER": { _pv_target = "server" } };
	};
	case "ARRAY": {
		switch (_pv_destination select 0) do {
			case "CLIENT": {
				if (typeName (_pv_destination select 1) in ["OBJECT", "SCALAR"]) then { _pv_target = "client" } else { _pv_target = "all" };
			};
			case "SERVER": { _pv_target = "server" };
		};
	};
};

//--- Send the message depending on the actor/target
switch (_pv_target) do {
	case "all": {
		publicVariable "CTI_NetCom";
		if (_pv_exec_local || CTI_IsHostedServer) then { CTI_NetCom call CTI_CO_FNC_OnPVFReceived }; //--- Execute the code locally if the server is LAN Hosted or if the local execution is asked for
	};
	case "server": {
		if !(isMultiplayer) then {
			CTI_NetCom call CTI_CO_FNC_OnPVFReceived
		} else {
			publicVariableServer "CTI_NetCom";
		};
		// if (CTI_IsHostedServer) then { CTI_NetCom call CTI_CO_FNC_OnPVFReceived }; //--- Execute the code locally if the server is LAN Hosted
	};
	case "client": {
		_pv_who = _pv_destination select 1;

		if !(isMultiplayer) then { //--- LAN based
			if (typeName _pv_who == "OBJECT") then { _pv_who = owner _pv_who };
			if (_pv_who == owner player) then { //--- The target is the player, execute the pvf locally
				CTI_NetCom call CTI_CO_FNC_OnPVFReceived;
			};
		} else { //--- Dedicated or Pure Client
			if (CTI_IsServer) then { //--- Dedicated server here, no problems
				if (typeName _pv_who == "OBJECT") then { _pv_who = owner _pv_who };
				_pv_who publicVariableClient "CTI_NetCom";
			} else { //--- Pure client, owner will not work here so we forward the PVF content to the server which will forward it to the client
				if (typeName _pv_who == "OBJECT") then {
					CTI_NetCom = ["SERVER", "Server_Forwarder", CTI_NetCom];
					publicVariableServer "CTI_NetCom";
				} else {
					if (CTI_Log_Level >= CTI_Log_Error) then { //--- Error
						["ERROR", "FILE: Common\Functions\Common_NetSend.sqf", format ["PVF [%1] could not be forwarded to the desired client since the target isn't an OBJECT (Target: [%2], Type [%3])", _pv_name, _pv_who, typeName _pv_who]] call CTI_CO_FNC_Log
					};
				};
			};
		};
	};
};
/*
  # HEADER #
	Script: 		Client\Functions\Client_DisplayMessage.sqf
	Alias:			CTI_CL_FNC_DisplayMessage
	Description:	Display a localize message on the client
					Note that this command is often used by a PVF
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[String]: The message to use
    1	[Dynamic]: The parameters linked to the message

  # RETURNED VALUE #
	None

  # SYNTAX #
	[MESSAGE] call CTI_CL_FNC_DisplayMessage
	[MESSAGE, PARAMETERS] call CTI_CL_FNC_DisplayMessage

  # DEPENDENCIES #
	Depends on the Message content

  # EXAMPLE #
    ["commander-disconnected"] call CTI_CL_FNC_DisplayMessage
	["town-capture", [_town, _value]] call CTI_CL_FNC_DisplayMessage;
	  -> Display some message on the client

	[["CLIENT", West], "Client_OnMessageReceived", ["commander-disconnected"]] call CTI_CO_FNC_NetSend;
	  -> Display a message for the west side, the "Client_OnMessageReceived" will call this function
	[["CLIENT", West], "Client_OnMessageReceived", ["structure-preplaced", [_this select 0, _position]]] call CTI_CO_FNC_NetSend;
	  -> Display a parameterized message for the west side, the "Client_OnMessageReceived" will call this function
*/

private ["_message_var", "_parameters"];

_message_var = _this select 0;
_parameters = if (count _this > 1) then {_this select 1} else {[]};

switch (_message_var) do {
	case "award-bounty": {HUD_NOTIFICATIONS pushBack [format [localize "STR_Award_Bounty", _parameters select 0, _parameters select 1],time+20,"00bb00"]};
	case "build-by": {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _parameters select 1];
		(_parameters select 0) groupChat format ["Constructing %1... %2%3", (_var select 0) select 1, _parameters select 2, "%"];
	};
	case "commander-disconnected": {HUD_NOTIFICATIONS pushBack [localize "STR_Cmnd_Disc",time+40,"ffffff"]};
	case "hq-destroyed": {HUD_NOTIFICATIONS pushBack [localize "STR_HQ_Destroyed",time+12000,"ffff00"]};
	case "hq-repair": {HUD_NOTIFICATIONS pushBack [localize "STR_HQ_Repair",time+12000,"ffff00"]};
	case "funds-transfer": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Funds_Transfer", _parameters select 0, (name leader (_parameters select 1)) ],time+90,"00bb00"]};
	case "order-taketowns": {_parameters sideChat "Acknowledged.  Advancing on neutral or enemy towns"};
	case "order-takeholdtowns": {_parameters sideChat "Acknowledged.  Advancing on neutral or enemy towns with guard duty"};
	case "order-holdtowns": {_parameters sideChat "Acknowledged.  Proceeding to nearest base or friendly town for guard duty"};
	case "order-sad": {_parameters sideChat "Acknowledged.  Proceeding with a search and destroy mission"};
	case "order-move": {_parameters sideChat "Acknowledged.  Moving to position now"};
	case "order-getin": {_parameters sideChat "Acknowledged.  Taking command of any nearby vehicle(s)"};
	case "order-getout": {_parameters sideChat "Acknowledged.  Disembarking the team from any vehicle(s)"};
	case "order-getinc": {_parameters sideChat "Acknowledged.  Embarking in nearest transport(s)"};
	case "order-getoutc": {_parameters sideChat "Acknowledged.  Disembarking from any transport(s)"};
	case "penalty": {
		_var = missionNamespace getVariable (_parameters select 0);
		HUD_NOTIFICATIONS pushBack [ format [localize "STR_Penalty", _var select CTI_UNIT_LABEL, (_parameters select 1) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS] , name leader  (_parameters select 1),(_parameters select 3)],time+180,"ffffff"];
	};
	case "repair-by": {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _parameters select 1];
		(_parameters select 0) groupChat format [localize "STR_Repair_by", (_var select 0) select 1, _parameters select 2, "%"];
	};
	case "salvage": {
		_value = if (call CTI_CL_FNC_IsPlayerCommander) then {_parameters select 2} else {_parameters select 1};
		_var = missionNamespace getVariable (_parameters select 0);
		if (_value > 0) then {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Salvage", _var select CTI_UNIT_LABEL, _value],time+20,"00bb00"]};
	};
	case "salvage-by": {
		_var = missionNamespace getVariable (_parameters select 0);
		HUD_NOTIFICATIONS pushBack [ format [localize "STR_Salvage", _var select CTI_UNIT_LABEL, _parameters select 1],time+40,"00bb00"];
	};
	case "spot-base": {(_parameters select 0) sideChat format [localize "STR_Spot_Base", mapGridPosition(_parameters select 1)]};
	case "spot-unit": {(_parameters select 0) sideChat format [localize "STR_Spot_Unit", mapGridPosition(_parameters select 1)]};
	case "structure-preplaced": {
		_var = missionNamespace getVariable (_parameters select 0);
		HUD_NOTIFICATIONS pushBack [format [localize "STR_Structure_Preplaced", (_var select 0) select 1, mapGridPosition (_parameters select 1)],time+20,"ffffff"];
	};
	case "structure-attacked": {
		_var = missionNamespace getVariable (_parameters select 0);
		HUD_NOTIFICATIONS pushBack [ format [localize "STR_Structure_Attacked", (_var select 0) select 1, mapGridPosition (_parameters select 1)],180,"ffff00"];
	};
	case "structure-teamkill-attempt": {
		CTI_P_ChatID commandChat format [localize "STR_Structure_Teamkill_Attempt", _parameters select 0, _parameters select 1, _parameters select 2];
	};
	case "teamkill": {HUD_NOTIFICATIONS pushBack [localize "STR_Teamkill",time+7,"ff0000"];};
	case "teamswap": {HUD_NOTIFICATIONS pushBack [format [localize "STR_TeamSwap", _parameters],time+7,"ffffff"];};
	case "town-capture": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Town_Capture" , _parameters select 1, (_parameters select 0) getVariable "cti_town_name"],time+90,"00bb00"]};
	case "town-hostilenear": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Town_HostileNear", _parameters getVariable "cti_town_name"],180,"ffff00"]};
	case "upgrade-ended": {
		HUD_NOTIFICATIONS pushBack [ format [localize "STR_Upgrade_Ended", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select (_parameters select 0)) select 0, (_parameters select 1)],time + 120000,"ffffff"];
	};
	case "upgrade-started": {
		HUD_NOTIFICATIONS pushBack [ format [localize "STR_Upgrade_Started", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select (_parameters select 0)) select 0, (_parameters select 1)],time + 120000,"ffffff"];
	};
	case "jailed": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Jailed", _parameters select 0, _parameters select 1],time+20,"ffffff"];};
	case "town_award": {
		HUD_NOTIFICATIONS pushBack [ format [localize "STR_Town_Capture",_parameters select 0, _parameters select 1],time+90,"00bb00"];
	};
	case "take_com": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Player_Take_Cmd", _parameters select 0],time+60000,"ffffff"];};
	case "leave_com": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Leave_Com", _parameters select 0],time+60000,"ffffff"];};
	case "eject_com": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Eject_Com", _parameters select 0],time+60000,"ffff00"];};
	case "player_joined": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Player_Join_Side", _parameters select 0, _parameters select 1],time+180,"ffffff"];};
	case "vote_casted": {HUD_NOTIFICATIONS pushBack [ format [localize "STR_Vote_Casted", _parameters select 0],time+60000,"ffff00"];};
};
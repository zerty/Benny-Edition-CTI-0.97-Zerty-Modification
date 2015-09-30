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
	case "award-bounty": {HUD_NOTIFICATIONS pushBack [format ["Kill reward  %2: $%1", _parameters select 0, _parameters select 1],time+20,"00bb00"]};
	case "build-by": {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _parameters select 1];
		(_parameters select 0) groupChat format ["Constructing %1... %2%3", (_var select 0) select 1, _parameters select 2, "%"];
	};
	case "commander-disconnected": {HUD_NOTIFICATIONS pushBack ["The current commander has left the game",time+40,"ffffff"]};
	case "hq-destroyed": {HUD_NOTIFICATIONS pushBack ["The HQ has been destroyed!",time+12000,"ffff00"]};
	case "hq-repair": {HUD_NOTIFICATIONS pushBack ["The HQ has been repaired",time+12000,"ffff00"]};
	case "funds-transfer": {HUD_NOTIFICATIONS pushBack [ format ["Got Tranfer from %2:  $%1", _parameters select 0, (name leader (_parameters select 1)) ],time+90,"00bb00"]};
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
		HUD_NOTIFICATIONS pushBack [ format ["TK %4 :: %2(%3) killed a %1", _var select CTI_UNIT_LABEL, (_parameters select 1) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS] , name leader  (_parameters select 1),(_parameters select 3)],time+180,"ffffff"];
	};
	case "repair-by": {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _parameters select 1];
		(_parameters select 0) groupChat format ["Repairing %1... %2%3", (_var select 0) select 1, _parameters select 2, "%"];
	};
	case "salvage": {
		_value = if (call CTI_CL_FNC_IsPlayerCommander) then {_parameters select 2} else {_parameters select 1};
		_var = missionNamespace getVariable (_parameters select 0);
		if (_value > 0) then {HUD_NOTIFICATIONS pushBack [ format ["Salvage reward %1: $%2 ", _var select CTI_UNIT_LABEL, _value],time+20,"00bb00"]};
	};
	case "salvage-by": {
		_var = missionNamespace getVariable (_parameters select 0);
		HUD_NOTIFICATIONS pushBack [ format ["Salvage reward %1: $%2 ", _var select CTI_UNIT_LABEL, _parameters select 1],time+40,"00bb00"];
	};
	case "spot-base": {(_parameters select 0) sideChat format ["Enemy structure found near %1", mapGridPosition(_parameters select 1)]};
	case "spot-unit": {(_parameters select 0) sideChat format ["Enemy presence spotted near %1", mapGridPosition(_parameters select 1)]};
	case "structure-preplaced": {
		_var = missionNamespace getVariable (_parameters select 0);
		HUD_NOTIFICATIONS pushBack [format ["%1 ready for construction (%2).", (_var select 0) select 1, mapGridPosition (_parameters select 1)],time+20,"ffffff"];
	};
	case "structure-attacked": {
		_var = missionNamespace getVariable (_parameters select 0);
		HUD_NOTIFICATIONS pushBack [ format ["%1  under attack (%2)!", (_var select 0) select 1, mapGridPosition (_parameters select 1)],180,"ffff00"];
	};
	case "structure-teamkill-attempt": {
		CTI_P_ChatID commandChat format ["Player %1 from group %2 tried to place an explosive near a friendly %3! (the explosive was removed)", _parameters select 0, _parameters select 1, _parameters select 2];
	};
	case "teamkill": {HUD_NOTIFICATIONS pushBack ["Watch your fire! you're shooting on friendly!",time+7,"ff0000"];};
	case "teamswap": {HUD_NOTIFICATIONS pushBack [format ["Player %1 Sent back to the lobby for Teamswaping", _parameters],time+7,"ffffff"];};
	case "town-capture": {HUD_NOTIFICATIONS pushBack [ format ["Capt. reward for %2: $%1" , _parameters select 1, (_parameters select 0) getVariable "cti_town_name"],time+90,"00bb00"]};
	case "town-hostilenear": {HUD_NOTIFICATIONS pushBack [ format ["Hostile detected near %1!", _parameters getVariable "cti_town_name"],180,"ffff00"]};
	case "upgrade-ended": {
		HUD_NOTIFICATIONS pushBack [ format ["Up. %1 completed to lvl %2", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select (_parameters select 0)) select 0, (_parameters select 1)],time + 120000,"ffffff"];
	};
	case "upgrade-started": {
		HUD_NOTIFICATIONS pushBack [ format ["Up. %1 started to lvl %2", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select (_parameters select 0)) select 0, (_parameters select 1)],time + 120000,"ffffff"];
	};
	case "jailed": {HUD_NOTIFICATIONS pushBack [ format ["Player %1 Jailed for %2 minutes! ", _parameters select 0, _parameters select 1],time+20,"ffffff"];};
	case "town_award": {
		HUD_NOTIFICATIONS pushBack [ format ["Capt. reward for %2: $%1",_parameters select 0, _parameters select 1],time+90,"00bb00"];
	};
	case "take_com": {HUD_NOTIFICATIONS pushBack [ format ["Player %1 has taken command. ", _parameters select 0],time+60000,"ffffff"];};
	case "leave_com": {HUD_NOTIFICATIONS pushBack [ format ["Player %1 has left command. ", _parameters select 0],time+60000,"ffffff"];};
	case "eject_com": {HUD_NOTIFICATIONS pushBack [ format ["Player %1 has been relieved of Command.", _parameters select 0],time+60000,"ffff00"];};
	case "player_joined": {HUD_NOTIFICATIONS pushBack [ format ["Player %1 joined %2.", _parameters select 0, _parameters select 1],time+180,"ffffff"];};
	case "vote_casted": {HUD_NOTIFICATIONS pushBack [ format ["Vote against Com. from Player %1 ", _parameters select 0],time+60000,"ffff00"];};
};
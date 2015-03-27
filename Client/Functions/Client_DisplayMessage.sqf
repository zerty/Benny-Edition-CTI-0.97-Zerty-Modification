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
	case "award-bounty": {player groupChat format ["$%1 awarded for the neutralization of a %2", _parameters select 0, _parameters select 1]};
	case "build-by": {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _parameters select 1];
		(_parameters select 0) groupChat format ["Constructing %1... %2%3", (_var select 0) select 1, _parameters select 2, "%"];
	};
	case "commander-disconnected": {CTI_P_ChatID sideChat "The current commander has left the game"};
	case "hq-destroyed": {CTI_P_ChatID commandChat "The HQ has been destroyed!"};
	case "hq-repair": {CTI_P_ChatID commandChat "The HQ has been repaired"};
	case "funds-transfer": {player groupChat format ["%2 :: %3 has transfered you $%1", _parameters select 0, (_parameters select 1) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], (name leader (_parameters select 1)) ]};
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
		CTI_P_ChatID sideChat format ["%5 :: A friendly %1 was killed by the %2 (%4) group! %2 was fined $%3", _var select CTI_UNIT_LABEL, (_parameters select 1) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], _parameters select 2, name leader  (_parameters select 1),(_parameters select 3)];
	};
	case "repair-by": {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _parameters select 1];
		(_parameters select 0) groupChat format ["Repairing %1... %2%3", (_var select 0) select 1, _parameters select 2, "%"];
	};
	case "salvage": {
		_value = if (call CTI_CL_FNC_IsPlayerCommander) then {_parameters select 2} else {_parameters select 1};
		_var = missionNamespace getVariable (_parameters select 0);
		if (_value > 0) then {CTI_P_ChatID sideChat format ["$%2 received for the salvaging of a %1 by your side", _var select CTI_UNIT_LABEL, _value]};
	};
	case "salvage-by": {
		_var = missionNamespace getVariable (_parameters select 0);
		(_parameters select 2) groupChat format ["$%2 awarded for salvaging a %1", _var select CTI_UNIT_LABEL, _parameters select 1];
	};
	case "spot-base": {(_parameters select 0) sideChat format ["Enemy structure found near %1", mapGridPosition(_parameters select 1)]};
	case "spot-unit": {(_parameters select 0) sideChat format ["Enemy presence spotted near %1", mapGridPosition(_parameters select 1)]};
	case "structure-preplaced": {
		_var = missionNamespace getVariable (_parameters select 0);
		CTI_P_ChatID commandChat format ["%1 is ready for construction at grid %2", (_var select 0) select 1, mapGridPosition (_parameters select 1)];
	};
	case "structure-attacked": {
		_var = missionNamespace getVariable (_parameters select 0);
		CTI_P_ChatID commandChat format ["%1 is under attack at grid %2!", (_var select 0) select 1, mapGridPosition (_parameters select 1)];
	};
	case "structure-teamkill-attempt": {
		CTI_P_ChatID commandChat format ["Player %1 from group %2 tried to place an explosive near a friendly %3! (the explosive was removed)", _parameters select 0, _parameters select 1, _parameters select 2];
	};
	case "teamkill": {CTI_P_ChatID sideChat "Watch your fire! you're shooting on friendly!"};
	case "teamswap": {CTI_P_ChatID commandChat format ["Player %1 has been sent back to the lobby after teamswaping", _parameters]};
	case "town-capture": {player groupChat format ["$%1 awarded for the capture of %2", _parameters select 1, (_parameters select 0) getVariable "cti_town_name"]};
	case "town-hostilenear": {CTI_P_ChatID commandChat format ["Hostile detected near %1", _parameters getVariable "cti_town_name"]};
	case "upgrade-ended": {
		CTI_P_ChatID commandChat format ["%1 has been upgraded to level %2", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select (_parameters select 0)) select 0, (_parameters select 1)];
	};
	case "jailed": {CTI_P_ChatID commandChat format ["::JAIL:: Player %1 has been jailed for %2 minutes! ", _parameters select 0, _parameters select 1];};
	case "town_award": {
		CTI_P_ChatID commandChat  format ["$%1 awarded for the capture of %2",_parameters select 0, _parameters select 1];
		CTI_P_ChatID commandChat format ["[Base value:$%1][Team balance corrector:$%2][Teamplay balance:$%3]", _parameters select 2, _parameters select 3, _parameters select 4];
	};
	case "take_com": {CTI_P_ChatID commandChat format ["::Commander:: Player %1 has taken command of your side. ", _parameters select 0];};
	case "leave_com": {CTI_P_ChatID commandChat format ["::Commander:: Player %1 has left command of your side. ", _parameters select 0];};
	case "eject_com": {CTI_P_ChatID commandChat format ["::Commander:: Player %1 has been relieved of Command. ", _parameters select 0];};
};
_args = _this select 3;
_request = _args select 0;
_position = _args select 1;

_commander = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideCommander;

CTI_P_TeamsRequests_Last = time;

if (isPlayer leader _commander) then {
	_seed = round(time + random 10000 - random 500 + diag_frameno);
	[["CLIENT", leader _commander], "Client_OnRequestReceived", [group player, _request, _position, _seed, name player]] call CTI_CO_FNC_NetSend;
} else {
	//todo: AI Commmander ack/deny
};
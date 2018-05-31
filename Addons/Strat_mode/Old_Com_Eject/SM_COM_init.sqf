
if (CTI_isClient) then {
	CTI_COM_SET_CLIENT=compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Old_Com_Eject\SM_COM_Set_Client.sqf";
	CTI_COM_UNSET_CLIENT=compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Old_Com_Eject\SM_COM_UnSet_Client.sqf";
	CTI_P_LastVotedTime=-1000;
	with missionnamespace do {
		CTI_PVF_Client_Com_Eject={
			0 call CTI_COM_UNSET_CLIENT;
		};
	};
};

if (CTI_IsServer) then {
	CTI_COM_SERVERWD=compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Old_Com_Eject\SM_COM_ServerWD.sqf";
	CTI_COM_UNSET_SERVER=compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Old_Com_Eject\SM_COM_UnSet_Server.sqf";
	{
		_side_logic=(_x) call CTI_CO_FNC_GetSideLogic;
		_side_logic setvariable ["CTI_COM_BLACKLIST",[],true];
		_side_logic setvariable ["CTI_COM_VOTES",[],true];
	} forEach [east,west];


	with missionnamespace do {
		CTI_PVF_Server_Vote_Eject={
			_client=_this select 0;
			_side=_this select 1;
			_side_logic=(_side) call CTI_CO_FNC_GetSideLogic;
			if ((getPlayerUID _client) in (_side_logic getvariable "CTI_COM_VOTES")) exitwith{false};
			_side_logic setvariable ["CTI_COM_VOTES",((_side_logic getvariable "CTI_COM_VOTES") + [getPlayerUID _client]),true];
			[["CLIENT", _side], "Client_OnMessageReceived", ["vote_casted", [name _client]]] call CTI_CO_FNC_NetSend;
		};
		CTI_PVF_Server_Com_Leave={
			_side=_this;
			[_side,false] call CTI_COM_UNSET_SERVER;
			_side_logic=(_side) call CTI_CO_FNC_GetSideLogic;
			_side_logic setvariable ["CTI_COM_VOTES",[],true];
		};
	};

	{
		_x spawn CTI_COM_SERVERWD;
		true
	} count [east,west]
};
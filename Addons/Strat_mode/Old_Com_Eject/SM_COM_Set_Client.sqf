

CTI_P_SideLogic setVariable ["cti_commander", group player, true];
[["CLIENT", CTI_P_SideJoined], "Client_OnMessageReceived", ["take_com", [name player]],true] call CTI_CO_FNC_NetSend;
CTI_P_SideLogic setvariable ["CTI_COM_VOTES",[],true];

0 spawn {
	_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;

	if (alive _hq) then {
		player reveal _hq;
		if (isMultiplayer) then {["SERVER", "Request_HQLocality", [CTI_P_SideJoined, player]] call CTI_CO_FNC_NetSend};
		waitUntil {local _hq};
		_hq lock 2;
		_hq addAction ["<t color='#86F078'>Unlock</t>","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player &&alive _target && locked _target == 2'];
		_hq addAction ["<t color='#86F078'>Lock</t>","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player &&alive _target && locked _target == 0'];
		_hq spawn {
			sleep 1;
			while {!CTI_GameOver && !isnull _this && (0 call CTI_CL_FNC_IsPlayerCommander)} do {
				waitUntil {alive player && ! isnull player };
				//if !(local _this) then {["SERVER", "Request_HQLocality", [CTI_P_SideJoined, player]] call CTI_CO_FNC_NetSend};
				if !((getPlayerUID player) in (_this getvariable["v_keys",[]])) then {_this setVariable ["v_keys",[getPlayerUID player,group player],true];};
				sleep 2;
			};
		} ;
	};
};
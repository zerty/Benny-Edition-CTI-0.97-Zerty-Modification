PAI_CREATE_PATROL=compile preprocessfilelinenumbers "Addons\Strat_mode\PATROL_AI\PAI_CreatePatrol.sqf";
PAI_SERVER_LOOP=compile preprocessfilelinenumbers "Addons\Strat_mode\PATROL_AI\PAI_ServerLoop.sqf";
PAI_WD=compile preprocessfilelinenumbers "Addons\Strat_mode\PATROL_AI\PAI_watchdog.sqf";
PAI_PATROL_AI=compile preprocessfilelinenumbers "Addons\Strat_mode\PATROL_AI\PAI_PatrolAI.sqf";

SM_PATROLS_TO=300;


waitUntil {!isnull CTI_GUER};

if (CTI_isServer) then {
	CTI_GUER setvariable ["patrols",[],true];
	with missionNamespace do {
		CTI_PVF_Server_Patrol_WD={ _this spawn PAI_WD;};
	};
};
with missionNamespace do {
	CTI_PVF_Patrol_Create={
		_patrol= 0 call PAI_CREATE_PATROL;
		_patrol spawn PAI_PATROL_AI;
		waitUntil {!isNull (_patrol select 0)};
		CTI_GUER setvariable ["patrols",(CTI_GUER getVariable ["patrols",[]])+ [_patrol select 0]-[grpNull],true];
		if !(CTI_isServer) then {
			["SERVER", "Server_Patrol_WD",_patrol] call CTI_CO_FNC_NetSend;
		} else {
			_patrol spawn PAI_WD;
			["SERVER", "Server_Addeditable",[ADMIN_ZEUS,(_patrol select 1)]] call CTI_CO_FNC_NetSend;
			CTI_PVF_Server_Addeditable
		};
	};
};

if (CTI_isServer) then {0 spawn PAI_SERVER_LOOP};

AN_Check_Connection=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_CheckConn.sqf";
AN_Reconfigure=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Reconfigure.sqf";
AN_Launch=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Launch.sqf";
AN_Update_Connection=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Update_Connection.sqf";
AN_Handle_Team=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Handle_Team.sqf";

AN_Switchable = compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Switchable.sqf";
AN_Reconfigure_loop=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Reconfigure_Loop.sqf";
with missionNamespace do {
	CTI_PVF_Server_Run_Net={
		_this spawn AN_Launch;
	};
};

0  execVM "Addons\Strat_mode\AdvNet\AN_Ex_Intrusion.sqf";
waitUntil { CTI_Init_Strat&& CTI_InitTowns};
if (CTI_IsClient && hasinterface) then {

	0 spawn {
		while {!CTI_GameOver} do{
			waitUntil {! (isNull player) && alive player};
			[player,CTI_P_SideID] spawn AN_Launch;
			waitUntil {! (isNil {player getVariable "CTI_Net"} || isNil {player getVariable "AN_iNet"})};
			if (NET_LOG) then {diag_log ":: NET :: Starting Client_AN_Connected loop for player"};
			while {alive player && !CTI_GameOver } do {
				if (!(player getVariable "CTI_Net"==player getVariable "AN_iNet" && player getVariable "CTI_Net" == CTI_P_SideID) || player getVariable "CTI_Net" <= -1) then{Client_AN_Connected=False;} else {Client_AN_Connected=true;} ;
				sleep 0.2;
			};
		};
	};
};




if (CTI_IsServer) then {
	waitUntil {CTI_Init_Server};
	{ (_x) spawn AN_Switchable; true } count switchableUnits;
	{ [_x, (side _x)  call CTI_CO_FNC_GetSideID] spawn AN_Launch; true } count playableunits;
	{ [_x,-1]  spawn AN_Launch ;true }count CTI_Towns;
};
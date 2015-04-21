#define DIK_LWIN            0xDB
HUD_Normal=true;
HUD_Tactical=false;
HUD_Tactical_Allies=false;
HUD_Tactical_Inf=false;
HUD_Time= Time;
HUD_MAX_RANGE=3000;

HUD_SHARED=[];
HUD_T_OBJ=[];

HUD_Targets=[];
HUD_Towns=[];
HUD_Revives=[];
/*
HUD_KeyDown={
	if (HUD_Tactical) then {
		if ((HUD_Time-time > 100) && (_this select 1) == DIK_LWIN ) then {HUD_Time= 0};
		if ((HUD_Time-time < 0) && (_this select 1) == DIK_LWIN && (_this select 2)) then {HUD_Time= Time+10000000};

		if ((HUD_Time-time < 0) && (_this select 1) == DIK_LWIN && !(_this select 2)) then {HUD_Time= Time+1};
		/*if ((_this select 1) == DIK_LWIN) then {
			HUD_Time= Time+1;
		};
	};
};*/

waitUntil {!(isNull player)};
("CTI_HUD" call BIS_fnc_rscLayer) cutrsc["CTI_HUD_RSC","PLAIN",0,true];
waitUntil {!isNil {uiNamespace getVariable 'HUD'}};

0 execVM	 "Addons\Strat_mode\HUD\HUD_launch.sqf";
0 execVM	 "Addons\Strat_mode\HUD\HUD_PBar.sqf";

0 spawn {
	if (CTI_P_SideJoined == resistance) exitWith {false};
	while {!CTI_GameOver} do
	{
		waitUntil {[CTI_P_SideJoined, CTI_UPGRADE_HUD, 1] call CTI_CO_FNC_HasUpgrade || CTI_Debug};
		if (((goggles player) in  ['g_tactical_clear','g_tactical_black'] || CTI_Debug)&& profileNamespace getVariable ["HUD_Tactical",true] ) then {
				waitUntil {! isNil "HUD_AddFrameHandler"};
				0 call HUD_AddFrameHandler;
				2001 cutText ["Welcome in the Tactical Overlay; Press the Windows key to show.","PLAIN",5,false];
				//["SERVER", "Server_Hud_Share_Send", [player,CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;
				//sleep 5;
				2001 cutText ["","PLAIN",5,false];

		} else {
				HUD_SHARED =[];
				HUD_T_OBJ=[];
				HUD_Targets=[];
				HUD_Towns=[];
				if ( {(_x select 0) == "hudFrame"} count (missionNameSpace getVariable ["BIS_stackedEventHandlers_onEachFrame", []]) > 0) then {0 call HUD_RemoveFrameHandler};
		};
		sleep 5;

	};
};
/*
0 spawn {
	if (CTI_P_SideJoined == resistance) exitWith {false};
	disableSerialization;
	_main_disp = displayNull;
	while {!CTI_GameOver &&  isNull _main_disp} do {
		_main_disp=findDisplay 46;
		sleep 2;
	};
	_main_disp displayAddEventHandler ["KeyDown","_this call HUD_KeyDown"];
};*/

with missionNamespace do {
	CTI_PVF_Client_HUD_reveal={
		if !((player getVariable 'AN_iNet')==CTI_P_SideID) exitWith {false};
		{
			_o= _x;
			(group player) reveal [_o,(missionNamespace getVariable "CTI_EW_HUD_S")];
		} count _this;
	};
};
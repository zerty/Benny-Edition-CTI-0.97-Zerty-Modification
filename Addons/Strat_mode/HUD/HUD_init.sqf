#define DIK_LWIN            0xDB
#define HUD_IDC 1500000
#define	HUD_TOWN_MAX	20


HUD_GetRevives=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_GetRevive.sqf";
HUD_ShowRevives=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_ShowRevive.sqf";
HUD_GetTowns=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_GetTowns.sqf";
HUD_ShowTowns=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_ShowTowns.sqf";
HUD_GetTargets=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_GetTargets.sqf";
HUD_ShowTargets=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_ShowTargets.sqf";
HUD_ShowNotifications=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_ShowNotifications.sqf";
HUD_UpdateInfo=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_UpdateInfo.sqf";
HUD_UpdateVehicle=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_UpdateVehicle.sqf";







HUD_Normal=true;
HUD_Tactical=false;
HUD_Tactical_Allies=false;
HUD_Tactical_Inf=false;
HUD_Time= Time;
HUD_MAX_RANGE=4000;

HUD_SHARED=[];
HUD_T_OBJ=[];

HUD_Targets=[];
HUD_Towns=[];
HUD_Revives=[];




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
		//(tolower (goggles player)) in  ['g_tactical_clear','g_tactical_black']
		if ((true || CTI_Debug)&& profileNamespace getVariable ["HUD_Tactical",true] ) then {
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

				if ( {(_x select 0) == "hudFrame"} count (missionNameSpace getVariable ["BIS_stackedEventHandlers_onEachFrame", []]) > 0) then {
					0 call HUD_RemoveFrameHandler;
					disableSerialization;
					_hud=uiNamespace getVariable 'HUD';
					for "_i" from 0 to HUD_TOWN_MAX  do {(_hud displayCtrl(HUD_IDC+400+_i)) ctrlShow false;(_hud displayCtrl(HUD_IDC+500+_i)) ctrlShow false;};
				};
		};
		sleep 5;

	};
};


with missionNamespace do {
	CTI_PVF_Client_HUD_reveal={
		if !((player getVariable 'AN_iNet')==CTI_P_SideID) exitWith {false};
		{
			_o= _x;
			(group player) reveal [_o,(missionNamespace getVariable "CTI_EW_HUD_S")];
		true
		} count _this;
	};
};
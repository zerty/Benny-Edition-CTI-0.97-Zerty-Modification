#define HUD_IDC 1500000
#define	HUD_M_MAX	20
#define	HUD_TARG_MAX	100
#define	HUD_TOWN_MAX	10



["ReviveFrame", "onEachFrame", "{
	 	disableSerialization;
		_hud=uiNamespace getVariable 'HUD';
		[_hud] call HUD_ShowRevives;
}"] call BIS_fnc_addStackedEventHandler;



["NotifFrame", "onEachFrame", "{
	 	disableSerialization;
		_hud=uiNamespace getVariable 'HUD';
		[_hud] call HUD_ShowNotifications;
}"] call BIS_fnc_addStackedEventHandler;


HUD_AddFrameHandler={
	["hudFrame", "onEachFrame", "{
	 	disableSerialization;
		_hud=uiNamespace getVariable 'HUD';
		[_hud] call HUD_ShowTargets;
		[_hud] call HUD_ShowTowns;
	}"] call BIS_fnc_addStackedEventHandler;
};

HUD_RemoveFrameHandler={
	["hudFrame", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
};
/*
0 spawn {
	disableSerialization;
	_hud=uiNamespace getVariable 'HUD';
	while {!CTI_GameOver} do {
		[_hud] call HUD_ShowTargets;
		//[_hud] call HUD_ShowTowns;
		[_hud] call HUD_ShowRevives;
	};
};*/

0 spawn {
	while {!CTI_GameOver} do {
		waitUntil {([CTI_P_SideJoined, CTI_UPGRADE_HUD, 1] call CTI_CO_FNC_HasUpgrade || CTI_Debug) && profileNamespace getVariable ["HUD_Tactical",true]};
			HUD_Targets = (0) call HUD_GetTargets;
			//HUD_Targets = (0) exec "Addons\Strat_mode\HUD\HUD_GetTargets.sqf";
			HUD_Towns = (0) call HUD_GetTowns;
		sleep 5;
	};
};

0 spawn {
	while {!CTI_GameOver} do {
			disableSerialization;
			_hud=uiNamespace getVariable 'HUD';
			(_hud) call HUD_UpdateInfo;
			(_hud) call HUD_UpdateVehicle;
			HUD_Revives = (0) call HUD_GetRevives;
			sleep 2;
	};
};







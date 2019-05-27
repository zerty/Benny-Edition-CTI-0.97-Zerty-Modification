private ["_map1","_map2"];
if (missionNamespace getVariable "CTI_EW_ANET" == 1) then {
	MAP_GetItems=compile preprocessfilelinenumbers "Addons\Strat_mode\Functions\SM_MapEntities.sqf";
	MAP_DrawItems=compile preprocessfilelinenumbers "Addons\Strat_mode\Functions\SM_Draw_Map_Icons.sqf";
	MAP_DrawLines=compile preprocessfilelinenumbers "Addons\Strat_mode\Functions\SM_Draw_Map_Lines.sqf";
	SHOWTOMAP=[[],[],[]];
	/*MAP_GPS_DRAW={
		private ["_gps"];
		disableSerialization;
		_gps=objnull;
		{if !(isNull (_x displayctrl 101)) then {_gps= _x displayctrl 101; };} count (uiNamespace getVariable "IGUI_Displays");
		//{if !(isNil {_x displayctrl 101}) then {_gps= _x displayctrl 101};} count (uiNamespace getVariable "IGUI_Displays");
		if ! (isnull _gps) then {[_gps] call MAP_DrawItems};
	};
	["GPSdraw", "onEachFrame", MAP_GPS_DRAW] call BIS_fnc_addStackedEventHandler;
*/
	0 spawn {
		disableSerialization;
		_map1=controlNull;
		while {isNull _map1} do {
			_map1=findDisplay 12 displayCtrl 51;
			sleep 0.1;
		};
		_map1 ctrlAddEventHandler ["Draw", "_this call MAP_DrawItems;_this call MAP_DrawLines;"];
	};
	0 spawn {
		disableSerialization;
		_map2=controlNull;
		while {isNull _map2} do {
			_frames =[];
			{_frames set [count _frames,_x select 0]; true} count (missionNameSpace getVariable ["BIS_stackedEventHandlers_onEachFrame", []]);
			{if !(isNil {_x displayctrl 101}) then {_map2= _x displayctrl 101}; true} count (uiNamespace getVariable "IGUI_Displays");
			sleep 0.1;
		};
		_map2 ctrlAddEventHandler ["Draw", "
			private ['_frames'];
			_frames =[];
			{_frames set [count _frames,_x select 0]; true} count (missionNameSpace getVariable ['BIS_stackedEventHandlers_onEachFrame', []]);
			if !('hudFrame' in _frames) then {_this call MAP_DrawItems;}
				"];
	};
	0 spawn {
		disableSerialization;
		_map1=controlNull;
		while {isNull _map1} do {
			_map1=findDisplay 220000 displayCtrl 220001;
			sleep 0.2;
		};
		_map1 ctrlAddEventHandler ["Draw", "_this call MAP_DrawItems;_this call MAP_DrawLines;"];
	};
	0 spawn {
		while {!CTI_GameOver} do {
			SHOWTOMAP= 0 call MAP_GetItems;
			sleep 1;
		};
	};
} else {
	0 spawn {
		waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_teams"}};
		if (CTI_SM_FAR == 1 ) then {
			execFSM "Addons\Strat_mode\FSM\update_markers_team.fsm";
		} else {
			execFSM "Client\FSM\update_markers_team.fsm";
		};
	};
};
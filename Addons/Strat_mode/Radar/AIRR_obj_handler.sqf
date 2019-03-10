#define Radar_Range 5000
#define Min_Alt 40

private ["_radar","_vehicle","_side","_seed","_top_radar","_sl","_adv_net"];
_radar=_this select 0;
_vehicle=_this select 1;
_side=_this select 2;
_seed=_this select 3;

_top_radar= (getPosATL _radar);
_top_radar set [2, (_top_radar select 2 )+35];
_sl= (_side) call CTI_CO_FNC_GetSideLogic;
//diag_log format [":: AIR Radar ::%1::%2:: Starting loop for %3",_vehicle,_side,_radar];

_adv_net=if (missionNamespace getVariable "CTI_EW_ANET" == 1) then {true} else {false};

if (! _adv_net) then {
	/*
	we let clients handle it
	***TODO****/
	[["CLIENT",_side], "Client_AIRR_mcreate",[_radar,_vehicle,_seed]] call CTI_CO_FNC_NetSend;

} else {
	//try to register in Hud targets
	while {!CTI_GameOver && alive _vehicle && alive _radar} do {
		_alt=((getposASL _vehicle) select 2 ) min ((getposATL _vehicle) select 2 );
		if ( ([_vehicle,_radar]  call BIS_fnc_distance2D) < Radar_Range && _alt >= Min_Alt && !(terrainIntersect [_top_radar,(getPosATL _vehicle)]) &&  ((_sl getVariable "CTI_HUD_SHARED")  findif {_x select 0 == _vehicle && _x select 1 > time}) > -1 && !((_vehicle getvariable ["CTI_Net",-10]) == (_side  call CTI_CO_FNC_GetSideID)) ) then {
			//diag_log format [":: AIR Radar ::%1::%2:: Detected by %3",_vehicle,_side,_radar];
			["SERVER", "Server_Hud_Share_Add",[[[_vehicle,time +90+ random 20]],_side]] call CTI_CO_FNC_NetSend; //we use the netPV to not do strange stuff
			[["CLIENT",_side], "Client_AIRR_touched"] call CTI_CO_FNC_NetSend;//for the hud
		};
		sleep 10;
	};

};
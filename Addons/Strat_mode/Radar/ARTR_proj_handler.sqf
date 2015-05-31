#define Radar_Range 5000

private ["_radar","_proj","_side","_init_pos","_seed"];
_radar=_this select 0;
_proj=_this select 1;
_side=_this select 2;
waitUntil {!alive _radar || isnull _proj || ([_proj,_radar]  call BIS_fnc_distance2D) < Radar_Range};
if (!alive _radar || isnull _proj) exitwith {false};
_init_pos = getpos _proj;
_seed= diag_frameno+floor(random (10000));
[["CLIENT",_side], "Client_ARTR_marker",[_seed,_init_pos],true] call CTI_CO_FNC_NetSend;
while {!isnull _proj} do {
	[["CLIENT",_side], "Client_ARTR_update",[_seed,_init_pos,getpos _proj],true] call CTI_CO_FNC_NetSend;
	sleep 2;
};

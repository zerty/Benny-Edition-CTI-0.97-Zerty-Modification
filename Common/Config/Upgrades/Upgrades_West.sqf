private ["_side"];

_side = _this;

_a=[];
_c=[];
_lev=[];
_lin=[];
_t=[];
_l=[];

//barrack
_l=_l+			[[localize "STR_Up_Barracks", localize "STR_Up_Barracks_Descr"]];
_a=_a	+			[true];
_c=_c +			[[1000,2000,3000]];
_lev=_lev+	[3];
_lin=_lin+	[[[CTI_UPGRADE_GEAR,1],[CTI_UPGRADE_GEAR,2],[CTI_UPGRADE_GEAR,3]]];
_t=_t+			[[10*CTI_UPGRADE_RATIO,20*CTI_UPGRADE_RATIO,30*CTI_UPGRADE_RATIO]];


_l=_l+			[[localize "STR_Up_Light_Factory", localize "STR_Up_Light_Factory_Descr"]];
_a=_a	+			[true];
_c=_c +			[[5000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];


_l=_l+			[[localize "STR_Up_Heavy_Factory", localize "STR_Up_Heavy_Factory_Descr"]];
_a=_a	+			[true];
_c=_c +			[[10000,50000]];
_lev=_lev+	[2];
_lin=_lin+	[[[CTI_UPGRADE_LIGHT,1],[]]];
_t=_t+			[[180*CTI_UPGRADE_RATIO,240*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Aircraft_Factory", localize "STR_Up_Aircraft_Factory_Descr"]];
_a=_a	+			[true];
_c=_c +			[[25000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_AAF_technologies", localize "STR_Up_AAF_technologies_Descr"]];
_a=_a	+			[true];
_c=_c +			[[1500,2500,4000,6000,8000]];
_lev=_lev+	[5];
_lin=_lin+	[[[CTI_UPGRADE_LIGHT,1],[],[CTI_UPGRADE_HEAVY,1],[CTI_UPGRADE_AIR,1],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO,20*CTI_UPGRADE_RATIO,50*CTI_UPGRADE_RATIO,60*CTI_UPGRADE_RATIO,70*CTI_UPGRADE_RATIO]];


_l=_l+			[[localize "STR_Up_Aircraft_FFAR", localize "STR_Up_Aircraft_FFAR_Descr"]];
_a=_a	+			[true];
_c=_c +			[[10000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];


_l=_l+			[[localize "STR_Up_Aircraft_AT", localize "STR_Up_Aircraft_AT_Descr"]];
_a=_a	+			[true];
_c=_c +			[[50000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Aircraft_AA", localize "STR_Up_Aircraft_AA_Descr"]];
_a=_a	+			[true];
_c=_c +			[[50000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Air_Countermeasures", localize "STR_Up_Air_Countermeasures_Descr"]];
_a=_a	+			[true];
_c=_c +			[[8000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[60*CTI_UPGRADE_RATIO]];



_l=_l+			[[localize "STR_Up_Gear", localize "STR_Up_Gear_Descr"]];
_a=_a	+			[true];
_c=_c +			[[2000, 4000, 7500]];
_lev=_lev+	[3];
_lin=_lin+	[[[],[],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO, 40*CTI_UPGRADE_RATIO, 60*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Tactical_Hud", localize "STR_Up_Tactical_Hud_Descr"]];
_a=_a	+			[True];
_c=_c +			[[9000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_GEAR,3]]];
_t=_t+			[[120*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Towns_Occupation", localize "STR_Up_Towns_Occupation_Descr"]];
_a=_a	+			[true];
_c=_c +			[[5000, 20000, 40000]];
_lev=_lev+	[3];
_lin=_lin+	[[[CTI_UPGRADE_BARRACKS,1],[CTI_UPGRADE_LIGHT,1],[CTI_UPGRADE_HEAVY,1]]];
_t=_t+			[[60*CTI_UPGRADE_RATIO, 70*CTI_UPGRADE_RATIO, 80*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Satellite", localize "STR_Up_Satellite_Descr"]];
_a=_a	+			[true];
_c=_c +			[[100000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[120*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Halo_Jump", localize "STR_Up_Halo_Jump_Descr"]];
_a=_a	+			[True];
_c=_c +			[[4000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Air_Radar", localize "STR_Up_Air_Radar_Descr"]];
_a=_a	+			[True];
_c=_c +			[[6000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[30*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Artillery_Radar", localize "STR_Up_Artillery_Radar_Descr"]];
_a=_a	+			[true];
_c=_c +			[[6000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[30*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Range", localize "STR_Up_Range_Descr"]];
_a=_a	+			[True];
_c=_c +			[[2000,6000,12000]];
_lev=_lev+	[3];
_lin=_lin+	[[[],[],[]]];
_t=_t+			[[10*CTI_UPGRADE_RATIO,30*CTI_UPGRADE_RATIO,60*CTI_UPGRADE_RATIO]];


_l=_l+			[[localize "STR_Up_Intrusion", localize "STR_Up_Intrusion_Descr"]];
_a=_a	+			[true];
_c=_c +			[[2000,6000,12000]];
_lev=_lev+	[3];
_lin=_lin+	[[[CTI_UPGRADE_NETR, 1],[CTI_UPGRADE_NETR, 2],[CTI_UPGRADE_NETR, 3]]];
_t=_t+			[[10*CTI_UPGRADE_RATIO,30*CTI_UPGRADE_RATIO,60*CTI_UPGRADE_RATIO]];


_l=_l+			[[localize "STR_Up_Trophy", localize "STR_Up_Trophy_Descr"]];
_a=_a	+			[True];
_c=_c +			[[6000,12000]];
_lev=_lev+	[2];
_lin=_lin+	[[[CTI_UPGRADE_TRA, 1],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO,40*CTI_UPGRADE_RATIO]];

_l=_l+			[[localize "STR_Up_Max_Ammos", localize "STR_Up_Max_Ammos_Descr"]];
_a=_a	+			[True];
_c=_c +			[[6000,12000]];
_lev=_lev+	[2];
_lin=_lin+	[[[CTI_UPGRADE_HEAVY, 1],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO,40*CTI_UPGRADE_RATIO]];

_l=_l+				[[localize "STR_Up_Respawn_Truck", localize "STR_Up_Respawn_Truck_Descr"]];
_a=_a	+			[True];
_c=_c +				[[1000,2000,4000,8000,16000]];
_lev=_lev+			[5];
_lin=_lin+			[[[],[]]];
_t=_t+				[[10*CTI_UPGRADE_RATIO,20*CTI_UPGRADE_RATIO,40*CTI_UPGRADE_RATIO,80*CTI_UPGRADE_RATIO,160*CTI_UPGRADE_RATIO]];
/*
_l=_l+			[["Network: Reconfiguration cycle", "Lower Mesh Network reconfiguration cycle time (600s - 60s*lvl)"]];
_a=_a	+			[false];
_c=_c +			[[2000,2000,2000]];
_lev=_lev+	[3];
_lin=_lin+	[[[],[],[]]];
_t=_t+			[[10*CTI_UPGRADE_RATIO,10*CTI_UPGRADE_RATIO,10*CTI_UPGRADE_RATIO]];


_l=_l+			[["Territory protection: Air Patrol", "Provide CAS unit patrolling controlled Territory (lvl1 : 1 attack chopper; lvl2 : 1 additionnal Chopper; lvl3 : 1 additionnal CAS jet (Territory is constituted of towns where all neighbours are friendly)"]];
_a=_a	+			[true];
_c=_c +			[[10000,20000,40000]];
_lev=_lev+	[3];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1],[],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO,40*CTI_UPGRADE_RATIO,60*CTI_UPGRADE_RATIO]];
*/

missionNamespace setVariable [Format["CTI_%1_UPGRADES_ENABLED", _side], _a];
missionNamespace setVariable [Format["CTI_%1_UPGRADES_COSTS", _side], _c];
missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", _side], _lev];
missionNamespace setVariable [Format["CTI_%1_UPGRADES_LINKS", _side], _lin];
missionNamespace setVariable [Format["CTI_%1_UPGRADES_TIMES", _side], _t];
if (CTI_IsClient) then {
	missionNamespace setVariable [Format["CTI_%1_UPGRADES_LABELS", _side], _l];
};
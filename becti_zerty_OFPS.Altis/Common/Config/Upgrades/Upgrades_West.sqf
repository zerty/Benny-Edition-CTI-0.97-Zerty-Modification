private ["_side"];

_side = _this;

_a=[];
_c=[];
_lev=[];
_lin=[];
_t=[];
_l=[];

//barrack
_l=_l+			[["Factory: Barracks", "Unlock better infantry units"]];
_a=_a	+			[true];
_c=_c +			[[1000,2000,3000]];
_lev=_lev+	[3];
_lin=_lin+	[[[CTI_UPGRADE_GEAR,1],[CTI_UPGRADE_GEAR,2],[CTI_UPGRADE_GEAR,3]]];
_t=_t+			[[10*CTI_UPGRADE_RATIO,20*CTI_UPGRADE_RATIO,30*CTI_UPGRADE_RATIO]];


_l=_l+			[["Factory: Light Factory", "Unlock better motorized units"]];
_a=_a	+			[true];
_c=_c +			[[1500]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO]];

_l=_l+			[["Factory: Heavy Factory", "Unlock better armored units"]];
_a=_a	+			[true];
_c=_c +			[[5000,10000]];
_lev=_lev+	[2];
_lin=_lin+	[[[CTI_UPGRADE_LIGHT,1],[]]];
_t=_t+			[[50*CTI_UPGRADE_RATIO,240*CTI_UPGRADE_RATIO]];

_l=_l+			[["Factory: Aircraft Factory", "Unlock better aircraft units"]];
_a=_a	+			[true];
_c=_c +			[[25000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];

_l=_l+			[["Factory: AAF technologies", "Unlock AAF units (1::MRAPS, 2::APC , 3::TRACKED, 4::CHOPPERS, 5::PLANES)"]];
_a=_a	+			[true];
_c=_c +			[[1500,2500,4000,6000,8000]];
_lev=_lev+	[5];
_lin=_lin+	[[[CTI_UPGRADE_LIGHT,1],[],[CTI_UPGRADE_HEAVY,1],[CTI_UPGRADE_AIR,1],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO,20*CTI_UPGRADE_RATIO,50*CTI_UPGRADE_RATIO,60*CTI_UPGRADE_RATIO,70*CTI_UPGRADE_RATIO]];


_l=_l+			[["Air: Aircraft FFAR", "Unlocks the FFAR Rockets for Aircrafts"]];
_a=_a	+			[true];
_c=_c +			[[10000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];


_l=_l+			[["Air: Aircraft AT", "Unlocks the Anti Tank Missiles for Aircrafts"]];
_a=_a	+			[true];
_c=_c +			[[50000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];

_l=_l+			[["Air: Aircraft AA", "Unlocks the Anti Air Missiles for Aircrafts"]];
_a=_a	+			[true];
_c=_c +			[[50000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[90*CTI_UPGRADE_RATIO]];

_l=_l+			[["Air: Aircraft Countermeasures", "Allows Aircraft to deploy countermeasures"]];
_a=_a	+			[true];
_c=_c +			[[8000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[60*CTI_UPGRADE_RATIO]];



_l=_l+			[["Equipment: Gear", "Allows the use of better equipment in the Gear Menu"]];
_a=_a	+			[true];
_c=_c +			[[2000, 4000, 7500]];
_lev=_lev+	[3];
_lin=_lin+	[[[],[],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO, 40*CTI_UPGRADE_RATIO, 60*CTI_UPGRADE_RATIO]];

_l=_l+			[["Equipment: Tactical Hud", "Enable Tactical HUD for every unit equiped with tactical sunglasses"]];
_a=_a	+			[True];
_c=_c +			[[9000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_GEAR,3]]];
_t=_t+			[[120*CTI_UPGRADE_RATIO]];

_l=_l+			[["Other: Towns Occupation", "Allows the spawning of occupation forces which will defend friendly towns against any attackers.<br />It will also improve the income generation in non-occupied towns"]];
_a=_a	+			[true];
_c=_c +			[[5000, 20000, 40000]];
_lev=_lev+	[3];
_lin=_lin+	[[[CTI_UPGRADE_BARRACKS,1],[CTI_UPGRADE_LIGHT,1],[CTI_UPGRADE_HEAVY,1]]];
_t=_t+			[[60*CTI_UPGRADE_RATIO, 70*CTI_UPGRADE_RATIO, 80*CTI_UPGRADE_RATIO]];

_l=_l+			[["Other: Satellite", "Allows the use of the satellite camera"]];
_a=_a	+			[true];
_c=_c +			[[100000]];
_lev=_lev+	[1];
_lin=_lin+	[[[CTI_UPGRADE_AIR, 1]]];
_t=_t+			[[120*CTI_UPGRADE_RATIO]];

_l=_l+			[["Other: Halo Jump", "Enable HALO Jumping from the Air factory"]];
_a=_a	+			[True];
_c=_c +			[[4000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO]];

_l=_l+			[["Radar: Air Radar", "Enable Air Radars"]];
_a=_a	+			[True];
_c=_c +			[[6000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[30*CTI_UPGRADE_RATIO]];

_l=_l+			[["Radar: Artillery Radar", "Enable Artillery radar on Air Radars"]];
_a=_a	+			[true];
_c=_c +			[[6000]];
_lev=_lev+	[1];
_lin=_lin+	[[[]]];
_t=_t+			[[30*CTI_UPGRADE_RATIO]];

_l=_l+			[["Network: Range", "Improve Mesh Network range (Inf: 250+Lvl*250 V: 1000+Lvl*1000)"]];
_a=_a	+			[True];
_c=_c +			[[2000,6000,12000]];
_lev=_lev+	[3];
_lin=_lin+	[[[],[],[]]];
_t=_t+			[[10*CTI_UPGRADE_RATIO,30*CTI_UPGRADE_RATIO,60*CTI_UPGRADE_RATIO]];


_l=_l+			[["Network: Exploit : Intrusion","Allow players to connect to the enemy network if inside a stolen connected vehicle"]];
_a=_a	+			[true];
_c=_c +			[[2000,6000,12000]];
_lev=_lev+	[3];
_lin=_lin+	[[[CTI_UPGRADE_NETR, 1],[CTI_UPGRADE_NETR, 2],[CTI_UPGRADE_NETR, 3]]];
_t=_t+			[[10*CTI_UPGRADE_RATIO,30*CTI_UPGRADE_RATIO,60*CTI_UPGRADE_RATIO]];


_l=_l+			[["Trophy: Cooldown and effectiveness", "Reduced minimum time between Trophy activations and more chances for sucessfull protection"]];
_a=_a	+			[True];
_c=_c +			[[6000,12000]];
_lev=_lev+	[2];
_lin=_lin+	[[[CTI_UPGRADE_TRA, 1],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO,40*CTI_UPGRADE_RATIO]];

_l=_l+			[["Trophy: Max Ammos", "Augment maximum ammunition for the trophy system"]];
_a=_a	+			[True];
_c=_c +			[[6000,12000]];
_lev=_lev+	[2];
_lin=_lin+	[[[CTI_UPGRADE_HEAVY, 1],[]]];
_t=_t+			[[20*CTI_UPGRADE_RATIO,40*CTI_UPGRADE_RATIO]];

_l=_l+				[["Respawn Truck/Pod: Range", "Increase the max range of the respawn truck. 500m + lvl x 500m "]];
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
private ["_side", "_u"];

_side = _this;

missionNamespace setVariable [format["CTI_%1_Commander", _side], "B_officer_F"];
missionNamespace setVariable [format["CTI_%1_Worker", _side], "B_Soldier_lite_F"];

missionNamespace setVariable [format["CTI_%1_Diver", _side], "B_diver_f"];
missionNamespace setVariable [format["CTI_%1_Soldier", _side], "B_Soldier_F"];
missionNamespace setVariable [format["CTI_%1_Crew", _side], "B_crew_F"];
missionNamespace setVariable [format["CTI_%1_Pilot", _side], "B_Helipilot_F"];

missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [
	["B_Truck_01_medical_F", [
		["arifle_MX_GL_F", 2], ["30Rnd_65x39_caseless_mag", 20], ["30Rnd_65x39_caseless_mag_Tracer", 4],
		["arifle_MXM_F", 1],
		["launch_NLAW_F", 5], ["NLAW_F", 15],
		["HandGrenade", 15],
		["30Rnd_556x45_Stanag", 10],
		["3Rnd_HE_Grenade_shell", 6],
		["firstaidkit", 10],
		["optic_ACO_grn", 3],
		["optic_MRCO", 2],
		["optic_Hamr", 1],
		["Toolkit", 4],
		["B_AssaultPack_rgr", 4]
	]],
	["B_MRAP_01_F", [
		["firstaidkit", 10],
		["30Rnd_556x45_Stanag", 15],
		["launch_NLAW_F", 5],
		["NLAW_F", 20]
	]]
	//,	["B_Heli_Transport_01_F", []]

]];

//--- Units - Barracks

_u = ["B_Soldier_lite_F"];
_u = _u		+ ["B_crew_F"];
_u = _u		+ ["B_Soldier_F"];
_u = _u		+ ["B_Helipilot_F"];
_u = _u		+ ["B_diver_F"];
_u = _u		+ ["B_soldier_UAV_F"];
_u = _u		+ ['B_recon_F'];
_u = _u		+ ["B_soldier_AR_F"];
_u = _u		+ ['B_HeavyGunner_F'];
_u = _u		+ ["B_Soldier_GL_F"];
_u = _u		+ ["B_soldier_LAT_F"];
_u = _u		+ ['B_recon_LAT_F'];
_u = _u		+ ["B_soldier_M_F"];
_u = _u		+ ['B_Sharpshooter_F'];
_u = _u		+ ['B_recon_M_F'];
_u = _u		+ ['B_Recon_Sharpshooter_F'];
_u = _u		+ ["B_medic_F"];
_u = _u		+ ['B_recon_medic_F'];
_u = _u		+ ["B_soldier_repair_F"];
_u = _u		+ ["B_engineer_F"];
_u = _u		+ ["B_soldier_exp_F"];
_u = _u		+ ['B_recon_exp_F'];
_u = _u		+ ["B_soldier_PG_F"];
_u = _u		+ ["B_soldier_AA_F"];
_u = _u		+ ["B_soldier_AT_F"];
_u = _u		+ ["B_spotter_F"];
_u = _u		+ ["B_recon_JTAC_F"];
_u = _u		+ ["B_sniper_F"];
_u = _u		+ ['B_ghillie_lsh_F'];
_u = _u		+ ['B_ghillie_sard_F'];
_u = _u		+ ['B_ghillie_ard_F'];


missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_BARRACKS], _u];

_u 			= ["B_Quadbike_01_F"];
_u = _u		+ ["I_C_Offroad_02_unarmed_F"];
_u = _u		+ ["C_Offroad_02_unarmed_F"];
_u = _u		+ ["B_G_Offroad_01_F"];
_u = _u		+ ["B_G_Offroad_01_armed_F"];
_u = _u		+ ["B_Truck_01_transport_F"];
_u = _u		+ ["B_MRAP_01_F"];
_u = _u		+ ["B_MRAP_01_hmg_F"];
_u = _u		+ ["B_MRAP_01_gmg_F"];
_u = _u		+ ['B_CTRG_LSV_01_light_F'];
_u = _u		+ ['B_LSV_01_unarmed_F'];
_u = _u		+ ['B_LSV_01_armed_F'];
_u = _u		+ ["B_UGV_01_F"];
_u = _u		+ ["B_UGV_01_rcws_F"];
_u = _u  	+ ["B_Truck_01_medical_F"];
_u = _u		+ ['I_Truck_02_medical_F'];
_u = _u		+ ['I_MRAP_03_F'];
_u = _u		+ ['I_MRAP_03_hmg_F'];
_u = _u		+ ['I_MRAP_03_gmg_F'];
_u = _u		+ ['B_G_Van_01_transport_F'];
_u = _u		+ ['C_SUV_01_F'];
_u = _u		+ ['C_Hatchback_01_sport_F'];
_u = _u		+ ['C_Kart_01_F'];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_LIGHT], _u];


_u 			= ["B_APC_Tracked_01_rcws_F"];
_u = _u  	+ ["B_APC_Wheeled_01_cannon_F"];
_u = _u		+ ["B_APC_Tracked_01_AA_F"];
_u = _u		+ ["B_MBT_01_cannon_F"];
_u = _u		+ ["B_MBT_01_TUSK_F"];
_u = _u		+ ["B_MBT_01_arty_F"];
_u = _u		+ ["B_MBT_01_mlrs_F"];
_u = _u		+ ['I_APC_Wheeled_03_cannon_F'];
_u = _u		+ ['I_APC_tracked_03_cannon_F'];
_u = _u		+ ['I_MBT_03_cannon_F'];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_HEAVY], _u];

_u 			= ["B_Heli_Light_01_F"];
_u = _u		+ ["B_T_VTOL_01_infantry_F"];
_u = _u		+ ["B_T_VTOL_01_vehicle_F"];
_u = _u		+ ["B_T_VTOL_01_armed_F"];
_u = _u		+ ["B_Heli_Transport_01_F"];
_u = _u		+ ["B_Heli_Transport_03_unarmed_F"];
_u = _u		+ ["B_Heli_Transport_03_F"];
_u = _u		+ ["B_Heli_Light_01_armed_F"];
_u = _u		+ ["B_Heli_Attack_01_F"];
_u = _u		+ ["B_UAV_02_CAS_F"];
_u = _u		+ ["B_UAV_02_F"];
_u = _u		+ ["B_T_UAV_03_F"];
_u = _u		+ ["B_Plane_CAS_01_F"];
_u = _u		+ ['I_Heli_light_03_unarmed_F'];
_u = _u		+ ['I_Heli_light_03_F'];
_u = _u		+ ['I_Heli_Transport_02_F'];
_u = _u		+ ['I_Plane_Fighter_03_CAS_F'];
_u = _u		+ ['I_Plane_Fighter_03_AA_F'];
_u = _u		+ ['B_Slingload_01_Medevac_F'];
//_u = _u		+ ["I_Plane_Fighter_03_CAS_F"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AIR], _u];

_u 			= ["B_Truck_01_Repair_F"];
_u = _u		+ ["CTI_Salvager_West"];
_u = _u		+ ["B_Truck_01_fuel_F"];
_u = _u		+ ['B_G_Van_01_fuel_F'];
_u = _u		+ ['B_Slingload_01_Repair_F'];
_u = _u		+ ['B_Slingload_01_Fuel_F'];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_REPAIR], _u];

_u 			= ["B_Truck_01_ammo_F"];
_u = _u		+ ['B_Slingload_01_Ammo_F'];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AMMO], _u];

_u 			= ["C_Scooter_Transport_01_F"];
_u = _u		+ ["B_Boat_Transport_01_F"];
_u = _u		+ ["B_Boat_Armed_01_minigun_F"];
_u = _u		+ ["B_SDV_01_F"];
_u = _u		+ ["C_Boat_Civil_01_rescue_F"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_NAVAL], _u];



//--- Units - FLAG
_u = ['B_Soldier_F'];
_u = _u		+ ['B_supplyCrate_F'];
_u = _u		+ ['B_Quadbike_01_F'];
_u = _u		+ ['B_G_Offroad_01_F'];
_u = _u		+ ['B_G_Offroad_01_armed_F'];


missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_FTOWN], _u];
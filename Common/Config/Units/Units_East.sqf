_side = _this;
_faction = "East";

_c = []; //--- Classname
_p = []; //--- Picture. 				'' = auto generated.
_n = []; //--- Name. 					'' = auto generated.
_o = []; //--- Price.
_t = []; //--- Build time.
_u = []; //--- Upgrade level needed.    0 1 2 3...
_f = []; //--- Built from Factory.
_s = []; //--- Script

//--- Infantry
_c = _c + ['O_Soldier_SL_F']; //This unit for PvP Reward
_p = _p + [''];
_n = _n + [''];
_o = _o + [2000];
_t = _t + [5];
_u = _u + [4];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_SoldierU_SL_F']; //for Town Defense
_p = _p + [''];
_n = _n + [''];
_o = _o + [200];
_t = _t + [5];
_u = _u + [4];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_TL_F']; //for Town Defense
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [4];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_officer_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [10000];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Soldier_lite_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [50];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_crew_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [70];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Soldier_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [70];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [70];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_helipilot_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [70];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_diver_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldier_UAV_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [2600];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_recon_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Soldier_AR_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_AR_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_HeavyGunner_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [200];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Urban_HeavyGunner_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [200];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Soldier_GL_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_SoldierU_GL_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Soldier_LAT_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_LAT_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_recon_LAT_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [200];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldier_M_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [125];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_M_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [125];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Sharpshooter_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Urban_Sharpshooter_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_recon_M_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Pathfinder_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [180];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_medic_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_medic_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_recon_medic_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [120];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldier_repair_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_repair_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_engineer_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [120];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_engineer_U_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [120];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldier_exp_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_exp_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_recon_exp_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldier_PG_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Soldier_AA_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_AA_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_Soldier_AT_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [450];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_soldierU_AT_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [450];
_t = _t + [5];
_u = _u + [2];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_spotter_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [120];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_recon_JTAC_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [140];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_sniper_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [200];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_ghillie_lsh_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [250];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_ghillie_sard_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [250];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['O_ghillie_ard_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [250];
_t = _t + [5];
_u = _u + [3];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];


_c = _c + ["O_supplyCrate_F"];
_p = _p + [''];
_n = _n + [localize 'STR_Mobile_Gear_Access_Crate'];
_o = _o + [100];
_t = _t + [15];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + ["service-gear"];


_c = _c + ['O_Quadbike_01_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [70];
_t = _t + [10];
_u = _u + [0];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['I_C_Offroad_02_unarmed_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [200];
_t = _t + [10];
_u = _u + [0];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['C_Offroad_02_unarmed_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [250];
_t = _t + [10];
_u = _u + [0];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_G_Offroad_01_F'];
_p = _p + [''];
_n = _n + ['Offroad (can load statics)'];
_o = _o + [150];
_t = _t + [10];
_u = _u + [0];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_G_Offroad_01_armed_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [500];
_t = _t + [10];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_Truck_02_transport_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [15];
_u = _u + [0];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_Truck_03_transport_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [15];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_MRAP_02_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [325];
_t = _t + [15];
_u = _u + [0];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_MRAP_02_hmg_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [750];
_t = _t + [20];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_MRAP_02_gmg_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [900];
_t = _t + [20];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_LSV_02_unarmed_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [400];
_t = _t + [20];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_LSV_02_armed_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [600];
_t = _t + [20];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_UGV_01_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [500];
_t = _t + [20];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_UGV_01_rcws_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [1000];
_t = _t + [20];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];

_c = _c + ['O_Truck_03_medical_F'];
_p = _p + [''];
_n = _n + ["Mobile respawn Tempest + Equipment"];
_o = _o + [2500];
_t = _t + [25];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + ["service-medic"];

_c = _c + ['O_Truck_02_medical_F'];
_p = _p + [''];
_n = _n + ["Mobile respawn Kamaz + Equipment"];
_o = _o + [2000];
_t = _t + [20];
_u = _u + [1];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + ["service-medic"];


_c = _c + ['O_APC_Wheeled_02_rcws_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [1700];
_t = _t + [30];
_u = _u + [0];
_f = _f + [CTI_FACTORY_HEAVY];
_s = _s + [""];

_c = _c + ['O_APC_Tracked_02_cannon_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [3000];
_t = _t + [30];
_u = _u + [0];
_f = _f + [CTI_FACTORY_HEAVY];
_s = _s + [""];

_c = _c + ['O_MBT_02_cannon_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [8000];
_t = _t + [30];
_u = _u + [1];
_f = _f + [CTI_FACTORY_HEAVY];
_s = _s + [""];

_c = _c + ['O_APC_Tracked_02_AA_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [6000];
_t = _t + [30];
_u = _u + [1];
_f = _f + [CTI_FACTORY_HEAVY];
_s = _s + [""];

_c = _c + ['O_MBT_02_arty_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [60000];
_t = _t + [30];
_u = _u + [2];
_f = _f + [CTI_FACTORY_HEAVY];
_s = _s + [""];


_c = _c + ['O_Truck_02_box_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [500];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_REPAIR];
_s = _s + ["service-repairtruck"];

_c = _c + ['O_Truck_03_repair_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [550];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_REPAIR];
_s = _s + ["service-repairtruck"];

_c = _c + ['CTI_Salvager_East'];
_p = _p + [''];
_n = _n + ['Salvage Truck'];
_o = _o + [CTI_VEHICLES_SALVAGER_PRICE];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_REPAIR];
_s = _s + [["O_Truck_03_device_F","salvager"]];

_c = _c + ['CTI_Salvager_Independent_East'];
_p = _p + [''];
_n = _n + ['Salvage Truck'];
_o = _o + [CTI_VEHICLES_SALVAGER_PRICE];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_REPAIR];
_s = _s + [["O_Truck_03_device_F","salvager-independent"]];

_c = _c + ['O_Truck_02_fuel_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [450];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_REPAIR];
_s = _s + ["service-fueltruck"];

_c = _c + ['O_Truck_03_fuel_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [500];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_REPAIR];
_s = _s + ["service-fueltruck"];

_c = _c + ["Land_Pod_Heli_Transport_04_repair_F"];
_p = _p + [''];
_n = _n + [''];
_o = _o + [750];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_REPAIR];
_s = _s + ["service-repairtruck"];

_c = _c + ["Land_Pod_Heli_Transport_04_fuel_F"];
_p = _p + [''];
_n = _n + [''];
_o = _o + [550];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_REPAIR];
_s = _s + ["service-fueltruck"];


_c = _c + ['O_Truck_02_Ammo_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [500];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_AMMO];
_s = _s + ["service-ammotruck"];

_c = _c + ['O_Truck_03_Ammo_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [550];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_AMMO];
_s = _s + ["service-ammotruck"];

_c = _c + ["Land_Pod_Heli_Transport_04_ammo_F"];
_p = _p + [''];
_n = _n + [''];
_o = _o + [550];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_AMMO];
_s = _s + ["service-ammotruck"];


_c = _c + ['O_UAV_02_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [15000];
_t = _t + [35];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_T_UAV_04_CAS_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [20000];
_t = _t + [35];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_UAV_02_CAS_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [7000];
_t = _t + [35];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_Heli_Light_02_unarmed_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [5000];
_t = _t + [35];
_u = _u + [0];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_Heli_Light_02_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [12000];
_t = _t + [40];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_Heli_Attack_02_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [40000];
_t = _t + [50];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_Heli_Attack_02_black_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [40000];
_t = _t + [50];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_T_VTOL_02_infantry_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [60000];
_t = _t + [30];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_T_VTOL_02_vehicle_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [60000];
_t = _t + [30];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_Plane_CAS_02_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [50000];
_t = _t + [50];
_u = _u + [1];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ['O_Heli_Transport_04_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [6000];
_t = _t + [35];
_u = _u + [0];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ["Land_Pod_Heli_Transport_04_bench_F"];
_p = _p + [''];
_n = _n + [''];
_o = _o + [550];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ["Land_Pod_Heli_Transport_04_covered_F"];
_p = _p + [''];
_n = _n + [''];
_o = _o + [750];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + [""];

_c = _c + ["Land_Pod_Heli_Transport_04_medevac_F"];
_p = _p + [''];
_n = _n + [''];
_o = _o + [2500];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_AIR];
_s = _s + ["service-medic"];


_c = _c + ['C_Scooter_Transport_01_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [50];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_NAVAL];
_s = _s + [""];

_c = _c + ['O_Boat_Transport_01_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [275];
_t = _t + [15];
_u = _u + [0];
_f = _f + [CTI_FACTORY_NAVAL];
_s = _s + [""];

_c = _c + ['O_Boat_Armed_01_hmg_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [750];
_t = _t + [20];
_u = _u + [0];
_f = _f + [CTI_FACTORY_NAVAL];
_s = _s + [""];

_c = _c + ['O_SDV_01_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [400];
_t = _t + [25];
_u = _u + [0];
_f = _f + [CTI_FACTORY_NAVAL];
_s = _s + ["service-repairtruck"];


_c = _c + ['I_MRAP_03_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [15];
_u = _u + [1];
_f = _f + [4];
_s = _s + [""];

_c = _c + ['I_MRAP_03_hmg_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [750];
_t = _t + [20];
_u = _u + [1];
_f = _f + [4];
_s = _s + [""];

_c = _c + ['I_MRAP_03_gmg_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [900];
_t = _t + [20];
_u = _u + [1];
_f = _f + [4];
_s = _s + [""];


_c = _c + ['I_APC_Wheeled_03_cannon_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [2000];
_t = _t + [30];
_u = _u + [2];
_f = _f + [4];
_s = _s + [""];

_c = _c + ['I_APC_tracked_03_cannon_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [3000];
_t = _t + [30];
_u = _u + [3];
_f = _f + [4];
_s = _s + [""];

_c = _c + ['I_MBT_03_cannon_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [10000];
_t = _t + [30];
_u = _u + [3];
_f = _f + [4];
_s = _s + [""];

_c = _c + ["I_Heli_Transport_02_F"];
_p = _p + [''];
_n = _n + [''];
_o = _o + [5000];
_t = _t + [35];
_u = _u + [4];
_f = _f + [4];
_s = _s + [""];

_c = _c + ['I_Heli_light_03_unarmed_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [5000];
_t = _t + [30];
_u = _u + [4];
_f = _f + [4];
_s = _s + [""];

_c = _c + ['I_Heli_light_03_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [10000];
_t = _t + [30];
_u = _u + [4];
_f = _f + [4];
_s = _s + [""];

_c = _c + ['I_Plane_Fighter_03_CAS_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [35000];
_t = _t + [40];
_u = _u + [5];
_f = _f + [4];
_s = _s + [""];

_c = _c + ['I_Plane_Fighter_03_AA_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [35000];
_t = _t + [40];
_u = _u + [5];
_f = _f + [4];
_s = _s + [""];


_c = _c + ['Box_East_Wps_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [125];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];

_c = _c + ['Box_East_Ammo_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];

_c = _c + ['Box_East_Support_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];

_c = _c + ['Box_East_Grenades_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];

_c = _c + ['Box_East_AmmoOrd_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [500];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];

_c = _c + ['Box_East_WpsLaunch_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [250];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];

_c = _c + ['Box_East_WpsSpecial_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];


_c = _c + ['O_Mortar_01_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [5000];
_t = _t + [10];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];


_c = _c + ['Land_Pod_Heli_Transport_04_box_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [0];
_t = _t + [0];
_u = _u + [0];
_f = _f + [CTI_FACTORY_TOWN];
_s = _s + [""];


[_side, _faction, _c, _p, _n, _o, _t, _u, _f, _s] call compile preprocessFileLineNumbers "Common\Config\Units\Set_Units.sqf";

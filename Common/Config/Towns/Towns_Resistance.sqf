with missionNamespace do {
	//--- Infantry
	GUER_SOLDIER = "I_soldier_F";
	GUER_SOLDIER_AA = "I_Soldier_AA_F";
	GUER_SOLDIER_AR = "I_Soldier_AR_F";
	GUER_SOLDIER_AT = "I_Soldier_LAT_F";
	GUER_SOLDIER_CREW = "I_crew_F";
	GUER_SOLDIER_LAT = "I_Soldier_LAT_F";
	GUER_SOLDIER_HAT = "I_Soldier_AT_F";
	GUER_SOLDIER_ENGINEER = "I_engineer_F";
	GUER_SOLDIER_GL = "I_Soldier_GL_F";
	GUER_SOLDIER_MEDIC = "I_medic_F";
	// GUER_SOLDIER_MG = "soldiermg";
	GUER_SOLDIER_PILOT = "I_helipilot_F";
	GUER_SOLDIER_JETPILOT = "I_Fighter_Pilot_F";
	GUER_SOLDIER_SQUADLEADER = "I_Soldier_SL_F";
	GUER_SOLDIER_MARKSMAN = "I_Soldier_M_F";
	GUER_SOLDIER_TEAMLEADER = "I_Soldier_TL_F";

	//--- Infantry - Mixed
	// GUER_SOLDIERS_MG = [GUER_SOLDIER_MG, GUER_SOLDIER_AR];
	GUER_SOLDIERS_MG = [GUER_SOLDIER_AR];
	GUER_SOLDIERS_AT_LIGHT = [GUER_SOLDIER_LAT, GUER_SOLDIER_AT, "I_Soldier_LAT2_F"];
	GUER_SOLDIERS_AT_MEDIUM = [GUER_SOLDIER_AT, GUER_SOLDIER_AT, GUER_SOLDIER_HAT, "I_Soldier_LAT2_F"];
	GUER_SOLDIERS_AT_HEAVY = [GUER_SOLDIER_AT, GUER_SOLDIER_HAT];
	GUER_SOLDIERS_SPECOPS = ["I_Soldier_exp_F","I_soldier_mine_F"];
	GUER_SOLDIERS_ENGINEER = [GUER_SOLDIER_ENGINEER, "I_Soldier_repair_F"];
	GUER_SOLDIERS_SNIPERS = ["I_Spotter_F","I_Sniper_F"];

	//--- Vehicles
	GUER_VEHICLE_AA = ["I_LT_01_AA_F"];
	GUER_VEHICLE_AWC = ["I_LT_01_AT_F","I_LT_01_cannon_F"];
	GUER_VEHICLE_ARMORED_HEAVY = ["I_MBT_03_cannon_F"];
	GUER_VEHICLE_ARMORED_LIGHT = ["I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"];
	// GUER_VEHICLE_MECHANIZED = ["mechanized1","mechanized2"];
	GUER_VEHICLE_MOTORIZED = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_G_Offroad_01_armed_F","I_G_Offroad_01_AT_F"];

	//--- Vehicles - Mixed

	GUER_VEHICLES_LIGHT = GUER_VEHICLE_MOTORIZED;
	GUER_VEHICLES_MEDIUM = GUER_VEHICLE_ARMORED_LIGHT;
    GUER_VEHICLES_HEAVY =  GUER_VEHICLE_ARMORED_HEAVY;
	 GUER_VEHICLES_PATROL =  GUER_VEHICLES_MEDIUM + GUER_VEHICLES_HEAVY;
};
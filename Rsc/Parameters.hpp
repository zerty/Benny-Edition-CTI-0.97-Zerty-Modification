class Params {
	class CTI_AI_TEAMS_ENABLED {
		title = $STR_CTI_AI_TEAMS_ENABLED;
		values[] = {0,1,2,3};
		texts[] = {$STR_CTI_DISABLED, $STR_CTI_AI_TEAMS_ENABLED_1, $STR_CTI_AI_TEAMS_ENABLED_2, $STR_CTI_AI_TEAMS_ENABLED_3};
		default = 0;
	};
	class CTI_AI_TEAMS_NB{
		title = $STR_CTI_AI_TEAMS_NB;
		values[] = {2,4,6,8,10,16};
		texts[] = {"2","4","6","8","10","16"};
		default = 10;
	};
	class CTI_ARTILLERY_SETUP {
		title = $STR_CTI_ARTILLERY_SETUP;
		values[] = {-2,-1,0,1,2,3};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ARTILLERY_SETUP_1,$STR_CTI_ARTILLERY_SETUP_2,$STR_CTI_ARTILLERY_SETUP_3,$STR_CTI_ARTILLERY_SETUP_4,$STR_CTI_ARTILLERY_SETUP_5};
		default = -1;
	};
	class CTI_BASE_AREA_MAX {
		title = $STR_CTI_BASE_AREA_MAX;
		values[] = {0,1,2,4,6};
		texts[] = {"0","1","2","4","6"};
		default = 4;
	};
	class CTI_BASE_HQ_REPAIR {
		title = $STR_CTI_BASE_HQ_REPAIR;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_BASE_FOB_MAX {
		title = $STR_CTI_BASE_FOB_MAX;
		values[] = {0,1,2,3,4,5,6,7,8,9,10};
		texts[] = {$STR_CTI_DISABLED,"1","2","3","4","5","6","7","8","9","10"};
		default = 4;
	};
	class CTI_BASE_STARTUP_PLACEMENT {
		title = $STR_CTI_BASE_STARTUP_PLACEMENT;
		values[] = {2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,15000,20000};
		texts[] = {"2 KM","3 KM","4 KM","5 KM","6 KM","7 KM","8 KM","9 KM","10 KM","12 KM","15 KM","20 KM"};
		default = 12000;
	};
	class CTI_ECONOMY_INCOME_CYCLE {
		title = $STR_CTI_ECONOMY_INCOME_CYCLE;
		values[] = {15,30,45,60,90,120,160,190};
		texts[] = {"00:15 Minute","00:30 Minute","00:45 Minute","01:00 Minute","01:30 Minutes","02:00 Minutes","02:30 Minutes","03:00 Minutes"};
		default = 45;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_EAST_COMMANDER {
		title = $STR_CTI_ECONOMY_STARTUP_FUNDS_EAST_COMMANDER;
		values[] = {9000,15000,20000,25000,30000,35000,40000,45000,50000,60000};
		texts[] = {"$9000","$15000","$20000","$25000","$30000","$35000","$40000","$45000","$50000","$60000"};
		default = 15000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_EAST {
		title = $STR_CTI_ECONOMY_STARTUP_FUNDS_EAST;
		values[] = {900,1500,2400,3200,6000,8000,10000,12500,15000,20000};
		texts[] = {"$900","$1500","$2400","$3200","$6000","$8000","$10000","$12500","$15000","$20000"};
		default = 2400;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_WEST_COMMANDER {
		title = $STR_CTI_ECONOMY_STARTUP_FUNDS_WEST_COMMANDER;
		values[] = {9000,15000,20000,25000,30000,35000,40000,45000,50000,60000};
		texts[] = {"$9000","$15000","$20000","$25000","$30000","$35000","$40000","$45000","$50000","$60000"};
		default = 15000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_WEST {
		title = $STR_CTI_ECONOMY_STARTUP_FUNDS_WEST;
		values[] = {900,1500,2400,3200,6000,8000,10000,12500,15000,20000};
		texts[] = {"$900","$1500","$2400","$3200","$6000","$8000","$10000","$12500","$15000","$20000"};
		default = 2400;
	};
	class CTI_ECONOMY_TOWNS_OCCUPATION {
		title = $STR_CTI_ECONOMY_TOWNS_OCCUPATION;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_RESPAWN_AI {
		title = $STR_CTI_RESPAWN_AI;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};
	class CTI_RESPAWN_FOB_RANGE {
		title = $STR_CTI_RESPAWN_FOB_RANGE;
		values[] = {-1,500,750,1000,1250,1500,1750,2000};
		texts[] = {$STR_CTI_RESPAWN_FOB_DISABLED,"0.50 KM","0.75 KM","1 KM","1.25 KM","1.5 KM","1.75 KM","2 KM"};
		default = -1;
	};
	class CTI_RESPAWN_MOBILE {
		title = $STR_CTI_RESPAWN_MOBILE;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_RESPAWN_TIMER {
		title = $STR_CTI_RESPAWN_TIMER;
		values[] = {15,20,25,30,35,40,45,50,55,60};
		texts[] = {"15 Seconds","20 Seconds","25 Seconds","30 Seconds","35 Seconds","40 Seconds","45 Seconds","50 Seconds","55 Seconds","60 Seconds"};
		default = 30;
	};
	class CTI_TOWNS_OCCUPATION {
		title = $STR_CTI_TOWNS_OCCUPATION;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_VEHICLES_AIR_FFAR {
		title = $STR_CTI_VEHICLES_AIR_FFAR;
		values[] = {0,1,2};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED_UPGRADE,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_VEHICLES_AIR_AA {
		title = $STR_CTI_VEHICLES_AIR_AA;
		values[] = {0,1,2};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED_UPGRADE,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_VEHICLES_AIR_AT {
		title = $STR_CTI_VEHICLES_AIR_AT;
		values[] = {0,1,2};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED_UPGRADE,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_VEHICLES_AIR_CM {
		title = $STR_CTI_VEHICLES_AIR_CM;
		values[] = {0,1,2};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED_UPGRADE,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_MARKERS_INFANTRY {
		title = $STR_CTI_MARKERS_INFANTRY;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_UNITS_FATIGUE {
		title = $STR_CTI_UNITS_FATIGUE;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};
	class CTI_FATIGUE_RATIO {
		title = $STR_CTI_FATIGUE_RATIO;
		values[] = {0,20,40,60,80,100};
		texts[] = {$STR_STR_CTI_FATIGUE_RATIO_FULL,"20%","40%","60%","80%",$STR_STR_CTI_FATIGUE_RATIO_NOPE};
		default = 60;
	};
	class CTI_VEHICLES_EMPTY_TIMEOUT {
		title = $STR_CTI_VEHICLES_EMPTY_TIMEOUT;
		values[] = {60,120,180,240,300,600,1200,1800,2400,3000,3600};
		texts[] = {"1 Minute","2 Minutes","3 Minutes","4 Minutes","5 Minutes","10 Minutes","20 Minutes","30 Minutes","40 Minutes","50 Minutes","1 Hour"};
		default = 1800;
	};
	class CTI_GRAPHICS_TG_MAX {
		title = $STR_CTI_GRAPHICS_TG_MAX;
		values[] = {10,20,30,50};
		texts[] = {$STR_CTI_GRAPHICS_TG_FAR,$STR_CTI_GRAPHICS_TG_MED,$STR_CTI_GRAPHICS_TG_SHORT,$STR_CTI_GRAPHICS_TG_FREE};
		default = 50;
	};
	class CTI_GRAPHICS_VD_MAX {
		title = $STR_CTI_GRAPHICS_VD_MAX;
		values[] = {1000,1500,2000,2500,3000,3500,4000};
		texts[] = {"1 KM","1.5 KM","2 KM","2.5 KM","3 KM","3.5 KM","4 KM"};
		default = 4000;
	};

		//Additionnal Parameter (Zerty)
	class SEPARATOR {
		title = $STR_CTI_SEPARATOR;
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_PERSISTANT {
		title = $STR_CTI_PERSISTANT;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class SEPARATOR0 {
		title = $STR_CTI_SEPARATOR0;
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class HC_MODE {
		title = $STR_CTI_HC_MODE;
		values[] = {0,1,2};
		texts[] = {$STR_CTI_HC_MODE_0,$STR_CTI_HC_MODE_1,$STR_CTI_HC_MODE_2};
		default = 2;
	};
	class CACHE_EMPTY {
		title = $STR_CTI_CACHE_EMPTY;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};

	class CTI_TEAMSWAP {
		title = $STR_CTI_TEAMSWAP;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_TEAMSTACK {
		title = $STR_CTI_TEAMSTACK;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};


	class CTI_AI_SKILL {
		title = $STR_CTI_AI_SKILL;
		values[] = {1,2,3,4,5};
		texts[] = {$STR_CTI_AI_SKILL_0,$STR_CTI_AI_SKILL_1,$STR_CTI_AI_SKILL_2,$STR_CTI_AI_SKILL_3,$STR_CTI_AI_SKILL_4};
		default = 3;
	};

	class CTI_MAX_MISSION_TIME {
		title = $STR_CTI_MAX_MISSION_TIME;
		values[] = {0,2,4,6,8,12,24};
		texts[] = {$STR_CTI_MAX_MISSION_TIME_NEVER,"2h","4h","6h","8h","12h","24h"};
		default = 0;
	};
	class MIN_TOWNS {
		title = $STR_CTI_MIN_TOWNS;
		values[] = {0,10,20,30,40};
		texts[] = {$STR_CTI_ALL_TOWNS,"10","20","30","40"};
		default = 0;
	};
	class CTI_VICTORY_HQ {
		title = $STR_CTI_VICTORY_HQ;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};

	class CTI_BASE_FOB_PERMISSION {
		title = $STR_CTI_BASE_FOB_PERMISSION;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};

	class CTI_BUY_RESTRICT_LEADER {
		title = $STR_CTI_BUY_RESTRICT_LEADER;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};
	class CTI_GROUP_AWARD_MULT {
		title = $STR_CTI_GROUP_AWARD_MULT;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_GROUP_LEADER_RESP {
		title = $STR_CTI_GROUP_LEADER_RESP;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};

	class CTI_AI_TEAMS_GROUPSIZE {
		title = $STR_CTI_AI_TEAMS_GROUPSIZE;
		values[] = {0,4,6,8,10,12,14,16};
		texts[] = {"0","4","6","8","10","12","14","16"};
		default = 8;
	};

	class CTI_PLAYERS_GROUPSIZE {
		title = $STR_CTI_PLAYERS_GROUPSIZE;
		values[] = {0,1,2,3,4,5,8,10,12,14,16};
		texts[] = {$STR_CTI_PLAYERS_GROUPSIZE_AUTO,"1","2","3","4","5","8","10","12","14","16"};
		default = 0;
	};
	class CTI_GAMEPLAY_MISSILES_RANGE {
		title = $STR_CTI_GAMEPLAY_MISSILES_RANGE;
		values[] = {0,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000};
		texts[] = {$STR_CTI_DISABLED,"500m","1000m","1500m","2000m","2500m","3000m","3500m","4000m","4500m","5000m","5500m","6000m","6500m","7000m","7500m","8000m","8500m","9000m","9500m","10000m"};
		default = 0;
	};
	class CTI_GAMEPLAY_3P {
		title = $STR_CTI_GAMEPLAY_3P;
		values[] = {-1,0,1,2};
		texts[] = {$STR_CTI_GAMEPLAY_3P_ALL,$STR_CTI_GAMEPLAY_3P_GV,$STR_CTI_GAMEPLAY_3P_VEH,$STR_CTI_GAMEPLAY_3P_OFF};
		default = 0;
	};
	class CTI_GAMEPLAY_REARM_AMMO {
		title = $STR_CTI_GAMEPLAY_REARM_AMMO;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_GAMEPLAY_REARM_MED {
		title = $STR_CTI_GAMEPLAY_REARM_MED;
		values[] = {0,1,2,3,4,100};
		texts[] = {$STR_CTI_GAMEPLAY_REARM_MED_AL,$STR_CTI_GAMEPLAY_REARM_MED_UP1,$STR_CTI_GAMEPLAY_REARM_MED_UP2,$STR_CTI_GAMEPLAY_REARM_MED_UP3,$STR_CTI_GAMEPLAY_REARM_MED_UP4,$STR_CTI_GAMEPLAY_REARM_MED_OFF};
		default = 3;
	};
	class CTI_BASEBUILDING {
		title = $STR_CTI_BASEBUILDING;
		values[] = {0,1};
		texts[] = {$STR_CTI_BASEBUILDING_WK,$STR_CTI_BASEBUILDING_PL};
		default = 1;
	};
	class CTI_GAMEPLAY_DARTER {
		title = $STR_CTI_GAMEPLAY_DARTER;
		values[] = {0,500,800,1200,1500,2000};
		texts[] = {"None","Connection range 500m","Connection range 800m","Connection range 1200m","Connection range 1500m","Connection range 2000m"};
		default = 1200;
	};
	class CTI_GAMEPLAY_DARTER_FUEL {
		title = $STR_CTI_GAMEPLAY_DARTER_FUEL;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};
	class CTI_SM_NONV {
		title = $STR_CTI_SM_NONV;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};
	class CTI_ECONOMY_BASE_PLAYER_INCOME {
		title = $STR_CTI_ECONOMY_BASE_PLAYER_INCOME;
		values[] = {0,10,25,50,100,150,200,250};
		texts[] = {"0$","10$","25$","50$","100$","150$","200$","250$"};
		default = 10;
	};
	class CTI_VEHICLES_BOUNTY {
		title = $STR_CTI_VEHICLES_BOUNTY;
		values[] = {0,25,50,75,100};
		texts[] = {$STR_CTI_VEHICLES_BOUNTY_NO,$STR_CTI_VEHICLES_BOUNTY_LOW,$STR_CTI_VEHICLES_BOUNTY_MED,$STR_CTI_VEHICLES_BOUNTY_HIGH,$STR_CTI_VEHICLES_BOUNTY_FULL};
		default = 50;
	};
	class CTI_PLAYER_REEQUIP {
		title = $STR_CTI_PLAYER_REEQUIP;
		values[] = {0,1,2};
		texts[] = {$STR_CTI_PLAYER_REEQUIP_F,$STR_CTI_PLAYER_REEQUIP_LP,$STR_CTI_PLAYER_REEQUIP_CO};
		default = 2;
	};
	class CTI_PLAYER_TOWN_RESPAWN {
		title = $STR_CTI_PLAYER_TOWN_RESPAWN;
		values[] = {0,1,2};
		texts[] = {$STR_CTI_PLAYER_TOWN_RESPAWN_F,$STR_CTI_PLAYER_TOWN_RESPAWN_CL,$STR_CTI_PLAYER_TOWN_RESPAWN_ALL};
		default = 1;
	};
	class CTI_TOWNS_INCOME_RATIO {
		title = $STR_CTI_TOWNS_INCOME_RATIO;
		values[] = {1,2,3,4,5,10};
		texts[] = {"1","2","3","4","5","10"};
		default = 1;
	};
	class CTI_TOWNS_CAPTURE_RATIO {
		title = $STR_CTI_TOWNS_CAPTURE_RATIO;
		values[] = {1,2,3,4,5,10};
		texts[] = {"1","2","3","4","5","10"};
		default = 10;
	};
	class CTI_TOWNS_RESISTANCE_DETECTION_RANGE {
		title = $STR_CTI_TOWNS_RESISTANCE_DETECTION_RANGE;
		values[] = {300,500,800,1000,1200};
		texts[] = {"300m","500m","800m","1000m","1200m"};
		default = 800;
	};
	class CTI_TOWNS_RESISTANCE_GROUPS_RATIO {
		title = $STR_CTI_TOWNS_RESISTANCE_GROUPS_RATIO;
		values[] = {0,25,50,75,100};
		texts[] = {"Null","Normal","Hard","Very hard","HELL"};
		default = 75;
	};
	class CTI_TOWNS_RESISTANCE_INACTIVE_MAX {
		title = $STR_CTI_TOWNS_RESISTANCE_INACTIVE_MAX;
		values[] = {30,60,120,240};
		texts[] = {"30s","60s","120s","240s"};
		default = 60;
	};
	class CTI_TOWNS_SHOPS {
		title = $STR_CTI_TOWNS_SHOPS;
		values[] = {1,2,3,5,10,100};
		texts[] = {"1","2","3","5","10","100"};
		default = 1;
	};

	class CTI_WEATHER_INITIAL {
		title = $STR_CTI_WEATHER_INITIAL;
		values[] = {0,1,2,3,10};
		texts[] = {$STR_CTI_WEATHER_INITIAL_M,$STR_CTI_WEATHER_INITIAL_N,$STR_CTI_WEATHER_INITIAL_E,$STR_CTI_WEATHER_INITIAL_Mid,$STR_CTI_WEATHER_INITIAL_R};
		default = 10;
	};
	class CTI_WEATHER_ALLOWRAIN {
		title = $STR_CTI_WEATHER_ALLOWRAIN;
		values[] = {0,1};
		texts[] = {$STR_CTI_WEATHER_ALLOWRAIN_F,$STR_CTI_WEATHER_ALLOWRAIN_T};
		default = 0;
	};
  	class CTI_WEATHER_FAST {
		title = $STR_CTI_WEATHER_FAST;
		values[] = {1,2,3,4,5,6,7,8,9,10,11,12};
		texts[] = {"1 hour","2 hours","3 hours","4 hours","5 hours","6 hours","7 hours","8 hours","9 hours","10 hours","11 hours","12 hours"};
		default = 3;
	};
  	class CTI_WEATHER_FAST_NIGTH {
		title = $STR_CTI_WEATHER_FAST_NIGHT;
		values[] = {1,2,3,4,5,6,7,8,9,10,11,12};
		texts[] = {"1 hour","2 hours","3 hours","4 hours","5 hours","6 hours","7 hours","8 hours","9 hours","10 hours","11 hours","12 hours"};
		default = 1;
	};
	class SEPARATOR2 {
		title = $STR_CTI_SEPARATOR2;
		values[] = {1};
		texts[] = {""};
		default = 1;
	};

	class CTI_SM_BASEP_M {
		title = $STR_CTI_SM_BASEP_M;
		values[] = {0,-1,2,5,10,20,50,100};
		texts[] = {$STR_CTI_DISABLED,"Hard Protection","Dmg reduced by 2","Dmg reduced by 5","Dmg reduced by 10","Dmg reduced by 20","Dmg reduced by 50","Dmg reduced by 100"};
		default = 10;
	};

	class CTI_SM_PATROLS {
		title = $STR_CTI_SM_PATROLS;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	/*class CTI_SM_PATROLS_NUMBER {
		title = "Zerty: Strategic: Patrols number";
		values[] = {2,5,8,10,15,20};
		texts[] = {"2","5","8","10","15","20"};
		default = 8;
	};*/

	class CTI_SM_MORTARS {
		title = $STR_CTI_SM_MORTARS;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_SM_STRATEGIC {
		title = $STR_CTI_SM_STRATEGIC;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 0;
	};
	class CTI_SM_STRATEGIC_NB {
		title = $STR_CTI_SM_STRATEGIC_NB;
		values[] = {1,2,3,4};
		texts[] = {"1","2","3","4"};
		default = 3;
	};
	class CTI_SM_TCAS {
		title = $STR_CTI_SM_TCAS;
		values[] = {0,100,150,200,250,300,350,400,500,600};
		texts[] = {"0","100","150","200","250","300","350","400","500","600"};
		default = 250;
	};


	class SEPARATOR3 {
		title = $STR_CTI_SEPARATOR3;
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_EW_HUD {
		title = $STR_CTI_EW_HUD;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_EW_HUD_S {
		title = $STR_CTI_EW_HUD_S;
		values[] = {1,2,3,4,5};
		texts[] = {$STR_CTI_EW_HUD_S_HIGH, $STR_CTI_EW_HUD_S_MEDHIGH, $STR_CTI_EW_HUD_S_MEDLOW, $STR_CTI_EW_HUD_S_LOW, $STR_CTI_EW_HUD_S_DIS};
		default = 2;
	};
	class CTI_EW_HUD_I {
		title = $STR_CTI_EW_HUD_I;
		values[] = {0,1};
		texts[] = {$STR_CTI_WEATHER_ALLOWRAIN_F,$STR_CTI_WEATHER_ALLOWRAIN_T};
		default = 0;
	};
	class CTI_EW_ANET {
		title = $STR_CTI_EW_ANET;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class SEPARATOR4 {
		title = $STR_CTI_SEPARATOR4;
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_SM_REPAIR {
		title = $STR_CTI_SM_REPAIR;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_SM_FAR {
		title = $STR_CTI_SM_FAR;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_SM_HALO {
		title = $STR_CTI_SM_HALO;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_SM_RADAR {
		title = $STR_CTI_SM_RADAR;
		values[] = {0,1};
		texts[] = {$STR_CTI_DISABLED,$STR_CTI_ENABLED};
		default = 1;
	};
	class CTI_TROPHY_APS {
		title = $STR_CTI_TROPHY_APS;
		values[] = {0,1};
		texts[] = {$STR_CTI_WEATHER_ALLOWRAIN_F,$STR_CTI_WEATHER_ALLOWRAIN_T};
		default = 1;
	};
};

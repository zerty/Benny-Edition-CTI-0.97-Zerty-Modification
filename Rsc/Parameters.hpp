class Params {
	class CTI_AI_TEAMS_ENABLED {
		title = "AI: Teams";
		values[] = {0,1,2,3};
		texts[] = {"Disabled", "Enabled West", "Enabled East", "Fully Enabled"};
		default = 0;
	};
	class CTI_ARTILLERY_SETUP {
		title = "ARTILLERY: Setup";
		values[] = {-2,-1,0,1,2,3};
		texts[] = {"Disabled","Ballistic Computer","Short","Medium","Long","Extreme"};
		default = -1;
	};
	class CTI_BASE_AREA_MAX {
		title = "BASE: Maximum base number ";
		values[] = {0,1,2,4,6};
		texts[] = {"0","1","2","4","6"};
		default = 4;
	};
	class CTI_BASE_HQ_REPAIR {
		title = "BASE: HQ Repairable";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_BASE_FOB_MAX {
		title = "BASE: FOB Limit";
		values[] = {0,1,2,3,4,5,6,7,8,9,10};
		texts[] = {"Disabled","1","2","3","4","5","6","7","8","9","10"};
		default = 4;
	};
	class CTI_BASE_STARTUP_PLACEMENT {
		title = "BASE: Startup Placement";
		values[] = {2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,15000,20000};
		texts[] = {"2 KM","3 KM","4 KM","5 KM","6 KM","7 KM","8 KM","9 KM","10 KM","12 KM","15 KM","20 KM"};
		default = 12000;
	};
	class CTI_ECONOMY_INCOME_CYCLE {
		title = "INCOME: Delay";
		values[] = {15,30,45,60,90,120,160,190};
		texts[] = {"00:15 Minute","00:30 Minute","00:45 Minute","01:00 Minute","01:30 Minutes","02:00 Minutes","02:30 Minutes","03:00 Minutes"};
		default = 45;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_EAST_COMMANDER {
		title = "INCOME: Starting Funds (East Commander)";
		values[] = {9000,15000,20000,25000,30000,35000,40000,45000,50000,60000};
		texts[] = {"$9000","$15000","$20000","$25000","$30000","$35000","$40000","$45000","$50000","$60000"};
		default = 15000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_EAST {
		title = "INCOME: Starting Funds (East Players)";
		values[] = {900,1500,2400,3200,6000,8000,10000,12500,15000,20000};
		texts[] = {"$900","$1500","$2400","$3200","$6000","$8000","$10000","$12500","$15000","$20000"};
		default = 2400;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_WEST_COMMANDER {
		title = "INCOME: Starting Funds (West Commander)";
		values[] = {9000,15000,20000,25000,30000,35000,40000,45000,50000,60000};
		texts[] = {"$9000","$15000","$20000","$25000","$30000","$35000","$40000","$45000","$50000","$60000"};
		default = 15000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_WEST {
		title = "INCOME: Starting Funds (West Players)";
		values[] = {900,1500,2400,3200,6000,8000,10000,12500,15000,20000};
		texts[] = {"$900","$1500","$2400","$3200","$6000","$8000","$10000","$12500","$15000","$20000"};
		default = 2400;
	};
	class CTI_ECONOMY_TOWNS_OCCUPATION {
		title = "INCOME: Towns Occupation";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_RESPAWN_AI {
		title = "RESPAWN: AI Members";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_RESPAWN_FOB_RANGE {
		title = "RESPAWN: FOB Range";
		values[] = {-1,500,750,1000,1250,1500,1750,2000};
		texts[] = {"FOB Disabled","0.50 KM","0.75 KM","1 KM","1.25 KM","1.5 KM","1.75 KM","2 KM"};
		default = -1;
	};
	class CTI_RESPAWN_MOBILE {
		title = "RESPAWN: Mobile";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_RESPAWN_TIMER {
		title = "RESPAWN: Delay";
		values[] = {15,20,25,30,35,40,45,50,55,60};
		texts[] = {"15 Seconds","20 Seconds","25 Seconds","30 Seconds","35 Seconds","40 Seconds","45 Seconds","50 Seconds","55 Seconds","60 Seconds"};
		default = 30;
	};
	class CTI_TOWNS_OCCUPATION {
		title = "TOWNS: Occupation";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_VEHICLES_AIR_FFAR {
		title = "UNITS: Aircraft FFAR";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled with Upgrade","Enabled"};
		default = 1;
	};
	class CTI_VEHICLES_AIR_AA {
		title = "UNITS: Aircraft AA Missiles";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled with Upgrade","Enabled"};
		default = 1;
	};
	class CTI_VEHICLES_AIR_AT {
		title = "UNITS: Aircraft AT Missiles";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled with Upgrade","Enabled"};
		default = 1;
	};
	class CTI_VEHICLES_AIR_CM {
		title = "UNITS: Aircraft Countermeasures";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled with Upgrade","Enabled"};
		default = 1;
	};
	class CTI_MARKERS_INFANTRY {
		title = "UNITS: Show Map Infantry";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_UNITS_FATIGUE {
		title = "UNITS: Fatigue";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_VEHICLES_EMPTY_TIMEOUT {
		title = "UNITS: Vehicles Reycling Delay";
		values[] = {60,120,180,240,300,600,1200,1800,2400,3000,3600};
		texts[] = {"1 Minute","2 Minutes","3 Minutes","4 Minutes","5 Minutes","10 Minutes","20 Minutes","30 Minutes","40 Minutes","50 Minutes","1 Hour"};
		default = 3600;
	};
	class CTI_GRAPHICS_TG_MAX {
		title = "VISUAL: Terrain Grid";
		values[] = {10,20,30,50};
		texts[] = {"Far","Medium","Short","Free"};
		default = 50;
	};
	class CTI_GRAPHICS_VD_MAX {
		title = "VISUAL: View Distance";
		values[] = {1000,1500,2000,2500,3000,3500,4000};
		texts[] = {"1 KM","1.5 KM","2 KM","2.5 KM","3 KM","3.5 KM","4 KM"};
		default = 4000;
	};

		//Additionnal Parameter (Zerty)
	class SEPARATOR {
		title = "========================== PERSISTENCY ============================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_PERSISTANT {
		title = "Zerty: PERSISTANCY";
		values[] = {0,1};
		texts[] = {"DISABLED", "ENABLED"};
		default = 1;
	};
	class SEPARATOR0 {
		title = "===================== Gameplay and Mission =======================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class HC_MODE {
		title = "Zerty: Perf: HeadLess Client Mode";
		values[] = {0,1,2};
		texts[] = {"Towns:Server + HCs | patrols:HCs","Towns : HCs |  Patrols : HCs","Towns : Server |  Patrols : HCs"};
		default = 2;
	};
	class CACHE_EMPTY {
		title = "Zerty: Perf: PhysX Caching System";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};

	class CTI_TEAMSWAP {
		title = "Zerty:Team swap protection";
		values[] = {0,1};
		texts[] = {"off","on"};
		default = 1;
	};
	class CTI_TEAMSTACK {
		title = "Zerty:Team Stack protection";
		values[] = {0,1};
		texts[] = {"off","on"};
		default = 1;
	};


	class CTI_AI_SKILL {
		title = "Zerty: AI: Skill (credit : Bl1p, fluit)";
		values[] = {1,2,3,4,5};
		texts[] = {"Retards","DumbFucks","NotSobad","Good","Very Good"};
		default = 3;
	};

	class CTI_MAX_MISSION_TIME {
		title = "Zerty: MISSION : Time Limit";
		values[] = {0,2,4,6,8,12,24};
		texts[] = {"Never","2h","4h","6h","8h","12h","24h"};
		default = 0;
	};
	class MIN_TOWNS {
		title = "Zerty: MISSION: Minimum number of towns";
		values[] = {0,10,20,30,40};
		texts[] = {"all","10","20","30","40"};
		default = 0;
	};
	class CTI_VICTORY_HQ {
		title = "Zerty: MISSION : Victory on HQ Destroyed";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 0;
	};

	class CTI_BASE_FOB_PERMISSION {
		title = "Zerty: MISSION : Need Commander permission for FOB";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 0;
	};

	class CTI_BUY_RESTRICT_LEADER {
		title = "Zerty: GROUPS: Restrict purchases to group leader";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 0;
	};
	class CTI_GROUP_AWARD_MULT {
		title = "Zerty: GROUPS: Award multiplyer";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class CTI_GROUP_LEADER_RESP {
		title = "Zerty: GROUPS: Respawn on leader";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};

	class CTI_AI_TEAMS_GROUPSIZE {
		title = "Zerty: GROUPS: Size (AI) -- Resistance, West, East ";
		values[] = {0,4,6,8,10,12,14,16};
		texts[] = {"0","4","6","8","10","12","14","16"};
		default = 8;
	};

	class CTI_PLAYERS_GROUPSIZE {
		title = "Zerty: GROUPS: Size (Players) ";
		values[] = {0,1,2,3,4,5,8,10,12,14,16};
		texts[] = {"AutoAdaptative","1","2","3","4","5","8","10","12","14","16"};
		default = 0;
	};
	class CTI_GAMEPLAY_MISSILES_RANGE {
		title = "Zerty: GAMEPLAY: Missile Range";
		values[] = {0,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000};
		texts[] = {"Disabled","500m","1000m","1500m","2000m","2500m","3000m","3500m","4000m","4500m","5000m","5500m","6000m","6500m","7000m","7500m","8000m","8500m","9000m","9500m","10000m"};
		default = 0;
	};
	class CTI_GAMEPLAY_3P {
		title = "Zerty: GAMEPLAY: 3P view";
		values[] = {-1,0,1,2};
		texts[] = {"All","No group view","Vehicle","None"};
		default = 0;
	};
	class CTI_GAMEPLAY_REARM_AMMO {
		title = "Zerty: GAMEPLAY: Gear On Ammo Trucks";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class CTI_GAMEPLAY_REARM_MED {
		title = "Zerty: GAMEPLAY: Gear On MED Trucks";
		values[] = {0,1,2,3,4,100};
		texts[] = {"Always","Upg 1","Upg 2","Upg 3","Upg 4","Off"};
		default = 3;
	};
	class CTI_BASEBUILDING {
		title = "Zerty: GAMEPLAY: Base building";
		values[] = {0,1};
		texts[] = {"Workers","Players"};
		default = 1;
	};
	class CTI_GAMEPLAY_DARTER {
		title = "Zerty: GAMEPLAY: Darter Range limitation";
		values[] = {0,500,800,1200,1500,2000};
		texts[] = {"None","Connection range 500m","Connection range 800m","Connection range 1200m","Connection range 1500m","Connection range 2000m"};
		default = 1200;
	};
	class CTI_GAMEPLAY_DARTER_FUEL {
		title = "Zerty: GAMEPLAY: Darter Fuel limitation";
		values[] = {0,1};
		texts[] = {"Disabled", "Enabled"};
		default = 0;
	};
	class CTI_SM_NONV {
		title = "Zerty: GAMEPLAY: No NVs, No Thermal";
		values[] = {0,1};
		texts[] = {"false","true"};
		default = 0;
	};
	class CTI_ECONOMY_BASE_PLAYER_INCOME {
		title = "Zerty: INCOME: base income for players";
		values[] = {0,10,25,50,100,150,200,250};
		texts[] = {"0$","10$","25$","50$","100$","150$","200$","250$"};
		default = 10;
	};
	class CTI_VEHICLES_BOUNTY {
		title = "Zerty: INCOME: On kill";
		values[] = {0,25,50,75,100};
		texts[] = {"No value","Low value","Medium value","High value","Full value"};
		default = 50;
	};
	class CTI_PLAYER_REEQUIP {
		title = "Zerty: RESPAWN : Reequip Gear";
		values[] = {0,1,2};
		texts[] = {"False","Last Purchase","Continuous"};
		default = 2;
	};
	class CTI_PLAYER_TOWN_RESPAWN {
		title = "Zerty: RESPAWN : On occupied towns";
		values[] = {0,1,2};
		texts[] = {"False","Closest", "All"};
		default = 1;
	};
	class CTI_TOWNS_INCOME_RATIO {
		title = "Zerty: TOWNS: Value Ratio";
		values[] = {1,2,3,4,5,10};
		texts[] = {"1","2","3","4","5","10"};
		default = 1;
	};
	class CTI_TOWNS_CAPTURE_RATIO {
		title = "Zerty: TOWNS: Value Award Ratio";
		values[] = {1,2,3,4,5,10};
		texts[] = {"1","2","3","4","5","10"};
		default = 10;
	};
	class CTI_TOWNS_RESISTANCE_DETECTION_RANGE {
		title = "Zerty: TOWNS: Detection Range";
		values[] = {300,500,800,1000,1200};
		texts[] = {"300m","500m","800m","1000m","1200m"};
		default = 800;
	};
	class CTI_TOWNS_RESISTANCE_GROUPS_RATIO {
		title = "Zerty: TOWNS : Resistance difficulty";
		values[] = {0,25,50,75,100};
		texts[] = {"Null","Normal","Hard","Very hard","HELL"};
		default = 75;
	};
	class CTI_TOWNS_RESISTANCE_INACTIVE_MAX {
		title = "Zerty: TOWNS : Resistance despawn Timer";
		values[] = {30,60,120,240};
		texts[] = {"30s","60s","120s","240s"};
		default = 60;
	};
	class CTI_TOWNS_SHOPS {
		title = "Zerty: TOWNS : Shop price ratio";
		values[] = {1,2,3,5,10,100};
		texts[] = {"1","2","3","5","10","100"};
		default = 1;
	};

	class CTI_WEATHER_INITIAL {
		title = "Zerty: WEATHER: Inital time";
		values[] = {0,1,2,3,10};
		texts[] = {"Morning","Noon","Evening","Midnigth","Random"};
		default = 10;
	};
	class CTI_WEATHER_DYNAMIC {
		title = "Zerty: WEATHER: Dynamic";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};

	class initialWeatherParam {
	    title = "Zerty: WEATHER:Starting Weather";
	    values[] = {0,1,2,3,4};
	    texts[] = {"Clear","Overcast","Rain","Fog","Random"};
	    default = 4;
	};
  	class CTI_WEATHER_FAST {
		title = "Zerty: WEATHER: Time ratio";
		values[] = {1,2,3,4,5,6,7,8,9,10,11,12};
		texts[] = {"x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11","x12"};
		default = 4;
	};
	class SEPARATOR2 {
		title = "===================== Strategic Mode =======================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};

	class CTI_SM_BASEP_M {
		title = "Zerty: Strategic: Base Protection Mode";
		values[] = {0,-1,2,5,10,20,50,100};
		texts[] = {"Disabled","Hard Protection","Dmg reduced by 2","Dmg reduced by 5","Dmg reduced by 10","Dmg reduced by 20","Dmg reduced by 50","Dmg reduced by 100"};
		default = 10;
	};

	class CTI_SM_PATROLS {
		title = "Zerty: Strategic: Patrols";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	/*class CTI_SM_PATROLS_NUMBER {
		title = "Zerty: Strategic: Patrols number";
		values[] = {2,5,8,10,15,20};
		texts[] = {"2","5","8","10","15","20"};
		default = 8;
	};*/

	class CTI_SM_MORTARS {
		title = "Zerty: Strategic: Town Mortars";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_SM_STRATEGIC {
		title = "Zerty: Strategic: Town Links";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_SM_STRATEGIC_NB {
		title = "Zerty: Strategic: Max active per side";
		values[] = {1,2,3,4};
		texts[] = {"1","2","3","4"};
		default = 3;
	};
	class CTI_SM_TCAS {
		title = "Zerty: Strategic: Town CAS if value above";
		values[] = {0,100,150,200,250,300,350,400,500,600};
		texts[] = {"0","100","150","200","250","300","350","400","500","600"};
		default = 250;
	};


	class SEPARATOR3 {
		title = "===================== Electronic Warfare =======================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_EW_HUD {
		title = "Zerty: Electronic Warfare : Tactical HUD";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_EW_HUD_S {
		title = "Zerty: Electronic Warfare : Tactical HUD target report sensitivity";
		values[] = {1,2,3,4,5};
		texts[] = {"high","medium high", "medium low", "low","Disable target report"};
		default = 2;
	};
	class CTI_EW_HUD_I {
		title = "Zerty: Electronic Warfare : Tactical HUD report infantry";
		values[] = {0,1};
		texts[] = {"false","true"};
		default = 0;
	};
	class CTI_EW_ANET {
		title = "Zerty: Electronic Warfare : Field Network Meshing";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class SEPARATOR4 {
		title = "===================== Other Stuff =======================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_SM_REPAIR {
		title = "Zerty: Repair/Forcelock: Enabled";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_SM_FAR {
		title = "Zerty: Revive: Enabled";
		values[] = {0,1};
		texts[] = {"disabled","Enabled"};
		default = 1;
	};
	class CTI_SM_HALO {
		title = "Zerty: Halo Jump: Enabled";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_SM_RADAR {
		title = "Zerty: Air Radar: Enabled";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_TROPHY_APS {
		title = "Zerty: Trophy: Enabled";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class CTI_AC_ENABLED {
		title = "Henroth: Aircraft Loadout Customisation : Enabled";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
};

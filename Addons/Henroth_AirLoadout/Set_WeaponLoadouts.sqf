/*
 * Filename: Set_WeaponLoadouts.sqf
 *
 * Purpose: Mapping of vehicles and their possible loadouts along with research / magazine mappings.
 * Author: Henroth
 * Date: 08/Sept/2014
 * Version: 1.1
 *
 * Change log:
 * -------------------------------------------
 * 07/Sept/2014 - Henroth - Initial code
 * 08/Sept/2014 - Henroth - Added new-loadouts for
 *                           - Typhoon
 * 11/Sept/2014 - Henroth - Re-introduced UAV
 *                          Re-introduced Hellcat (Armed)
 * 12/May/2018 - Yoshi_E - New Templates for all Units
						 - Rework of inital code
 * 
 *
 *
 * Note: Weapon needs to start with "Pylon" (caps senetive) if you want the weapon * * to be treated as a pylon.
 * "default - pylon" is just a dummy var for now
*/

/*
Format:
CTI_LOADOUT_<Vehicleclassname>_MNT_OPTIONS =
	Layout name
	default - pylon
		Mount
			Weapon name
				Magazine
				Magazine
			Weapon name
				Magazine
				Magazine
		Mount
			Weapon name
				Magazine
				Magazine
			Weapon name
				Magazine
				Magazine
			
			

Get Pylons:
	configProperties [configFile >> "CfgVehicles" >> typeOf (vehicle player) >> "Components" >> "TransportPylonsComponent" >> "Pylons"]
	
	configProperties [configFile >> "CfgVehicles" >> "I_Plane_Fighter_03_dynamicLoadout_F" >> "Components" >> "TransportPylonsComponent" >> "Pylons"]
Get Ammo for pylon:
	"I_Plane_Fighter_03_dynamicLoadout_F" getCompatiblePylonMagazines "PylonLeft1"
	
As an empty weapon or Place Holder use:
	["FakeHorn" , //Dummy weapon
		[
			[ "WeaponSafty" , "0", [-1]]
		]
	]	
	
*/


CTI_LOADOUT_UNARMED_FLARES =
[
	[
		"Standard - configuration" ,
		"default",
		[	
			[
				[ "CMFlareLauncher" ,
					[
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
					]
				]
			]
		]
	]
];


// ***************************
// Experimental loadouts for AA tanks
// ***************************
//Bluefor

CTI_LOADOUT_B_APC_Tracked_01_AA_F_MNT_OPTIONS =
[	
	[
		"Standard - configuration" ,
		"default",
		[	
			[ 	
				["autocannon_35mm",
					[
						[ "680Rnd_35mm_AA_shells_Tracer_Green" , "2000"]
					]
				]
			],	
			[ 	
				["autocannon_35mm",
					[
						[ "680Rnd_35mm_AA_shells_Tracer_Green" , "2000"]
					]
				]
			],
			[ 	
				["missiles_SAAMI",
					[
						[ "4Rnd_70mm_SAAMI_missiles" , "4000"]
					]
				]
			],	
			[ 	
				["missiles_SAAMI",
					[
						[ "4Rnd_70mm_SAAMI_missiles" , "4000"]
					]
				]
			],			
			[ 	
				["SmokeLauncher",
					[
						[ "SmokeLauncherMag" , "1000", [0,0]]
					]
				]
			],
			[ 	
				["SmokeLauncher",
					[
						[ "SmokeLauncherMag" , "1000", [0,0]]
					]
				]
			]
		]
	]
];
//Opfor
CTI_LOADOUT_O_APC_Tracked_02_AA_F_MNT_OPTIONS =
[	
	[
		"Standard - configuration" ,
		"default",
		[	
			[ 	
				["autocannon_35mm",
					[
						[ "680Rnd_35mm_AA_shells_Tracer_Green" , "2000"]
					]
				]
			],	
			[ 	
				["autocannon_35mm",
					[
						[ "680Rnd_35mm_AA_shells_Tracer_Green" , "2000"]
					]
				]
			],
			[ 	
				["missiles_SAAMI",
					[
						[ "4Rnd_70mm_SAAMI_missiles" , "4000"]
					]
				]
			],	
			[ 	
				["missiles_SAAMI",
					[
						[ "4Rnd_70mm_SAAMI_missiles" , "4000"]
					]
				]
			],			
			[ 	
				["SmokeLauncher",
					[
						[ "SmokeLauncherMag" , "1000", [0,0]]
					]
				]
			],
			[ 	
				["SmokeLauncher",
					[
						[ "SmokeLauncherMag" , "1000", [0,0]]
					]
				]
			]
		]
	]
];

// ***************************
// BLUFOR - Vehicle loadout options
// ***************************


// ***************************
// Plane - Wipeout
// ***************************
CTI_LOADOUT_B_Plane_CAS_01_dynamicLoadout_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[	
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500"]
					]
				]
			],			
			[
				[ "Gatling_30mm_Plane_CAS_01_F" ,
					[
						[ "1000Rnd_Gatling_30mm_Plane_CAS_01_F" , "1000"]
					]
				]
			],
			[ 	
				["Pylons1",
					[
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],
			[ 
				["Pylons2",
					[
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],
			[ 	
				["Pylons3",
					[
						[ "PylonRack_3Rnd_Missile_AGM_02_F" , "15000"],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],					
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],
			[ 
				["Pylons4",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000"],
						[ "PylonRack_3Rnd_Missile_AGM_02_F" , "15000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],
			[ 	
				["Pylons5",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000"],
						[ "PylonRack_3Rnd_Missile_AGM_02_F" , "15000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],			
			[ 	
				["Pylons6",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000"],
						[ "PylonRack_3Rnd_Missile_AGM_02_F" , "15000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],
			[ 	
				["Pylons7",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000"],
						[ "PylonRack_3Rnd_Missile_AGM_02_F" , "15000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],	
			[ 	
				["Pylons8",
					[
						[ "PylonRack_3Rnd_Missile_AGM_02_F" , "15000"],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],			
			[ 	
				["Pylons9",
					[
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],	
			[ 	
				["Pylons10",
					[
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],			
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
					]
				]
			]
		]
	],
	[
		"Bomber" ,
		"pylon",
		[	
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500"]
					]
				]
			],			
			[
				[ "Gatling_30mm_Plane_CAS_01_F" ,
					[
						[ "1000Rnd_Gatling_30mm_Plane_CAS_01_F" , "1000"]
					]
				]
			],
			[ 	
				["Pylons1",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],
			[ 
				["Pylons2",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],
			[ 	
				["Pylons3",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],
			[ 
				["Pylons4",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],
			[ 	
				["Pylons5",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],			
			[ 	
				["Pylons6",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],
			[ 	
				["Pylons7",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],	
			[ 	
				["Pylons8",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],			
			[ 	
				["Pylons9",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],	
			[ 	
				["Pylons10",
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000"]
					]
				]
			],			
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
					]
				]
			]
		]
	]
];


// ***************************
// Plane - Black Wasp II 
// ***************************
CTI_LOADOUT_B_Plane_Fighter_01_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[	
			[
				["Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500"]
					]
				]
			],			
			[
				["weapon_Fighter_Gun20mm_AA" ,
					[
						[ "magazine_Fighter01_Gun20mm_AA_x450" , "1000"]
					]
				]
			],
			[ 	
				["Pylon1",
					[
						[ "PylonRack_Missile_AMRAAM_D_x1" , "4000"],
						[ "PylonRack_Missile_AMRAAM_D_x2" , "4000"],
						[ "PylonRack_Missile_BIM9X_x1" , "4000"],
						[ "PylonRack_Missile_BIM9X_x2" , "4000"],
						[ "PylonRack_Missile_AGM_02_x1" , "5000"],
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],
			[ 	
				["Pylon3",
					[
						[ "PylonRack_Missile_AGM_02_x1" , "5000"],
						[ "PylonRack_Missile_AMRAAM_D_x1" , "4000"],
						[ "PylonRack_Missile_AMRAAM_D_x2" , "4000"],
						[ "PylonRack_Missile_BIM9X_x1" , "4000"],
						[ "PylonRack_Missile_BIM9X_x2" , "4000"],
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"],
						[ "PylonRack_Missile_AGM_02_x2" , "5000"],
						[ "PylonRack_Bomb_GBU12_x2" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonRack_2Rnd_BombCluster_01_F" , "2000"],
						[ "PylonRack_2Rnd_BombCluster_03_F" , "2000"],
						[ "PylonRack_Bomb_SDB_x4" , "5000"],
						[ "PylonRack_Missile_HARM_x1" , "10000"],
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"],
						[ "PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],		
			[ 	
				["PylonBayLeft1",
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter1",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter2",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],			
			[ 	
				["PylonBayCenter3",
					[
						["" , ""],
						[ "PylonRack_Bomb_SDB_x4" , "5000"],
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter4",
					[
						["" , ""],
						[ "PylonRack_Bomb_SDB_x4" , "5000"],
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],	
			[ 	
				["PylonBayCenter5",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],			
			[ 	
				["PylonBayCenter6",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],	
			[ 	
				["PylonBayRight1",
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"]
					]
				]
			],			
			[ 	
				["Pylon4",
					[
						[ "PylonRack_Missile_AGM_02_x1" , "5000"],
						[ "PylonRack_Missile_AMRAAM_D_x1" , "4000"],
						[ "PylonRack_Missile_AMRAAM_D_x2" , "4000"],
						[ "PylonRack_Missile_BIM9X_x1" , "4000"],
						[ "PylonRack_Missile_BIM9X_x2" , "4000"],
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"],
						[ "PylonRack_Missile_AGM_02_x2" , "5000"],
						[ "PylonRack_Bomb_GBU12_x2" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonRack_2Rnd_BombCluster_01_F" , "2000"],
						[ "PylonRack_2Rnd_BombCluster_03_F" , "2000"],
						[ "PylonRack_Bomb_SDB_x4" , "5000"],
						[ "PylonRack_Missile_HARM_x1" , "10000"],
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"],
						[ "PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],			
			[ 	
				["Pylon2",
					[
						[ "PylonRack_Missile_AMRAAM_D_x1" , "4000"],
						[ "PylonRack_Missile_AMRAAM_D_x2" , "4000"],
						[ "PylonRack_Missile_BIM9X_x1" , "4000"],
						[ "PylonRack_Missile_BIM9X_x2" , "4000"],
						[ "PylonRack_Missile_AGM_02_x1" , "5000"],
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
					]
				]
			]
		]
	],
	[
		"Air Supremacy - Maddog",
		"pylon",
		[	
			[
				["Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500"]
					]
				]
			],			
			[
				["weapon_Fighter_Gun20mm_AA" ,
					[
						[ "magazine_Fighter01_Gun20mm_AA_x450" , "1000"]
					]
				]
			],
			[ 	
				["Pylon1",
					[
						[ "PylonRack_Missile_AMRAAM_D_x2" , "4000"]
					]
				]
			],
			[ 	
				["Pylon3",
					[
						[ "PylonRack_Missile_AMRAAM_D_x2" , "4000"]
					]
				]
			],		
			[ 	
				["PylonBayLeft1",
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter1",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter2",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],			
			[ 	
				["PylonBayCenter3",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter4",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],	
			[ 	
				["PylonBayCenter5",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"]
					]
				]
			],			
			[ 	
				["PylonBayCenter6",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"]
					]
				]
			],	
			[ 	
				["PylonBayRight1",
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"]
					]
				]
			],			
			[ 	
				["Pylon4",
					[
						[ "PylonRack_Missile_AMRAAM_D_x2" , "4000"]
					]
				]
			],			
			[ 	
				["Pylon2",
					[
						[ "PylonRack_Missile_AMRAAM_D_x2" , "4000"]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
					]
				]
			]
		]
	],
	[
		"Ground Supremacy - Hybrid" ,
		"pylon",
		[	
			[
				["Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500"]
					]
				]
			],			
			[
				["weapon_Fighter_Gun20mm_AA" ,
					[
						[ "magazine_Fighter01_Gun20mm_AA_x450" , "1000"]
					]
				]
			],
			[ 	
				["Pylon1",
					[
						[ "PylonRack_Missile_AGM_02_x1" , "5000"]
					]
				]
			],
			[ 	
				["Pylon3",
					[
						[ "PylonRack_Missile_HARM_x1" , "10000"]
					]
				]
			],		
			[ 	
				["PylonBayLeft1",
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter1",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter2",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],			
			[ 	
				["PylonBayCenter3",
					[
						[ "PylonRack_Bomb_SDB_x4" , "5000"]
					]
				]
			],
			[ 	
				["PylonBayCenter4",
					[
						[ "PylonRack_Bomb_SDB_x4" , "5000"]
					]
				]
			],	
			[ 	
				["PylonBayCenter5",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"]
					]
				]
			],			
			[ 	
				["PylonBayCenter6",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"]
					]
				]
			],	
			[ 	
				["PylonBayRight1",
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"]
					]
				]
			],			
			[ 	
				["Pylon4",
					[
						[ "PylonRack_Missile_HARM_x1" , "10000"]
					]
				]
			],			
			[ 	
				["Pylon2",
					[
						[ "PylonRack_Missile_AGM_02_x1" , "5000"]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
					]
				]
			]
		]
	]
];




// ***************************
// Plane - Black Wasp II  Stealth
// ***************************
CTI_LOADOUT_B_Plane_Fighter_01_Stealth_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[	
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],			
			[
				[ "weapon_Fighter_Gun20mm_AA" ,
					[
						[ " magazine_Fighter01_Gun20mm_AA_x450" , "1000" , [0]]
					]
				]
			],
			[ 	
				["PylonBayRight1",
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter1",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter2",
					[
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],			
			[ 	
				["PylonBayCenter3",
					[
						["" , ""],
						[ "PylonRack_Bomb_SDB_x4" , "5000"],
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],
			[ 	
				["PylonBayCenter4",
					[
						["" , ""],
						[ "PylonRack_Bomb_SDB_x4" , "5000"],
						["PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],	
			[ 	
				["PylonBayCenter5",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],			
			[ 	
				["PylonBayCenter6",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000"],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000"],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000"],
						[ "PylonMissile_Missile_AMRAAM_D_INT_x1" , "4000"]
					]
				]
			],	
			[ 	
				["PylonBayRight1",
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000"]
					]
				]
			],	
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
					]
				]
			]		
		]
	]
];
// ***************************
// Heli - AH-9 Pawnee
// ***************************
CTI_LOADOUT_B_Heli_Light_01_dynamicLoadout_F_MNT_OPTIONS =
[
	[
		"Pylon - Configuration" ,
		"pylon",
		[
			[
				["M134_minigun" , 
					[
						[ "5000Rnd_762x51_Belt" , "350"]
					]
				]
			],			
			[
				["PylonRight1" , 
					[
						[ "PylonRack_12Rnd_missiles" , "2000"],
						//[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						//[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"]
						//[ "PylonRack_12Rnd_PG_missiles" , "8000"],
					]
				]
			],	
			[
				["PylonLeft1" , 
					[
						[ "PylonRack_12Rnd_missiles" , "2000"],
						//[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						//[ "PylonRack_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"]
						//[ "PylonRack_12Rnd_PG_missiles" , "8000"],
					]
				]
			]
		]
	]
];


// ***************************
// Heli - UH-80 Ghost Hawk
// ***************************
CTI_LOADOUT_B_Heli_Transport_01_F_MNT_OPTIONS =
[
	[
		"Pylon - Configuration" ,
		"pylon",
		[
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [0] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [0] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [0] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [0] ]
					]
				]
			],
			[
				["LMG_Minigun_Transport" ,
					[
						[ "2000Rnd_65x39_Belt_Tracer_Red" , "500", [1]]
					]
				]
			],
			[
				["LMG_Minigun_Transport" ,
					[
						[ "2000Rnd_65x39_Belt_Tracer_Red" , "500", [1]]
					]
				]
			],
			[
				["LMG_Minigun_Transport" ,
					[
						[ "2000Rnd_65x39_Belt_Tracer_Red" , "500", [2]]
					]
				]
			],
			[
				["LMG_Minigun_Transport" ,
					[
						[ "2000Rnd_65x39_Belt_Tracer_Red" , "500", [2]]
					]
				]
			]
		]
	]
];
CTI_LOADOUT_B_CTRG_Heli_Transport_01_sand_F_MNT_OPTIONS = CTI_LOADOUT_B_Heli_Transport_01_F_MNT_OPTIONS;
CTI_LOADOUT_B_CTRG_Heli_Transport_01_tropic_F_MNT_OPTIONS = CTI_LOADOUT_B_Heli_Transport_01_F_MNT_OPTIONS;
CTI_LOADOUT_B_Heli_Transport_01_camo_F_MNT_OPTIONS = CTI_LOADOUT_B_Heli_Transport_01_F_MNT_OPTIONS;


// ***************************
// Heli - CH-67 Huron Armed
// ***************************
CTI_LOADOUT_B_Heli_Transport_03_F_MNT_OPTIONS = CTI_LOADOUT_B_Heli_Transport_01_F_MNT_OPTIONS;
CTI_LOADOUT_B_Heli_Transport_03_black_F_MNT_OPTIONS = CTI_LOADOUT_B_Heli_Transport_03_F_MNT_OPTIONS;



// ***************************
// Heli - CH-67 Huron Unarmed
// ***************************
CTI_LOADOUT_B_Heli_Transport_03_unarmed_F_MNT_OPTIONS = CTI_LOADOUT_UNARMED_FLARES;
CTI_LOADOUT_B_Heli_Transport_03_unarmed_green_F_MNT_OPTIONS  = CTI_LOADOUT_UNARMED_FLARES;



// ***************************
// VTOL - 	V-44 X Blackfish (Armed)
// ***************************
CTI_LOADOUT_B_T_VTOL_01_armed_F_MNT_OPTIONS =
[
	[
		"Pylon - Configuration" ,
		"pylon",
		[
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
					]
				]
			],
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500", [0]]
					]
				]
			],			
			[
				["cannon_105mm_VTOL_01" ,
					[
						[ "100Rnd_105mm_HEAT_MP" , "2000", [1]]
					]
				]
			],			
			[
				["cannon_105mm_VTOL_01" ,
					[
						[ "40Rnd_105mm_APFSDS_T_Red" , "2000", [1]]
					]
				]
			],			
			[
				["gatling_20mm_VTOL_01" ,
					[
						[ "4000Rnd_20mm_Tracer_Red_shells" , "2000", [1]]
					]
				]
			],			
			[
				["autocannon_40mm_VTOL_01" ,
					[
						[ "240Rnd_40mm_GPR_Tracer_Red_shells" , "2000", [2]]
					]
				]
			],			
			[
				["autocannon_40mm_VTOL_01" ,
					[
						[ "240Rnd_40mm_GPR_Tracer_Red_shells" , "2000", [2]]
					]
				]
			],			
			[
				["autocannon_40mm_VTOL_01" ,
					[
						[ "160Rnd_40mm_APFSDS_Tracer_Red_shells" , "2000", [2]]
					]
				]
			],
			[
				["gatling_20mm_VTOL_01" ,
					[
						[ "4000Rnd_20mm_Tracer_Red_shells" , "2000", [2]]
					]
				]
			]			
		]
	]
];

CTI_LOADOUT_B_T_VTOL_01_infantry_F_MNT_OPTIONS = CTI_LOADOUT_UNARMED_FLARES;
CTI_LOADOUT_B_T_VTOL_01_vehicle_F_MNT_OPTIONS = CTI_LOADOUT_UNARMED_FLARES;
 


// ***************************
// Heli - AH-99 Blackfoot
// ***************************
CTI_LOADOUT_B_Heli_Attack_01_dynamicLoadout_F_MNT_OPTIONS =
[
	[
		"Pylon - Configuration" ,
		"pylon",
		[
			[
				["FakeHorn" , //Dummy weapon
					[
						[ "WeaponSafty" , "0", [-1]]
					]
				]
			],
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500", [0]]
					]
				]
			],
			[
				["gatling_20mm" ,
					[
						[ "1000Rnd_20mm_shells" , "1000", [0]]
					]
				],
				["gatling_25mm" ,
					[
						[ "1000Rnd_25mm_shells" , "1500", [0]] ,
						[ "300Rnd_25mm_shells" , "500", [0]]
					]
				]
			],
			[
				["PylonLeft1" ,
					[
						[ "PylonMissile_1Rnd_AAA_missiles" , "4000"],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000", [0]],
						[ "PylonRack_12Rnd_PG_missiles" , "8000", [0]],
						[ "PylonRack_12Rnd_missiles" , "2000"]
					]
				]
			],
			[
				["PylonLeft2" ,
					[
						[ "PylonMissile_1Rnd_AAA_missiles" , "4000"],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000", [0]]
					]
				]
			],
			[
				["PylonLeft3" ,
					[
						[ "PylonRack_12Rnd_PG_missiles" , "8000", [0]],
						[ "PylonMissile_1Rnd_AAA_missiles" , "4000"],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000", [0]],
						[ "PylonRack_12Rnd_missiles" , "2000"]
					]
				]
			],
			[
				["PylonRight3" ,
					[
						[ "PylonRack_12Rnd_PG_missiles" , "8000", [0]],
						[ "PylonMissile_1Rnd_AAA_missiles" , "4000"],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000", [0]],
						[ "PylonRack_12Rnd_missiles" , "2000"]
					]
				]
			],			
			[
				["PylonRight2" ,
					[
						[ "PylonMissile_1Rnd_AAA_missiles" , "4000"],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000", [0]]
					]
				]
			],			
			[
				["PylonRight1" ,
					[
						[ "PylonMissile_1Rnd_AAA_missiles" , "4000"],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000", [0]],
						[ "PylonRack_12Rnd_PG_missiles" , "8000", [0]],
						[ "PylonRack_12Rnd_missiles" , "2000"]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
					]
				]
			]
		] 
	]
];
// ***************************
// UAV - MQ-4A Greyhawk AA Version
// ***************************
CTI_LOADOUT_B_UAV_02_F_MNT_OPTIONS =
[
	[
		"AA - Configurations" ,
		"default",
		[
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[
				["Missile_AA_04_Plane_CAS_01_F" ,
					[
						[ "2Rnd_Missile_AA_04_F" , "8000"]
					]
				],
				["Missile_AA_03_Plane_CAS_02_F" ,
					[
						[ "2Rnd_Missile_AA_03_F" , "8000"]
					] 
				],				
				["missiles_ASRAAM" ,
					[
						[ "2Rnd_AAA_missiles" , "8000"]
					] 
				]

			],
			[
				["CMFlareLauncher" ,
					[
					[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]],
					[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
					[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]],
					[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]]
					]
				]
			]
		]
	]
];

// ***************************
// UAV - MQ-4A Greyhawk Bomb Version
// ***************************
CTI_LOADOUT_B_UAV_02_CAS_F_MNT_OPTIONS =
[
	[
		"Bomb - Configurations" ,
		"default",
		[
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[
				["GBU12BombLauncher" ,
					[
						[ "2Rnd_GBU12_LGB" , "4000" , [0]]
					]
				],
				["Mk82BombLauncher" ,
					[
						[ "2Rnd_Mk82" , "3000" ,[0]]
					] 
				]

			],
			[
				["CMFlareLauncher" ,
					[
					[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]],
					[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
					[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]],
					[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]]
					]
				]
			]
		]
	]
];


// ***************************
// UAV - MQ-4A Greyhawk AT version
// ***************************
CTI_LOADOUT_B_UAV_02_dynamicLoadout_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[	
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[ 	
				["Pylons1",
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" , [0]],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" , [-1]],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "100" , [-1]],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" , [0]],
						[ "PylonRack_12Rnd_missiles" , "2000" , [-1]],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" , [0]]
					]
				]
			],
			[ 	
				["Pylons2",
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" , [0]],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" , [-1]],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "100" , [-1]],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" , [0]],
						[ "PylonRack_12Rnd_missiles" , "2000" , [-1]],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" , [0]]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
					[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]],
					[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
					[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]],
					[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]]
					]
				]
			]
		]
	]
];

// ***************************
// UAV - MQ-12 Falcon
// ***************************
CTI_LOADOUT_B_T_UAV_03_dynamicLoadout_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[	
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[ 	
				["Pylons1",
					[
						[ "PylonRack_12Rnd_missiles" , "2000" , [-1]],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" , [0]],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" , [-1]],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "100" , [-1]],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" , [0]]
					]
				]
			],
			[ 	
				["Pylons2",
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" , [0]],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" , [-1]],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "100" , [-1]],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" , [0]],
						[ "PylonRack_12Rnd_missiles" , "2000" , [-1]],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" , [0]]
					]
				]
			],			
			[ 	
				["Pylons3",
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" , [0]],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" , [-1]],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "100" , [-1]],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" , [0]],
						[ "PylonRack_12Rnd_missiles" , "2000" , [-1]],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" , [0]]
					]
				]
			],
			[ 	
				["Pylons4",
					[
						[ "PylonRack_12Rnd_missiles" , "2000" , [-1]],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" , [0]],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" , [-1]],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "100" , [-1]],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" , [0]]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]],
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]]
					]
				]
			]
		]
	]
];

// ***************************
// UAV - UCAV Sentinel
// ***************************
CTI_LOADOUT_B_UAV_05_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[	
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[ 	
				["Pylons1",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000" , [0]],
						[ "PylonMissile_Missile_AGM_02_x2" , "10000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" , [0]]
					]
				]
			],
			[ 	
				["Pylons2",
					[
						[ "PylonMissile_Bomb_GBU12_x1" , "5000" , [0]],
						[ "PylonMissile_Missile_AGM_02_x2" , "10000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" , [0]]
					]
				]
			],			
			[
				["CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]]
						
					]
				]
			]
		]
	]
];



// ***************************
// OPFOR ( east ) - Vehicle loadout options
// ***************************

// ***************************
// UAV - Fenghuang
// ***************************
CTI_LOADOUT_O_T_UAV_04_CAS_F_MNT_OPTIONS =
[
	[
		"Standard - Configuration" ,
		"default",
		[	
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500", [0]]
					]
				]
			] ,
			[
				[ "missiles_Jian" ,
					[
						[ "4Rnd_LG_Jian" , "12000", [0]]
					]
				]
			] ,
			[
				[ "CMFlareLauncher" ,
					[
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
					]
				]
			]
		]
	]
];

// ***************************
// Heli - Orca armed
// ***************************
CTI_LOADOUT_O_Heli_Light_02_dynamicLoadout_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration",
		"pylon",
		[
			[
				[ "PylonLeft1" ,
					[
						[ "PylonWeapon_2000Rnd_65x39_belt" , "1000" ],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" ],
						[ "PylonRack_12Rnd_missiles" , "2000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonWeapon_300Rnd_20mm_shells" , "1000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ]
					]
				]
			],			
			[
				[ "PylonRight1" ,
					[
						[ "PylonRack_12Rnd_PG_missiles" , "8000" ],
						[ "PylonRack_12Rnd_missiles" , "2000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonWeapon_300Rnd_20mm_shells" , "1000" ],
						[ "PylonWeapon_2000Rnd_65x39_belt" , "1000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ]
					]
				]
			],
			[
				[ "CMFlareLauncher" ,
					[
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
					]
				]
			]
		]
	]
];

// ***************************
// Heli - Orca unarmed
// ***************************
CTI_LOADOUT_O_Heli_Light_02_unarmed_F_MNT_OPTIONS = CTI_LOADOUT_UNARMED_FLARES;
// ***************************
// Heli - Mi-290 Taru
// ***************************
CTI_LOADOUT_O_Heli_Transport_04_F_MNT_OPTIONS = CTI_LOADOUT_UNARMED_FLARES;
// ***************************
// Plane - To-201 Stealth
// ***************************
CTI_LOADOUT_O_Plane_Fighter_02_Stealth_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration",
		"pylon",
		[
			[
				[ "weapon_Fighter_Gun_30mm" ,
					[
						[ "magazine_Fighter02_Gun30mm_AA_x180" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "PylonBayRight1" ,
					[
						[ "PylonMissile_Missile_AA_R73_x1" , "4000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "4000" ],
						[ "PylonMissile_Missile_AA_R77_INT_x1" , "4000" ],
						[ "PylonMissile_Missile_AGM_KH25_INT_x1" , "5000" ],
						[ "PylonMissile_Bomb_KAB250_x1" , "6000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "PylonBayRight2" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ]
						
					]
				] 
			],
			[
				[ "PylonBayCenter1" ,
					[
						[ "PylonMissile_Missile_AA_R77_INT_x1" , "4000" ]

					]
				]
			],		
			[
				[ "PylonBayCenter3" ,
					[
						["PylonMissile_Missile_AA_R77_INT_x1" , "4000" ],
						["PylonMissile_Missile_AGM_KH25_INT_x1" , "6000" ],
						["PylonMissile_Bomb_KAB250_x1" , "6000" ],
						["PylonMissile_Missile_KH58_INT_x1" , "10000" ],
						["PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "PylonBayCenter2" ,
					[
						[ "PylonMissile_Missile_AA_R77_INT_x1" , "4000" ]
					]
				]
			],
			[
				[ "PylonBayLeft2" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ]
						
					]
				]
			],	
			[
				[ "PylonBayLeft1" ,
					[
						[ "PylonMissile_Missile_AA_R73_x1" , "4000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "4000" ],
						[ "PylonMissile_Missile_AA_R77_INT_x1" , "4000" ],
						[ "PylonMissile_Missile_AGM_KH25_INT_x1" , "5000" ],
						[ "PylonMissile_Bomb_KAB250_x1" , "6000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
						
					]
				]
			]
		]
	]
];


// ***************************
// Plane - To-201
// ***************************
CTI_LOADOUT_O_Plane_Fighter_02_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration",
		"pylon",
		[
			[
				[ "weapon_Fighter_Gun_30mm" ,
					[
						[ "magazine_Fighter02_Gun30mm_AA_x180" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "Pylons1" ,
					[
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons2" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ]
						
					]
				] 
			],
			[
				[ "Pylons3" ,
					[
						[ "PylonMissile_Bomb_KAB250_x1" , "6000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_Missile_AGM_KH25_x1" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],		
			[
				[ "PylonBayRight1" ,
					[
						["PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayRight2" ,
					[
						["PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayCenter1" ,
					[
						["PylonMissile_Missile_AA_R77_INT_x1" , "5000" ]
						
					]
				]
			],	
			[
				[ "PylonBayCenter3" ,
					[
						[ "PylonMissile_Bomb_KAB250_x1" , "6000" ],
						[ "PylonMissile_Missile_AA_R77_INT_x1" , "5000" ],
						[ "PylonMissile_Missile_AGM_KH25_INT_x1" , "5000" ],
						["PylonMissile_Missile_KH58_INT_x1" , "10000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "PylonBayCenter2" ,
					[
						["PylonMissile_Missile_AA_R77_INT_x1" , "5000" ]
					]
				]
			],		
			[
				[ "PylonBayLeft2" ,
					[
						["PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayLeft1" ,
					[
						["PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons4" ,
					[
						[ "PylonMissile_Bomb_KAB250_x1" , "6000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_Missile_AGM_KH25_x1" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "Pylons5" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						["PylonMissile_Missile_KH58_INT_x1" , "10000" ]
					]
				]
			],
			[
				[ "Pylons6" ,
					[
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						["PylonMissile_Missile_KH58_INT_x1" , "10000" ]
						
					]
				]
			],	
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
						
					]
				]
			]
		]
	],
	[
		"Air Supremacy - Maddog",
		"pylon",
		[
			[
				[ "weapon_Fighter_Gun_30mm" ,
					[
						[ "magazine_Fighter02_Gun30mm_AA_x180" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "Pylons1" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons2" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ]
						
					]
				] 
			],
			[
				[ "Pylons3" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],		
			[
				[ "PylonBayRight1" ,
					[
						["PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayRight2" ,
					[
						["PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayCenter1" ,
					[
						["PylonMissile_Missile_AA_R77_INT_x1" , "5000" ]
						
					]
				]
			],	
			[
				[ "PylonBayCenter3" ,
					[
						[ "PylonMissile_Missile_AA_R77_INT_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayCenter2" ,
					[
						["PylonMissile_Missile_AA_R77_INT_x1" , "5000" ]
					]
				]
			],		
			[
				[ "PylonBayLeft2" ,
					[
						["PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayLeft1" ,
					[
						["PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons4" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons5" ,
					[
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons6" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],	
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
						
					]
				]
			]
		]
	],
	[
		"Ground Supremacy",
		"pylon",
		[
			[
				[ "weapon_Fighter_Gun_30mm" ,
					[
						[ "magazine_Fighter02_Gun30mm_AA_x180" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "Pylons1" ,
					[
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons2" ,
					[
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ]
						
					]
				] 
			],
			[
				[ "Pylons3" ,
					[
						[ "PylonMissile_Missile_AGM_KH25_x1" , "5000" ],
						[ "PylonMissile_Bomb_KAB250_x1" , "6000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],		
			[
				[ "PylonBayRight1" ,
					[
						["PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayRight2" ,
					[
						["PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayCenter1" ,
					[
						["PylonMissile_Missile_AA_R77_INT_x1" , "5000" ]
						
					]
				]
			],	
			[
				[ "PylonBayCenter3" ,
					[
						["PylonMissile_Missile_KH58_INT_x1" , "10000" ],
						[ "PylonMissile_Bomb_KAB250_x1" , "6000" ],
						[ "PylonMissile_Missile_AA_R77_INT_x1" , "5000" ],
						[ "PylonMissile_Missile_AGM_KH25_INT_x1" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "PylonBayCenter2" ,
					[
						["PylonMissile_Missile_AA_R77_INT_x1" , "5000" ]
					]
				]
			],		
			[
				[ "PylonBayLeft2" ,
					[
						["PylonMissile_Missile_AA_R77_x1" , "5000" ]
					]
				]
			],
			[
				[ "PylonBayLeft1" ,
					[
						["PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons4" ,
					[
						[ "PylonMissile_Missile_AGM_KH25_x1" , "5000" ],
						[ "PylonMissile_Bomb_KAB250_x1" , "6000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "Pylons5" ,
					[
						["PylonMissile_Missile_KH58_INT_x1" , "10000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons6" ,
					[
						["PylonMissile_Missile_KH58_INT_x1" , "10000" ],
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ],
						[ "PylonMissile_Missile_AA_R77_x1" , "5000" ]					
					]
				]
			],	
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
						
					]
				]
			]
		]
	]
];

// ***************************
// VTOL - Y-32 
// ***************************
CTI_LOADOUT_O_T_VTOL_02_infantry_dynamicLoadout_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[
				[ "gatling_30mm" ,
					[
						[ "250Rnd_30mm_APDS_shells" , "500" , [0]]
					]
				]
			],
			[
				[ "gatling_30mm" ,
					[
						[ "250Rnd_30mm_HE_shells" , "750" , [0]]
					]
				]
			],
			[
				[ "PylonLeft1" ,
					[
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [-1]],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [-1]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [-1]],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" , [-1]]
					]
				]
			],
			[
				[ "PylonLeft2" ,
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonRack_4Rnd_LG_scalpel" , "20000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [-1]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [-1]],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [-1]],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" , [-1]]
					]
				] 
			],
			[
				[ "PylonRight2" ,
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonRack_4Rnd_LG_scalpel" , "20000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [-1]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [-1]],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [-1]],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" , [-1]]
					]
				]
			],
			[
				[ "PylonRight1" ,
					[
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [-1]],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [-1]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [-1]],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" , [-1]]
					]
				]
			],
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
						
					]
				]
			]
		]
	]
];
CTI_LOADOUT_O_T_VTOL_02_vehicle_dynamicLoadout_F_MNT_OPTIONS = CTI_LOADOUT_O_T_VTOL_02_infantry_dynamicLoadout_F_MNT_OPTIONS;


// ***************************
// UAV - MQ-4A Greyhawk AA Version
// ***************************
CTI_LOADOUT_O_UAV_02_F_MNT_OPTIONS =
[
	[
		"AA - Configurations" ,
		"default",
		[
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[
				["Missile_AA_04_Plane_CAS_01_F" ,
					[
						[ "2Rnd_Missile_AA_04_F" , "8000"]
					]
				],
				["Missile_AA_03_Plane_CAS_02_F" ,
					[
						[ "2Rnd_Missile_AA_03_F" , "8000"]
					] 
				],				
				["missiles_ASRAAM" ,
					[
						[ "2Rnd_AAA_missiles" , "8000"]
					] 
				]

			],
			[
				["CMFlareLauncher" ,
					[
					[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]],
					[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
					[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]],
					[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]]
					]
				]
			]
		]
	]
];

// ***************************
// UAV - MQ-4A Greyhawk Bomb Version
// ***************************
CTI_LOADOUT_O_UAV_02_CAS_F_MNT_OPTIONS =
[
	[
		"Bomb - Configurations" ,
		"default",
		[
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[
				["GBU12BombLauncher" ,
					[
						[ "2Rnd_GBU12_LGB" , "4000" , [0]]
					]
				],
				["Mk82BombLauncher" ,
					[
						[ "2Rnd_Mk82" , "3000" ,[0]]
					] 
				]

			],
			[
				["CMFlareLauncher" ,
					[
					[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]],
					[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
					[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]],
					[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]]
					]
				]
			]
		]
	]
];
// ***************************
// Plane - UAV Dynamic AT
// ***************************
CTI_LOADOUT_O_UAV_02_dynamicLoadout_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[	
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[ 	
				["Pylons1",
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [-1]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [-1]],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [-1]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [0]]
					]
				]
			],
			[ 	
				["Pylons2",
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [-1]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [-1]],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [-1]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [-1]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [0]]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
					[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]],
					[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
					[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]],
					[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]]
					]
				]
			]
		]
	]
];


// ***************************
// Heli - Kajman ( Camo )
// ***************************
CTI_LOADOUT_O_Heli_Attack_02_dynamicLoadout_F_MNT_OPTIONS =
[	
	[
		"Pylon - configuration" ,
		"pylon",
		[
			[
				[ "gatling_30mm" ,
					[
						[ "250Rnd_30mm_APDS_shells" , "500", [0]]
					]
				]
			],
			[
				[ "gatling_30mm" ,
					[
						[ "250Rnd_30mm_HE_shells" , "750" , [0]]
					]
				]
			],
			[
				[ "PylonLeft1" ,
					[
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [0]],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_02_F" , "1000" , [0]]
					]
				]
			],
			[
				[ "PylonLeft2" ,
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_4Rnd_LG_scalpel" , "20000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [0]],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_02_F" , "1000" , [0]]
					]
				] 
			],
			[
				[ "PylonRight2" ,
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						[ "PylonRack_4Rnd_LG_scalpel" , "20000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [0]],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_02_F" , "1000" , [0]]
					]
				]
			],
			[
				[ "PylonRight1" ,
					[
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" , [0]],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" , [0]],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" , [0]],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" , [0]],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" , [0]],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" , [0]],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" , [0]],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" , [0]],
						[ "PylonMissile_1Rnd_BombCluster_02_F" , "1000" , [0]]
					]
				]
			],
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1]],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]],
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1]],
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1]]	
					]
				]
			]
		]
	]
];
//Setting same loadout for both variants
CTI_LOADOUT_O_Heli_Attack_02_dynamicLoadout_black_F_MNT_OPTIONS = CTI_LOADOUT_O_Heli_Attack_02_dynamicLoadout_F_MNT_OPTIONS;
// ***************************
// Plane - NEO
// ***************************
CTI_LOADOUT_O_Plane_CAS_02_dynamicLoadout_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration" ,
		"pylon",
		[
			[
				[ "Cannon_30mm_Plane_CAS_02_F" ,
					[
						[ "500Rnd_Cannon_30mm_Plane_CAS_02_F" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "Pylons1" ,
					[
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ]
					]
				]
			],
			[
				[ "Pylons2" ,
					[
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ]
						
					]
				] 
			],
			[
				[ "Pylons3" ,
					[
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]

					]
				]
			],
			[
				[ "Pylons4" ,
					[
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "Pylons5" ,
					[
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_4Rnd_LG_scalpel" , "20000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "Pylons6" ,
					[
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_4Rnd_LG_scalpel" , "20000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],			
			[
				[ "Pylons7" ,
					[
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "Pylons8" ,
					[
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_cap_F" , "1000" ]
					]
				]
			],
			[
				[ "Pylons9" ,
					[
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "20000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ]
					]
				]
			],
			[
				[ "Pylons10" ,
					[
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ]
						
					]
				]
			],			
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ] 
					]
				]
			]
		]
	]
];



// ***************************
// Resistance - Vehicle loadout options
// ***************************

// ***************************
// Helicopter - Mohawk
// ***************************

CTI_LOADOUT_I_Heli_Transport_02_F_MNT_OPTIONS = CTI_LOADOUT_UNARMED_FLARES;

// ***************************
// Helicopter - Hellcat ( unarmed )
// ***************************

CTI_LOADOUT_I_Heli_light_03_unarmed_F_MNT_OPTIONS = CTI_LOADOUT_UNARMED_FLARES;

// ***************************
// Helicopter - Hellcat (armed) TODO
// ***************************
/*
I_Heli_light_03_F = 
[
	[
		"Pylon - configuration" ,
		"pylon",
		[
		]
	]
];
*/
// ***************************
// Helicopter - Hellcat ( armed - dynmaic)
// ***************************
CTI_LOADOUT_I_Heli_light_03_dynamicLoadout_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration" ,
		"pylon",
		[
			[
				[ "M134_minigun" ,
					[
						[ "5000Rnd_762x51_Yellow_Belt" , "500" ]
					]
				]
			],			
			[
				[ "Laserdesignator_mounted" ,
					[
						[ "Laserbatteries" , "500" , [0]]
					]
				]
			],
			[
				["PylonLeft1" ,
					[
						[ "PylonRack_12Rnd_missiles" , "2000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_4Rnd_LG_scalpel" , "20000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" ],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonWeapon_300Rnd_20mm_shells" , "3000"]
					]
				]
			] ,
			[
				["PylonRight1" ,
					[
						[ "PylonRack_12Rnd_missiles" , "2000"],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000"],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000"],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000"],
						[ "PylonRack_4Rnd_LG_scalpel" , "20000"],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000"],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000"],
						[ "PylonRack_12Rnd_PG_missiles" , "8000"],
						[ "PylonWeapon_300Rnd_20mm_shells" , "3000"]
					]
				]
			] ,
			[
				[ "CMFlareLauncher" ,
					[
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
					]
				]
			]
		]
	]
];

// ***************************
// Helicopter - Hellcat ( unarmed )
// ***************************
CTI_LOADOUT_I_Heli_light_03_unarmed_F_MNT_OPTIONS = CTI_LOADOUT_UNARMED_FLARES;

// ***************************
// Plane - Buzzard (CAS) TODO
// ***************************
/*
CTI_LOADOUT_I_Plane_Fighter_03_CAS_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration" ,
		"pylon",
		[
		]
	]
];
*/
// ***************************
// Plane - Buzzard (AA)
// ***************************

CTI_LOADOUT_I_Plane_Fighter_03_AA_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration" ,
		"pylon",
		[
			[
				[ "Cannon_30mm_Plane_CAS_02_F" ,
					[
						[ "500Rnd_Cannon_30mm_Plane_CAS_02_F" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "missiles_Zephyr" ,
					[
						[ "4Rnd_GAA_missiles" , "16000" ]
					]
				]
			],
			[
				[ "missiles_ASRAAM" ,
					[
						[ "2Rnd_AAA_missiles_MI06" , "8000" ]
					]
				] 
			],
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
						
					]
				]
			]
		]
	]
];

// ***************************
// Plane - Buzzard (Cas)
// ***************************

CTI_LOADOUT_I_Plane_Fighter_03_CAS_F_MNT_OPTIONS =
[
	[
		"Standart - configuration" ,
		"default",
		[
			[
				[ "Cannon_30mm_Plane_CAS_02_F" ,
					[
						[ "500Rnd_Cannon_30mm_Plane_CAS_02_F" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "missiles_SCALPEL" ,
					[
						[ "2Rnd_LG_scalpel" , "10000" ]
					]
				]
			],
			[
				[ "missiles_ASRAAM" ,
					[
						[ "2Rnd_AAA_missiles_MI06" , "8000" ]
					]
				] 
			],	
			[
				[ "GBU12BombLauncher_Plane_Fighter_03_F" ,
					[
						[ "2Rnd_GBU12_LGB_MI10" , "10000" ]
					]
				] 
			],
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
					]
				]
			]
		]
	]
];

// ***************************
// Plane - Buzzard (Dynamic) 
// ***************************
CTI_LOADOUT_I_Plane_Fighter_03_dynamicLoadout_F_MNT_OPTIONS =
[
	[
		"Standart - configuration" ,
		"default",
		[
			[
				[ "Cannon_30mm_Plane_CAS_02_F" ,
					[
						[ "500Rnd_Cannon_30mm_Plane_CAS_02_F" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "Pylons1" ,
					[
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_GAA_missiles" , "4000" ],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" ],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000" ],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" ],
						[ "PylonRack_12Rnd_missiles" , "2000" ]
					]
				]
			],
			[
				[ "Pylons2" ,
					[
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_GAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" ],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000" ],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" ],
						[ "PylonRack_12Rnd_missiles" , "2000" ]
					]
				] 
			],
			[
				[ "Pylons3" ,
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000" ],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_GAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000" ],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" ],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000" ],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" ],
						[ "PylonRack_12Rnd_missiles" , "2000" ],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000" ],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" ],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" ]
					]
				]
			],
			[
				[ "Pylons4" ,
					[
						[ "PylonWeapon_300Rnd_20mm_shells" , "1000" ]
					]
				]
			],
			[
				[ "Pylons5" ,
					[
						[ "PylonMissile_1Rnd_Bomb_04_F" , "5000" ],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_GAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_02_F" , "5000" ],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" ],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000" ],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" ],
						[ "PylonRack_12Rnd_missiles" , "2000" ],
						[ "PylonMissile_1Rnd_Mk82_F" , "1000" ],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" ],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" ]
					]
				]
			],
			[
				[ "Pylons6" ,
					[
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_GAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" ],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000" ],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" ],
						[ "PylonRack_12Rnd_missiles" , "2000" ]
					]
				]
			],			
			[
				[ "Pylons7" ,
					[
						[ "PylonRack_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_1Rnd_Missile_AA_04_F" , "4000" ],
						[ "PylonRack_1Rnd_AAA_missiles" , "4000" ],
						[ "PylonRack_1Rnd_GAA_missiles" , "4000" ],
						[ "PylonRack_7Rnd_Rocket_04_HE_F" , "1000" ],
						[ "PylonRack_7Rnd_Rocket_04_AP_F" , "1000" ],
						[ "PylonRack_12Rnd_PG_missiles" , "8000" ],
						[ "PylonRack_12Rnd_missiles" , "2000" ]
					]
				]
			],		
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
						
					]
				]
			]
		]
	]
];

// ***************************
// Plane - A-149 Gryphon (Dynamic) 
// ***************************
CTI_LOADOUT_I_Plane_Fighter_04_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration" ,
		"pylon",
		[
			[
				[ "Cannon_30mm_Plane_CAS_02_F" ,
					[
						[ "500Rnd_Cannon_30mm_Plane_CAS_02_F" , "1000" ]
					]
				]
			],
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[
				[ "Pylon1" ,
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000" ],
						[ "PylonRack_Missile_AMRAAM_C_x1" , "4000" ]
						
					]
				]
			],
			[
				[ "Pylon2" ,
					[
						[ "PylonMissile_Missile_BIM9X_x1" , "4000" ],
						[ "PylonRack_Missile_AMRAAM_C_x1" , "4000" ]
					]
				] 
			],
			[
				[ "Pylon3" ,
					[
						[ "PylonRack_Missile_AGM_02_x1" , "5000" ],
						[ "PylonRack_Missile_AMRAAM_C_x1" , "4000" ],
						[ "PylonMissile_Missile_BIM9X_x1" , "4000" ]
						


					]
				]
			],
			[
				[ "Pylon4" ,
					[
						[ "PylonRack_Missile_AGM_02_x1" , "5000" ],
						[ "PylonRack_Missile_AMRAAM_C_x1" , "4000" ],
						[ "PylonMissile_Missile_BIM9X_x1" , "4000" ]
					]
				]
			],
			[
				[ "Pylon5" ,
					[
						[ "PylonRack_Missile_AMRAAM_C_x1" , "4000" ],
						[ "PylonRack_Missile_AMRAAM_C_x2" , "4000" ],
						[ "PylonRack_Missile_BIM9X_x1" , "4000" ],
						[ "PylonRack_Missile_BIM9X_x2" , "4000" ],
						[ "PylonRack_Missile_AGM_02_x1" , "5000" ],
						[ "PylonRack_Missile_AGM_02_x2" , "10000" ],
						[ "PylonMissile_Bomb_GBU12_x1" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" ],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" ]

					]
				]
			],
			[
				[ "Pylon6" ,
					[
						[ "PylonRack_Missile_AMRAAM_C_x1" , "4000" ],
						[ "PylonRack_Missile_AMRAAM_C_x2" , "4000" ],
						[ "PylonRack_Missile_BIM9X_x1" , "4000" ],
						[ "PylonRack_Missile_BIM9X_x2" , "4000" ],
						[ "PylonRack_Missile_AGM_02_x1" , "5000" ],
						[ "PylonRack_Missile_AGM_02_x2" , "10000" ],
						[ "PylonMissile_Bomb_GBU12_x1" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_01_F" , "1000" ],
						[ "PylonMissile_1Rnd_BombCluster_03_F" , "1000" ]
					]
				]
			],				
			[
				[ "CMFlareLauncher" ,
					[
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ],
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ]
					]
				]
			]
		]
	]
];

// ***************************
// Plane - A-149 Gryphon (Cluster) TODO
// ***************************
/*
CTI_LOADOUT_I_Plane_Fighter_04_Cluster_F_MNT_OPTIONS =
[
	[
		"Pylon - configuration" ,
		"pylon",
		[
		]
	]
];
*/

// ***************************
// Plane - UAV (AA) (Copyies opfor loadout)
// ***************************
CTI_LOADOUT_I_UAV_02_F_MNT_OPTIONS = CTI_LOADOUT_O_UAV_02_F_MNT_OPTIONS;

// ***************************
// Plane - UAV (Bomb) TODO
// ***************************

CTI_LOADOUT_I_UAV_02_CAS_F_MNT_OPTIONS = CTI_LOADOUT_O_UAV_02_CAS_F_MNT_OPTIONS;

// ***************************
// Plane - UAV (AT) TODO
// ***************************

CTI_LOADOUT_I_UAV_02_dynamicLoadout_F_MNT_OPTIONS = CTI_LOADOUT_O_UAV_02_dynamicLoadout_F_MNT_OPTIONS;



// *******************************
// Research mapping
// *******************************

CTI_ALM_AA_RESEARCHED_MAGAZINES =
[
	"2Rnd_AAA_missiles" ,
	"2Rnd_AAA_missiles_MI02" ,
	"4Rnd_AAA_missiles" ,
	"4Rnd_AAA_missiles_MI02" ,
	"PylonRack_1Rnd_AAA_missiles" ,
	"PylonMissile_1Rnd_AAA_missiles" ,
	"4Rnd_GAA_missiles" ,
	"PylonRack_1Rnd_GAA_missiles" ,
	"PylonMissile_1Rnd_GAA_missiles" ,
	"1Rnd_GAA_missiles" ,
	"2Rnd_Missile_AA_04_F" ,
	"PylonRack_1Rnd_Missile_AA_04_F" ,
	"PylonMissile_1Rnd_Missile_AA_04_F" ,
	"2Rnd_Missile_AA_03_F" ,
	"PylonRack_1Rnd_Missile_AA_03_F" ,
	"PylonMissile_1Rnd_Missile_AA_03_F" ,
	"magazine_Missile_BIM9X_x1" ,
	"PylonMissile_Missile_BIM9X_x1" , 
	"PylonRack_Missile_BIM9X_x1" ,
	"PylonRack_Missile_BIM9X_x2" ,
	"magazine_Missile_AMRAAM_D_x1" ,
	"PylonMissile_Missile_AMRAAM_D_x1" ,
	"PylonMissile_Missile_AMRAAM_D_INT_x1" ,
	"PylonRack_Missile_AMRAAM_D_x1" ,
	"PylonRack_Missile_AMRAAM_D_x2" ,
	"magazine_Missile_AA_R73_x1" ,
	"PylonMissile_Missile_AA_R73_x1" ,
	"magazine_Missile_AA_R77_x1" ,
	"PylonMissile_Missile_AA_R77_x1" ,
	"PylonMissile_Missile_AA_R77_INT_x1"
];

CTI_ALM_ATGM_RESEARCHED_MAGAZINES =
[
	"24Rnd_PG_missiles" ,
	"12Rnd_PG_missiles" ,
	"PylonRack_12Rnd_PG_missiles" ,
	"2Rnd_LG_scalpel" ,
	"8Rnd_LG_scalpel" ,
	"6Rnd_LG_scalpel" ,
	"PylonRack_1Rnd_LG_scalpel" ,
	"PylonMissile_1Rnd_LG_scalpel" ,
	"PylonRack_3Rnd_LG_scalpel" ,
	"PylonRack_4Rnd_LG_scalpel" ,
	"2Rnd_GAT_missiles" ,
	"5Rnd_GAT_missiles" ,
	"4Rnd_Titan_long_missiles" ,
	"1Rnd_GAT_missiles" ,
	"6Rnd_Missile_AGM_02_F" ,
	"PylonRack_1Rnd_Missile_AGM_02_F" ,
	"PylonRack_3Rnd_Missile_AGM_02_F" ,
	"4Rnd_Missile_AGM_01_F" ,
	"PylonRack_1Rnd_Missile_AGM_01_F" ,
	"4Rnd_LG_Jian" ,
	"PylonRack_1Rnd_Missile_Jian" ,
	"magazine_Missile_AGM_02_x1" ,
	"PylonMissile_Missile_AGM_02_x1" ,
	"PylonMissile_Missile_AGM_02_x2" ,
	"PylonRack_Missile_AGM_02_x1" ,
	"PylonRack_Missile_AGM_02_x2" ,
	"PylonMissile_Missile_AGM_KH25_x1"
];

CTI_ALM_FFAR_RESEARCHED_MAGAZINES =
[
	"14Rnd_80mm_rockets" ,
	"38Rnd_80mm_rockets" ,
	"PylonRack_19Rnd_Rocket_Skyfire" ,
	"7Rnd_Rocket_04_HE_F" ,
	"PylonRack_7Rnd_Rocket_04_HE_F" ,
	"7Rnd_Rocket_04_AP_F" ,
	"PylonRack_7Rnd_Rocket_04_AP_F" ,
	"20Rnd_Rocket_03_HE_F" ,
	"PylonRack_20Rnd_Rocket_03_HE_F" ,
	"20Rnd_Rocket_03_AP_F" ,
	"PylonRack_20Rnd_Rocket_03_AP_F" ,
	"24Rnd_missiles" ,
	"12Rnd_missiles" ,
	"PylonRack_12Rnd_missiles"
];

CTI_ALM_CM_RESEARCHED_MAGAZINES =
[
	"60Rnd_CMFlareMagazine" ,
	"120Rnd_CMFlareMagazine" ,
	"240Rnd_CMFlareMagazine" ,
	"60Rnd_CMFlare_Chaff_Magazine" ,
	"120Rnd_CMFlare_Chaff_Magazine" ,
	"240Rnd_CMFlare_Chaff_Magazine" ,
	"192Rnd_CMFlare_Chaff_Magazine" ,
	"168Rnd_CMFlare_Chaff_Magazine" ,
	"300Rnd_CMFlare_Chaff_Magazine"
];

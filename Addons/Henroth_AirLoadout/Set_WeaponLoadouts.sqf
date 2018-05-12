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
			
			
Get Ammo for pylon:
	"O_Plane_Fighter_02_F" getCompatiblePylonMagazines "pylons1"
Get Pylons:
	configProperties [configFile >> "CfgVehicles" >> typeOf (vehicle player) >> "Components" >> "TransportPylonsComponent" >> "Pylons"]
	
	configProperties [configFile >> "CfgVehicles" >> "O_Plane_Fighter_02_F" >> "Components" >> "TransportPylonsComponent" >> "Pylons"]
*/

//O_T_UAV_04_CAS_F
//O_Heli_Light_02_dynamicLoadout_F
//	O_Plane_Fighter_02_Stealth_F

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
						[ "PylonMissile_Missile_AA_R73_x1" , "5000" ]
					]
				]
			],
			[
				[ "Pylons6" ,
					[
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
		"Standard - configuration" ,
		"default",
		[
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[ 	
				["gatling_30mm_VTOL_02",
					[
						[ "250Rnd_30mm_HE_shells_Tracer_Green" , "750" ]
					]
				]
			],
			[
				["gatling_30mm_VTOL_02",
					[
						[ "250Rnd_30mm_APDS_shells_Tracer_Green" , "750" ]
					]
				]
			],
			[
				[ "missiles_SCALPEL" ,
					[
						[ "8Rnd_LG_scalpel" , "40000" ]
					]
				]
			],
			[
				[ "rockets_Skyfire" ,
					[
						[ "38Rnd_80mm_rockets" , "8000" ]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ]
					]
				]
			]
		]
	],
	[
		"Pylon - configuration" ,
		"pylon",
		[
			[
				[ "gatling_30mm" ,
					[
						[ "250Rnd_30mm_APDS_shells" , "500" ]
					]
				]
			],
			[
				[ "gatling_30mm" ,
					[
						[ "250Rnd_30mm_HE_shells" , "750" ]
					]
				]
			],
			[
				[ "PylonLeft1" ,
					[
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
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
				[ "PylonLeft2" ,
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_4Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
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
				[ "PylonRight2" ,
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_4Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
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
				[ "PylonRight1" ,
					[
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "15000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
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
				[ "CMFlareLauncher" ,
					[
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ]
					]
				]
			]
		]
	]
];
CTI_LOADOUT_O_T_VTOL_02_vehicle_dynamicLoadout_F_MNT_OPTIONS = CTI_LOADOUT_O_T_VTOL_02_infantry_dynamicLoadout_F_MNT_OPTIONS;

// ***************************
// Plane - UAV
// ***************************
CTI_LOADOUT_O_UAV_02_dynamicLoadout_F_MNT_OPTIONS =
[	
	[
		"Standart - configuration" ,
		"default",
		[	
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[ 	
				["missiles_SCALPEL",
					[
						[ "6Rnd_LG_scalpel" , "20000" ] //10k cheaper to prevent money exploit
					]
				],
				["GBU12BombLauncher",
					[
						[ "2Rnd_GBU12_LGB" , "6000" ]
					]
				],
				["Mk82BombLauncher",
					[
						[ "2Rnd_Mk82" , "1000" ]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
					[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ] ,
					[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
					[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
					[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ]
					]
				]
			]
		]
	],
	[
		"Pylon - configuration" ,
		"pylon",
		[	
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			],
			[ 	
				["Pylons1",
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ]
					]
				]
			],
			[ 	
				["Pylons2",
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
					[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ] ,
					[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
					[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
					[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ]
					]
				]
			]
		]
	]
];


// ***************************
// Heli - Kajman ( Camo )
// ***************************
//PylonLeft1, PylonLeft2, PylonRight2 PylonRight1
/* Same for all pylones
["PylonMissile_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonWeapon_300Rnd_20mm_shells","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonMissile_1Rnd_Bomb_03_F","PylonMissile_1Rnd_BombCluster_02_F"]

*/
CTI_LOADOUT_O_Heli_Attack_02_dynamicLoadout_F_MNT_OPTIONS =
[	
	[
		"Standard - configuration" ,
		"default",
		[
			[ 	
				["gatling_30mm",
					[
						[ "250Rnd_30mm_APDS_shells" , "500" ]
					]
				]
			],
			[
				["gatling_30mm",
					[
						[ "250Rnd_30mm_HE_shells" , "750" ]
					]
				]
			],
			[
				[ "missiles_SCALPEL" ,
					[
						[ "8Rnd_LG_scalpel" , "20000" ]
					]
				]
			],
			[
				[ "rockets_Skyfire" ,
					[
						[ "38Rnd_80mm_rockets" , "4000" ]
					]
				]
			],
			[
				["CMFlareLauncher" ,
					[
						[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
					]
				]
			]
		]
	],
	[
		"Pylon - configuration" ,
		"pylon",
		[
			[
				[ "gatling_30mm" ,
					[
						[ "250Rnd_30mm_APDS_shells" , "500" ]
					]
				]
			],
			[
				[ "gatling_30mm" ,
					[
						[ "250Rnd_30mm_HE_shells" , "750" ]
					]
				]
			],
			[
				[ "PylonLeft1" ,
					[
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "15000" ],
						[ "PylonWeapon_300Rnd_20mm_shells" , "2000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_F" , "1000" ]
					]
				]
			],
			[
				[ "PylonLeft2" ,
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_4Rnd_LG_scalpel" , "15000" ],
						[ "PylonWeapon_300Rnd_20mm_shells" , "2000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_F" , "1000" ]
					]
				] 
			],
			[
				[ "PylonRight2" ,
					[
						[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						[ "PylonRack_4Rnd_LG_scalpel" , "15000" ],
						[ "PylonWeapon_300Rnd_20mm_shells" , "2000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_F" , "1000" ]
					]
				]
			],
			[
				[ "PylonRight1" ,
					[
						//[ "PylonRack_3Rnd_LG_scalpel" , "15000" ],
						[ "PylonMissile_1Rnd_LG_scalpel" , "5000" ],
						//[ "PylonRack_4Rnd_LG_scalpel" , "15000" ],
						[ "PylonWeapon_300Rnd_20mm_shells" , "2000" ],
						[ "PylonRack_20Rnd_Rocket_03_HE_F" , "3000" ],
						[ "PylonRack_20Rnd_Rocket_03_AP_F" , "3000" ],
						[ "PylonRack_19Rnd_Rocket_Skyfire" , "3000" ],
						[ "PylonRack_1Rnd_Missile_AA_03_F" , "4000" ],
						[ "PylonRack_1Rnd_Missile_AGM_01_F" , "6000" ],
						[ "PylonMissile_1Rnd_Bomb_03_F" , "5000" ],
						[ "PylonMissile_1Rnd_BombCluster_02_F" , "1000" ]
					]
				]
			],
			[
				[ "CMFlareLauncher" ,
					[
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ]
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
/*
Pylons1: ["PylonMissile_1Rnd_LG_scalpel","PylonRack_1Rnd_Missile_AA_03_F"]
Pylons2: ["PylonMissile_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AGM_01_F"]
Pylons3: ["PylonMissile_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonMissile_1Rnd_Bomb_03_F","PylonMissile_1Rnd_BombCluster_02_cap_F"]
Pylons4: ["PylonMissile_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonMissile_1Rnd_Bomb_03_F","PylonMissile_1Rnd_BombCluster_02_cap_F"]
Pylons5: ["PylonMissile_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonMissile_1Rnd_Bomb_03_F","PylonMissile_1Rnd_BombCluster_02_cap_F"]


*/
CTI_LOADOUT_O_Plane_CAS_02_dynamicLoadout_F_MNT_OPTIONS =
[
	[
		"Standard - configuration" ,
		"default",
		[
			[
				[ "Laserdesignator_pilotCamera" ,
					[
						[ "Laserbatteries" , "500" ]
					]
				]
			] ,
			[
				[ "Cannon_30mm_Plane_CAS_02_F" ,
					[
						[ "500Rnd_Cannon_30mm_Plane_CAS_02_F" , "1000" ]
					]
				]
			] ,
			[
				[ "Missile_AA_03_Plane_CAS_02_F" ,
					[
						[ "2Rnd_Missile_AA_03_F" , "4000" ]
					]
				]
			] ,
			[
				[ "Missile_AGM_01_Plane_CAS_02_F" ,
					[
						[ "4Rnd_Missile_AGM_01_F" , "20000" ]
					]
				]
			] ,
			[
				[ "Bomb_03_Plane_CAS_02_F" ,
					[
						[ "2Rnd_Bomb_03_F" , "4000" ]
					]
				]
			] ,
			[
				[ "Rocket_03_HE_Plane_CAS_02_F" ,
					[
						[ "20Rnd_Rocket_03_HE_F" , "3000" ]
					]
				]
			] ,
			[
				[ "Rocket_03_AP_Plane_CAS_02_F" ,
					[
						[ "20Rnd_Rocket_03_AP_F" , "3000" ]
					]
				]
			] ,
			[
				[ "CMFlareLauncher" ,
					[
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ]
					]
				]
			]
		]
	], 
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
						[ "PylonRack_3Rnd_LG_scalpel" , "1500" ],
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
						[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
						[ "168Rnd_CMFlare_Chaff_Magazine" , "3000" , [-1] ] ,
						[ "192Rnd_CMFlare_Chaff_Magazine" , "4000" , [-1] ] ,
						[ "240Rnd_CMFlare_Chaff_Magazine" , "5000" , [-1] ]
					]
				]
			]
		]
	]
];


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

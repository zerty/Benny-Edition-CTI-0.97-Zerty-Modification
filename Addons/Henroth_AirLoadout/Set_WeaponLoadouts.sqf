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
 *
*/

// ***************************
// BLUFOR - Vehicle loadout options
// ***************************


// ***************************
// Plane - Wipeout
// ***************************
CTI_LOADOUT_B_Plane_CAS_01_F_MNT_OPTIONS =
[
	"Standard - Configuration" ,
	[
		[
			"Gatling_30mm_Plane_CAS_01_F" ,
			[
				[ "1000Rnd_Gatling_30mm_Plane_CAS_01_F" , "2000" ]
			] ,
			"gatling_25mm" ,
			[
				[ "1000Rnd_25mm_shells" , "1500" ] ,
				[ "300Rnd_25mm_shells" , "500" ]
			]
		],
		[
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			]
		] ,
		[
			"Missile_AGM_02_Plane_CAS_01_F" ,
			[
				[ "6Rnd_Missile_AGM_02_F" , "30000" ]
			]
		] ,
		[ "Bomb_04_Plane_CAS_01_F" ,
			[
				[ "4Rnd_Bomb_04_F" , "6000" ]
			]
		],
		[
			"Rocket_04_HE_Plane_CAS_01_F" ,
			[
				[ "7Rnd_Rocket_04_HE_F" , "2500" ]
			]
		] ,
		[
			"Rocket_04_AP_Plane_CAS_01_F" ,
			[
				[ "7Rnd_Rocket_04_AP_F" , "2500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1]] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	],
	"Air Interceptor - Mix 1" ,
	[
		[
			"Gatling_30mm_Plane_CAS_01_F" ,
			[
				[ "1000Rnd_Gatling_30mm_Plane_CAS_01_F" , "2000" ]
			] ,
			"gatling_25mm" ,
			[
				[ "1000Rnd_25mm_shells" , "1500" ] ,
				[ "300Rnd_25mm_shells" , "500" ]
			]
		],
		[
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			] ,
			"GBU12BombLauncher" ,
			[
				[ "2Rnd_GBU12_LGB" , "4000" ]
			]
		] ,
		[ "missiles_SCALPEL" ,
			[
				[ "6Rnd_LG_scalpel" , "15000" ]
			]
		] ,
		[ "missiles_Zephyr" ,
			[
				[ "4Rnd_GAA_missiles" , "8000" ]
			]
		] ,
		[ "Rocket_04_HE_Plane_CAS_01_F" ,
			[
				[ "7Rnd_Rocket_04_HE_F" , "2500" ]
			]
		] ,
		[ "Rocket_04_AP_Plane_CAS_01_F" ,
			[
				[ "7Rnd_Rocket_04_AP_F" , "2500" ]
			]
		],
		[ "CMFlareLauncher" ,
			[
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Plane - UAV (CAS)
// ***************************
CTI_LOADOUT_B_UAV_02_CAS_F_MNT_OPTIONS =
[
	"Anti Ground - Configurations" ,
	[
		[
			"Mk82BombLauncher" ,
			[
				[ "2Rnd_Mk82" , "3000" ]
			] ,
			"GBU12BombLauncher" ,
			[
				[ "2Rnd_GBU12_LGB" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	],
	"Anti Tank - Configurations" ,
	[
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	] ,
	"Anti Air - Configurations" ,
	[
		[
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			] ,
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			] ,
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	]

];



// ***************************
// Plane - UAV
// ***************************
CTI_LOADOUT_B_UAV_02_F_MNT_OPTIONS =
[
	"Universal - Configuration" ,
	[
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			],
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			]
		] ,
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			],
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			],
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			]
		] ,
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			],
			"Mk82BombLauncher" ,
			[
				[ "2Rnd_Mk82" , "3000" ]
			] ,
			"GBU12BombLauncher" ,
			[
				[ "2Rnd_GBU12_LGB" , "4000" ]
			],
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			],
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	]
];


// ***************************
// Heli - Littlebird
// ***************************

CTI_LOADOUT_B_Heli_Light_01_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];

// ***************************
// Heli - Pawnee
// ***************************

CTI_LOADOUT_B_Heli_Light_01_armed_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "M134_minigun" ,
			[
				[ "5000Rnd_762x51_Belt" , "350" ]
			]
		] ,
		[ "missiles_DAR" ,
			[
				[ "24Rnd_missiles" , "3000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Heli - Blackhawk
// ***************************
CTI_LOADOUT_B_Heli_Transport_01_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "LMG_Minigun" ,
			[
				[ "2000Rnd_65x39_Belt_Tracer_Red" , "500" , [1] ]
			]
		] ,
		[ "LMG_Minigun2" ,
			[
				[ "2000Rnd_65x39_Belt_Tracer_Red" , "500" , [2] ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Heli - Huron armed
// ***************************
CTI_LOADOUT_B_Heli_Transport_03_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "LMG_Minigun_Transport" ,
			[
				[ "2000Rnd_65x39_Belt_Tracer_Red" , "500" , [1] ]
			]
		] ,
		[ "LMG_Minigun_Transport2" ,
			[
				[ "2000Rnd_65x39_Belt_Tracer_Red" , "500" , [2] ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Heli - Huron unarmed
// ***************************
CTI_LOADOUT_B_Heli_Transport_03_unarmed_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];


// ***************************
// Heli - Blackfoot
// ***************************
CTI_LOADOUT_B_Heli_Attack_01_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "gatling_20mm" ,
			[
				[ "1000Rnd_20mm_shells" , "1000" ]
			] ,
		  "gatling_25mm" ,
			[
				[ "1000Rnd_25mm_shells" , "1500" ] ,
				[ "300Rnd_25mm_shells" , "500" ]
			]
		] ,
		[ "missiles_ASRAAM" ,
			[
				[ "4Rnd_AAA_missiles" , "8000" ] ,
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "missiles_DAGR" ,
			[
				[ "24Rnd_PG_missiles" , "20000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	]
];

// ***************************
// OPFOR ( east ) - Vehicle loadout options
// ***************************



// ***************************
// Heli - Mi-290 Taru
// ***************************

CTI_LOADOUT_O_Heli_Transport_04_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];

// ***************************
// Heli - Mi-290 Taru ammo
// ***************************

CTI_LOADOUT_O_Heli_Transport_04_ammo_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];

// ***************************
// Heli - Mi-290 Taru bench
// ***************************

CTI_LOADOUT_O_Heli_Transport_04_bench_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];

// ***************************
// Heli - Mi-290 Taru box
// ***************************

CTI_LOADOUT_O_Heli_Transport_04_box_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];

// ***************************
// Heli - Mi-290 Taru covered
// ***************************

CTI_LOADOUT_O_Heli_Transport_04_covered_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];

// ***************************
// Heli - Mi-290 Taru fuel
// ***************************

CTI_LOADOUT_O_Heli_Transport_04_fuel_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];


// ***************************
// Heli - Mi-290 Taru medevac
// ***************************

CTI_LOADOUT_O_Heli_Transport_04_medevac_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];


// ***************************
// Heli - Mi-290 Taru repair
// ***************************

CTI_LOADOUT_O_Heli_Transport_04_repair_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];


// ***************************
// Heli - Orac unarmed
// ***************************

CTI_LOADOUT_O_Heli_Light_02_unarmed_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];

// ***************************
// Heli - Orca armed
// ***************************

CTI_LOADOUT_O_Heli_Light_02_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "LMG_Minigun_heli" ,
			[
				[ "2000Rnd_65x39_Belt_Tracer_Green" , "500" ]
			]
		] ,
		[ "missiles_DAGR" ,
			[
				[ "12Rnd_PG_missiles" , "10000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];


// ***************************
// Heli - Kajman ( Camo )
// ***************************

CTI_LOADOUT_O_Heli_Attack_02_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_APDS_shells" , "500" ]
			]
		] ,
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_HE_shells" , "750" ]
			]
		] ,
		[ "missiles_SCALPEL" ,
			[
				[ "8Rnd_LG_scalpel" , "20000" ]
			]
		] ,
		[ "rockets_Skyfire" ,
			[
				[ "38Rnd_80mm_rockets" , "4000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	],
	"Custom - Hardpoint 2-6 combo" ,
	[
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_APDS_shells" , "500" ]
			]
		] ,
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_HE_shells" , "750" ]
			]
		] ,
		[ "missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			],
		  "missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			]
		] ,
		[ "missiles_SCALPEL" ,
			[
				[ "6Rnd_LG_scalpel" , "15000" ]
			]
		] ,
		[ "rockets_Skyfire" ,
			[
				[ "38Rnd_80mm_rockets" , "4000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	],
	"Custom - Hardpoint 2-2-4 combo" ,
	[
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_APDS_shells" , "500" ]
			]
		] ,
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_HE_shells" , "750" ]
			]
		] ,
		[ "missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[  "missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "missiles_ASRAAM" ,
			[
				[ "4Rnd_AAA_missiles" , "8000" ]
			]
		] ,
		[ "rockets_Skyfire" ,
			[
				[ "38Rnd_80mm_rockets" , "4000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ],
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Heli - Kajman ( Black )
// ***************************

CTI_LOADOUT_O_Heli_Attack_02_black_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_APDS_shells" , "500" ]
			]
		] ,
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_HE_shells" , "750" ]
			]
		] ,
		[ "missiles_SCALPEL" ,
			[
				[ "8Rnd_LG_scalpel" , "20000" ]
			]
		] ,
		[ "rockets_Skyfire" ,
			[
				[ "38Rnd_80mm_rockets" , "4000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	],
	"Custom - Hardpoint 2-6 combo" ,
	[
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_APDS_shells" , "500" ]
			]
		] ,
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_HE_shells" , "750" ]
			]
		] ,
		[ "missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			],
		  "missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			]
		] ,
		[ "missiles_SCALPEL" ,
			[
				[ "6Rnd_LG_scalpel" , "15000" ]
			]
		] ,
		[ "rockets_Skyfire" ,
			[
				[ "38Rnd_80mm_rockets" , "4000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	],
	"Custom - Hardpoint 2-2-4 combo" ,
	[
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_APDS_shells" , "500" ]
			]
		] ,
		[ "gatling_30mm" ,
			[
				[ "250Rnd_30mm_HE_shells" , "750" ]
			]
		] ,
		[ "missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[  "missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "missiles_ASRAAM" ,
			[
				[ "4Rnd_AAA_missiles" , "8000" ]
			]
		] ,
		[ "rockets_Skyfire" ,
			[
				[ "38Rnd_80mm_rockets" , "4000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ],
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Plane - Typhoon
// ***************************

CTI_LOADOUT_O_Plane_CAS_02_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "Cannon_30mm_Plane_CAS_02_F" ,
			[
				[ "500Rnd_Cannon_30mm_Plane_CAS_02_F" , "1000" ]
			]
		] ,
		[ "Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			]
		] ,
		[ "Missile_AGM_01_Plane_CAS_02_F" ,
			[
				[ "4Rnd_Missile_AGM_01_F" , "20000" ]
			]
		] ,
		[ "Bomb_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Bomb_03_F" , "4000" ]
			]
		] ,
		[ "Rocket_03_HE_Plane_CAS_02_F" ,
			[
				[ "20Rnd_Rocket_03_HE_F" , "3000" ]
			]
		] ,
		[ "Rocket_03_AP_Plane_CAS_02_F" ,
			[
				[ "20Rnd_Rocket_03_AP_F" , "3000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1]] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	],
	"Anti Air - Configurations" ,
	[
		[ "Cannon_30mm_Plane_CAS_02_F" ,
			[
				[ "500Rnd_Cannon_30mm_Plane_CAS_02_F" , "1000" ]
			]
		] ,
		[ "Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			]
		] ,
		[ "missiles_Zephyr" ,
			[
				[ "4Rnd_GAA_missiles" , "8000" ]
			]
		] ,
		[ "Bomb_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Bomb_03_F" , "4000" ]
			]
		] ,
		[ "Rocket_03_HE_Plane_CAS_02_F" ,
			[
				[ "20Rnd_Rocket_03_HE_F" , "3000" ]
			]
		] ,
		[ "Rocket_03_AP_Plane_CAS_02_F" ,
			[
				[ "20Rnd_Rocket_03_AP_F" , "3000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Plane - UAV (CAS)
// ***************************

CTI_LOADOUT_O_UAV_02_CAS_F_MNT_OPTIONS =
[
	"Anti Ground - Configurations" ,
	[
		[
			"Mk82BombLauncher" ,
			[
				[ "2Rnd_Mk82" , "3000" ]
			] ,
			"GBU12BombLauncher" ,
			[
				[ "2Rnd_GBU12_LGB" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	],
	"Anti Tank - Configurations" ,
	[
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]

			]
		]
	] ,
	"Anti Air - Configurations" ,
	[
		[
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			] ,
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			] ,
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	]

];

// ***************************
// Plane - UAV
// ***************************
CTI_LOADOUT_O_UAV_02_F_MNT_OPTIONS =
[
	"Universal - Configuration" ,
	[
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			],
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			],
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			]
		] ,
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			],
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			],
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			]
		] ,
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			],
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			],
			"Mk82BombLauncher" ,
			[
				[ "2Rnd_Mk82" , "3000" ]
			] ,
			"GBU12BombLauncher" ,
			[
				[ "2Rnd_GBU12_LGB" , "4000" ]
			],
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			],
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
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
CTI_LOADOUT_I_Heli_Transport_02_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "CMFlareLauncher" ,
			[
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000"  , [-1] ]
			]
		]
	]
];

// ***************************
// Helicopter - Hellcat ( armed )
// ***************************
CTI_LOADOUT_I_Heli_light_03_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "M134_minigun" ,
			[
				[ "5000Rnd_762x51_Yellow_Belt" , "500" , [-1] ]
			]
		] ,
		[ "missiles_DAR" ,
			[
				[ "24Rnd_missiles" , "3000" , [-1] ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Helicopter - Hellcat ( unarmed )
// ***************************
CTI_LOADOUT_I_Heli_light_03_unarmed_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
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
];

// ***************************
// Plane - Buzzard (CAS)
// ***************************
CTI_LOADOUT_I_Plane_Fighter_03_CAS_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "Twin_Cannon_20mm" ,
			[
				[ "300Rnd_20mm_shells" , "750" ]
			]
		] ,
		[ "missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			]
		] ,
		[ "missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "GBU12BombLauncher" ,
			[
				[ "2Rnd_GBU12_LGB_MI10" , "3000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];


// Buzzard ( AA )
CTI_LOADOUT_I_Plane_Fighter_03_AA_F_MNT_OPTIONS =
[
	"Standard - configuration" ,
	[
		[ "Twin_Cannon_20mm" ,
			[
				[ "300Rnd_20mm_shells" , "750" ]
			]
		] ,
		[ "missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "missiles_Zephyr" ,
			[
				[ "4Rnd_GAA_missiles" , "8000" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ] ,
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ]
			]
		]
	]
];

// ***************************
// Plane - UAV (CAS)
// ***************************

CTI_LOADOUT_I_UAV_02_F_MNT_OPTIONS =
[
	"Anti Tank - Configurations" ,
	[
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	] ,
	"Anti Air - Configurations" ,
	[
		[
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			] ,
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			] ,
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	] ,
	"Anti Ground - Configurations" ,
	[
		[
			"Mk82BombLauncher" ,
			[
				[ "2Rnd_Mk82" , "3000" ]
			] ,
			"GBU12BombLauncher" ,
			[
				[ "2Rnd_GBU12_LGB" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	]
];


// ***************************
// Plane - UAV (CAS)
// ***************************

CTI_LOADOUT_I_UAV_02_CAS_F_MNT_OPTIONS =
[
	"Anti Tank - Configurations" ,
	[
		[
			"missiles_SCALPEL" ,
			[
				[ "2Rnd_LG_scalpel" , "5000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	] ,
	"Anti Air - Configurations" ,
	[
		[
			"Missile_AA_04_Plane_CAS_01_F" ,
			[
				[ "2Rnd_Missile_AA_04_F" , "4000" ]
			] ,
			"Missile_AA_03_Plane_CAS_02_F" ,
			[
				[ "2Rnd_Missile_AA_03_F" , "4000" ]
			] ,
			"missiles_ASRAAM" ,
			[
				[ "2Rnd_AAA_missiles" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
			]
		]
	] ,
	"Anti Ground - Configurations" ,
	[
		[
			"Mk82BombLauncher" ,
			[
				[ "2Rnd_Mk82" , "3000" ]
			] ,
			"GBU12BombLauncher" ,
			[
				[ "2Rnd_GBU12_LGB" , "4000" ]
			]
		] ,
		[ "Laserdesignator_mounted" ,
			[
				[ "Laserbatteries" , "500" ]
			]
		] ,
		[ "CMFlareLauncher" ,
			[
				[ "240Rnd_CMFlare_Chaff_Magazine" , "2000" , [-1] ] ,
				[ "120Rnd_CMFlare_Chaff_Magazine" , "500" , [-1] ] ,
				[ "168Rnd_CMFlare_Chaff_Magazine" , "1000" , [-1] ] ,
				[ "192Rnd_CMFlare_Chaff_Magazine" , "1500" , [-1] ]
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
	"4Rnd_GAA_missiles" ,
	"1Rnd_GAA_missiles" ,
	"2Rnd_Missile_AA_04_F" ,
	"2Rnd_Missile_AA_03_F"
];

CTI_ALM_ATGM_RESEARCHED_MAGAZINES =
[
	"24Rnd_PG_missiles" ,
	"12Rnd_PG_missiles" ,
	"2Rnd_LG_scalpel" ,
	"8Rnd_LG_scalpel" ,
	"6Rnd_LG_scalpel" ,
	"2Rnd_GAT_missiles" ,
	"5Rnd_GAT_missiles" ,
	"4Rnd_Titan_long_missiles" ,
	"1Rnd_GAT_missiles" ,
	"6Rnd_Missile_AGM_02_F" ,
	"4Rnd_Missile_AGM_01_F"
];

CTI_ALM_FFAR_RESEARCHED_MAGAZINES =
[
	"14Rnd_80mm_rockets" ,
	"38Rnd_80mm_rockets" ,
	"7Rnd_Rocket_04_HE_F" ,
	"7Rnd_Rocket_04_AP_F" ,
	"20Rnd_Rocket_03_HE_F" ,
	"20Rnd_Rocket_03_AP_F" ,
	"24Rnd_missiles"
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

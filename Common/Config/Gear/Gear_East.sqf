private ["_faction", "_i", "_p", "_side", "_u"];

_side = _this;
_faction = "East";

_i = [];
_u = [];
_p = [];

//--- Magazines
_i = _i		+ ["ATMine_Range_Mag"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["APERSMine_Range_Mag"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["APERSBoundingMine_Range_Mag"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["SLAMDirectionalMine_Wire_Mag"];
_u = _u		+ [2];
_p = _p		+ [10];

_i = _i		+ ["APERSTripMine_Wire_Mag"];
_u = _u		+ [1];
_p = _p		+ [5];

_i = _i		+ ["SatchelCharge_Remote_Mag"];
_u = _u		+ [2];
_p = _p		+ [20];

_i = _i		+ ["DemoCharge_Remote_Mag"];
_u = _u		+ [1];
_p = _p		+ [15];

_i = _i		+ ["ClaymoreDirectionalMine_Remote_Mag"];
_u = _u		+ [2];
_p = _p		+ [10];


_i = _i		+ ["Laserbatteries"];
_u = _u		+ [2];
_p = _p		+ [20];

//Pistols ammo
_i = _i		+ ["10Rnd_9x21_Mag"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["16Rnd_9x21_Mag"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["6Rnd_45ACP_Cylinder"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["6Rnd_GreenSignal_F"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["6Rnd_RedSignal_F"];
_u = _u		+ [0];
_p = _p		+ [20];


//SMG Ammo
_i = _i		+ ["30Rnd_9x21_Mag_SMG_02_Tracer_Green"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_9x21_Mag"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_9x21_Red_Mag"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_545x39_Mag_Green_F"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["30Rnd_545x39_Mag_Tracer_Green_F"];
_u = _u		+ [0];
_p = _p		+ [20];


//Rifles Ammo
_i = _i		+ ["30Rnd_556x45_Stanag_green"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_556x45_Stanag_Tracer_Green"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["30Rnd_762x39_Mag_Green_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["30Rnd_762x39_Mag_Tracer_Green_F"];
_u = _u		+ [1];
_p = _p		+ [15];

_i = _i		+ ["30Rnd_65x39_caseless_green"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["30Rnd_65x39_caseless_green_mag_Tracer"];
_u = _u		+ [1];
_p = _p		+ [25];

_i = _i		+ ["30Rnd_580x42_Mag_F"];
_u = _u		+ [1];
_p = _p		+ [15];

_i = _i		+ ["30Rnd_580x42_Mag_Tracer_F"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["10Rnd_50BW_Mag_F"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["20Rnd_556x45_UW_mag"];
_u = _u		+ [2];
_p = _p		+ [100];


//MG Ammo
_i = _i		+ ["150Rnd_762x54_Box"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["150Rnd_762x54_Box_Tracer"];
_u = _u		+ [2];
_p = _p		+ [90];

_i = _i		+ ["150Rnd_93x64_Mag"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["100Rnd_580x42_Mag_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["100Rnd_580x42_Mag_Tracer_F"];
_u = _u		+ [1];
_p = _p		+ [25];



//Sniper rifles Ammo
_i = _i		+ ["10Rnd_762x54_Mag"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["20Rnd_650x39_Cased_Mag_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["10Rnd_93x64_DMR_05_Mag"];
_u = _u		+ [3];
_p = _p		+ [150];

_i = _i		+ ["10Rnd_127x54_Mag"];
_u = _u		+ [3];
_p = _p		+ [150];

_i = _i		+ ["5Rnd_127x108_Mag"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["5Rnd_127x108_APDS_Mag"];
_u = _u		+ [3];
_p = _p		+ [250];


//Launchers Ammo
_i = _i		+ ["RPG7_F"];
_u = _u		+ [0];
_p = _p		+ [25];

_i = _i		+ ["RPG32_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["RPG32_HE_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["Titan_AA"];
_u = _u		+ [2];
_p = _p		+ [250];

_i = _i		+ ["Titan_AP"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["Titan_AT"];
_u = _u		+ [3];
_p = _p		+ [250];


//Grenades
_i = _i		+ ["HandGrenade"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["MiniGrenade"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["O_IR_Grenade"];
_u = _u		+ [2];
_p = _p		+ [40];


//Smoke Shell
_i = _i		+ ["SmokeShellBlue"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["SmokeShellGreen"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["SmokeShellOrange"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["SmokeShellPurple"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["SmokeShellRed"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["SmokeShell"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["SmokeShellYellow"];
_u = _u		+ [0];
_p = _p		+ [50];


//Chemlights
_i = _i		+ ["Chemlight_green"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["Chemlight_red"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["Chemlight_yellow"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["Chemlight_blue"];
_u = _u		+ [0];
_p = _p		+ [10];


//GL Ammo
_i = _i		+ ["1Rnd_HE_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["1Rnd_Smoke_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["1Rnd_SmokeRed_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["1Rnd_SmokeGreen_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["1Rnd_SmokeYellow_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["1Rnd_SmokePurple_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["1Rnd_SmokeBlue_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["1Rnd_SmokeOrange_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [10];


_i = _i		+ ["UGL_FlareWhite_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["UGL_FlareGreen_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["UGL_FlareRed_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["UGL_FlareYellow_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["UGL_FlareCIR_F"];
_u = _u		+ [1];
_p = _p		+ [10];


//--- Weapons (Nested array elements are defined but skiped in the gear menu)
//Rifles
_i = _i		+ ["hgun_PDW2000_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["SMG_02_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["arifle_AKS_F"];
_u = _u		+ [0];
_p = _p		+ [30];

_i = _i		+ ["arifle_TRG21_F"];
_u = _u		+ [0];
_p = _p		+ [40];

_i = _i		+ ["arifle_TRG21_GL_F"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["arifle_AKM_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["arifle_Katiba_C_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_Katiba_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["arifle_Katiba_GL_F"];
_u = _u		+ [1];
_p = _p		+ [125];

_i = _i		+ ["LMG_Zafir_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["srifle_DMR_01_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["arifle_CTAR_blk_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["arifle_CTAR_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["arifle_CTAR_hex_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["arifle_CTAR_GL_blk_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["arifle_CTAR_GL_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["arifle_CTAR_GL_hex_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["arifle_CTARS_blk_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_CTARS_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_CTARS_hex_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_AK12_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["arifle_AK12_GL_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["srifle_DMR_07_blk_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["srifle_DMR_07_ghex_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["srifle_DMR_07_hex_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["arifle_SDAR_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["arifle_ARX_blk_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["arifle_ARX_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["arifle_ARX_hex_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["MMG_01_hex_F"];
_u = _u		+ [3];
_p = _p		+ [400];

_i = _i		+ ["MMG_01_tan_F"];
_u = _u		+ [3];
_p = _p		+ [400];

_i = _i		+ ["srifle_DMR_05_blk_F"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["srifle_DMR_05_hex_F"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["srifle_DMR_05_tan_f"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["srifle_DMR_04_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["srifle_DMR_04_Tan_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["srifle_GM6_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["srifle_GM6_camo_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["srifle_GM6_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [500];


//Launchers
_i = _i		+ ["launch_O_Titan_short_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["launch_O_Titan_short_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["launch_O_Titan_F"];
_u = _u		+ [2];
_p = _p		+ [125];

_i = _i		+ ["launch_O_Titan_ghex_F"];
_u = _u		+ [2];
_p = _p		+ [125];

_i = _i		+ ["launch_RPG32_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["launch_RPG32_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["launch_RPG7_F"];
_u = _u		+ [0];
_p = _p		+ [50];

//Pistols
_i = _i		+ ["hgun_Pistol_01_F"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["hgun_Rook40_F"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["hgun_Pistol_heavy_02_F"];
_u = _u		+ [2];
_p = _p		+ [20];

_i = _i		+ ["hgun_Pistol_Signal_F"];
_u = _u		+ [0];
_p = _p		+ [15];


//Uniforms
_i = _i		+ ["U_O_V_Soldier_Viper_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["U_O_V_Soldier_Viper_hex_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["U_O_FullGhillie_ard"];
_u = _u		+ [3];
_p = _p		+ [350];

_i = _i		+ ["U_O_T_FullGhillie_tna_F"];
_u = _u		+ [3];
_p = _p		+ [350];

_i = _i		+ ["U_O_FullGhillie_lsh"];
_u = _u		+ [3];
_p = _p		+ [350];

_i = _i		+ ["U_O_FullGhillie_sard"];
_u = _u		+ [3];
_p = _p		+ [350];

_i = _i		+ ["U_O_GhillieSuit"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["U_O_T_Sniper_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["U_O_PilotCoveralls"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["U_O_CombatUniform_ocamo"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["U_O_SpecopsUniform_ocamo"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["U_O_CombatUniform_oucamo"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["U_O_T_Soldier_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["U_O_T_Officer_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["U_O_OfficerUniform_ocamo"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["U_O_Wetsuit"];
_u = _u		+ [2];
_p = _p		+ [50];


//Vests
_i = _i		+ ["V_TacVest_blk"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["V_TacVest_brn"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["V_TacVest_camo"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["V_TacVest_khk"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["V_TacVest_oli"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["V_HarnessOGL_brn"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_HarnessOGL_ghex_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_HarnessOGL_gry"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_HarnessO_brn"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["V_HarnessO_ghex_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["V_HarnessO_gry"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["V_BandollierB_cbr"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["V_BandollierB_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["V_RebreatherIR"];
_u = _u		+ [2];
_p = _p		+ [100];


//Backpacks
_i = _i		+ ["B_Bergen_dgtl_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["B_Bergen_hex_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["B_Carryall_cbr"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["B_Carryall_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["B_Carryall_ocamo"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["B_Carryall_khk"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["B_Carryall_oli"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["B_Carryall_oucamo"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["O_UAV_01_backpack_F"];
_u = _u		+ [3];
_p = _p		+ [2500];

_i = _i		+ ["B_ViperHarness_blk_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["B_ViperHarness_ghex_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["B_ViperHarness_hex_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["B_ViperHarness_khk_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["B_ViperHarness_oli_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["B_Kitbag_cbr"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["B_Kitbag_rgr"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["B_Kitbag_sgg"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["B_ViperLightHarness_blk_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["B_ViperLightHarness_ghex_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["B_ViperLightHarness_hex_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["B_ViperLightHarness_khk_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["B_ViperLightHarness_oli_F"];
_u = _u		+ [2];
_p = _p		+ [100];

if !(MADE_FOR_STRATIS) then {
	_i = _i		+ ["O_Mortar_01_support_F"];
	_u = _u		+ [3];
	_p = _p		+ [5];

	_i = _i		+ ["O_Mortar_01_weapon_F"];
	_u = _u		+ [3];
	_p = _p		+ [2995];
};

_i = _i		+ ["B_FieldPack_blk"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_FieldPack_cbr"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_FieldPack_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_FieldPack_ocamo"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_FieldPack_khk"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_FieldPack_oli"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_FieldPack_oucamo"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_Parachute"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["O_Static_Designator_02_weapon_F"];
_u = _u		+ [2];
_p = _p		+ [500];


//Helms
_i = _i		+ ["H_HelmetO_ViperSP_hex_F"];
_u = _u		+ [3];
_p = _p		+ [1500];

_i = _i		+ ["H_HelmetO_ViperSP_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [1500];

_i = _i		+ ["H_HelmetLeaderO_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_HelmetLeaderO_ocamo"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_HelmetLeaderO_oucamo"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_PilotHelmetFighter_O"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["H_HelmetSpecO_blk"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["H_HelmetSpecO_ghex_F"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["H_HelmetSpecO_ocamo"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["H_HelmetCrew_O_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetCrew_O"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetO_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetO_ocamo"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetO_oucamo"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_PilotHelmetHeli_O"];
_u = _u		+ [1];
_p = _p		+ [40];

_i = _i		+ ["H_CrewHelmetHeli_O"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["H_Bandanna_gry"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_cbr"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_sgg"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_camo"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Watchcap_blk"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["H_Watchcap_cbr"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["H_Watchcap_camo"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["H_Watchcap_khk"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["H_Beret_ocamo"];
_u = _u		+ [0];
_p = _p		+ [15];

_i = _i		+ ["H_Cap_grn_BI"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_blk"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_grn"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_tan"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_brn_SPECOPS"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_MilCap_ghex_F"];
_u = _u		+ [0];
_p = _p		+ [30];

_i = _i		+ ["H_MilCap_ocamo"];
_u = _u		+ [0];
_p = _p		+ [30];

_i = _i		+ ["H_ShemagOpen_tan"];
_u = _u		+ [0];
_p = _p		+ [20];


//Glasses
_i = _i		+ ["G_Tactical_Black"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["G_Balaclava_blk"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Balaclava_combat"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Balaclava_lowprofile"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Balaclava_oli"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Bandanna_aviator"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Bandanna_beast"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Bandanna_blk"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Bandanna_khk"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Bandanna_oli"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Bandanna_shades"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Bandanna_sport"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_Bandanna_tan"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["G_O_Diving"];
_u = _u		+ [2];
_p = _p		+ [50];


//Optics
_i = _i		+ ["optic_ACO_grn_smg"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["optic_ACO_grn"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["optic_MRCO"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["optic_DMS"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["optic_DMS_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["optic_Arco"];
_u = _u		+ [2];
_p = _p		+ [20];

_i = _i		+ ["optic_Arco_blk_F"];
_u = _u		+ [2];
_p = _p		+ [20];

_i = _i		+ ["optic_Arco_ghex_F"];
_u = _u		+ [2];
_p = _p		+ [20];

_i = _i		+ ["optic_KHS_blk"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["optic_KHS_hex"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["optic_KHS_tan"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["optic_KHS_old"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["optic_LRPS"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["optic_LRPS_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["optic_Nightstalker"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["optic_tws"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["optic_Yorris"];
_u = _u		+ [1];
_p = _p		+ [5];

//Accessories
_i = _i		+ ["acc_pointer_IR"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["acc_flashlight"];
_u = _u		+ [1];
_p = _p		+ [20];


//Silencers
_i = _i		+ ["muzzle_snds_L"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["muzzle_snds_M"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["muzzle_snds_m_khk_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["muzzle_snds_m_snd_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["muzzle_snds_58_blk_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["muzzle_snds_58_wdm_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["muzzle_snds_H"];
_u = _u		+ [1];
_p = _p		+ [75];

_i = _i		+ ["muzzle_snds_H_khk_F"];
_u = _u		+ [1];
_p = _p		+ [75];

_i = _i		+ ["muzzle_snds_H_snd_F"];
_u = _u		+ [1];
_p = _p		+ [75];

_i = _i		+ ["muzzle_snds_H_MG"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["muzzle_snds_H_MG_blk_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["muzzle_snds_H_MG_khk_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["muzzle_snds_B"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["muzzle_snds_B_snd_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["muzzle_snds_B_khk_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["muzzle_snds_93mmg"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["muzzle_snds_93mmg_tan"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["muzzle_snds_65_TI_hex_F"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["muzzle_snds_65_TI_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["muzzle_snds_65_TI_blk_F"];
_u = _u		+ [3];
_p = _p		+ [100];


//Bipods
_i = _i		+ ["bipod_02_F_blk"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["bipod_02_F_hex"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["bipod_02_F_tan"];
_u = _u		+ [2];
_p = _p		+ [50];


//Items
_i = _i		+ ["NVGoggles_OPFOR"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["O_NVGoggles_hex_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["O_NVGoggles_ghex_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["O_NVGoggles_urb_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["Rangefinder"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["Laserdesignator_02"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["Laserdesignator_02_ghex_F"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["ItemGPS"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["O_UavTerminal"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["FirstAidKit"];
_u = _u		+ [0];
_p = _p		+ [15];

_i = _i		+ ["Medikit"];
_u = _u		+ [0];
_p = _p		+ [15];

_i = _i		+ ["ItemMap"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["itemradio"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["itemcompass"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["itemwatch"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["MineDetector"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["Toolkit"];
_u = _u		+ [0];
_p = _p		+ [25];





[_faction, _i, _u, _p] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Config_Set.sqf";

//--- Templates (Those lines can be generated in the RPT on purchase by uncommenting the diag_log in Events_UI_GearMenu.sqf >> "onPurchase").
_t = [];
/*_t = _t		+ [[[["arifle_trg21_f",["","acc_pointer_ir","optic_aco_grn"],["30rnd_556x45_stanag"]],["",[],[]],["hgun_rook40_f",[],["16rnd_9x21_mag"]]],[["u_o_combatuniform_ocamo",["firstaidkit","firstaidkit"]],["V_PlateCarrier2_rgr",["handgrenade","handgrenade"]],["b_assaultpack_khk",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag"]]],["h_helmeto_ocamo",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t		+ [[[["arifle_trg21_gl_f",["","acc_pointer_ir","optic_aco_grn"],["30rnd_556x45_stanag"]],["",[],[]],["hgun_rook40_f",[],["16rnd_9x21_mag"]]],[["u_o_combatuniform_ocamo",["firstaidkit","firstaidkit"]],["V_PlateCarrier2_rgr",["handgrenade","handgrenade"]],["b_assaultpack_khk",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_smokered_grenade_shell","1rnd_smokered_grenade_shell"]]],["h_helmeto_ocamo",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t		+ [[[["lmg_zafir_f",["","acc_pointer_ir","optic_aco_grn"],["150rnd_762x51_box"]],["",[],[]],["hgun_rook40_f",[],["16rnd_9x21_mag"]]],[["u_o_combatuniform_ocamo",["firstaidkit","firstaidkit"]],["V_PlateCarrier2_rgr",["handgrenade","handgrenade"]],["b_assaultpack_khk",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","150rnd_762x51_box","150rnd_762x51_box","150rnd_762x51_box","150rnd_762x51_box","150rnd_762x51_box"]]],["h_helmeto_ocamo",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t		+ [[[["arifle_katiba_f",["","acc_pointer_ir","optic_mrco"],["30rnd_65x39_caseless_green"]],["",[],[]],["hgun_rook40_f",["muzzle_snds_l","",""],["16rnd_9x21_mag"]]],[["u_o_combatuniform_ocamo",["firstaidkit","firstaidkit"]],["V_PlateCarrier2_rgr",["handgrenade","handgrenade","muzzle_snds_h"]],["b_assaultpack_khk",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","30rnd_65x39_caseless_green","democharge_remote_mag","democharge_remote_mag","democharge_remote_mag","apersboundingmine_range_mag","apersboundingmine_range_mag"]]],["h_helmeto_ocamo",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t		+ [[[["arifle_mk20c_f",["","acc_pointer_ir","optic_aco_grn"],["30rnd_556x45_stanag"]],["launch_rpg32_f",[],["rpg32_f"]],["hgun_rook40_f",[],["16rnd_9x21_mag"]]],[["u_o_combatuniform_ocamo",["firstaidkit","firstaidkit"]],["V_PlateCarrier2_rgr",["handgrenade","handgrenade"]],["b_assaultpack_khk",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","rpg32_f","rpg32_f"]]],["h_helmeto_ocamo",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t		+ [[[["arifle_mk20c_f",["","acc_pointer_ir","optic_aco_grn"],["30rnd_556x45_stanag"]],["launch_b_titan_f",[],["titan_aa"]],["hgun_rook40_f",[],["16rnd_9x21_mag"]]],[["u_o_combatuniform_ocamo",["firstaidkit","firstaidkit"]],["V_PlateCarrier2_rgr",["handgrenade","handgrenade"]],["b_assaultpack_khk",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","titan_aa","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag","30rnd_556x45_stanag"]]],["h_helmeto_ocamo",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t		+ [[[["srifle_gm6_f",["","","optic_sos"],["5rnd_127x108_mag"]],["",[],[]],["hgun_acpc2_f",["muzzle_snds_acp","",""],["16rnd_9x21_mag"]]],[["u_o_ghilliesuit",[]],["v_tacvest_brn",["firstaidkit","firstaidkit","handgrenade","handgrenade","smokeshellblue","smokeshellblue"]],["b_fieldpack_ocamo",["claymoredirectionalmine_remote_mag","claymoredirectionalmine_remote_mag","slamdirectionalmine_wire_mag","9rnd_45acp_mag","9rnd_45acp_mag","9rnd_45acp_mag","9rnd_45acp_mag","5rnd_127x108_mag","5rnd_127x108_mag","5rnd_127x108_mag","5rnd_127x108_mag","5rnd_127x108_mag","5rnd_127x108_mag","5rnd_127x108_mag","5rnd_127x108_mag","5rnd_127x108_mag","5rnd_127x108_mag"]]],["h_helmeto_ocamo",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t		+ [[[["smg_01_f",["","","optic_aco_grn"],["30rnd_45acp_mag_smg_01"]],["",[],[]],["hgun_rook40_f",[],["16rnd_9x21_mag"]]],[["u_o_combatuniform_ocamo",["firstaidkit","firstaidkit"]],["V_PlateCarrier2_rgr",["handgrenade","handgrenade"]],["b_assaultpack_khk",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01","30rnd_45acp_mag_smg_01"]]],["h_helmeto_ocamo",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];*/

[_faction, _t] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Template_Set.sqf";

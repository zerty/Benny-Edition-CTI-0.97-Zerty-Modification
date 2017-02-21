private ["_faction", "_i", "_p", "_side", "_u"];

_side = _this;
_faction = "West";

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
_u = _u		+ [1];
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
_u = _u		+ [1];
_p = _p		+ [10];


_i = _i		+ ["Laserbatteries"];
_u = _u		+ [2];
_p = _p		+ [20];


//Pistols ammo
_i = _i		+ ["16Rnd_9x21_Mag"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["9Rnd_45ACP_Mag"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["11Rnd_45ACP_Mag"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["6Rnd_GreenSignal_F"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["6Rnd_RedSignal_F"];
_u = _u		+ [0];
_p = _p		+ [20];


//SMG Ammo
_i = _i		+ ["30Rnd_9x21_Mag"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_9x21_Red_Mag"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_45ACP_Mag_SMG_01"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_45ACP_Mag_SMG_01_tracer_green"];
_u = _u		+ [0];
_p = _p		+ [10];


//Rifles Ammo
_i = _i		+ ["30Rnd_65x39_caseless_mag"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["30Rnd_65x39_caseless_green_mag_Tracer"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_556x45_Stanag"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["30Rnd_556x45_Stanag_Tracer_Red"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["20Rnd_556x45_UW_mag"];
_u = _u		+ [2];
_p = _p		+ [100];


//MG Ammo
_i = _i		+ ["100Rnd_65x39_caseless_mag"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["100Rnd_65x39_caseless_mag_Tracer"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["200Rnd_65x39_cased_Box"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["200Rnd_65x39_cased_Box_Tracer"];
_u = _u		+ [2];
_p = _p		+ [30];

_i = _i		+ ["200Rnd_556x45_Box_F"];
_u = _u		+ [1];
_p = _p		+ [40];

_i = _i		+ ["200Rnd_556x45_Box_Tracer_Red_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["150Rnd_556x45_Drum_Mag_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["150Rnd_556x45_Drum_Mag_Tracer_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["130Rnd_338_Mag"];
_u = _u		+ [2];
_p = _p		+ [100];


//Sniper rifles Ammo
_i = _i		+ ["20Rnd_762x51_Mag"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["10Rnd_338_Mag"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["7Rnd_408_Mag"];
_u = _u		+ [3];
_p = _p		+ [150];


//Launchers Ammo
_i = _i		+ ["NLAW_F"];
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

_i = _i		+ ["B_IR_Grenade"];
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


_i = _i		+ ["3Rnd_HE_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [150];

_i = _i		+ ["3Rnd_Smoke_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_SmokeRed_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_SmokeGreen_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_SmokeYellow_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_SmokePurple_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_SmokeBlue_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_SmokeOrange_Grenade_shell"];
_u = _u		+ [1];
_p = _p		+ [30];


_i = _i		+ ["3Rnd_UGL_FlareWhite_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_UGL_FlareGreen_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_UGL_FlareRed_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_UGL_FlareYellow_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["3Rnd_UGL_FlareCIR_F"];
_u = _u		+ [1];
_p = _p		+ [100];


//Rifles
_i = _i		+ ["SMG_01_F"];
_u = _u		+ [0];
_p = _p		+ [15];

_i = _i		+ ["SMG_05_F"];
_u = _u		+ [0];
_p = _p		+ [15];

_i = _i		+ ["arifle_Mk20_plain_F"];
_u = _u		+ [0];
_p = _p		+ [30];

_i = _i		+ ["arifle_Mk20_GL_plain_F"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["LMG_03_F"];
_u = _u		+ [0];
_p = _p		+ [150];

_i = _i		+ ["arifle_MXC_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_MXC_Black_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_MXC_khk_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_MX_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["arifle_MX_Black_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["arifle_MX_khk_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["arifle_MX_GL_F"];
_u = _u		+ [1];
_p = _p		+ [125];

_i = _i		+ ["arifle_MX_GL_Black_F"];
_u = _u		+ [1];
_p = _p		+ [125];

_i = _i		+ ["arifle_MX_GL_khk_F"];
_u = _u		+ [1];
_p = _p		+ [125];

_i = _i		+ ["arifle_MX_SW_F"];
_u = _u		+ [1];
_p = _p		+ [150];

_i = _i		+ ["arifle_MX_SW_Black_F"];
_u = _u		+ [1];
_p = _p		+ [150];

_i = _i		+ ["arifle_MX_SW_khk_F"];
_u = _u		+ [1];
_p = _p		+ [150];

_i = _i		+ ["arifle_MXM_F"];
_u = _u		+ [1];
_p = _p		+ [150];

_i = _i		+ ["arifle_MXM_Black_F"];
_u = _u		+ [1];
_p = _p		+ [150];

_i = _i		+ ["arifle_MXM_khk_F"];
_u = _u		+ [1];
_p = _p		+ [150];

_i = _i		+ ["arifle_SPAR_01_blk_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_SPAR_01_khk_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_SPAR_01_snd_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["arifle_SPAR_01_GL_blk_F"];
_u = _u		+ [1];
_p = _p		+ [75];

_i = _i		+ ["arifle_SPAR_01_GL_khk_F"];
_u = _u		+ [1];
_p = _p		+ [75];

_i = _i		+ ["arifle_SPAR_01_GL_snd_F"];
_u = _u		+ [1];
_p = _p		+ [75];

_i = _i		+ ["srifle_EBR_F"];
_u = _u		+ [1];
_p = _p		+ [200];

_i = _i		+ ["arifle_SPAR_02_blk_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["arifle_SPAR_02_khk_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["arifle_SPAR_02_snd_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["arifle_SPAR_03_blk_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["arifle_SPAR_03_khk_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["arifle_SPAR_03_snd_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["arifle_SDAR_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["srifle_DMR_03_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["srifle_DMR_03_multicam_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["srifle_DMR_03_khaki_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["srifle_DMR_03_tan_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["srifle_DMR_03_woodland_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["srifle_DMR_06_camo_F"];
_u = _u		+ [2];
_p = _p		+ [175];

_i = _i		+ ["srifle_DMR_06_olive_F"];
_u = _u		+ [2];
_p = _p		+ [175];

_i = _i		+ ["LMG_Mk200_F"];
_u = _u		+ [2];
_p = _p		+ [200];

_i = _i		+ ["MMG_02_black_F"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["MMG_02_camo_F"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["MMG_02_sand_F"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["srifle_DMR_02_F"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["srifle_DMR_02_camo_F"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["srifle_DMR_02_sniper_F"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["srifle_LRR_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["srifle_LRR_camo_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["srifle_LRR_tna_F"];
_u = _u		+ [3];
_p = _p		+ [500];


//Launchers
_i = _i		+ ["launch_B_Titan_short_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["launch_B_Titan_short_tna_F"];
_u = _u		+ [3];
_p = _p		+ [250];

_i = _i		+ ["launch_B_Titan_F"];
_u = _u		+ [2];
_p = _p		+ [125];

_i = _i		+ ["launch_B_Titan_tna_F"];
_u = _u		+ [2];
_p = _p		+ [125];

_i = _i		+ ["launch_NLAW_F"];
_u = _u		+ [1];
_p = _p		+ [100];


//Pistols
_i = _i		+ ["hgun_P07_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["hgun_P07_khk_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["hgun_ACPC2_F"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["hgun_Pistol_heavy_01_F"];
_u = _u		+ [2];
_p = _p		+ [20];

_i = _i		+ ["hgun_Pistol_Signal_F"];
_u = _u		+ [0];
_p = _p		+ [15];


//Uniforms
_i = _i		+ ["U_B_FullGhillie_ard"];
_u = _u		+ [3];
_p = _p		+ [60];

_i = _i		+ ["U_B_T_FullGhillie_tna_F"];
_u = _u		+ [3];
_p = _p		+ [60];

_i = _i		+ ["U_B_FullGhillie_lsh"];
_u = _u		+ [3];
_p = _p		+ [60];

_i = _i		+ ["U_B_FullGhillie_sard"];
_u = _u		+ [3];
_p = _p		+ [60];

_i = _i		+ ["U_B_T_Sniper_F"];
_u = _u		+ [3];
_p = _p		+ [45];

_i = _i		+ ["U_B_GhillieSuit"];
_u = _u		+ [3];
_p = _p		+ [45];

_i = _i		+ ["U_B_CTRG_Soldier_F"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["U_B_CTRG_Soldier_3_F"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["U_B_CTRG_1"];
_u = _u		+ [2];
_p = _p		+ [30];

_i = _i		+ ["U_B_CTRG_3"];
_u = _u		+ [2];
_p = _p		+ [30];

_i = _i		+ ["U_B_CTRG_Soldier_2_F"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["U_B_CTRG_Soldier_urb_1_F"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["U_B_CTRG_Soldier_urb_3_F"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["U_B_PilotCoveralls"];
_u = _u		+ [2];
_p = _p		+ [30];

_i = _i		+ ["U_B_Wetsuit"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["U_B_CTRG_2"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["U_B_HeliPilotCoveralls"];
_u = _u		+ [1];
_p = _p		+ [15];

_i = _i		+ ["U_B_CombatUniform_mcam"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["U_B_CombatUniform_mcam_vest"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["U_B_T_Soldier_SL_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["U_B_T_Soldier_F"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["U_B_CTRG_Soldier_urb_2_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["U_I_G_Story_Protagonist_F"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["U_B_CombatUniform_mcam_tshirt"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["U_I_G_resistanceLeader_F"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["U_B_T_Soldier_AR_F"];
_u = _u		+ [0];
_p = _p		+ [10];


// Vests
_i = _i		+ ["V_PlateCarrierSpec_blk"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["V_PlateCarrierSpec_rgr"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["V_PlateCarrierSpec_mtp"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["V_PlateCarrierSpec_tna_F"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["V_PlateCarrierGL_blk"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["V_PlateCarrierGL_rgr"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["V_PlateCarrierGL_mtp"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["V_PlateCarrierGL_tna_F"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["V_PlateCarrier1_blk"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_PlateCarrier1_rgr"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_PlateCarrier1_rgr_noflag_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_PlateCarrier1_tna_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_PlateCarrierL_CTRG"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_PlateCarrier_Kerry"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_PlateCarrier2_blk"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["V_PlateCarrier2_rgr"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["V_PlateCarrier2_rgr_noflag_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["V_PlateCarrier2_tna_F"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["V_PlateCarrierH_CTRG"];
_u = _u		+ [2];
_p = _p		+ [150];

_i = _i		+ ["V_RebreatherB"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["V_I_G_resistanceLeader_F"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["V_TacVestIR_blk"];
_u = _u		+ [1];
_p = _p		+ [150];

_i = _i		+ ["V_BandollierB_rgr"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["V_BandollierB_khk"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["V_BandollierB_oli"];
_u = _u		+ [0];
_p = _p		+ [50];

_i = _i		+ ["V_Chestrig_blk"];
_u = _u		+ [0];
_p = _p		+ [100];

_i = _i		+ ["V_Chestrig_rgr"];
_u = _u		+ [0];
_p = _p		+ [100];

_i = _i		+ ["V_Chestrig_khk"];
_u = _u		+ [0];
_p = _p		+ [100];

_i = _i		+ ["V_Chestrig_oli"];
_u = _u		+ [0];
_p = _p		+ [100];

_i = _i		+ ["V_TacChestrig_cbr_F"];
_u = _u		+ [0];
_p = _p		+ [100];

_i = _i		+ ["V_TacChestrig_grn_F"];
_u = _u		+ [0];
_p = _p		+ [100];

_i = _i		+ ["V_TacChestrig_oli_F"];
_u = _u		+ [0];
_p = _p		+ [100];


//Backpacks
_i = _i		+ ["B_Carryall_cbr"];
_u = _u		+ [3];
_p = _p		+ [150];

_i = _i		+ ["B_Carryall_khk"];
_u = _u		+ [3];
_p = _p		+ [150];

_i = _i		+ ["B_Carryall_mcamo"];
_u = _u		+ [3];
_p = _p		+ [150];

_i = _i		+ ["B_Carryall_oli"];
_u = _u		+ [3];
_p = _p		+ [150];

_i = _i		+ ["B_Bergen_mcamo_F"];
_u = _u		+ [3];
_p = _p		+ [1000];

_i = _i		+ ["B_Bergen_tna_F"];
_u = _u		+ [3];
_p = _p		+ [1000];

_i = _i		+ ["B_UAV_01_backpack_F"];
_u = _u		+ [3];
_p = _p		+ [2500];

_i = _i		+ ["B_Kitbag_cbr"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["B_Kitbag_rgr"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["B_Kitbag_mcamo"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["B_Kitbag_sgg"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["B_Static_Designator_01_weapon_F"];
_u = _u		+ [2];
_p = _p		+ [500];

if !(MADE_FOR_STRATIS) then {
_i = _i		+ ["B_Mortar_01_support_F"];
_u = _u		+ [3];
_p = _p		+ [5];

_i = _i		+ ["B_Mortar_01_weapon_F"];
_u = _u		+ [3];
_p = _p		+ [2995];
};

_i = _i		+ ["B_TacticalPack_blk"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["B_TacticalPack_rgr"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["B_TacticalPack_mcamo"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["B_TacticalPack_oli"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["B_AssaultPack_blk"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_AssaultPack_cbr"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_AssaultPack_rgr"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_AssaultPack_khk"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_AssaultPack_mcamo"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_AssaultPack_sgg"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_AssaultPack_tna_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_AssaultPack_Kerry"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["B_Parachute"];
_u = _u		+ [1];
_p = _p		+ [100];


//Helms
_i = _i		+ ["H_HelmetB_TI_tna_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["H_HelmetSpecB"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_HelmetSpecB_blk"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_HelmetSpecB_paint2"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_HelmetSpecB_paint1"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_HelmetSpecB_sand"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_HelmetSpecB_snakeskin"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_HelmetB_Enh_tna_F"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["H_PilotHelmetFighter_B"];
_u = _u		+ [3];
_p = _p		+ [300];

_i = _i		+ ["H_HelmetB"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["H_HelmetB_black"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["H_HelmetB_camo"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["H_HelmetB_desert"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["H_HelmetB_grass"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["H_HelmetB_sand"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["H_HelmetB_snakeskin"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["H_HelmetB_tna_F"];
_u = _u		+ [2];
_p = _p		+ [40];

_i = _i		+ ["H_HelmetCrew_B"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["H_PilotHelmetHeli_B"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["H_CrewHelmetHeli_B"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["H_HelmetB_light"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetB_light_black"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetB_light_desert"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetB_light_grass"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetB_light_sand"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetB_light_snakeskin"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_HelmetB_Light_tna_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["H_Bandanna_gry"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_blu"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_cbr"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_khk_hs"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_khk"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_mcamo"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_sgg"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Bandanna_sand"];
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

_i = _i		+ ["H_Beret_blk"];
_u = _u		+ [0];
_p = _p		+ [15];

_i = _i		+ ["H_Beret_02"];
_u = _u		+ [0];
_p = _p		+ [15];

_i = _i		+ ["H_Beret_Colonel"];
_u = _u		+ [0];
_p = _p		+ [15];

_i = _i		+ ["H_Booniehat_khk_hs"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Booniehat_khk"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Booniehat_mcamo"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Booniehat_oli"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Booniehat_tan"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Booniehat_tna_F"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_grn_BI"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_blk"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_blk_CMMG"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_grn"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_blk_ION"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_oli"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_oli_hs"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_tan"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_tan_specops_US"];
_u = _u		+ [0];
_p = _p		+ [5];

_i = _i		+ ["H_Cap_khaki_specops_UK"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Cap_usblack"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_MilCap_gry"];
_u = _u		+ [0];
_p = _p		+ [30];

_i = _i		+ ["H_MilCap_mcamo"];
_u = _u		+ [0];
_p = _p		+ [30];

_i = _i		+ ["H_MilCap_tna_F"];
_u = _u		+ [0];
_p = _p		+ [30];

_i = _i		+ ["H_Shemag_olive"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_Shemag_olive_hs"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["H_ShemagOpen_khk"];
_u = _u		+ [0];
_p = _p		+ [20];


//Glasses
_i = _i		+ ["G_Tactical_Clear"];
_u = _u		+ [1];
_p = _p		+ [100];

_i = _i		+ ["G_Balaclava_TI_blk_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["G_Balaclava_TI_G_blk_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["G_Balaclava_TI_tna_F"];
_u = _u		+ [2];
_p = _p		+ [100];

_i = _i		+ ["G_Balaclava_TI_G_tna_F"];
_u = _u		+ [2];
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

_i = _i		+ ["G_Combat"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["G_Combat_Goggles_tna_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["G_B_Diving"];
_u = _u		+ [2];
_p = _p		+ [50];


//Optics
_i = _i		+ ["optic_Aco_smg"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["optic_Aco"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["optic_Holosight"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["optic_Holosight_blk_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["optic_Holosight_khk_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["optic_Holosight_smg"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["optic_Holosight_smg_blk_F"];
_u = _u		+ [0];
_p = _p		+ [10];

_i = _i		+ ["optic_MRCO"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["optic_DMS"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["optic_ERCO_blk_F"];
_u = _u		+ [2];
_p = _p		+ [30];

_i = _i		+ ["optic_ERCO_khk_F"];
_u = _u		+ [2];
_p = _p		+ [30];

_i = _i		+ ["optic_ERCO_snd_F"];
_u = _u		+ [2];
_p = _p		+ [30];

_i = _i		+ ["optic_Hamr"];
_u = _u		+ [2];
_p = _p		+ [20];

_i = _i		+ ["optic_Hamr_khk_F"];
_u = _u		+ [2];
_p = _p		+ [20];

_i = _i		+ ["optic_NVS"];
_u = _u		+ [2];
_p = _p		+ [30];

_i = _i		+ ["optic_SOS"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["optic_SOS_khk_F"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["optic_AMS"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["optic_AMS_khk"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["optic_AMS_snd"];
_u = _u		+ [3];
_p = _p		+ [50];

_i = _i		+ ["optic_LRPS"];
_u = _u		+ [3];
_p = _p		+ [75];

_i = _i		+ ["optic_LRPS_tna_F"];
_u = _u		+ [3];
_p = _p		+ [75];

_i = _i		+ ["optic_tws"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["optic_tws_mg"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["optic_Nightstalker"];
_u = _u		+ [3];
_p = _p		+ [100];

_i = _i		+ ["optic_MRD"];
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

_i = _i		+ ["muzzle_snds_acp"];
_u = _u		+ [0];
_p = _p		+ [40];

_i = _i		+ ["muzzle_snds_M"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["muzzle_snds_m_khk_F"];
_u = _u		+ [1];
_p = _p		+ [50];

_i = _i		+ ["muzzle_snds_m_snd_F"];
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

_i = _i		+ ["muzzle_snds_338_black"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["muzzle_snds_338_green"];
_u = _u		+ [3];
_p = _p		+ [200];

_i = _i		+ ["muzzle_snds_338_sand"];
_u = _u		+ [3];
_p = _p		+ [200];


//Bipods
_i = _i		+ ["bipod_01_F_blk"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["bipod_01_F_khk"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["bipod_01_F_mtp"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["bipod_01_F_snd"];
_u = _u		+ [2];
_p = _p		+ [50];


//Items
_i = _i		+ ["NVGoggles"];
_u = _u		+ [0];
_p = _p		+ [20];

_i = _i		+ ["NVGoggles_tna_F"];
_u = _u		+ [1];
_p = _p		+ [30];

_i = _i		+ ["NVGogglesB_grn_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["NVGogglesB_gry_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["NVGogglesB_blk_F"];
_u = _u		+ [3];
_p = _p		+ [500];

_i = _i		+ ["Rangefinder"];
_u = _u		+ [1];
_p = _p		+ [20];

_i = _i		+ ["Laserdesignator"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["Laserdesignator_01_khk_F"];
_u = _u		+ [2];
_p = _p		+ [50];

_i = _i		+ ["ItemGPS"];
_u = _u		+ [1];
_p = _p		+ [10];

_i = _i		+ ["B_UavTerminal"];
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

//--- Templates (Generated on purchase by uncommenting the diag_log in Events_UI_GearMenu.sqf >> "onPurchase").
_t = [];
/*_t = _t 	+ [[[["arifle_mx_f",["","","optic_arco"],["30rnd_65x39_caseless_mag"]],["",[],[]],["hgun_p07_f",["","",""],["16rnd_9x21_mag"]]],[["u_b_combatuniform_mcam",["firstaidkit","firstaidkit"]],["v_platecarrier1_rgr",["handgrenade","handgrenade"]],["b_assaultpack_mcamo",["30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag"]]],["h_helmetb",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t 	+ [[[["arifle_mx_gl_f",["","acc_pointer_ir","optic_aco"],["30rnd_65x39_caseless_mag"]],["",[],[]],["hgun_p07_f",["","",""],["16rnd_9x21_mag"]]],[["u_b_combatuniform_mcam",["firstaidkit","firstaidkit"]],["v_platecarrier1_rgr",["handgrenade","handgrenade"]],["b_assaultpack_mcamo",["30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag_tracer","30rnd_65x39_caseless_mag_tracer","30rnd_65x39_caseless_mag_tracer","30rnd_65x39_caseless_mag_tracer","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_he_grenade_shell","1rnd_smokeblue_grenade_shell","1rnd_smokeblue_grenade_shell","1rnd_smokeblue_grenade_shell","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag"]]],["h_helmetb",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t 	+ [[[["arifle_mx_sw_f",["","acc_pointer_ir","optic_holosight"],["100rnd_65x39_caseless_mag"]],["",[],[]],["hgun_p07_f",["","",""],["16rnd_9x21_mag"]]],[["u_b_combatuniform_mcam",["firstaidkit","firstaidkit"]],["v_platecarrier1_rgr",["handgrenade","handgrenade"]],["b_assaultpack_mcamo",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","100rnd_65x39_caseless_mag","100rnd_65x39_caseless_mag","100rnd_65x39_caseless_mag","100rnd_65x39_caseless_mag","100rnd_65x39_caseless_mag","100rnd_65x39_caseless_mag_tracer","100rnd_65x39_caseless_mag_tracer"]]],["h_helmetb",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t 	+ [[[["lmg_mk200_f",["","acc_pointer_ir","optic_holosight"],["200rnd_65x39_cased_box"]],["",[],[]],["hgun_p07_f",["","",""],["16rnd_9x21_mag"]]],[["u_b_combatuniform_mcam",["firstaidkit","firstaidkit"]],["v_platecarrier1_rgr",["handgrenade","handgrenade"]],["b_assaultpack_mcamo",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","200rnd_65x39_cased_box","200rnd_65x39_cased_box","200rnd_65x39_cased_box","200rnd_65x39_cased_box","200rnd_65x39_cased_box"]]],["h_helmetb",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t 	+ [[[["srifle_ebr_f",["","acc_pointer_ir","optic_hamr"],["20rnd_762x51_mag"]],["",[],[]],["hgun_p07_f",["muzzle_snds_l","",""],["16rnd_9x21_mag"]]],[["u_b_combatuniform_mcam",["firstaidkit","firstaidkit"]],["v_platecarrier1_rgr",["handgrenade","handgrenade","muzzle_snds_b"]],["b_assaultpack_mcamo",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","20rnd_762x51_mag","democharge_remote_mag","democharge_remote_mag","democharge_remote_mag","apersboundingmine_range_mag","apersboundingmine_range_mag"]]],["h_helmetb",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t 	+ [[[["arifle_mxc_f",["","acc_pointer_ir","optic_holosight"],["30rnd_65x39_caseless_mag"]],["launch_nlaw_f",[],["nlaw_f"]],["hgun_p07_f",["","",""],["16rnd_9x21_mag"]]],[["u_b_combatuniform_mcam",["firstaidkit","firstaidkit"]],["v_platecarrier1_rgr",["handgrenade","handgrenade"]],["b_assaultpack_mcamo",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","nlaw_f","nlaw_f"]]],["h_helmetb",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t 	+ [[[["arifle_mxc_f",["","acc_pointer_ir","optic_holosight"],["30rnd_65x39_caseless_mag"]],["launch_b_titan_f",[],["titan_aa"]],["hgun_p07_f",["","",""],["16rnd_9x21_mag"]]],[["u_b_combatuniform_mcam",["firstaidkit","firstaidkit"]],["v_platecarrier1_rgr",["handgrenade","handgrenade"]],["b_assaultpack_mcamo",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","30rnd_65x39_caseless_mag","titan_aa"]]],["h_helmetb",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];
_t = _t 	+ [[[["srifle_lrr_f",["","","optic_sos"],["7rnd_408_mag"]],["",[],[]],["hgun_p07_f",["muzzle_snds_l","",""],["16rnd_9x21_mag"]]],[["u_b_ghilliesuit",[]],["v_tacvest_oli",["firstaidkit","firstaidkit","handgrenade","handgrenade","smokeshellblue","smokeshellblue"]],["b_assaultpack_mcamo",["16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","16rnd_9x21_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag","7rnd_408_mag"]]],["h_helmetb",""],[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]]];*/

[_faction, _t] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Template_Set.sqf";

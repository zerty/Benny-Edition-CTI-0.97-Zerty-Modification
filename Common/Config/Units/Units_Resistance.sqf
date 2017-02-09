_side = _this;
_faction = "Resistance";

_c = []; //--- Classname
_p = []; //--- Picture. 				'' = auto generated.
_n = []; //--- Name. 					'' = auto generated.
_o = []; //--- Price.
_t = []; //--- Build time.
_u = []; //--- Upgrade level needed.    0 1 2 3...
_f = []; //--- Built from Factory.
_s = []; //--- Script

//--- Infantry
_c = _c + ['I_Soldier_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [70];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_crew_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [70];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_Soldier_A_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [80];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_soldier_AA_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_soldier_AT_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [450];
_t = _t + [5];
_u = _u + [1];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_soldier_AR_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_engineer_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [120];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_soldier_exp_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [110];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_Soldier_GL_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_soldier_M_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_medic_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_officer_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_soldier_repair_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [100];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_soldier_LAT_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [200];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_helipilot_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [150];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];

_c = _c + ['I_pilot_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [200];
_t = _t + [5];
_u = _u + [0];
_f = _f + [CTI_FACTORY_BARRACKS];
_s = _s + [""];


_c = _c + ['I_G_Offroad_01_armed_F'];
_p = _p + [''];
_n = _n + [''];
_o = _o + [300];
_t = _t + [20];
_u = _u + [0];
_f = _f + [CTI_FACTORY_LIGHT];
_s = _s + [""];


[_side, _faction, _c, _p, _n, _o, _t, _u, _f, _s] call compile preprocessFileLineNumbers "Common\Config\Units\Set_Units.sqf";
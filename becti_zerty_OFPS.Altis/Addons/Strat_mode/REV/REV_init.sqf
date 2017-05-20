REV_ACT_DRAG=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_act_drag.sqf";
REV_ACT_REL=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_act_rel.sqf";
REV_ACT_REV=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_act_rev.sqf";
REV_ACT_SUIC=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_act_suic.sqf";
REV_UNC=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_unc.sqf";
REV_UNC_LOOP=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_unc_loop.sqf";
REV_HANDLER=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_handler.sqf";
REV_OBJ_INIT=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_obj_init.sqf";
REV_REM_OBJ_INIT=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_rem_obj_init.sqf";
REV_UI_MOD=compile preprocessfilelinenumbers "Addons\Strat_mode\REV\REV_ui_mod.sqf";

REV_REMOTE_HANDELD=[];
/*
0 spawn {
	while {!CTI_GameOver} do {
	 {_x call REV_REM_OBJ_INIT ; true }count (playableunits-[player]);
	 sleep 1;
	};
};
*/
0 spawn REV_UI_MOD;


with missionnamespace do {
	CTI_PVF_REV_DRAGGED={
		_unit=_this select 0;
		_target =_this select 1;
		if !( local _unit) exitwith {false};
		_unit attachTo [_target, [0, 1.1, 0.092]];
		_unit setdir 180;
		_unit setvariable ["REV_DRAGGED",true,true];
	};
	CTI_PVF_REV_UNDRAGGED={
		_unit=_this;
		if !( local _unit) exitwith {false};
		detach _unit;
		_unit switchMove "AinjPpneMstpSnonWrflDnon";
		_unit setvariable ["REV_DRAGGED",false,true];
	};
};
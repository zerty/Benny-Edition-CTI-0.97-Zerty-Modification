
#define animation "ainvpknlmstpsnonwrfldnon_medic0s"
#define player_ratio 4
#define reward 25
_caller=_this select 0;
_target=_this select 1;

private ["_caller"];

_primary_weapon = primaryWeapon _caller;
_caller selectWeapon _primary_weapon;
CTI_P_Repairing = true ;
_caller switchMove animation;
[localize "STR_Action_Build",0,100,0] call HUD_PBar_start;
(_target getVariable "cti_completion") call HUD_PBar_update;
while {alive _caller  && animationstate _caller == animation && _target in (CTI_P_SideLogic getVariable ["cti_structures_wip",[]]) &&(_target getVariable ["cti_completion",0] <100) } do {
			_target setVariable ["cti_completion", (_target getVariable "cti_completion") + ((CTI_BASE_WORKERS_BUILD_COEFFICIENT*player_ratio/(_target getVariable "cti_structures_iteration")) * (_target getVariable "cti_completion_ratio")),true];
			(_target getVariable "cti_completion") call HUD_PBar_update;
			(reward) call CTI_CL_FNC_ChangePlayerFunds;
			sleep 5;
};
_caller switchMove "";
CTI_P_Repairing = false ;
0 call HUD_PBar_stop;

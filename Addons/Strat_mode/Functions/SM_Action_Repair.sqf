#define animation "ainvpknlmstpsnonwrfldnon_medic0s"
#define player_ratio 0.5
#define reward 15
_caller=_this select 0;
_target=_this select 1;




private ["_caller","_virtual_damages","_addin"];

_primary_weapon = primaryWeapon _caller;
_caller selectWeapon _primary_weapon;
CTI_P_Repairing = true ;
_caller switchMove animation;
["Repairing",0,1,0] call HUD_PBar_start;
(_target getVariable "cti_completion") call HUD_PBar_update;
_virtual_damages = _target getVariable ["cti_altdmg",-1];
while {alive _caller  && animationstate _caller == animation && (getDammage _target > 0 || _virtual_damages >0) } do {
			_virtual_damages = _target getVariable ["cti_altdmg",-1];
			if (_virtual_damages < 0) then {
				_addin = getDammage _target - (CTI_BASE_WORKERS_REPAIR* player_ratio);
				if (_addin < 0) then {_addin = 0};
				_target  setDammage _addin;
				(getDammage _target) call HUD_PBar_update;
			}else{
				_addin = _virtual_damages - (CTI_BASE_WORKERS_REPAIR* player_ratio);
				if (_addin < 0) then {_addin = 0};
				if (_addin != _virtual_damages) then {_target setVariable ["cti_altdmg", _addin,true]};
				(_target getVariable "cti_altdmg") call HUD_PBar_update;
			};
			(reward) call CTI_CL_FNC_ChangePlayerFunds;
			sleep 5;
};
_caller switchMove "";
CTI_P_Repairing = false ;
0 call HUD_PBar_stop;

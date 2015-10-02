#define animation "ainvpknlmstpsnonwrfldnon_medic0s"

_caller=_this select 0;
_target=_this select 1;

private ["_caller"];

CTI_P_Repairing = true ;
_caller switchMove animation;
["Removing defense",0,1,0] call HUD_PBar_start;
(getDammage _target) call HUD_PBar_update;

_side= if  (_target in (CTI_EAST getVariable ["cti_defences", []])) then { east } else {west};
_maxtime= if (_target in (CTI_P_SideLogic getVariable ["cti_defences", []])) then {7} else {90};

while {alive _caller  && animationstate _caller == animation &&(getDammage _target) <1 } do {
			_target setDamage ((getDammage _target)+1/_maxtime);
			((getDammage _target)) call HUD_PBar_update;
			sleep 1;
};

if ((getDammage _target ) >=1) then {

	_var = missionNamespace getVariable format["CTI_%1_%2",_side,typeOf _target];
	_fob = false;
	if (!isNil "_var") then {
		{if (_x select 0 == "FOB") exitWith {_fob = true}} forEach (_var select 5);

		if (_fob) then { //--- Erase this FOB upon destruction
			_logic = (_side) call CTI_CO_FNC_GetSideLogic;
			_logic setVariable ["cti_fobs", (_logic getVariable "cti_fobs") - [objNull, _target], true];
		};
	};

	deleteVehicle _target;


};
_caller switchMove "";
CTI_P_Repairing = false ;
0 call HUD_PBar_stop;


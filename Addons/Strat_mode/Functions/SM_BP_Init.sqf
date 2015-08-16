private ["_base","_side","_ind","_side_id","_sidelogic"];
_base= _this select 0;
_side = _this select 1;
_ind=_this select 2;

_side_id=(_side) call CTI_CO_FNC_GetSideID;
_sidelogic= (_side) call CTI_CO_FNC_GetSideLogic;
waitUntil {(count CTI_Towns) > 0};
sleep 2;
[_base,_side,_ind] call SM_BP_Link;
[_base,_side,_ind] spawn SM_BP_DetectLoop;
[_base,_side,_ind] spawn SM_BP_ProtectLoop;
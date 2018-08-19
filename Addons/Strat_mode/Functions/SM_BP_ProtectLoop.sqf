private ["_base","_side","_ind","_side_id","_sidelogic","_neigh","_protected","_objects"];
_base= _this select 0;
_side = _this select 1;
_ind=_this select 2;

_side_id=(_side) call CTI_CO_FNC_GetSideID;
_sidelogic= (_side) call CTI_CO_FNC_GetSideLogic;


_neigh=( _sidelogic getVariable "CTI_BASES_NEIGH") select _ind;

_protected =[];

while {!CTI_GameOver} do {
	if (({(_x getVariable "cti_town_sideID") == _side_id } count _neigh) == count _neigh) then {
		_objects = _sidelogic getvariable ["cti_structures",[]];
		{ if (!(_x getvariable ["CTI_protected",false]) && ((_x distance _base) <= CTI_BASE_AREA_RANGE)) then {
			_x setvariable ["CTI_protected",true,false];
			if (CTI_SM_BASEP_M< 0 ) then {_x allowDammage false;};
			_protected set [count _protected,_x];};true } count _objects;
	} else {
		{diag_log format [ ":: BP :: %1 :: Protecting off  %2" , _base,_x];_x allowDammage true;_x setvariable ["CTI_protected",false,false];true} count _protected;
		_protected = [];
	};
	sleep 10;
};

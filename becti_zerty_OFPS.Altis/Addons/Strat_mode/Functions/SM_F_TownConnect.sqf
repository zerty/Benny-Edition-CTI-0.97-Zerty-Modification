private ["_ct","_tv","_neigh","_towns","_new_neigh","_nt","_oneigh"];
_ct= _this select 0;
_tv= _ct getVariable "cti_town_value";
_neigh= _ct getVariable "CTI_Neigh";

_towns=CTI_Towns;
_new_neigh = [_ct,_towns] call CTI_CO_FNC_SortByDistance;
_new_neigh=	_new_neigh- [_ct];
{
	_nt=_x;
	_oneigh=  _nt getVariable "CTI_Neigh";
  if ( (_nt getVariable "cti_town_value") <500 && _nt != _ct  && {_x==_nt} count _neigh == 0 && ( count _neigh == 0 ||  _tv <150  &&  count _neigh < 1 ||  _tv >=150 && _tv <200 &&  count _neigh < 2|| _tv >=200 &&_tv <500  && count _neigh <= 2 &&(_nt distance _ct ) <5000)) then {
  	_neigh= _neigh + [_nt];
  	_oneigh= _oneigh + [_ct];
		_ct setVariable ["CTI_Neigh",_neigh,True];
		_nt setVariable ["CTI_Neigh",_oneigh,True];
  };
} forEach _new_neigh;
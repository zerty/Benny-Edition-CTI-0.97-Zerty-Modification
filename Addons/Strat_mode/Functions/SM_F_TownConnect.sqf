private ["_ct"];

_ct= _this select 0;
_neigh =[];
{
	if (_x in CTI_Towns) then {
		_neigh pushBack _x;
	};
} forEach synchronizedObjects _ct;

_ct setVariable ["CTI_Neigh",_neigh,true] ;
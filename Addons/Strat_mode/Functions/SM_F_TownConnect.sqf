private ["_ct"];

_ct= _this select 0;
_neigh =[];
{
	if (_x in CTI_Towns) then {
		_neigh pushBack _x;
	};
} forEach synchronizedObjects _ct;


if (count _neigh == 0 ) then {
	_neigh pushBack ([_ct, CTI_Towns - [_ct]] call CTI_CO_FNC_GetClosestEntity);
};

_ct setVariable ["CTI_Neigh",_neigh,true] ;
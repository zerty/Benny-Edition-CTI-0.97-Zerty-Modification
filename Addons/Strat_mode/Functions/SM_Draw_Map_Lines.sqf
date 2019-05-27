private ["_map"];
_map=_this select 0;

{
		_x set [0 , objNull];
	_x=_x-[objNull];
	 _map drawLine _x ;
true
}count (SHOWTOMAP select 2);
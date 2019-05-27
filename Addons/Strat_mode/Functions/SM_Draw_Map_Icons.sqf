private ["_map"];
_map=_this select 0;
//if ((time <= HUD_Time) && !visibleMap ) exitWith {false};

{
	_x set [0 , objNull];
	_x=_x-[objNull];
	 _map drawIcon _x ;
true
}count (SHOWTOMAP select 1)+(SHOWTOMAP select 0);
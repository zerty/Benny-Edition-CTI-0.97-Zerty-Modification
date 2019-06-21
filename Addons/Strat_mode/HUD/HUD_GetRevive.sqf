
_rev=[];
_ob= player nearEntities ["Man",150];
{
	if ( _x getVariable ["REV_UNC",false] && (side group _x == side group player)&& !(_x == player)) then {
		_dis= player distance _x;
		_fade=0.3 + (1-(150 - _dis)/150)*0.7;
		_fade =(1-(_dis/150)*0.7);
		_scale = 1*(1-(_dis/150)*0.7);
		_rev set[count _rev,[_x,_fade,_scale]];
	};
true
} count _ob;
_rev
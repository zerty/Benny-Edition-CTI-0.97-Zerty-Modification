// arguments: [vector1, vector2]
// return: vector

private ["_x", "_y", "_z", "_res"];

_x = ((_this select 0) select 1)*((_this select 1) select 2) - ((_this select 0) select 2)*((_this select 1) select 1);
_y = ((_this select 0) select 2)*((_this select 1) select 0) - ((_this select 0) select 0)*((_this select 1) select 2);
_z = ((_this select 0) select 0)*((_this select 1) select 1) - ((_this select 0) select 1)*((_this select 1) select 0);

_res = [_x,_y,_z];

_res
// arguments: [vector1, vector2]
// return: product

private ["_res"];

_res = ((_this select 0) select 0)*((_this select 1) select 0) + ((_this select 0) select 1)*((_this select 1) select 1);

_res
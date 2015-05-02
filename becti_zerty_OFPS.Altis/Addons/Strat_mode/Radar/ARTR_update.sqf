private ["_marker","_base1","_base2","_xdif","_ydif","_xpos","_ypos","_pos","_dir"];

_marker=format ["ARTR_%1",_this select 0];
_base1 = _this select 1;
_base2 = _this select 2;

_xdif = (_base1 select 0) - (_base2 select 0);
_ydif = (_base1 select 1) - (_base2 select 1);

_xpos = (_base1 select 0) - _xdif / 2;
_ypos = (_base1 select 1) - _ydif / 2;

_pos	= [_xpos,_ypos,0];
if (_ydif==0) exitwith {false};
_dir	= atan ( _xdif / _ydif );
_marker setMarkerPosLocal _pos;
_marker setMarkerDirLocal _dir;
_marker setMarkerSizeLocal [5, ((([ _base1 select 0, _base1 select 1]  distance [ _base2 select 0, _base2 select 1])) / 2) ];
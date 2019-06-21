/*
	Script written by TeeTime dont remove this comment
*/

private ["_base1","_base2","_xdif","_ydif","_xpos","_ypos","_pos","_marker"];

_base1 = _this select 0;
_base2 = _this select 1;
_color = _this select 2;
_offset = _this select 3;

_xdif = (_base1 select 0) - (_base2 select 0);
_ydif = (_base1 select 1) - (_base2 select 1);

_xpos = (_base1 select 0) - _xdif / 2;
_ypos = (_base1 select 1) - _ydif / 2;

_pos	= [_xpos,_ypos,0];
_dir	= atan ( _xdif / _ydif );

_name 	= format ["CM_%1_%2",floor(time),floor(random(1000))];
_type	= "RECTANGLE";

_l = if (ISLAND != 1) then {20} else {10};

_marker = CreateMarkerLocal [_name, _pos];
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerBrushLocal "Solid";
_marker setMarkerDirLocal _dir;
_marker setMarkerSizeLocal [_l, (((_base1 distance _base2)-_offset) / 2) ];
_marker setMarkerColorLocal _color;
_marker setMarkerAlphaLocal 1;
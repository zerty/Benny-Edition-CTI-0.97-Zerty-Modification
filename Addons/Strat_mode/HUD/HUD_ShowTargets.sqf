//if (!visibleMap && profileNamespace getVariable ["HUD_Tactical",true]) then {
if ( profileNamespace getVariable ["HUD_Tactical",true]) then {

{
	_ob=_x select 0;
	_icon=_x select 1;
	_color=_x select 2;
	_shared=_x select 3;
	_size=_x select 4;
	_text=_x select 5;
	_text_size= _size/10;
	_pos = visiblePosition _ob;
	if (_ob isKindOf "Man") then {_pos set[2,((_ob modelToWorld(_ob selectionPosition "head"))select 2)+0.5]} else {_pos set[2, (_pos select 2) +2 ];};
	if !(_icon == "") then {drawIcon3D [_icon, _color, _pos , _size, _size, 0,"", 0, 0, "PuristaMedium"];};
	if !(_text == "") then {drawIcon3D ["", _color, [_pos select 0,_pos select 1,_pos select 2] ,0, 0, 0,_text, 0, _text_size, "PuristaMedium"];};
	if (_shared) then {drawIcon3D ["a3\ui_f\data\map\Markers\NATO\group_7.paa", [_color select 0,_color select 1,_color select 2,1], _pos , _size*2, _size*2, 0,"", 0, 0, "PuristaMedium"];};

} count HUD_Targets;
//[object,texture, color, position, width, height, angle, text, shadow, textSize, font, align]


//if ( (vehicle player) getVariable "AN_iNet" == CTI_P_SideID) then {
{

	_pos=asltoatl getPosASL(_x select 0);
	if ((_x select 0) isKindOf "Man") then {_pos set[2,(((_x select 0) modelToWorld((_x select 0) selectionPosition "head"))select 2)+0.5]} else {_pos set[2, (_pos select 2) +2 ];};
	_dis= (positionCameraToWorld [0,0,0]) distance _pos;
	_fade=1-(_dis/HUD_MAX_RANGE) max 0;
	if ((_x select 0) == (vehicle player)) then {_fade=0;};
	_size=(1-((_dis)/HUD_MAX_RANGE)*0.8) max 0;
	if ((_x select 0) isKindOf "Man") then { _size=_size*0.5;};
	_color = +(_x select 2);
	_color set [3,_fade];
	//(_x select 2) set [3,_fade];
	//diag_log [(_x select 1)+".paa",_color, _pos , _size, _size, 0,(_x select 7), 0, 0, "PuristaMedium"];
	drawIcon3D [(_x select 1)+".paa",_color, _pos , _size, _size, 0,(_x select 7), 0, 0.05*_size, "PuristaMedium"];
}count (SHOWTOMAP select 0)+(SHOWTOMAP select 1) - HUD_Targets;

	/*{
		if (((_x select 0)) call AN_Check_Connection)	then  {
			_off=7;
			if ((_x select 0) isKindOf "Man") then {
				if ((_x select 0) == leader (_x select 0)) then {_off = 5} else {_off = 3};
			} ;
			//if ((_x select 0) isKindOf "Man" && (_x select 0) == leader (_x select 0)) then {_off = 5};
			_posplay= atltoasl visiblePosition player;
			_pos1 = visiblePosition (_x select 0);
			_pos1 set [2,0];
			_pos2= []+ _pos1;
			_pos2 set [2, (_posplay select 2) +_off ];
			_pos3= visiblePosition ((_x select 0) getVariable "AN_Conn");
			_pos3 set [2, (_posplay select 2) +_off ];
			drawLine3D [asltoatl _pos1,asltoatl _pos2,(_x select 3)];
			drawLine3D [asltoatl _pos2,asltoatl _pos3,(_x select 3)];
		}; true
	}count (SHOWTOMAP select 2);*/
};
//};
/*
{
	_pos1= getPos player;
	_pos1 set [2,0.5];
	_pos2= getPos _x;
	_pos2 set [2,0.5];
	drawLine3D [_pos1, _pos2, [1,1,0,1]];
} count (units (group player));*/
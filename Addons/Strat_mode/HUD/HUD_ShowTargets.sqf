//if (!visibleMap && profileNamespace getVariable ["HUD_Tactical",true]) then {
if ( profileNamespace getVariable ["HUD_Tactical",true]) then {
	_sl= (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
	_shared_targets= (_sl getVariable "CTI_HUD_SHARED");


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
		_obj= (_x select 0) ;
		//drawIcon3D  :: [object,texture, color, position, width, height, angle, text, shadow, textSize, font, align]
		if ((_shared_targets findif {_x select 0 == _obj && _x select 1>time}) >-1) then {drawIcon3D ["a3\ui_f\data\map\Markers\NATO\group_7.paa", [_color select 0,_color select 1,_color select 2,1], _pos , _size*2, _size*2, 0,"", 0, 0, "PuristaMedium"];};
		drawIcon3D [(_x select 1)+".paa",_color, _pos , _size, _size, 0,(_x select 7), 0, 0.05*_size, "PuristaMedium"];
		true
	}count (SHOWTOMAP select 0)+(SHOWTOMAP select 1);

};

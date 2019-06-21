
{
	_obj=_x select 0;
	_pos=visiblePosition _obj;
	_pos set[2,((_obj modelToWorld(_obj selectionPosition "head"))select 2)+0.5];
	_fade=_x select 1;
	_size=_x select 2;
	drawIcon3D ['A3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa', [1,0,0,_fade], _pos , _size, _size, 0,"", 0, 0, "PuristaMedium"];
true
} count HUD_Revives;
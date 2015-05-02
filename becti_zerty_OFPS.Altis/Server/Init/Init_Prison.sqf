//--- Create the area for our pro players.
_pos = getMarkerPos "prison";

_z = -1.5;
_m = "Land_Mil_WiredFence_F";
_template = [[_m, 90, [-5,2.6,_z]], [_m, 90, [-5,-2.6,_z]], [_m, 180, [-2.6,5,_z]], [_m, 180, [2.6,5,_z]], [_m, 270, [5,2.6,_z]], [_m, 270, [5,-2.6,_z]], [_m, 0, [-2.6,-5,_z]], [_m, 0, [2.6,-5,_z]]];

{
	_item_modeltoworld = _x select 2;
	_item_pos = [(_pos select 0) + (_item_modeltoworld select 0), (_pos select 1) + (_item_modeltoworld select 1), 0 + (_item_modeltoworld select 2)];
	_item = (_x select 0) createVehicle [0,0,0];
	_item setPos _item_pos;
	_item setDir (_x select 1);
	_item addEventHandler ["handleDamage", {0}];
} forEach _template;
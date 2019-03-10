//--- Create the area for our pro players.
_pos = getMarkerPos "CTI_TUTORIAL";
_off=5.5;
_z = -0.5;
_m = "Land_Mil_WiredFence_F";
_lamp_o="Land_LampHalogen_F";
_lamp_offcet=7;
_text="UserTexture10m_F";
TUTORIAL_EXIT=objNull;

for "_i" from 0 to 3 /* step +1 */ do {
	for "_j" from 1 to 10 /* step +1 */ do {
		_item_pos = [((-30+_j*_off) * cos (_i*90) - (-27.5) * sin (_i*90)),((-30+_j*_off) * sin (_i*90) + (-27.5) * cos (_i*90)),_z];
		_item_pos=_pos vectoradd _item_pos;
		_item = _m createVehicle [0,0,0];
		_item setPos _item_pos;
		_item setDir (180+_i*-90);
		_item enableSimulationGlobal false;
		//ADMIN_ZEUS addCuratorEditableObjects [[_item],false];
	};
	_lamp_pos=[(0 * cos (_i*90) - (-_lamp_offcet) * sin (_i*90)),(0 * sin (_i*90) + (-_lamp_offcet) * cos (_i*90)),-2];
	_lamp_real_pos= _pos vectoradd _lamp_pos;
	_lamp = _lamp_o createVehicle [0,0,0];
	_lamp setPos _lamp_real_pos;
	_lamp setDir (90+_i*-90);
	_lamp addEventHandler ["handleDamage", {0}];
	//ADMIN_ZEUS addCuratorEditableObjects [[_lamp],false];
	/*for "_j" from 0 to 3  do {
		_item_pos = [((15-_j*10) * cos (_i*90) - (-23) * sin (_i*90)),((15-_j*10) * sin (_i*90) + (-23) * cos (_i*90)),5.5];
		_item_pos=_pos vectoradd _item_pos;
		_item = _text createVehicle [0,0,0];
		_item setPos _item_pos;
		_item setDir (180+_i*-90);
		_item enableSimulationGlobal false;
		_item setObjectTextureGlobal [0, format ["Rsc\tuto\%1.jpg",_j]];
		//ADMIN_ZEUS addCuratorEditableObjects [[_item],false];
	};*/
};

TUTORIAL_EXIT= "Land_Wreck_Heli_Attack_01_F" createVehicle _pos;
TUTORIAL_EXIT enableSimulationGlobal false;
//ADMIN_ZEUS addCuratorEditableObjects [[TUTORIAL_EXIT],false];

_pos = getMarkerPos "CTI_TUTORIAL";

_text="UserTexture10m_F";


for "_i" from 0 to 3 /* step +1 */ do {
	for "_j" from 0 to 2 /* step +1j*/ do {
		_item_pos = [((10-_j*10) * cos (_i*90) - (-23) * sin (_i*90)),((10-_j*10) * sin (_i*90) + (-23) * cos (_i*90)),5.5];
		_item_pos=_pos vectoradd _item_pos;
		_item = _text createVehiclelocal [0,0,0];
		_item setPos _item_pos;
		_item setDir (180+_i*-90);
		_item enableSimulation false;

		switch (language) do {
		    case "Russian": {
		    	_item setObjectTexture [0, format ["Rsc\tuto\ru\%1.jpg",_j]];
		    };

		    default {
		     	_item setObjectTexture [0, format ["Rsc\tuto\eng\%1.jpg",_j]];
		    };
		};
		//ADMIN_ZEUS addCuratorEditableObjects [[_item],false];
	};
};
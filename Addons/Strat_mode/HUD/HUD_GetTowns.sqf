	_vt=[];
	{
		_town=_x;
		if ((positionCameraToWorld [0,0,0]) distance _x < (HUD_MAX_RANGE*2) /*&& {_x == SM_Ask_Town} count _vt ==0*/) then {

			_fade =0.9;
			if ({_x == _town} count (CTI_P_SideLogic getvariable ["CTI_AVAILLABLE",[]]) > 0) then {_fade = 0.75;};
			if ({_x == _town} count (CTI_P_SideLogic getvariable ["CTI_ACTIVE",[]]) > 0) then {_fade = 0.3;};
			_marker = format ["cti_town_marker_%1", _town];
			_color = 	switch (getMarkerColor _marker) do {
				case 	"ColorGreen":{
					[0, 1, 0, 1]
				};
				case 	"ColorBlue":{
					 [0, 0, 1, 1]
				};
				case 	"ColorRed":{
					 [1, 0, 0, 1]
				};
				default {
					[0, 1, 0, 1]
				};
			};
			if (_town == (CTI_P_SideLogic getvariable ["CTI_PRIORITY",objnull])) then {
					_color = [0.99, 0.81, 0.09, 1];
			};
			_text = format ["%1-(%2m)",(_town getVariable "cti_town_name"),ceil ((positionCameraToWorld [0,0,0])  distance _town)];
			_vt=_vt+[[_town,_text,_color,_fade]];

		};
	true
	}count CTI_Towns;

	_vt
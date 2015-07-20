#define HUD_IDC 1500000
#define	HUD_TOWN_MAX	20


_hud=_this select 0;

disableSerialization;
if ( (!visibleMap  ) && (profileNamespace getVariable ["HUD_Normal",true]) ) then {
	for "_i" from 0 to HUD_TOWN_MAX  do {
		_ct=(_hud displayCtrl(HUD_IDC+400+_i));
		_ctl=(_hud displayCtrl(HUD_IDC+500+_i));
		if (count HUD_Towns > _i) then {
			_town = (HUD_Towns select _i) select 0;
			_text = (HUD_Towns select _i) select 1;
			_color= (HUD_Towns select _i) select 2;
			_fade = (HUD_Towns select _i) select 3;
			_pos1 = (worldToScreen (visiblePosition _town));
			if (count _pos1 >0) then {
				_ct ctrlShow true;
				_ctl ctrlShow true;
				_pos2 = [_pos1 select 0,(_pos1 select 1)- ((_pos1 select 1)* (player distance _town) /(HUD_MAX_RANGE*2))];
				_ct ctrlSetPosition [(_pos2 select 0),(_pos2 select 1)-0.05] + [0.3,0.1];
				_ct ctrlSetText _text;
				_ctl ctrlSetPosition _pos1 + [0, -((_pos1 select 1)-(_pos2 select 1))];
				_ct ctrlSetFade _fade;
				_ctl ctrlSetFade _fade;
				_ct ctrlSetTextColor _color;
				_ctl ctrlSetTextColor _color;
			} else {
				_ct ctrlShow false;
				_ctl ctrlShow false;
			};
		} else {
				_ct ctrlShow false;
				_ctl ctrlShow false;
		};
		_ct ctrlCommit 0;
		_ctl ctrlCommit 0;
	};
} else {
	for "_i" from 0 to HUD_TOWN_MAX  do {(_hud displayCtrl(HUD_IDC+400+_i)) ctrlShow false;(_hud displayCtrl(HUD_IDC+500+_i)) ctrlShow false;};
};
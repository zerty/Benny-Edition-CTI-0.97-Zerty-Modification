#define HUD_IDC 1500000


HUD_PBar_start={
	_text=_this select 0;
	_down=_this select 1;
	_up=_this select 2;
	_start=_this select 3;
	disableSerialization;
	_hud=uiNamespace getVariable 'HUD';
	uiNamespace setVariable ["PB_BOTTOM",_down];
	uiNamespace setVariable ["PB_TOP",_up];
	_bg=(_hud displayCtrl(HUD_IDC+4));
	_pb=(_hud displayCtrl(HUD_IDC+5));
	_t=(_hud displayCtrl(HUD_IDC+6));
	_bg ctrlShow true;
	_pb ctrlShow true;
	_pb progressSetPosition _start;
	_t ctrlSetText  _text;
	_t ctrlshow true;


};
HUD_PBar_stop={
	disableSerialization;
	_hud=uiNamespace getVariable 'HUD';
	_bg=(_hud displayCtrl(HUD_IDC+4));
	_pb=(_hud displayCtrl(HUD_IDC+5));
	_t=(_hud displayCtrl(HUD_IDC+6));
	_bg ctrlShow false;
	_pb ctrlShow false;
	_t ctrlSetText "";
	_t ctrlShow false;

};
HUD_PBar_update={
	_value = _this;
	disableSerialization;
	_hud=uiNamespace getVariable 'HUD';
	_pb=(_hud displayCtrl(HUD_IDC+5));
	_down=uiNamespace getVariable 'PB_BOTTOM';
	_up=uiNamespace getVariable 'PB_TOP';
	_rv=(_value - _down )/_up;
	_pb progressSetPosition _rv;
};

disableSerialization;
_hud=uiNamespace getVariable 'HUD';
0 call HUD_PBar_stop;
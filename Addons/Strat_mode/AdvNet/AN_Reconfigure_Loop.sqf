while {! CTI_GameOver && alive  _this } do {
	if (! local _this && _this isKindOf "Man") exitwith {false};
	_this call AN_Reconfigure;
	sleep 10+random(15);
};
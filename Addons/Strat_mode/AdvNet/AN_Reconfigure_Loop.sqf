while {! CTI_GameOver && alive  _this } do {
	if (((! local _this) && _this isKindOf "Man") || !(isPlayer _this) && (_this in (playableUnits+switchableUnits)) || ((side _this) == resistance && _this isKindOf "Man") || !(alive _this)) exitwith {false};
	if !(_this call AN_Check_Connection) then { _this call AN_Reconfigure;};
	sleep 10+random(10);
};
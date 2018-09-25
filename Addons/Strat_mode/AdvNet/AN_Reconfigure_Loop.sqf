while {! CTI_GameOver && alive  _this } do {
	if (((! local _this) && _this isKindOf "Man") || !(isPlayer _this) && (_this in (playableUnits+switchableUnits)) || ((side _this) == resistance && _this isKindOf "Man") || !(alive _this)) exitwith {if (NET_LOG) then {diag_log format [":: NET :: Canceling reconfiguration process for %1",_this]};false};
	if (NET_LOG) then {diag_log format [":: NET :: Running reconfiguration process for %1",_this]};
	_this call AN_Reconfigure;
	sleep 10+random(10);
};
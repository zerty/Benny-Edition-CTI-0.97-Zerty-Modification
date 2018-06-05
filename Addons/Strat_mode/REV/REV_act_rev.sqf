private ["_unit"];
_unit= _this select 0;
_caller = _this select 1;
_caller playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 5;
if (isplayer _caller && !((animationstate _caller ) == "AinvPknlMstpSlayWrflDnon_medic")) exitwith {false};
_unit setvariable ["REV_DRAGGED",false,true];
_unit setDamage 0.25;
_unit setVariable ["REV_REQREV", true, true];

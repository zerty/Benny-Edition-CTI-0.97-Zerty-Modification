private ["_veh","_proj","_side_u","_side_v","_up_trt","_dir","_side_tr","_side_time","_b"];
_veh = _this select 0;
_proj= _this select 1;
_side_u=side (_this select 2);

_side_v=_veh getVariable ["cti_occupant",civilian];
//diag_log format ["Trophy ::  %1 (%2) shooting on %3 (%4) with %5", (_this select 2),_side_u,(_this select 0),_side_v,(_this select 1)];
if ( _side_v==_side_u ) exitWith{diag_log format ["Trophy :: skipping %1 same side (%2)", _veh,_side_u];};
_up_trt=if (! (count ((_side_v) call CTI_CO_FNC_GetSideUpgrades) == 0)) then {((_side_v) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TRT} else {0};
if (isnil {_veh getVariable "TROPHY_ammo_l"}) exitWith {diag_log format ["Trophy :: not activated on %1", _veh];}; // no trophy system installed
_dir=[_veh, _proj] call CTI_CO_FNC_GetDirTo;
if (_dir >= -10 && _dir<= 10 || _dir >= 170 || _dir <= -170) exitWith {diag_log format ["Trophy :: blind spot on %1 :: %2", _veh,_dir];};
_side_tr= if(_dir >20 && _dir <160) then {"TROPHY_ammo_r"} else {"TROPHY_ammo_l"};
_side_time= if(_dir >20 && _dir <160) then {"TROPHY_time_r"} else {"TROPHY_time_l"};
waitUntil {! alive _veh|| isNull _proj || _proj distance _veh <50};
//if (!(alive _veh) ||  isNull _proj) exitWith {diag_log "Trophy :: vehicle down or ammo destroyed"}; // veh or ammo destroyed
if (!(alive _veh) ||  isNull _proj) exitWith {false};
//diag_log format ["Trophy :: Testing trophy on %1 :: side %2", _veh,_side_v];
if (_veh getVariable _side_tr <=0 || time - (_veh getVariable _side_time)< (60/(1+_up_trt)) ) exitWith {diag_log "Trophy :: failed no ammo or cooldonw"}; // no trophy ammo left or in timeout
if (random (100) >= (50+(_up_trt*15))) exitWith {diag_log "Trophy :: probability failed"}; //protection failed
_b='ProtectionZone_Invisible_F' createVehicleLocal (getpos _veh);
//_b='ProtectionZone_F' createVehiclelocal (getpos _veh);
//diag_log format ["Trophy :: Trophy sucessfull on %1", _veh];
_b setPos (getPos _veh);
_veh setVariable [_side_tr,((_veh getVariable _side_tr) - 1),true];
_veh setVariable [_side_time,time,true];
waitUntil {isNull _proj};
deleteVehicle _b;
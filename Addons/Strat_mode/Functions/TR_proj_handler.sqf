

private ["_veh","_proj","_side_u","_side_v","_up_trt","_dir","_side_tr","_side_time","_b"];
_veh = _this select 0;
_proj= _this select 1;
_side_u=side (_this select 2);


_ignored_proj = ["R_PG32V_F", "R_TBG32V_F", "M_NLAW_AT_F", "R_PG7_F", "M_SPG9_HEAT", "M_SPG9_HE", "R_MRAAWS_HEAT_F"];
if (typeOf _proj in _ignored_proj) exitWith{diag_log format ["Trophy :: skipping %1 irgnoring projectile (%2)", _veh,typeOf _proj];};


_side_v=_veh getVariable ["cti_occupant",civilian];
//Check Side
if ( _side_v==_side_u ) exitWith{diag_log format [":: Trophy :: skipping %1 same side (%2)", _veh,_side_u];};

//Check upgrade
_up_trt=if (! (count ((_side_v) call CTI_CO_FNC_GetSideUpgrades) == 0)) then {((_side_v) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TRT} else {0};
if (isnil {_veh getVariable "TROPHY_ammo_l"}) exitWith {diag_log format ["Trophy :: not activated on %1", _veh];};



// Wait for the Proj to be in range
waitUntil {! alive _veh|| isNull _proj || _proj distance _veh <50};
if (!(alive _veh) ||  isNull _proj) exitWith {false};

//get side of trophy to use
_dir=[_veh, _proj] call CTI_CO_FNC_GetDirTo;
if (_dir >= -10 && _dir<= 10 || _dir >= 170 || _dir <= -170) exitWith {diag_log format ["Trophy :: blind spot on %1 :: %2", _veh,_dir];};
_side_tr= if(_dir >20 && _dir <160) then {"TROPHY_ammo_r"} else {"TROPHY_ammo_l"};
_side_time= if(_dir >20 && _dir <160) then {"TROPHY_time_r"} else {"TROPHY_time_l"};


//Check probability and ammo on side
if (_veh getVariable _side_tr <=0 || time - (_veh getVariable _side_time)< (300/(1+_up_trt)) ) exitWith {diag_log "Trophy :: failed no ammo or cooldonw"};
if (random (100) >= (30+(_up_trt*15))) exitWith {diag_log ":: Trophy :: probability failed"}; //protection failed

//Create the protection zone
_b='ProtectionZone_Invisible_F' createVehicleLocal (getpos _veh);
_b setPos (getPos _veh);
_veh setVariable [_side_tr,((_veh getVariable _side_tr) - 1),true];
_veh setVariable [_side_time,time,true];
if(_veh == vehicle player) then {
	["trophy","playSound",_veh, false,false] call BIS_fnc_MP;
};
waitUntil {isNull _proj};
deleteVehicle _b;
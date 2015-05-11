private ["_obj","_handdled"];

_obj=_this;
//diag_log format [":: REV:: trying to remote object as %1", _obj];

if (local _obj) exitwith {false};
REV_REMOTE_HANDELD=REV_REMOTE_HANDELD-[objNull];
if (_obj in REV_REMOTE_HANDELD) exitwith {false};

//if (local _obj) then {_obj call REV_OBJ_INIT};
REV_REMOTE_HANDELD set [count REV_REMOTE_HANDELD,_obj];

private ["_obj","_handdled"];

_obj=_this;
//diag_log format [":: REV:: trying to remote object as %1", _obj];

if (local _obj) exitwith {false};
REV_REMOTE_HANDELD=REV_REMOTE_HANDELD-[objNull];
if (_obj in REV_REMOTE_HANDELD) exitwith {false};
//_obj addaction ["<t color='#C90000'>Revive</t>",REV_ACT_REV, [], 9, false, true, "", "_this != _target && _target getVariable ['REV_UNC',false]&& _target distance _this <2 && isNull (_this getVariable ['REV_DRAGGING',objNull])&& (side group _this)==(side group _target) && !( isplayer _this)"];
//_obj addaction ["<t color='#C90000'>Drag</t>",REV_ACT_DRAG, [], 9, false, true, "", "_this != _target && _target getVariable ['REV_UNC',false]&&!(_target getVariable ['REV_DRAGGED',true])&& isNull (_this getVariable ['REV_DRAGGING',objNull])&& _target distance _this <2 && isplayer _this && (side group _this)==(side group _target)"];

//if (local _obj) then {_obj call REV_OBJ_INIT};
REV_REMOTE_HANDELD set [count REV_REMOTE_HANDELD,_obj];

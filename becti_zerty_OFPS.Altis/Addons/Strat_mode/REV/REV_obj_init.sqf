private ["_obj","_handdled"];
_obj=_this;

diag_log format [":: REV:: trying to handle player as %1", _obj];
waitUntil {! isnull _obj && alive _obj};


_obj setvariable ["REV_UNC",false,true];
_obj setvariable ["REV_DRAGGED",false,true];
_obj setvariable ["REV_DRAGGING",objnull,false];

_obj addeventhandler["HandleDamage",REV_HANDLER];

_obj addaction ["<t color='#C90000'>Suicide</t>",REV_ACT_SUIC, [], 9, false, true, "", "_this == _target && _target getVariable ['REV_UNC',false]"];
_obj addaction ["<t color='#C90000'>Revive</t>",REV_ACT_REV, [], 9, false, true, "", "! (isplayer _this)  && _target getVariable ['REV_UNC',true]&& (_target distance _this) <100"];//
//_obj addaction ["<t color='#C90000'>Release</t>",REV_ACT_REL, [], 9, false, true, "", "_this == _target && ! (_target getVariable ['REV_UNC',true])&&!(_target getVariable ['REV_DRAGGED',true])&& ! isNull (_this getVariable ['REV_DRAGGING',objNull])"];

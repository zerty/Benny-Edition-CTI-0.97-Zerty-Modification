/*
* Example:
* player addAction ([player] call Addon_Simple_Earplugs);
* 
*/
_player = _this select 0;
_userAction = ["<t color='#1E90FF'>Put on ear plugs</t>",{
	_s = _this select 0;
	_i = _this select 2;
	if (soundVolume != 1) then {
		1 fadeSound 1;
		_s setUserActionText [_i,"<t color='#1E90FF'>Put on ear plugs</t>"];
	} else {
		1 fadeSound 0.4;
		_s setUserActionText [_i,"<t color='#1E90FF'>Take off ear plugs</t>"];
	}
},[],-90,false,true,"","_target == vehicle player"];

_userAction;
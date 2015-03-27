Private ["_m","_milalpha"];

_milalpha = [ "Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliet","Kilo","Lima","Mike",
"November","Oscar","Papa","Quebec","Romeo","Sierra","Tango","Uniform","Victor","Whiskey","Commander"];

_m = count _milalpha;
{
	waitUntil {!isNil {_x getVariable "cti_teams"}};
	{
		if !(isNil '_x' && _forEachIndex < _m) then {_x setGroupID [_milalpha select _forEachIndex]};
		if (CTI_IsClient) then {_x setVariable ["cti_alias", _milalpha select _forEachIndex]};
	} forEach (_x getVariable "cti_teams");
} forEach [CTI_WEST, CTI_EAST];
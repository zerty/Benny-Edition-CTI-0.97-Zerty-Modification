SM_ST_Create = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Map_Statics_Create.sqf";
SM_ST_Loop = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Map_Statics_Loop.sqf";

_towns = []+CTI_Towns;

_number = ceil ((count _towns)/6);

SM_ST_PARAM=[["AT",_number],["AA",_number]];

SM_ST_Groups=[];


{
	for "_i" from 0 to (_x select 1) step 1 do
	{
		_town = selectRandom _towns;
		_towns= _towns - [_town];
		_g=[_x select 0 ,_town] call SM_ST_Create;
		SM_ST_Groups pushBackUnique _g;
	};
	true
} count SM_ST_PARAM;


0 spawn SM_ST_Loop;
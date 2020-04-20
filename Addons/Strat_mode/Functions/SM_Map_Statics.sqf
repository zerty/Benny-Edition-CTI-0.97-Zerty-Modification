SM_ST_Create = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Map_Statics_Create.sqf";
SM_ST_Clean = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Map_Statics_Clean.sqf";
SM_ST_Loop = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Map_Statics_Loop.sqf";

SM_ST_PARAM=[["AT",15],["AA",8]];

_group = createGroup resistance;
_group setVariable ["cti_server_group", str "GUER"];

SM_ST_Groups=_group;

_towns = []+CTI_Towns;


{
	for "_i" from 0 to (_x select 1) step 1 do
	{
		_town = selectRandom _towns;
		_towns= _towns - [_town];
		[_x select 0 ,_town,_group] call SM_ST_Create;
	};
	true
} count SM_ST_PARAM;

{
	_x setskill 0.8;
	_x setSkill ["spotDistance", 1];
	_x setSkill ["spotTime", 1];
	_x disableAI "MOVE" ;
 	true
} count (units _group);

_group setCombatMode "RED";
_group  setBehaviourStrong "COMBAT";

0 spawn SM_ST_Loop;
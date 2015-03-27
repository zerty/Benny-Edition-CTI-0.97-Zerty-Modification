/*

    unit: Object - Object the event handler is assigned to
    weapon: String - Fired weapon
    muzzle: String - Muzzle that was used
    mode: String - Current mode of the fired weapon
    ammo: String - Ammo used
    magazine: String - magazine name which was used
    projectile: Object - Object of the projectile that was shot (Arma 2: OA and onwards)

*/
private ["_unit","_weap","_ammo","_proj","_s","_logic","_structures","_radars"];

_unit=_this select 0;
_weap=_this select 1;
_ammo=_this select 4;
_proj=_this select 6;

if !(_weap == "mortar_155mm_AMOS" || _weap == "rockets_230mm_GAT" || _weap == "mortar_82mm") exitWith {false};

//diag_log format [":: ART Radar ::%2:: starting handling %1", _this,_proj];
{
	_s=_x;
	_logic=_x  call CTI_CO_FNC_GetSideLogic;
	_structures=_logic getvariable ["cti_structures",[]];
	_radars=[CTI_RADAR, _structures] call CTI_CO_FNC_GetSideStructuresByType;
	_side=if (! isnil {_unit getvariable "CTI_Net"}) then {(_unit getvariable "CTI_Net") call CTI_CO_FNC_GetSideFromID} else {side _unit};
	if ([_x, CTI_UPGRADE_ARTR, 1] call CTI_CO_FNC_HasUpgrade && !(_side == _s)) then {_radars=[CTI_RADAR, _structures] call CTI_CO_FNC_GetSideStructuresByType;} else {_radars=[];};
	//diag_log format [":: ART Radar ::%2::%3::Found radars %1", _radars,_proj,_x];
	{[_x,_proj,_s] spawn ARTR_PROJ_HANDLER;true} count _radars;
	true
} count [east,west];

true

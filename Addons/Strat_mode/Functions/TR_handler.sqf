/*

    unit: Object - Object the event handler is assigned to
    weapon: String - Fired weapon
    muzzle: String - Muzzle that was used
    mode: String - Current mode of the fired weapon
    ammo: String - Ammo used
    magazine: String - magazine name which was used
    projectile: Object - Object of the projectile that was shot (Arma 2: OA and onwards)

*/
private ["_unit","_ammo","_proj","_tro_v"];
_unit=_this select 0;
_ammo=_this select 4;
_proj=_this select 6;

if !(_proj isKindOf "RocketCore" || _proj isKindOf "MissileCore") exitWith {false};
_tro_v= _unit nearEntities [["tank", "Wheeled_APC_F"],((missionNamespace getVariable "CTI_GRAPHICS_VD_MAX")*2)];
{
	[_x,_proj,_unit] spawn TR_PROJ_HANDLER;
	true
} count (_tro_v)	 ;

true

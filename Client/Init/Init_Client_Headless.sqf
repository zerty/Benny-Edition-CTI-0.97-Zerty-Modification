
CTI_SE_FNC_SpawnTownOccupation = compileFinal preprocessFileLineNumbers "Server\Functions\Server_SpawnTownOccupation.sqf";
CTI_SE_FNC_SpawnTownResistance = compileFinal preprocessFileLineNumbers "Server\Functions\Server_SpawnTownResistance.sqf";
CTI_SM_Mortars_script = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Mortar.sqf";
TR_PROJ_HANDLER = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\TR_proj_handler.sqf";
TR_HANDLER = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\TR_handler.sqf";


0 execVM "Addons\Strat_mode\Functions\SM_Town_CAS.sqf";
CENTER_POS=getMarkerPos "CENTER_POS";
CENTER_RADIUS=(getMarkerSize "CENTER_POS")select 0;
HELO_STARTUP=[];
_i=0;
while {! (((getMarkerPos format ["HELO_START_%1", _i])select 0) == 0)} do
{
    if (((getMarkerPos format ["HELO_START_%1", _i]) distance CENTER_POS)<CENTER_RADIUS) then { HELO_STARTUP set [count HELO_STARTUP,getMarkerPos format ["HELO_START_%1", _i]]};
    _i=_i+1;
};

// Patrols
if ( (missionNamespace getVariable 'CTI_SM_PATROLS')==1) then {
	0 execVM "Addons\Strat_mode\PATROL_AI\PAI_Init.sqf";
};
profileNamespace setVariable ["CTI_SAVE_ENABLED",True];

// save town status
_towns=[];
{_towns pushBack [_x getVariable "cti_town_lastSideID", _x getVariable "cti_town_sideID"];true}count (CTI_TOWNS);
profileNamespace setVariable ["CTI_SAVE_TOWNS",_towns];

{
	_save=[];
	_side = _x;
	_logic= (_side) call CTI_CO_FNC_GetSideLogic;
	//save hq
	_hq=(_side) call CTI_CO_FNC_GetSideHQ;
	_save pushBack [[(getposATL _hq),getDir _hq],(alive _hq)];
    //save com money
    _save pushBack ((_side)call CTI_CO_FNC_GetFundsCommander);
	//save upgrades
	_save pushBack ((_side) call CTI_CO_FNC_GetSideUpgrades);
	//save Base Areas
	_save pushBack  (_logic getVariable "cti_structures_areas");
	//save structure
	_save_structures=[];
	_structures=(_side) call CTI_CO_FNC_GetSideStructures;
	{_save_structures pushBack [_x getVariable "cti_save", [getPosATL _x, getDir _x],getDammage _x];true}count _structures;
	_save pushBack _save_structures;
	//save WIP structure
	_save_structures=[];
	{_save_structures pushBack [_x getVariable "cti_save", [getPosATL _x, getDir _x],getDammage _x];true} count (_logic getVariable "cti_structures_wip");
	_save pushBack _save_structures;
	//save defenses
	_save_structures=[];
	{_save_structures pushBack (_x getVariable "cti_save");true} count (_logic getVariable "cti_defences");
	_save pushBack _save_structures;
	//Current upgrade
	_save pushBack [(_logic getVariable "cti_upgrade"),(_logic getVariable "cti_upgrade_level"),(_logic getVariable "cti_upgrade_lt")];


	profileNamespace setVariable [format ["CTI_SAVE_%1", _side],_save];
} forEach [east,west];

//save players variables
_players=[];
{_players pushBack [_x,missionNamespace getVariable _x];true}count CTI_PLAYER_VARIABLES;
profileNamespace setVariable ["CTI_SAVE_PLAYERS",_players];


saveProfileNamespace;
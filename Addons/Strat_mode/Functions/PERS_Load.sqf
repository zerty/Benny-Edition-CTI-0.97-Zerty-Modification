diag_log " :: SAVE :: Trying to load";
_towns = profileNamespace getVariable ["CTI_SAVE_TOWNS",[]];
if (count _towns == count CTI_TOWNS) then  {

    diag_log ":: SAVE :: Loading";
    { _x setVariable ["cti_town_lastSideID", (_towns select _foreachindex) select 0, true];[_x, ((_towns select _foreachindex) select 1) call CTI_CO_FNC_GetSideFromID] call CTI_SE_FNC_OnTownCaptured;true }foreach (CTI_TOWNS);

    {
    	_side=_x;
    	_logic= (_side) call CTI_CO_FNC_GetSideLogic;
    	_load=profileNamespace getVariable format ["CTI_SAVE_%1", _side];

    	//hq
         diag_log format [":: SAVE :: Setting up hq",(_load select 0 )];
    	_hq=(_side) call CTI_CO_FNC_GetSideHQ;
    	_hq setposATL (((_load select 0 ) select 0)select 0);
    	_hq setdir (((_load select 0 ) select 0)select 1);
    	if !(((_load select 0 ) select 1)) then {_hq setDamage 1};

        // com funds
        diag_log format [":: SAVE :: Setting team funds",(_load select 1 )];
        _logic setvariable ["cti_commander_funds",(_load select 1 ),true];

        // upgrades
        diag_log format [":: SAVE :: Loading Upgrades",(_load select 2 )];
        _logic setVariable ["cti_upgrades", (_load select 2 ), true];

        //base area
        diag_log format [":: SAVE :: Loading Base areas",(_load select 3 )];
        _logic setVariable ["cti_structures_areas", (_load select 3 ), true];

        //structures
        {diag_log format [":: SAVE :: Loading %1",_x];
    	_build=[(_x select 0), _side,(_x select 1)  select 0 ,(_x select 1)  select 1 ] call CTI_SE_FNC_BuildStructure;
    	sleep 0.1;
    	_build setvariable ["cti_completion",100,true];
    	true
    	} count (_load select 4);

        //WIP structures
        {diag_log format [":: SAVE :: Loading %1",_x]; _build=[(_x select 0), _side,(_x select 1)  select 0 ,(_x select 1)  select 1 ] call CTI_SE_FNC_BuildStructure;_build setvariable ["cti_completion",100,true];true} count (_load select 5);

        //defences
        {diag_log format [":: SAVE :: Loading %1",_x]; [_x select 0, _side,(( _x select 1) select 0), (( _x select 1) select 1),objnull, false, _x select 2] call CTI_SE_FNC_BuildDefense;true} count (_load select 6);

        //curent upgrade
        diag_log format [":: SAVE :: Loading upgrade %1",(_load select 7)];
        if (((_load select 7) select 0 ) > -1) then {_logic setvariable ["cti_upgrade_lt",((_load select 7) select 2 ),true]; [_side,((_load select 7) select 0 ), ((_load select 7) select 1 )] spawn CTI_SE_FNC_StartUpgrade;   };

        //bases found
        diag_log format [":: SAVE :: Loading detected bases %1 for side %2",(_load select 10),_x];
        _logic setVariable ["CTI_BASES_FOUND",(_load select 10),true];

    } forEach [east,west];



    _loadwest = profileNamespace getVariable format ["CTI_SAVE_%1", west];
    _loadeast = profileNamespace getVariable format ["CTI_SAVE_%1", east];

    //current time [H]Tom
    diag_log format [":: SAVE :: Time",(_loadwest select 8)];
    _currenttime = round (daytime);
    if (_currenttime > (_loadwest select 8)) then {skipTime ((24 - _currenttime) + (_loadwest select 8));};
    if (_currenttime < (_loadwest select 8)) then {skipTime ((_loadwest select 8) - _currenttime);};



    //team score west [H]Tom
    diag_log format [":: SAVE :: TeamScoreWest",(_loadwest select 9)];
    west addScoreSide (_loadwest select 9);

    //team score east [H]Tom
    diag_log format [":: SAVE :: TeamScoreEast",(_loadeast select 9)];
    east addScoreSide (_loadeast select 9);

    //Time Left [H]Tom
    diag_log format [":: SAVE :: TimeLimit",(_loadwest select 11)];
    if (_loadwest select 11 > 0) then {
        missionNamespace setVariable ["CTI_MAX_MISSION_TIME",((_loadwest select 11)/60),true];
    };

} else {
    diag_log " :: SAVE :: Loading fail";
};

{
    _side=_x;
    _logic= (_side) call CTI_CO_FNC_GetSideLogic;
    _logic setVariable ["CTI_LOAD_COMPLETED",true,true];
} forEach [east,west];

CTI_Init_Server=True;
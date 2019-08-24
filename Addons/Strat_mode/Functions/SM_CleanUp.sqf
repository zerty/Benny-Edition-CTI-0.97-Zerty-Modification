SM_CLEAN_REVIVES={
	while {!CTI_GameOver} do
	{
	    {if (!isnil {_x getVariable "REV_UNC"}) then  {if (!isPlayer _x && (_x getVariable "REV_UNC")  ) then {_x setDammage 1;}};true}count playableUnits;
	    sleep 3;
	};
};

SM_CLEAN_GROUPS={

	private ["_g","_players","_unit"];
	while {!CTI_GameOver} do
	{
	    {
	    	_g=group _x;
	    	if ! (side _g == resistance) then {
		    	_players={isPlayer _x} count (units _g);
		    	if (_players==0) then {
		    		{
		    		 if !(vehicle _x == _x) then {
		    		 	(vehicle _x) lock false;
		    		 	unAssignVehicle _x;
							_x action ["eject", vehicle _x];
							_x action ["getOut", (vehicle _x)];
		    		 };
		    		 deleteVehicle _x; true
		    		} count (units _g)
		    	};
		    }; true
	    }count playableUnits;
	    sleep 3;
	};
};

SM_CLEAN_GCONT= {
	private ["_timeout","_time"];
	_timeout={
		_time=time;
		waitUntil {time > _time + 240};
		deleteVehicle (_this);
	};
	while {! CTI_GameOver} do {
		{
			//if (simulationEnabled _x) then {_x enableSimulationGlobal false};
			if (isNil {_x getVariable "GC"}) then {
			 _x setVariable ["GC",true];
			 (_x) spawn _timeout;
			};
		} forEach allMissionObjects "GroundWeaponHolder";
		sleep 10;
	};
};

//Clean all groups that are no longer tracked by the mission (e.g. kicked units from BIS_fnc_dynamicGroups)
SM_CLEAN_DG= {
	private ["_side", "_logic", "_groups", "_check"];
	_check = { 		
		params ["_side"];
		_logic=(_side) call CTI_CO_FNC_GetSideLogic;
		_groups = allGroups select {side _x isEqualTo _side};
		{
			//Exclude all town defenses, player groups, or workers
			if( !(_x in (["GetAllGroups",[]] call BIS_fnc_dynamicGroups)) &&
				("" == _x getVariable ["cti_server_group", ""]) &&
				("" == _x getVariable ["cti_role_evo", ""]) &&
				(_x != _logic getVariable ["cti_defensive_team", grpNull]) &&
				//((units _x) findIf {!isDamageAllowed _x} >= 0) &&
				((units _x) findIf {_x in (_logic getVariable ["cti_workers", []])} == -1) &&
				((units _x) findIf {unitIsUAV (vehicle _x)} == -1)
				) then {
					//Empty the group and delete it
					{ deleteVehicle _x }forEach units _x; 
					deleteGroup _x;
			}
		} forEach _groups;
	};
	
	while {! CTI_GameOver} do {
		{
			[_x] call _check;
		} forEach [east,west];
		sleep 10;
	};
};


SM_CLEAN_STRUCTURES={
	private ["_side","_side_logic","_new_structures"];
	_side=_this;
	_side_logic=(_side) call CTI_CO_FNC_GetSideLogic;
	while {!CTI_GameOver} do {
		_new_structures=[];
		{if (getdammage _x == 1) then {deleteVehicle _x} else {_new_structures set [count _new_structures,_x]};true}count ( _side_logic getVariable ["cti_structures",[]]);
		_side_logic setVariable  ["cti_structures",_new_structures,true];
	    sleep 60;
	};
};

0 spawn SM_CLEAN_REVIVES;
if (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED" ==0)then { 0 spawn SM_CLEAN_GROUPS};
0 spawn SM_CLEAN_GCONT;
0 spawn SM_CLEAN_DG;
{
	_x spawn SM_CLEAN_STRUCTURES;
} forEach [east,west];
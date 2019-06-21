
//todo: Kerberos Tracker -> perma track main infos with clients UID (teamkills, kills, hq killed (ff/no ff)).

//--- Create a resistance center
createCenter resistance;
resistance setFriend [west, 0];
resistance setFriend [east, 0];
resistance setFriend [civilian, 0];

CTI_SE_FNC_AddScore = compileFinal preprocessFileLineNumbers "Server\Functions\Server_AddScore.sqf";
CTI_SE_FNC_AI_PurchaseSquad = compileFinal preprocessFileLineNumbers "Server\Functions\Server_AI_PurchaseSquad.sqf";
CTI_SE_FNC_BuildStructure = compileFinal preprocessFileLineNumbers "Server\Functions\Server_BuildStructure.sqf";
CTI_SE_FNC_BuildDefense = compileFinal preprocessFileLineNumbers "Server\Functions\Server_BuildDefense.sqf";
CTI_SE_FNC_CreateWorker = compileFinal preprocessFileLineNumbers "Server\Functions\Server_CreateWorker.sqf";
CTI_SE_FNC_HandleAIPurchase = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleAIPurchase.sqf";
CTI_SE_FNC_HandleEmptyVehicle = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleEmptyVehicle.sqf";
CTI_SE_FNC_HandleStaticDefenses = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleStaticDefenses.sqf";
CTI_SE_FNC_HandleStructureConstruction = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleStructureConstruction.sqf";
CTI_SE_FNC_InitializeGroup = compileFinal preprocessFileLineNumbers "Server\Functions\Server_InitializeGroup.sqf";
CTI_SE_FNC_InitializeStructure = compileFinal preprocessFileLineNumbers "Server\Functions\Server_InitializeStructure.sqf";
CTI_SE_FNC_NoobLogger = compileFinal preprocessFileLineNumbers "Server\Functions\Server_NoobLogger.sqf";
CTI_SE_FNC_NoobLoggerEnd = compileFinal preprocessFileLineNumbers "Server\Functions\Server_NoobLoggerEnd.sqf";
CTI_SE_FNC_ObservateEnvironment = compileFinal preprocessFileLineNumbers "Server\Functions\Server_ObservateEnvironment.sqf";
CTI_SE_FNC_OnBuildingDestroyed = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnBuildingDestroyed.sqf";
CTI_SE_FNC_OnBuildingHandleDamage = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnBuildingHandleDamage.sqf";
CTI_SE_FNC_OnBuildingHandleVirtualDamage = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnBuildingHandleVirtualDamage.sqf";
CTI_SE_FNC_OnBuildingHit = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnBuildingHit.sqf";
CTI_SE_FNC_OnClientPurchase = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnClientPurchase.sqf";
CTI_SE_FNC_OnClientPurchaseCancelled = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnClientPurchaseCancelled.sqf";
CTI_SE_FNC_OnClientPurchaseComplete = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnClientPurchaseComplete.sqf";
CTI_SE_FNC_OnDefenseDestroyed = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnDefenseDestroyed.sqf";
CTI_SE_FNC_OnHQDestroyed = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnHQDestroyed.sqf";
CTI_SE_FNC_OnTownCaptured = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnTownCaptured.sqf";
CTI_SE_FNC_RepairHQ = compileFinal preprocessFileLineNumbers "Server\Functions\Server_RepairHQ.sqf";
CTI_SE_FNC_SpawnTownOccupation = compileFinal preprocessFileLineNumbers "Server\Functions\Server_SpawnTownOccupation.sqf";
CTI_SE_FNC_SpawnTownResistance = compileFinal preprocessFileLineNumbers "Server\Functions\Server_SpawnTownResistance.sqf";
CTI_SE_FNC_StartFactoryQueue = compileFinal preprocessFileLineNumbers "Server\Functions\Server_StartFactoryQueue.sqf";
CTI_SE_FNC_StartUpgrade = compileFinal preprocessFileLineNumbers "Server\Functions\Server_StartUpgrade.sqf";
CTI_SE_FNC_TrashObject = compileFinal preprocessFileLineNumbers "Server\Functions\Server_TrashObject.sqf";
CTI_SE_FNC_Cache = compileFinal preprocessFileLineNumbers "Server\Functions\Server_CacheVehicle.sqf";

PERS_SAVE = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\PERS_save.sqf";
PERS_LOAD = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\PERS_Load.sqf";


funcCalcAlignPosDir = compileFinal preprocessFileLineNumbers "Server\Functions\Externals\fCalcAlignPosDir.sqf";
funcVectorAdd = compileFinal preprocessFileLineNumbers "Server\Functions\Externals\fVectorAdd.sqf";
funcVectorCross = compileFinal preprocessFileLineNumbers "Server\Functions\Externals\fVectorCross.sqf";
funcVectorDot = compileFinal preprocessFileLineNumbers "Server\Functions\Externals\fVectorDot.sqf";
funcVectorScale = compileFinal preprocessFileLineNumbers "Server\Functions\Externals\fVectorScale.sqf";
funcVectorSub = compileFinal preprocessFileLineNumbers "Server\Functions\Externals\fVectorSub.sqf";

call compile preprocessFileLineNumbers "Server\Init\Init_PublicVariables.sqf";
call compile preprocessFileLineNumbers "Server\Functions\FSM\Functions_FSM_RepairTruck.sqf";
call compile preprocessFileLineNumbers "Server\Functions\FSM\Functions_FSM_UpdateAI.sqf";
call compile preprocessFileLineNumbers "Server\Functions\FSM\Functions_FSM_UpdateCommander.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;


execVM "Server\Init\Init_Prison.sqf";
execVM "Addons\Strat_mode\Functions\TUTORIAL_Init.sqf";

CTI_Structure_Lock=False;
CTI_HQ_Repair_Lock_EAST=False;
CTI_HQ_Repair_Lock_WEST=False;
CTI_Worker_Lock=False;



CENTER_POS=getMarkerPos "CENTER_POS";
"CENTER_POS" setmarkeralpha 0;
CENTER_RADIUS=(getMarkerSize "CENTER_POS")select 0;
_locations= CENTER_POS nearroads CENTER_RADIUS;
_attempts = 0;
_real_attempts = 0;
_asked= missionNamespace getVariable "CTI_BASE_STARTUP_PLACEMENT";
waitUntil {CTI_InitTowns};
_eastLocation=CENTER_POS;
_westLocation=CENTER_POS;
while {(_eastLocation distance _westLocation) <(_asked)*0.95 ||(_eastLocation distance _westLocation) >( _asked)*1.25 || {(_x distance _eastLocation)<600} count CTI_Towns>0 || {(_x distance _westLocation)<600} count CTI_Towns>0 ||(_eastLocation distance CENTER_POS) > ( _asked)*1.2 ||(_westLocation distance CENTER_POS) > ( _asked)*1.2 } do {
	while {random(1)>0.2}do {
		_a="BiS pseudo-random number Generator is crappy";
	};
	_eastLocation=_locations call BIS_fnc_selectRandom;
	_westLocation=_locations call BIS_fnc_selectRandom;
	_attempts =_attempts +1;
	_real_attempts =_real_attempts +1;
	if (_attempts >40000) Then {
		_asked = _asked*0.9;
		_attempts=0;
		diag_log format ["Procedural starting point failed reducing distance to distance %1",_asked];
	};

};
diag_log format ["Procedural starting point took %1 distance %2",_real_attempts,(_eastLocation distance _westLocation)];

HELO_STARTUP=[];
_i=0;
while {! (((getMarkerPos format ["HELO_START_%1", _i])select 0) == 0)} do
{
    if (((getMarkerPos format ["HELO_START_%1", _i]) distance CENTER_POS)<CENTER_RADIUS) then { HELO_STARTUP set [count HELO_STARTUP,getMarkerPos format ["HELO_START_%1", _i]]};
    _i=_i+1;
};


{
	_side = _x select 0;
	_logic = _x select 1;
	_startPos = _x select 2;
	_sideID = _side call CTI_CO_FNC_GetSideID;

	_hq = [missionNamespace getVariable Format["CTI_%1_HQ", _side], _startPos, 0, _side, true, true] call CTI_CO_FNC_CreateVehicle;
	_hq setVariable ["cti_gc_noremove", true]; //--- HQ wreck cannot be removed nor salvaged
	_hq setVariable ["cti_ai_prohib", true]; //--- HQ may not be used by AI as a commandable vehicle
	//_hq addEventHandler ["getIn", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	//_hq addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	_hq setVariable ["cti_occupant", _side,true];
	_hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideID]];
	if (CTI_BASE_NOOBPROTECTION == 1) then {
		_hq addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage", _sideID]]; //--- You want that on public
	};



	//--- Generic per-logic variables
	_logic setVariable ["cti_hq", _hq, true];
	_logic setVariable ["cti_structures_wip", [],true];
	_logic setVariable ["cti_structures", [], true];
	_logic setVariable ["cti_structures_areas", [], true];
	_logic setVariable ["cti_structures_lasthit", -600];
	_logic setVariable ["cti_workers", [], true];
	_logic setVariable ["cti_commander", grpNull, true];
	_logic setVariable ["cti_commander_funds", missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1_COMMANDER", _side], true];
	_logic setVariable ["cti_pool_award", missionNamespace getVariable format ["CTI_ECONOMY_POOL_AWARD_PERCENTAGE_%1", _side], true];
	_logic setVariable ["cti_pool_resources", missionNamespace getVariable format ["CTI_ECONOMY_POOL_RESOURCES_PERCENTAGE_%1", _side], true];
	_logic setVariable ["cti_salvagers", [], true];
	_logic setVariable ["cti_spotted_units", []];
	_logic setVariable ["cti_spotted_structures", []];
	_logic setVariable ["cti_defences", [],true];
	_logic setVariable ["cti_service", [],true];
	_upgrades = [];
	for '_i' from 1 to count(missionNamespace getVariable format["CTI_%1_UPGRADES_LEVELS", _side]) do { _upgrades pushBack 0 };
	if ((missionNamespace getvariable "CTI_VEHICLES_AIR_FFAR")==2) then {_upgrades set [CTI_UPGRADE_AIR_FFAR,1]};
	if ((missionNamespace getvariable "CTI_VEHICLES_AIR_AT") ==2)then {_upgrades set [CTI_UPGRADE_AIR_AT,1]};
	if( (missionNamespace getvariable "CTI_VEHICLES_AIR_AA")==2 ) then {_upgrades set [CTI_UPGRADE_AIR_AA,1]};
	if ((missionNamespace getvariable "CTI_VEHICLES_AIR_CM")==2) then {_upgrades set [CTI_UPGRADE_AIR_CM,1]};
	if ((missionNamespace getvariable "CTI_TOWNS_OCCUPATION")==0) then {_upgrades set [CTI_UPGRADE_TOWNS,10]};
	// for '_i' from 1 to count(missionNamespace getVariable format["CTI_%1_UPGRADES_LEVELS", _side]) do { _upgrades pushback 1 };
	_logic setVariable ["cti_upgrades", _upgrades, true];
	_logic setVariable ["cti_upgrade", -1, true];
	_logic setVariable ["cti_upgrade_lt", -1, true];


	//--- Create the defensive teams if needed
	if (CTI_BASE_DEFENSES_AUTO_LIMIT > 0) then {
		_defense_team = createGroup _side;
		_defense_team setGroupIDGlobal ["Defense Team"];
		_logic setVariable ["cti_defensive_team", _defense_team,true];
	};

	//--- Add FOB if needed
	if (CTI_BASE_FOB_MAX > 0) then {_logic setVariable ["cti_fobs", [], true]};

	//--- Startup vehicles
	if !((profileNamespace getvariable ["CTI_SAVE_ENABLED",false]) &&(count(profileNamespace getVariable ["CTI_SAVE_TOWNS",[]]) == count CTI_TOWNS) && (ISLAND in [2,3])) then {
	{
		_model = _x select 0;
		_equipment = _x select 1;
		_roads=_startPos nearroads 75;
		_no_roads=_startPos nearroads 25;
		_position= (_roads-_no_roads) call BIS_fnc_selectRandom;
		_vehicle = [_model, _position, 0, _side, false, true, true] call CTI_CO_FNC_CreateVehicle;
		//[_vehicle, getPos _hq, 45, 60, true, false, true] call CTI_CO_FNC_PlaceNear;
		[_vehicle] spawn CTI_SE_FNC_HandleEmptyVehicle;
		if (count _equipment > 0) then {[_vehicle, _equipment] call CTI_CO_FNC_EquipVehicleCargoSpace};
		if ((missionNamespace getVariable [format ["%1", _model],["","","","","","","",""]]) select 7 != "") then {[_vehicle, _side, ((missionNamespace getVariable [format ["%1", _model],["","","","","","","",""]]) select 7)] call CTI_CO_FNC_InitializeCustomVehicle;};
	} forEach (missionNamespace getVariable format["CTI_%1_Vehicles_Startup", _side]);
	};

	_teams = [];

	0 spawn {
		waitUntil {CTI_Init_Server};
		while {! CTi_GameOver} do {
			{
				_unit=_x;
				_group=group _x;
				_side=side _group;
				_side_logic=(_side) call CTI_CO_FNC_GetSideLogic;
				_sideID=_side call CTI_CO_FNC_GetSideID;
				if (!(isPlayer _unit) && (_side in [east,west]) && ((_side == west && CTI_AI_TEAMS_ENABLED == 1) || (_side == east && CTI_AI_TEAMS_ENABLED == 2) || CTI_AI_TEAMS_ENABLED == 3)) then {
					if ({!(isPlayer leader _x)} count (_side_logic getVariable "CTI_TEAMS") < CTI_AI_TEAMS_NB) then {
						_new_group=grpNull;
						_new_group =createGroup _side;
						[_unit] joinSilent _new_group;
						[_unit, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR", _side]] call CTI_CO_FNC_EquipUnit;

						waitUntil {!isNull _new_group};
						[_unit] joinSilent _new_group;
						waitUntil {group _unit == _new_group};
						diag_log format ["%1- %2", units _new_group,_new_group];
						_unit enableFatigue false;
						_new_group selectLeader  _unit;
						[_new_group,_side ] call CTI_SE_FNC_InitializeGroup;
						_new_group allowFleeing 0;
						if (isNil {_new_group getVariable "cti_aifsm_handled"}) then {
							[_new_group, _side] execFSM "Server\FSM\update_ai.fsm";
						};
						_unit addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _sideID]];

						if (isMultiplayer) then { sleep 20 }else {sleep 2};

						_unit setDamage 1; //force respawn
					};


				};
			true
			}count (playableUnits+switchableUnits);
			sleep 10;
		};
	};

	_logic setVariable ["cti_teams", _teams, true];


	if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 3 || _side == west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 1 || _side == east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 2 ) then {
		[_side, _logic] spawn {
			private ["_side","_logic","_teams","_possible","_next_commander"];
			_side =_this select 0;
			_logic=_this select 1;
			_logic setVariable ["cti_ai_commander", false,true];
			_logic setVariable ["cti_ai_commander_group", grpNull,true];
			sleep 120;
			//if (isMultiplayer) then { sleep 60 };
			while {!CTi_GameOver} do {
				if (isMultiplayer) then { sleep 30 };
				if ((isnull (_logic getVariable "cti_commander")&& ! (_logic getVariable ["cti_ai_commander",true])) || isplayer leader (_logic getVariable ["cti_ai_commander_group",grpNull]) )then {
					_teams =_logic getVariable ["cti_teams",[]];
					_possible=[];
					{if ! (isplayer leader _x) then {_possible set [count _possible,_x]};true} count _teams;
					_next_commander= _possible select floor random (count _possible);
					if  ! (isnil "_next_commander") then {
					_logic setVariable ["cti_ai_commander", true,true];
					_logic setVariable ["cti_ai_commander_group", _next_commander,true];
					(leader _next_commander) setpos( [(_logic getVariable "cti_hq"), 8, 30] call CTI_CO_FNC_GetRandomPosition);
					[["CLIENT", _side], "Client_OnMessageReceived", ["take_com",[format ["%1 (AI)",(name leader _next_commander)]]],true] call CTI_CO_FNC_NetSend;
					_seed = time + random 10000 - random 500 + diag_frameno;
					{deleteWaypoint _x} foreach (waypoints _next_commander);
					_next_commander setVariable ["cti_order_seed", _seed];
					_next_commander setVariable ["cti_team_reload",true];
					_next_commander setVariable ["cti_order",-1];
					_next_commander setVariable ["cti_order_pos",[0,0,0]];
					//waitUntil {isNil {_next_commander getVariable "cti_aifsm_handled"}};
					[_side,_next_commander] execFSM "Server\FSM\update_commander.fsm";
					};
				};
			    sleep 10;
			};
		};

	};

} forEach [[west, CTI_WEST, _westLocation], [east, CTI_EAST, _eastLocation]];

//--- Towns init thread
0 spawn {
	waitUntil {!isNil 'CTI_InitTowns'};

	execFSM "Server\FSM\update_garbage_collector.fsm";
	execFSM "Server\FSM\update_resources.fsm";
	execFSM "Server\FSM\update_victory.fsm";
};


// handle statics for the team
if (( missionNamespace getVariable [ "CTI_BASE_DEFENSES_AUTO_LIMIT",0]) >0) then {
	{
		_x spawn CTI_SE_FNC_HandleStaticDefenses;
	} forEach [east,west];
};

if (missionNamespace getvariable "CTI_PERSISTANT" == 1) then {
	waitUntil {!isNil 'CTI_InitTowns'};
	sleep 10; // prenvent loading without all town FSM stable
	if (profileNamespace getvariable ["CTI_SAVE_ENABLED",false]) then {
		0 call PERS_LOAD;
	} else {
		CTI_Init_Server=True;
		{
		    _side=_x;
		    _logic= (_side) call CTI_CO_FNC_GetSideLogic;
		    _logic setVariable ["CTI_LOAD_COMPLETED",true,true];
		} forEach [east,west];
	};
	0 spawn {
		sleep 270;
		while {!CTi_GameOver} do {
			0 call PERS_SAVE;
			sleep 270 +random (60);
		};
	};
} else {
	CTI_Init_Server=True;
	{
		    _side=_x;
		    _logic= (_side) call CTI_CO_FNC_GetSideLogic;
		    _logic setVariable ["CTI_LOAD_COMPLETED",true,true];
	} forEach [east,west];

};

//Logging of varius values
0 spawn {
		sleep 100; //wait for everything to finish loading
		_version = 3; //version of DiscordBot logReader
		_arr = 	[["CTI_DataPacket", "Header"],
				 ["Version", _version],
				 ["Map", worldName]
				];
		diag_log _arr;
		while {!CTI_GameOver} do {
			_east_sl = (east) call CTI_CO_FNC_GetSideLogic;
			_west_sl = (west) call CTI_CO_FNC_GetSideLogic;
			_towns = count(_east_sl getVariable  ["CTI_ACTIVE",[]]) + count(_west_sl getVariable  ["CTI_ACTIVE",[]]);

			//build player array, splitting at 800 to ensure char limit of 1000 is not reached
			_players = [];
			_players_sub = [];
			{
				if(count (_players_sub joinString ", ") >= 800) then {
					_players pushBack _players_sub;
					_players_sub = [];
				};
				_players_sub pushBack [name _x, str (side _x), getPlayerScores _x, getPos _x];
			} forEach allPlayers - entities "HeadlessClient_F";
			if(count (_players_sub joinString ", ") >= 10) then {
					_players pushBack _players_sub;
					_players_sub = [];
			};

			//Build town arrays
			_west_towns = [];
			{
				_west_towns pushBack str _x;
			} forEach (west call CTI_CO_FNC_GetSideTowns);
			_east_towns = [];
			{
				_east_towns pushBack str _x;
			} forEach (east call CTI_CO_FNC_GetSideTowns);

			//Post Data to .rpt log
			//Data for general mission performance
			diag_log[["CTI_DataPacket", "Data_1"],
					["time", time],
					["fps", diag_fps],
					["score_east", (scoreSide east)],
					["score_west", (scoreSide west)],
					["player_count_east", (east countSide allPlayers)],
					["player_count_west", (west countSide allPlayers)],
					["commander_east", (name leader ((east) call CTI_CO_FNC_GetSideCommander))],
					["commander_west", (name leader ((west) call CTI_CO_FNC_GetSideCommander))],
					["town_count_east", ((east) call CTI_CO_FNC_GetSideTownCount)],
					["town_count_west", ((west) call CTI_CO_FNC_GetSideTownCount)],
					["active_SQF_count", count(diag_activeSQFScripts)],
					["active_AI", count(allUnits)],
					["total_objects", count(allMissionObjects "All")],
					["active_towns", _towns]];
			_dataP = 2; //next data packet index
			{
				//Data for Replay
				diag_log[["CTI_DataPacket", (format ["Data_%1", _dataP])],
						["players", _x]];
				_dataP = _dataP+1;
			} forEach _players;

			diag_log[["CTI_DataPacket", format ["Data_EOD_%1", _dataP]], //Marking package as "last"
					["bases_east", _east_sl getVariable ["cti_structures_areas",[]]],
					["bases_west", _west_sl getVariable ["cti_structures_areas",[]]],
					["east_towns", _east_towns],
					["west_towns", _west_towns]];

			sleep 60;
		};
		//Triggerd on Misson end, used when FSM does not trigger. (used for debugging)
		_arr = 	[["CTI_DataPacket", "EOF"],
				 ["Version", _version],
				 ["Map", worldName]
				];
		diag_log _arr;
};

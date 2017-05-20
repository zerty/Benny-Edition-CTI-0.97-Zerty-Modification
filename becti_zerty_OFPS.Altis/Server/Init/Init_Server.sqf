//todo: Kerberos Tracker -> perma track main infos with clients UID (teamkills, kills, hq killed (ff/no ff)).

//--- Create a resistance center
createCenter resistance;
resistance setFriend [west, 0];
resistance setFriend [east, 0];

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

["Initialize"] call BIS_fnc_dynamicGroups


execVM "Server\Init\Init_Prison.sqf";

CTI_Structure_Lock=False;
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
	for '_i' from 1 to count(missionNamespace getVariable format["CTI_%1_UPGRADES_LEVELS", _side]) do { [_upgrades, 0] call CTI_CO_FNC_ArrayPush };
	if ((missionNamespace getvariable "CTI_VEHICLES_AIR_FFAR")==2) then {_upgrades set [CTI_UPGRADE_AIR_FFAR,10]};
	if ((missionNamespace getvariable "CTI_VEHICLES_AIR_AA") ==2)then {_upgrades set [CTI_UPGRADE_AIR_AT,10]};
	if( (missionNamespace getvariable "CTI_VEHICLES_AIR_AT")==2 ) then {_upgrades set [CTI_UPGRADE_AIR_AA,10]};
	if ((missionNamespace getvariable "CTI_VEHICLES_AIR_CM")==2) then {_upgrades set [CTI_UPGRADE_AIR_CM,10]};
	if ((missionNamespace getvariable "CTI_TOWNS_OCCUPATION")==0) then {_upgrades set [CTI_UPGRADE_TOWNS,10]};
	// for '_i' from 1 to count(missionNamespace getVariable format["CTI_%1_UPGRADES_LEVELS", _side]) do { [_upgrades, 1] Call CTI_CO_FNC_ArrayPush };
	_logic setVariable ["cti_upgrades", _upgrades, true];
	_logic setVariable ["cti_upgrade", -1, true];
	_logic setVariable ["cti_upgrade_lt", 0, true];


	//--- Create the defensive teams if needed
	if (CTI_BASE_DEFENSES_AUTO_LIMIT > 0) then {
		_defense_team = createGroup _side;
		_defense_team setGroupID ["Defense Team"];
		_logic setVariable ["cti_defensive_team", _defense_team,true];
	};

	//--- Add FOB if needed
	if (CTI_BASE_FOB_MAX > 0) then {_logic setVariable ["cti_fobs", [], true]};

	//--- Startup vehicles
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

	//Radios
	/*
	_logic setVariable ["cti_radios", [],true];
	{
		_l=format ["%1_%2", _side,_x];
		_rindex=radioChannelCreate [[0.8,0.1,0.1,1], _l, "%UNIT_NAME",[]];
		_logic setVariable ["cti_radios", (_logic getVariable "cti_radios")+[[_rindex,_l]],true];
	} forEach CTI_RADIOS;*/


	//--- Handle the Team
	_teams = [];
	/*
	{
		if !(isNil '_x') then {
			if (_x isKindOf "Man") then {
				_group = group _x;
				[_teams, _group] call CTI_CO_FNC_ArrayPush;
				[_group, _side] call CTI_SE_FNC_InitializeGroup;

				[leader _group, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR", _side]] call CTI_CO_FNC_EquipUnit;

				if !(isPlayer leader _group) then {
					if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 3 || _side == west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 1 || _side == east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 2 ) then { //--- Wait for the player to be "ready"
						(leader _group) setPos ([_startPos, 8, 30] call CTI_CO_FNC_GetRandomPosition);
						leader _group addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _sideID]]; //--- Called on destruction
						//if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {leader _group enableFatigue false}; //--- Disable the unit's fatigue
						[leader _group, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR_AI", _side]] call CTI_CO_FNC_EquipUnit;
						[_group, _side, _logic] spawn {
							_group = _this select 0;
							_side = _this select 1;
							_logic = _this select 2;

							if (isMultiplayer) then { sleep 20 };
							_group allowFleeing 0;

							if (typeOf (leader _group) != (missionNamespace getVariable format["CTI_%1_Commander", _side])) then { //--- An AI Team
								sleep (random 5); //--- Differ each threads.
								if (isNil {_group getVariable "cti_aifsm_handled"}) then {
									[_group, _side] execFSM "Server\FSM\update_ai.fsm";
								};
							};
							} else { //--- The Commander
								if (isNull (_logic getVariable "cti_commander")) then { _logic setVariable ["cti_commander", _group, true] };
							};

						};
					};
				};
			};
		};
	} forEach (synchronizedObjects _logic);
	*/
	_logic setVariable ["cti_teams", _teams, true];

	//--- Handle the Commander
	/*if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 3 || _side == west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 1 || _side == east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") == 2 ) then {
		[_side, _logic] spawn {
			_side = _this select 0;
			_logic = _this select 1;

			sleep 2;
			while {!CTi_GameOver} do {
				if (isMultiplayer) then { sleep 25 };

				if !(isNull (_logic getVariable "cti_commander")) then {
						_logic setVariable ["cti_ai_commander", true];
						(_side) execFSM "Server\FSM\update_commander.fsm";
					};
				};
		};
	};*/
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
				if (isMultiplayer) then { sleep 20 };
				if ((isnull (_logic getVariable "cti_commander")&& ! (_logic getVariable ["cti_ai_commander",true])) || isplayer leader (_logic getVariable ["cti_ai_commander_group",grpNull]) )then {
					_teams =_logic getVariable ["cti_teams",[]];
					_possible=[];
					{if ! (isplayer leader _x) then {_possible set [count _possible,_x]};true} count _teams;
					_next_commander= _possible select floor random (count _possible);
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
			    sleep 5;
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


CTI_Init_Server=True;


//0 execVM "Addons\Zeus\Z_init_GUER.sqf";
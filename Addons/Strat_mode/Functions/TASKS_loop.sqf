// Loop for tasks creation ard removal:
// each player has :
//- a list of Attack tasks related to town
//- a list of defend tasks related to towns
//
//  A task is then a tupple of [task_type,object,taskname]


//Constants for type definition

CTI_TASK_TYPE_ATTACK=0;
CTI_TASK_TYPE_DEFEND=1;
CTI_TASK_TYPE_BUILD=2;
CTI_TASK_TYPE_EVACUATE=3;

//List of current task
_TASKS_LIST=[];

//other values used but the script
_side=_this;
_logic= _side call  CTI_CO_FNC_GetSideLogic;
_sideID = _side call CTI_CO_FNC_GetSideID;

// main Loop
waitUntil { (_logic getVariable ["CTI_LOAD_COMPLETED",false])};
while {!CTI_GAMEOVER} do
{
	//*****************************************************************
	//********************** CLEANUPS  ********************************
	//*****************************************************************

	_to_delete=+[]; // list of task that will be removed at end of checks
	_active_towns=_logic getVariable  ["CTI_ACTIVE",[]];

	// CLEAN ATTACK TASKS
	{
		if ((_x select 0 )== CTI_TASK_TYPE_ATTACK ) then {
			_town=_x select 1 ;
			if ( (_active_towns find _town) == -1 )  then {_to_delete pushBackUnique _forEachIndex};

		};

	} foreach _TASKS_LIST;

	// CLEAN DEFENSE TASKS
	{
		if ((_x select 0 )== CTI_TASK_TYPE_DEFEND ) then {
			_town=_x select 1 ;
			if ((_town getvariable ["cti_town_sideID",-1]) == _sideID && !(_town getvariable ["cti_town_occupation_active",false]) ) then {_to_delete pushBackUnique _forEachIndex};
		};

	} foreach _TASKS_LIST;


	//*****************************************************************
	//********************** TASK CREATION ****************************
	//*****************************************************************

	// ATTACK TASKS

	{
		_town=_x;
		if ((_TASKS_LIST findif {(_x select 0) == CTI_TASK_TYPE_ATTACK && (_x select 1) == _town}) == -1) then {
			_taskname=format ["A_%1_%2_%3",_side,ceil(random(100000)),ceil(time)];
			_tasktext=format ["Attack %1",_town getvariable ["cti_town_name",""]];
			waitUntil {_taskname==[_side, _taskname, [_tasktext,_tasktext,""], _town, "CREATED", 1, true, "attack", true] call BIS_fnc_taskCreate};
			if ([_taskname] call BIS_fnc_taskExists) then {_TASKS_LIST pushBack [CTI_TASK_TYPE_ATTACK,_town,_taskname];};
		};
		true
	} count _active_towns;


	// Priority ATTACK TASKS
/*
	if (! isNull (_logic  getVariable  ["CTI_PRIORITY",objNull])) then{
		_town=(_logic  getVariable  ["CTI_PRIORITY",objNull]);
		if ((TASKS_LIST findif {(_x select 0) == CTI_TASK_TYPE_ATTACK && (_x select 1) == _town}) == -1) then {
			_taskname=format ["A_%1_%2",ceil(random(100000)),ceil(time)];
			TASKS_LIST pushBack [CTI_TASK_TYPE_ATTACK,_town,_taskname];
			_tasktext=format ["/!\ Attack Priority %1",_town getvariable ["cti_town_name",""]];
			[player, _taskname, [_tasktext,_tasktext,""], _town, "AUTOASSIGNED", 10, true, "attack", true] call BIS_fnc_taskCreate;
		};
		true
	};*/


	// DEFEND TASKS
	{
		_town=_x;
		if ((_town getvariable ["cti_town_sideID",-1]) == _sideID && (_town getvariable ["cti_town_occupation_active",false]) ) then {
			if ((_TASKS_LIST findif {(_x select 0) == CTI_TASK_TYPE_DEFEND && (_x select 1) == _town}) == -1) then {
				_taskname=format ["D_%1_%2_%3",_side,ceil(random(100000)),ceil(time)];
				_tasktext=format ["Defend %1",_town getvariable ["cti_town_name",""]];
				waitUntil {_taskname==[_side, _taskname, [_tasktext,_tasktext,""], _town, "CREATED", 1, true, "defend", true] call BIS_fnc_taskCreate};
				if ([_taskname] call BIS_fnc_taskExists) then {_TASKS_LIST pushBack [CTI_TASK_TYPE_DEFEND,_town,_taskname];};

			};
		};
		true
	} count (_logic getVariable ["CTI_TOWNS",[]]);


	// DO THE CLEANUP

	{
		 _task=_TASKS_LIST select _x;
		 [(_task select 2), "CANCELED"] call BIS_fnc_taskSetState;
		 sleep 0.5;
		 waitUntil {[(_task select 2) ] call BIS_fnc_deleteTask};
		 true
	} count _to_delete;
	{
		if !([_TASKS_LIST select _x select 2] call BIS_fnc_taskExists) then {_TASKS_LIST deleteAt _x};
		true
	} count _to_delete;


	//wait some time
	sleep 3;
};
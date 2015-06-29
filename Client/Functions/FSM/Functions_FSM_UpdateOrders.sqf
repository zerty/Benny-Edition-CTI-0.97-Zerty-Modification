CTI_FSM_UpdateOrders_TakeTowns = {
	private ["_assigned_target", "_group", "_order", "_reload"];
	_order = _this select 0;
	_reload = _this select 1;

	_group = group player;

	//--- Check if the target is given or assigned
	_assigned_target = [player, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestEnemyTown;
	if !(isNull _assigned_target) then { //--- Assign a target to the AI if found and swap the order to the town one.
		switch (_order) do {
			case CTI_ORDER_TAKETOWNS: {_group setVariable ["cti_order", CTI_ORDER_TAKETOWN_AUTO, true]};
			case CTI_ORDER_TAKEHOLDTOWNS: {_group setVariable ["cti_order", CTI_ORDER_TAKEHOLDTOWN_AUTO, true]};
		};
		_group setVariable ["cti_order_pos", _assigned_target, true];
		if (_reload) then {_group setVariable ["cti_team_reload", true]}; //--- No ACK
	} else {
		//--- Reload the order till we have a target
		_group setVariable ["cti_team_reload", true];
	};
};

CTI_FSM_UpdateOrders_TakeTown = {
	private ["_group", "_town"];
	_order = _this select 0;
	_town = _this select 1;
	_seed = _this select 2;
	_reload = _this select 3;

	_group = group player;

	//--- Tasking
	_task_title = "";
	_task_label = "";

	switch (true) do {
		case (_order in [CTI_ORDER_TAKETOWN, CTI_ORDER_TAKETOWN_AUTO]): {
			_task_title = format["Take %1", _town getVariable "cti_town_name"];
			_task_label = format["The Commander has ordered your group to take %1", _town getVariable "cti_town_name"];
		};
		case (_order in [CTI_ORDER_TAKEHOLDTOWN, CTI_ORDER_TAKEHOLDTOWN_AUTO]): {
			_task_title = format["Take and Hold %1", _town getVariable "cti_town_name"];
			_task_label = format["The Commander has ordered your group to take and hold %1", _town getVariable "cti_town_name"];
		};
	};

	{if !(isNull _x) then {player removeSimpleTask _x}} forEach CTI_P_CurrentTasks;
	CTI_P_CurrentTasks = [];
	_task = player createSimpleTask ["CTI_MainOrder"];
	_task setSimpleTaskDescription [_task_label, _task_title, _task_title];
	_task setSimpleTaskDestination getPos _town;
	player setCurrentTask _task;
	CTI_P_CurrentTasks pushBack _task;

	["CTI_TaskAssigned",[_task_title]] call bis_fnc_showNotification;

	//--- Town Taking thread (Auto orders may swap targets if needed)
	_process = true;
	_side_owned = false;
	while {_process} do {
		if (isNil '_group') exitWith {};
		if (_seed != (_group getVariable "cti_order_seed")) exitWith {};

		if ((_town getVariable "cti_town_sideID") == CTI_P_SideID) exitWith {_side_owned = true};
		if (_order in [CTI_ORDER_TAKETOWN_AUTO, CTI_ORDER_TAKEHOLDTOWN_AUTO] && !CTI_P_Respawning) then {if (([player, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestEnemyTown) != _town) then {_process = false}};

		sleep 5;
	};

	if (_side_owned) then {
		["CTI_TaskSucceeded",[_task_title]] call bis_fnc_showNotification;
		_task setTaskState "Succeeded";
	};

	//--- Units using the Take Hold orders will patrol if necessary/in range
	if (_side_owned && _order in [CTI_ORDER_TAKEHOLDTOWN_AUTO, CTI_ORDER_TAKEHOLDTOWN]) then {
		if (_town distance player < CTI_PLAYER_ORDER_TAKEHOLDTOWNS_RANGE) then {
			_task setTaskState "Assigned";
			_task_title = format["Hold %1", _town getVariable "cti_town_name"];
			_task_label = format["The Commander has ordered your group to hold %1", _town getVariable "cti_town_name"];
			_task setSimpleTaskDescription [_task_label, _task_title, _task_title];
			player setCurrentTask _task;

			["CTI_TaskUpdated",[_task_title]] call bis_fnc_showNotification;

			//--- We patrol!
			_start_patrol = time;

			while {true} do {
				if (_seed != (_group getVariable "cti_order_seed") || time - _start_patrol > CTI_PLAYER_ORDER_TAKEHOLDTOWNS_TIME) exitWith {};

				sleep 2.5;
			};

			if (time - _start_patrol > CTI_PLAYER_ORDER_TAKEHOLDTOWNS_TIME) then {
				if ((_town getVariable "cti_town_sideID") == CTI_P_SideID) then {
					["CTI_TaskSucceeded",[_task_title]] call bis_fnc_showNotification;
					_task setTaskState "Succeeded";
				} else {
					["CTI_TaskFailed",[_task_title]] call bis_fnc_showNotification;
					_task setTaskState "Failed";
				};
			};
		};
	};

	//--- Release ! (if order still match the current seed)
	if (_seed == (_group getVariable "cti_order_seed")) then {
		switch (true) do {
			case (_order in [CTI_ORDER_TAKETOWN, CTI_ORDER_TAKETOWN_AUTO]): {_group setVariable ["cti_order", CTI_ORDER_TAKETOWNS, true]};
			case (_order in [CTI_ORDER_TAKEHOLDTOWN, CTI_ORDER_TAKEHOLDTOWN_AUTO]): {_group setVariable ["cti_order", CTI_ORDER_TAKEHOLDTOWNS, true]};
		};

		_group setVariable ["cti_team_reload", true];
	};
};

CTI_FSM_UpdateOrders_HoldTownsBases = {
	private ["_bases", "_closest", "_group", "_order", "_reload", "_towns"];
	_order = _this select 0;
	_reload = _this select 1;
	_group = group player;

	//--- Check if the target is given or assigned
	_towns = (CTI_P_SideID) call CTI_CO_FNC_GetSideTowns;
	if (count _towns > 0) then { //--- We have something to defend
		_closest = [getPos leader _group, _towns] call CTI_CO_FNC_GetClosestEntity;
		_group setVariable ["cti_order", CTI_ORDER_HOLDTOWNSBASE, true];
		_group setVariable ["cti_order_pos", _closest, true];
		if (_reload) then {_group setVariable ["cti_team_reload", true]}; //--- No ACK
	} else {
		_bases = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		if (count _bases > 0) then { //--- Assign the closest structure
			_closest = [getPos leader _group, _bases] call CTI_CO_FNC_GetClosestEntity;
			_group setVariable ["cti_order", CTI_ORDER_HOLDTOWNSBASE, true];
			_group setVariable ["cti_order_pos", _closest, true];
			if (_reload) then {_group setVariable ["cti_team_reload", true]}; //--- No ACK
		} else {
			_group setVariable ["cti_team_reload", true]; //--- No ACK
		};
	};
};

CTI_FSM_UpdateOrders_HoldTownsBase = {
	private ["_defend", "_group"];
	_order = _this select 0;
	_defend = _this select 1;
	_seed = _this select 2;
	_reload = _this select 3;

	_group = group player;

	//--- Tasking
	_name = "";
	if !(isNil {_defend getVariable "cti_town_name"}) then {_name = _defend getVariable "cti_town_name"};
	if !(isNil {_defend getVariable "cti_structure_type"}) then {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _defend getVariable "cti_structure_type"];
		_name = (_var select 0) select 1;
	};

	_task_title = format["Hold %1", _name];
	_task_label = format["The Commander has ordered your group to hold %1", _name];

	{if !(isNull _x) then {player removeSimpleTask _x}} forEach CTI_P_CurrentTasks;
	CTI_P_CurrentTasks = [];
	_task = player createSimpleTask ["CTI_MainOrder"];
	_task setSimpleTaskDescription [_task_label, _task_title, _task_title];
	_task setSimpleTaskDestination getPos _defend;
	player setCurrentTask _task;
	CTI_P_CurrentTasks pushBack _task;

	["CTI_TaskAssigned",[_task_title]] call bis_fnc_showNotification;

	//--- We patrol!
	_pos_patrol = getPos _defend;
	_pos_patrol_isbase = if (isNil {_defend getVariable "cti_town_sideID"}) then {true} else {false};

	_destroyed = false;
	while {true} do {
		if (_seed != (_group getVariable "cti_order_seed")) exitWith {};
		if !(alive _defend) exitWith {_destroyed = true};

		sleep 2.5;
	};

	if (_destroyed) then {
		["CTI_TaskFailed",[_task_title]] call bis_fnc_showNotification;
		_task setTaskState "Failed";
	};

	if (_destroyed && _pos_patrol_isbase) then { //--- A base structure was assigned but got destroyed. Try to get the closest one (if there's any duh)
		_bases = (_side) call CTI_CO_FNC_GetSideStructures;
		if (count _bases > 0) then { //--- Assign the closest structure
			_closest = [_pos_patrol, _bases] call CTI_CO_FNC_GetClosestEntity;
			_group setVariable ["cti_order_pos", _closest, true];
		} else {
			_group setVariable ["cti_order", CTI_ORDER_HOLDTOWNSBASES, true]; //--- We need a new order
		};
		_group setVariable ["cti_team_reload", true];
	};
};

CTI_FSM_UpdateOrders_Move = {
	private ["_order_pos", "_reload", "_seed"];
	_order_pos = _this select 0;
	_seed = _this select 1;
	_reload = _this select 2;

	_group = group player;

	//--- Tasking
	_hint_title = "Move to Position";
	_task_title = "Move";
	_task_label = "The Commander has ordered your group to move to the assigned location";

	{if !(isNull _x) then {player removeSimpleTask _x}} forEach CTI_P_CurrentTasks;
	CTI_P_CurrentTasks = [];
	_task = player createSimpleTask ["CTI_MainOrder"];
	_task setSimpleTaskDescription [_task_label, _task_title, _task_title];
	_task setSimpleTaskDestination _order_pos;
	player setCurrentTask _task;
	CTI_P_CurrentTasks pushBack _task;

	["CTI_TaskAssigned",[_hint_title]] call bis_fnc_showNotification;

	_reach = false;
	while {true} do {
		if (_seed != (_group getVariable "cti_order_seed")) exitWith {};
		if (player distance _order_pos <= 20) exitWith {_reach = true};

		sleep 1.5;
	};

	if (_reach) then {
		["CTI_TaskSucceeded",[_hint_title]] call bis_fnc_showNotification;
		_task setTaskState "Succeeded";
	};
};

CTI_FSM_UpdateOrders_SAD = {
	private ["_order_pos", "_reload", "_seed"];
	_order_pos = _this select 0;
	_seed = _this select 1;
	_reload = _this select 2;

	//--- Tasking
	_task_title = "Search and Destroy";
	_task_label = "The Commander has ordered your group to Search and Destroy enemy targets/structures";

	{if !(isNull _x) then {player removeSimpleTask _x}} forEach CTI_P_CurrentTasks;
	CTI_P_CurrentTasks = [];
	_task = player createSimpleTask ["CTI_MainOrder"];
	_task setSimpleTaskDescription [_task_label, _task_title, _task_title];
	// _task setSimpleTaskDestination _order_pos;
	player setCurrentTask _task;
	CTI_P_CurrentTasks pushBack _task;

	["CTI_TaskAssigned",[_task_title]] call bis_fnc_showNotification;
};
CTI_FSM_UpdateOrders_TakeTowns = {
	private ["_order","_reload","_available_t","_active_t","_assigned_target","_c"];
	_order = _this select 0;
	_reload = _this select 1;
	_available_t=CTI_P_SideLogic getvariable "CTI_AVAILLABLE";
	_active_t=CTI_P_SideLogic getvariable "CTI_ACTIVE";
	_group = group player;

	//--- Check if the target is given or assigned
	_assigned_target = objNull;
	_c=([player,_active_t] call CTI_CO_FNC_SortByDistance)+ ([player,_available_t] call CTI_CO_FNC_SortByDistance);
	if (count _c >0 ) then {
		_c=_c-((CTI_P_SideJoined) call CTI_CO_FNC_GetFriendlyTowns);
	} else {
		_c=[[player, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestEnemyTown];
	};
	if (count _c >0 ) then {_assigned_target = _c select 0};


	if (isNull _assigned_target) then {_assigned_target=[player, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestEnemyTown;};
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
	private ["_order","_town","_seed","_reload","_available_t","_active_t","_task_title","_task_label","_task","_process","_side_owned","_assigned_target","_c","_start_patrol"];
	_order = _this select 0;
	_town = _this select 1;
	_seed = _this select 2;
	_reload = _this select 3;
	_available_t=CTI_P_SideLogic getvariable "CTI_AVAILLABLE";
	_active_t=CTI_P_SideLogic getvariable "CTI_ACTIVE";
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
		if (_order in [CTI_ORDER_TAKETOWN_AUTO, CTI_ORDER_TAKEHOLDTOWN_AUTO] && !CTI_P_Respawning) then {
			_assigned_target = objNull;
			_c=([player,_active_t] call CTI_CO_FNC_SortByDistance)+ ([player,_available_t] call CTI_CO_FNC_SortByDistance);
			if (count _c >0 ) then {
				_c=_c-((CTI_P_SideJoined) call CTI_CO_FNC_GetFriendlyTowns);
			} else {
				_c=[[player, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestEnemyTown];
			};
			if (count _c >0 ) then {_assigned_target = _c select 0};
			if (isNull _assigned_target) then {_assigned_target=[player, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestEnemyTown;};
			if (_assigned_target != _town) then {_process = false};
		};

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

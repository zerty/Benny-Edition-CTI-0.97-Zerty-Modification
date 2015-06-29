//--- AI Order: Patrol an AI group to the desired location
CTI_FSM_UpdateClientAI_Order_Patrol = {
	private ["_ai", "_position"];
	_ai = _this select 0;
	_position = +(_this select 1);
	_seed = _this select 2;

	//--- Subin-Formation ?
	_members = _ai getVariable "cti_ai_formation";
	if (isNil '_members') then {_members = []};

	_exit = false;
	if (count _members > 1) then { //--- AI was ordered to move in formation
		//--- Who is the leader of the subgroup?
		_subleader = objNull;
		{if (alive _x) exitWith {_subleader = _x}} forEach _members;

		if (_ai != _subleader) then {_exit = true};
	};

	//--- Is it a queued order?
	_is_queued = if ((typeName (_position select 0)) == "ARRAY") then {true} else {false};

	if (_exit) exitWith {if (_is_queued) then {_ai setVariable ["cti_ai_reload", true]}}; //--- Reload if the order is queued since the leader may die and our members may not move to the next pos.

	_ai groupChat "Acknowledged.  Patrolling the designated positions";

	//--- Determine the patrol area
	_patrol_area = [];
	if !(_is_queued) then { //--- A point was given
		for '_i' from 1 to CTI_ORDER_CLIENT_PATROL_HOPS do {
			_patrol_area pushBack ( [_position, 20, CTI_ORDER_CLIENT_PATROL_RANGE] call CTI_CO_FNC_GetRandomPosition);
		};
	} else {
		_patrol_area = _position;
	};

	//--- Resume?
	_node = 0;
	if (_is_queued) then {
		if !(isNil {_ai getVariable "cti_ai_order_patrol_cn"}) then {_node = _ai getVariable "cti_ai_order_patrol_cn"};
	};

	_position_current = _patrol_area select _node;
	vehicle _ai doMove _position_current;
	((_ai getVariable "cti_ai_formation") - [_ai]) doFollow _ai;

	while {true} do {
		sleep 1;

		if !(alive _ai) exitWith {};
		if (_seed != (_ai getVariable "cti_ai_order_seed")) exitWith {};

		if ((_ai distance _position_current < 20) || ([getPos _ai select 0, getPos _ai select 1] distance [_position_current select 0, _position_current select 1] < 125 && vehicle _ai isKindOf "Air")) then { //--- Move order complete, more nodes?
			//--- Determine the next node (restart?)
			_node = if (_node + 1 > (count _patrol_area)-1) then {0} else {_node + 1};
			{_x setVariable ["cti_ai_order_patrol_cn", _node]} forEach (_ai getVariable "cti_ai_formation");
			_position_current = _patrol_area select _node;
			vehicle _ai doMove _position_current;
			((_ai getVariable "cti_ai_formation") - [_ai]) doFollow _ai;
		};
	};
};

//--- AI Order: Move an AI group to the desired location
CTI_FSM_UpdateClientAI_Order_Move = {
	private ["_ai", "_position"];
	_ai = _this select 0;
	_position = +(_this select 1);
	_seed = _this select 2;

	//--- Subin-Formation ?
	_members = _ai getVariable "cti_ai_formation";
	if (isNil '_members') then {_members = []};

	_exit = false;
	if (count _members > 1) then { //--- AI was ordered to move in formation
		//--- Who is the leader of the subgroup?
		_subleader = objNull;
		{if (alive _x) exitWith {_subleader = _x}} forEach _members;

		if (_ai != _subleader) then {_exit = true};
	};

	//--- Is it a queued order?
	_is_queued = if ((typeName (_position select 0)) == "ARRAY") then {true} else {false};

	if (_exit) exitWith {if (_is_queued) then {_ai setVariable ["cti_ai_reload", true]}}; //--- Reload if the order is queued since the leader may die and our members may not move to the next pos.

	if !(_is_queued) then { //--- Simple non-queued order
		if (_position select 0 == 0 && _position select 1 == 0) exitWith {};
		_ai groupChat format ["Acknowledged.  Moving to grid %1", mapGridPosition _position];

		vehicle _ai doMove _position;
		(_members - [_ai]) doFollow _ai;
	} else { //--- Queued order, move toward the different hops
		_ai groupChat "Acknowledged.  Moving to the designated positions";

		_position_current = _position select 0;
		vehicle _ai doMove _position_current;
		(_members - [_ai]) doFollow _ai;

		//--- When a position is reached, we remove it from the group pos array so that the subgroup members knows where they're at.
		while {true} do {
			sleep 2;

			if !(alive _ai) exitWith {};
			if (_seed != (_ai getVariable "cti_ai_order_seed")) exitWith {};

			if ((_ai distance _position_current < 20) || ([getPos _ai select 0, getPos _ai select 1] distance [_position_current select 0, _position_current select 1] < 125 && vehicle _ai isKindOf "Air")) then { //--- Move order complete, more nodes?
				_position set [0, false];
				_position = _position - [false];
				if (count _position < 1) then {_position = [0,0]};
				_position_current = _position select 0;
				{_x setVariable ["cti_ai_order_pos", _position]} forEach (_ai getVariable "cti_ai_formation");
				if (typeName _position_current == "ARRAY") then {vehicle _ai doMove _position_current; ((_ai getVariable "cti_ai_formation") - [_ai]) doFollow _ai};
			};

			if (typeName _position_current != "ARRAY") exitWith {};
		};
	};
};

//--- AI Order: Take a town (Assign a target if none are given).
CTI_FSM_UpdateClientAI_Order_TakeTowns = {
	private ["_ai", "_assigned_target", "_order", "_reload"];
	_ai = _this select 0;
	_order = _this select 1;
	_reload = _this select 2;

	//--- Subin-Formation ?
	_members = _ai getVariable "cti_ai_formation";
	if (isNil '_members') then {_members = []};

	_exit = false;
	if (count _members > 1) then { //--- AI was ordered to move in formation
		//--- Who is the leader of the subgroup?
		_subleader = objNull;
		{if (alive _x) exitWith {_subleader = _x}} forEach _members;

		if (_ai != _subleader) then {_exit = true};
	};

	if (_exit) exitWith {_ai setVariable ["cti_ai_reload", true]}; //--- Reload in case the subleader died (reelect)

	//--- Check if the target is given or assigned
	_assigned_target = [_ai, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestEnemyTown;
	if !(isNull _assigned_target) then { //--- Assign a target to the AI if found and swap the order to the town one.
		switch (_order) do {
			case CTI_ORDER_CLIENT_TAKETOWNS: {_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_TAKETOWN_AUTO]};
			case CTI_ORDER_CLIENT_TAKEHOLDTOWNS: {_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_TAKEHOLDTOWN_AUTO]};
		};
		_ai setVariable ["cti_ai_order_pos", _assigned_target];
		if (_reload) then {_ai setVariable ["cti_ai_reload", true]}; //--- No ACK
	} else {
		//--- Reload the order till we have a target
		_ai setVariable ["cti_ai_reload", true];
	};
};

CTI_FSM_UpdateClientAI_Order_TakeTown = {
	private ["_ai", "_town"];
	_ai = _this select 0;
	_town = _this select 1;
	_seed = _this select 2;
	_reload = _this select 3;
	_order = _this select 4;

	//--- Subin-Formation ?
	_members = _ai getVariable "cti_ai_formation";
	if (isNil '_members') then {_members = []};

	_exit = false;
	if (count _members > 1) then { //--- AI was ordered to move in formation
		//--- Who is the leader of the subgroup?
		_subleader = objNull;
		{if (alive _x) exitWith {_subleader = _x}} forEach _members;

		if (_ai != _subleader) then {_exit = true};
	};

	if (_exit) exitWith {
		_ai setVariable ["cti_ai_reload", true];
		switch (true) do {
			case (_order in [CTI_ORDER_CLIENT_TAKETOWN, CTI_ORDER_CLIENT_TAKETOWN_AUTO]): {_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_TAKETOWNS]};
			case (_order in [CTI_ORDER_CLIENT_TAKEHOLDTOWN, CTI_ORDER_CLIENT_TAKEHOLDTOWN_AUTO]): {_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_TAKEHOLDTOWNS]};
		};
	}; //--- Skip if we have a leader.

	//--- Notify the player if the order wasn't reloaded
	if !(_reload) then {
		switch (true) do {
			case (_order in [CTI_ORDER_CLIENT_TAKETOWN, CTI_ORDER_CLIENT_TAKETOWN_AUTO]): {_ai groupChat format ["Acknowledged.  Advancing on %1", _town getVariable "cti_town_name"]};
			case (_order in [CTI_ORDER_CLIENT_TAKEHOLDTOWN, CTI_ORDER_CLIENT_TAKEHOLDTOWN_AUTO]): {_ai groupChat format ["Acknowledged.  Advancing on %1 with guard duty", _town getVariable "cti_town_name"]};
		};
	};

	//--- Let's go to the town!
	vehicle _ai doMove ([getPos _town, 5, 40] call CTI_CO_FNC_GetRandomPosition);
	(_members - [_ai]) doFollow _ai;

	//--- Town Taking thread (Auto orders may swap targets if needed)
	_process = true;
	_side_owned = false;
	while {_process} do {
		if !(alive _ai) exitWith {};
		if (_seed != (_ai getVariable "cti_ai_order_seed")) exitWith {};

		if ((_town getVariable "cti_town_sideID") == CTI_P_SideID) exitWith {_side_owned = true};
		if (_order in [CTI_ORDER_CLIENT_TAKETOWN_AUTO, CTI_ORDER_CLIENT_TAKEHOLDTOWN_AUTO]) then {if (([_ai, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestEnemyTown) != _town) then {_process = false}};

		sleep 5;
	};

	//--- Don't bother any further if nil!
	if !(alive _ai) exitWith {};

	//--- Units using the Take Hold orders will patrol if necessary/in range
	if (_side_owned && _order in [CTI_ORDER_CLIENT_TAKEHOLDTOWN_AUTO, CTI_ORDER_CLIENT_TAKEHOLDTOWN]) then {
		if (_town distance _ai < CTI_AI_ORDER_TAKEHOLDTOWNS_RANGE) then {
			//--- We patrol!
			_move_defend_last = 0;_move_patrol_reload = true;
			_action = "";_last_action = "";_patrol_area = [];_start_patrol = time;

			for '_i' from 1 to CTI_AI_ORDER_TAKEHOLDTOWNS_HOPS do {_patrol_area pushBack ([_town, 5, CTI_AI_ORDER_TAKEHOLDTOWNS_PATROL_RANGE] call CTI_CO_FNC_GetRandomPosition)};

			while {true} do {
				if !(alive _ai) exitWith {};
				if (_seed != (_ai getVariable "cti_ai_order_seed") || time - _start_patrol > CTI_AI_ORDER_TAKEHOLDTOWNS_TIME) exitWith {};

				if (((_town getVariable 'cti_town_capture') < CTI_TOWNS_CAPTURE_VALUE_CEIL && CTI_P_SideID == (_town getVariable 'cti_town_sideID')) || CTI_P_SideID != (_town getVariable 'cti_town_sideID')) then {
					_action = "defense";if (_action != _last_action) then {_move_defend_last = -120};
				} else {
					_action = "patrol";if (_action != _last_action) then {_move_patrol_reload = true};
				};

				switch (_action) do {
					case "patrol": {if (_move_patrol_reload || unitReady _ai && random 100 > (45 + (random 15))) then {if (_move_patrol_reload) then {_move_patrol_reload = false};_move_to = _patrol_area select floor(random count _patrol_area); vehicle _ai doMove _move_to; ((_ai getVariable "cti_ai_formation") - [_ai]) doFollow _ai}};
					case "defense": {if (unitReady _ai && time - _move_defend_last > 65) then {_move_defend_last = time; vehicle _ai doMove ([_town, 10, 50] call CTI_CO_FNC_GetRandomPosition); ((_ai getVariable "cti_ai_formation") - [_ai]) doFollow _ai}};
				};

				_last_action = _action;

				sleep 2.5;
			};
		};
	};

	//--- Don't bother any further if nil!
	if !(alive _ai) exitWith {};

	//--- Release ! (if order still match the current seed)
	if (_seed == (_ai getVariable "cti_ai_order_seed")) then {
		switch (true) do {
			case (_order in [CTI_ORDER_CLIENT_TAKETOWN, CTI_ORDER_CLIENT_TAKETOWN_AUTO]): {_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_TAKETOWNS]};
			case (_order in [CTI_ORDER_CLIENT_TAKEHOLDTOWN, CTI_ORDER_CLIENT_TAKEHOLDTOWN_AUTO]): {_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_TAKEHOLDTOWNS]};
		};

		_ai setVariable ["cti_ai_reload", true];
	};
};

//--- AI Order: Take a town (Assign a target if none are given).
CTI_FSM_UpdateClientAI_Order_HoldTownsBases = {
	private ["_ai", "_order", "_reload"];
	_ai = _this select 0;
	_order = _this select 1;
	_reload = _this select 2;

	//--- Subin-Formation ?
	_members = _ai getVariable "cti_ai_formation";
	if (isNil '_members') then {_members = []};

	_exit = false;
	if (count _members > 1) then { //--- AI was ordered to move in formation
		//--- Who is the leader of the subgroup?
		_subleader = objNull;
		{if (alive _x) exitWith {_subleader = _x}} forEach _members;

		if (_ai != _subleader) then {_exit = true};
	};

	if (_exit) exitWith {_ai setVariable ["cti_ai_reload", true]}; //--- Reload in case the subleader died (reelect)

	(_members - [_ai]) doFollow _ai;

	//--- Check if the target is given or assigned
	_towns = (CTI_P_SideID) call CTI_CO_FNC_GetSideTowns;
	if (count _towns > 0) then { //--- We have something to defend
		_closest = [getPos _ai, _towns] call CTI_CO_FNC_GetClosestEntity;
		_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_HOLDTOWNSBASE];
		_ai setVariable ["cti_ai_order_pos", _closest];
		if (_reload) then {_ai setVariable ["cti_ai_reload", true]}; //--- No ACK
	} else {
		_bases = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		if (count _bases > 0) then { //--- Assign the closest structure
			_closest = [getPos _ai, _bases] call CTI_CO_FNC_GetClosestEntity;
			_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_HOLDTOWNSBASE];
			_ai setVariable ["cti_ai_order_pos", _closest];
			if (_reload) then {_ai setVariable ["cti_ai_reload", true]}; //--- No ACK
		} else {
			_ai setVariable ["cti_ai_reload", true]; //--- No ACK
		};
	};
};

CTI_FSM_UpdateClientAI_Order_HoldTownsBase = {
	private ["_ai", "_defend", "_order"];
	_ai = _this select 0;
	_defend = _this select 1;
	_seed = _this select 2;
	_reload = _this select 3;
	_order = _this select 4;

	//--- Subin-Formation ?
	_members = _ai getVariable "cti_ai_formation";
	if (isNil '_members') then {_members = []};

	_exit = false;
	if (count _members > 1) then { //--- AI was ordered to move in formation
		//--- Who is the leader of the subgroup?
		_subleader = objNull;
		{if (alive _x) exitWith {_subleader = _x}} forEach _members;

		if (_ai != _subleader) then {_exit = true};
	};

	if (_exit) exitWith {_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_HOLDTOWNSBASES]};

	//--- Notify the side if the order wasn't reloaded
	if !(_reload) then {_ai groupChat "Acknowledged.  Proceeding to nearest base or friendly town for guard duty"};

	//--- We patrol!
	_move_defend_last = 0;_move_patrol_reload = true;
	_action = "patrol";_last_action = "";_patrol_area = [];_start_patrol = time;
	_pos_patrol = getPos _defend; _pos_patrol_isbase = if (isNil {_defend getVariable "cti_town_sideID"}) then {true} else {false};

	for '_i' from 1 to CTI_AI_ORDER_HOLDTOWNSBASES_HOPS do {_patrol_area pushBack ([_defend, 5, CTI_AI_ORDER_HOLDTOWNSBASES_PATROL_RANGE] call CTI_CO_FNC_GetRandomPosition);};

	_destroyed = false;
	while {true} do {
		if !(alive _ai) exitWith {};
		if (_seed != (_ai getVariable "cti_ai_order_seed")) exitWith {};
		if !(alive _defend) exitWith {_destroyed = true};

		if !(isNil {_defend getVariable "cti_town_sideID"}) then {
			if (((_defend getVariable 'cti_town_capture') < CTI_TOWNS_CAPTURE_VALUE_CEIL && CTI_P_SideID == (_defend getVariable 'cti_town_sideID')) || CTI_P_SideID != (_defend getVariable 'cti_town_sideID')) then {
				_action = "defense";if (_action != _last_action) then {_move_defend_last = -120};
			} else {
				_action = "patrol";if (_action != _last_action) then {_move_patrol_reload = true};
			};
		};

		switch (_action) do {
			case "patrol": {if (_move_patrol_reload || unitReady _ai && random 100 > (45 + (random 15))) then {if (_move_patrol_reload) then {_move_patrol_reload = false};_move_to = _patrol_area select floor(random count _patrol_area); vehicle _ai doMove _move_to; ((_ai getVariable "cti_ai_formation") - [_ai]) doFollow _ai}};
			case "defense": {if (unitReady _ai && time - _move_defend_last > 65) then {_move_defend_last = time; vehicle _ai doMove ([_defend, 10, 50] call CTI_CO_FNC_GetRandomPosition); ((_ai getVariable "cti_ai_formation") - [_ai]) doFollow _ai}};
		};

		_last_action = _action;

		sleep 2.5;
	};

	if (_destroyed && _pos_patrol_isbase) then { //--- A base structure was assigned but got destroyed. Try to get the closest one (if there's any duh)
		_bases = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		if (count _bases > 0) then { //--- Assign the closest structure
			_closest = [_pos_patrol, _bases] call CTI_CO_FNC_GetClosestEntity;
			_ai setVariable ["cti_ai_order_pos", _closest];
		} else {
			_ai setVariable ["cti_ai_order", CTI_ORDER_CLIENT_HOLDTOWNSBASES]; //--- We need a new order
		};
		_ai setVariable ["cti_ai_reload", true];
	};
};
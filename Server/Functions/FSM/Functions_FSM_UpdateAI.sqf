CTI_FSM_UpdateAI_GetRespawnLocation = {
	private ["_group", "_hq", "_side", "_structures"];

	_side = _this select 0;
	_center = _this select 1;

	if (typeName _side == "SCALAR") then { _side = (_side) call CTI_CO_FNC_GetSideFromID };

	_hq = (_side) call CTI_CO_FNC_GetSideHQ;
	_structures = (_side) call CTI_CO_FNC_GetSideStructures;

	_list = _structures;
	if (alive _hq) then { _list pushBack _hq };

	if (count _list == 0) then { _list = [_hq] };

	[_center, _list] call CTI_CO_FNC_GetClosestEntity
};

CTI_FSM_UpdateAI_RespawnLeader_MP = {
	_newUnit = _this select 0;
	_corpse = _this select 1;
	_sideID = _this select 2;
	_side = _sideID call CTI_CO_FNC_GetSideFromID;

	_position = getPos _corpse;
	_group = group _newUnit;

	if (leader _group != _newUnit) then {_group selectLeader _newUnit};
	_newUnit disableAI "MOVE";

	_group setVariable ["cti_nextrespawn", time + (missionNamespace getVariable "CTI_RESPAWN_TIMER")];
	_respawn_start = time;

	while { time - _respawn_start < (missionNamespace getVariable "CTI_RESPAWN_TIMER") && alive _newUnit && !isPlayer _newUnit} do { sleep .75 };

	if (!alive _newUnit || isPlayer _newUnit) exitWith {};

	[_newUnit, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR_AI", _side]] call CTI_CO_FNC_EquipUnit;
	if (missionNamespace getVariable "CTI_EW_ANET" == 1) then {
		[_newUnit,_sideID] call AN_Launch;
	};
	_newUnit enableAI "MOVE";
	_newUnit setPos ([[_side, _position] call CTI_FSM_UpdateAI_GetRespawnLocation, 8, 30] call CTI_CO_FNC_GetRandomPosition);

	_group setVariable ["cti_team_reload", true]; //--- The group shall reload whatever it was doing

	//if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {_newUnit enableFatigue false}; //--- Disable the unit's fatigue
};

CTI_FSM_UpdateAI_RespawnLeader_SP = {
	private ["_group", "_side"];

	_killed = _this select 0;
	_sideID = _this select 1;
	_side = _sideID call CTI_CO_FNC_GetSideFromID;

	_group = group _killed;
	_type = typeOf _killed;
	_position = getPos _killed;

	sleep 3; //--- Wait a bit.

	_leader = [_type, _group, [markerPos format ["CTI_%1Respawn", _side], 2, 15] call CTI_CO_FNC_GetRandomPosition, _sideID] call CTI_CO_FNC_CreateUnit;
	_leader addEventHandler ["killed", format["[_this select 0, %1] spawn CTI_FSM_UpdateAI_RespawnLeader_SP", _sideID]];
	_leader addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _sideID]]; //--- Called on destruction
	_group selectLeader _leader;
	_leader disableAI "MOVE";

	_group setVariable ["cti_nextrespawn", time + (missionNamespace getVariable "CTI_RESPAWN_TIMER")];
	_respawn_start = time;

	while { time - _respawn_start < (missionNamespace getVariable "CTI_RESPAWN_TIMER") && alive _leader } do { sleep .75 };

	if !(alive _leader) exitWith {};

	[_leader, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR_AI", _side]] call CTI_CO_FNC_EquipUnit;

	_leader enableAI "MOVE";
	_leader setPos ([[_side, _position] call CTI_FSM_UpdateAI_GetRespawnLocation, 8, 30] call CTI_CO_FNC_GetRandomPosition);
	//if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {_leader enableFatigue false}; //--- Disable the unit's fatigue
	if (missionNamespace getVariable "CTI_EW_ANET" == 1) then {
		[_leader,_sideID] call AN_Launch;
	};
	_group setVariable ["cti_team_reload", true]; //--- The group shall reload whatever it was doing
};

//--- AI Duty: Board in a commandable slots
CTI_FSM_UpdateAI_EmbarkCommandableVehicles = {
	private ["_group", "_interacts", "_interacts_with", "_unit", "_units", "_vehicle"];
	_group = _this;
	_units = units _group;
//todo, units prefer to man missing spot in team vehicles first if available. ( _interacts_with_air_GROUP _interacts_with_heavy_GROUP _interacts_with_light_GROUP )
	//--- Retrieve the units on foot/in cargo/in statics
	_interacts = [];
	{
		_roles = assignedVehicleRole _x;
		if (count _roles > 0) then { //--- It's assigned
			if (_roles select 0 == "cargo" || (vehicle _x isKindOf "StaticWeapon" || assignedVehicle _x isKindOf "StaticWeapon")) then {
				_interacts pushBack _x;
			};
		} else { //--- No given roles
			_interacts pushBack _x;
		};
	} forEach _units;

	if (count _interacts > 0) then { //--- We have some units, what about the vehicles?
		//--- Create a vehicle list
		_vehicles = [];
		{if (alive assignedVehicle _x && !(assignedVehicle _x in _vehicles)) then {_vehicles pushBack (assignedVehicle _x)}} forEach _units;

		//--- Sort by preference
		_group_air = [];
		_group_heavy = [];
		_group_light = [];

		{
			if (local _x && canMove _x) then {
				switch (true) do {
					case (_x isKindOf "Air"): {if !(_x in _group_air) then {_group_air pushBack _x}};
					case (_x isKindOf "Tank"): {if !(_x in _group_heavy) then {_group_heavy pushBack _x}};
					case (_x isKindOf "Car"): {if !(_x in _group_light) then {_group_light pushBack _x}};
				};
			};
		} forEach _vehicles;

		_group_vehicles = _group_air + _group_heavy + _group_light;

		_i = 0;
		_process = true;
		_assigned_in = [];
		_sidechecks = [west,east,resistance] - [side _group];
		while {_process} do {
			_unit = _interacts select _i;

			//--- Generate a list of vehicles near that unit
			_interacts_with_air = [];
			_interacts_with_heavy = [];
			_interacts_with_light = [];
			{
				if (local _x && isNil{_x getVariable "cti_ai_prohib"} && canMove _x) then { //--- Vehicle is local to our server, it's usable, it can move
					_assigned = [assignedDriver _x, assignedGunner _x, assignedCommander _x, driver _x, gunner _x, commander _x] - _units;
					{if (!alive _x) then {_assigned = _assigned - [_x]}} forEach +_assigned; //--- Cleanse the array

					_enemies = 0;
					_crew = crew _x;
					{_enemies = _enemies + (_x countSide _crew)} forEach _sidechecks;

					if (count _assigned == 0 && _enemies == 0) then { //--- There is no "outsiders" among the main roles and no enemies
						switch (true) do {
							case (_x isKindOf "Air"): {if !(_x in _interacts_with_air) then {_interacts_with_air pushBack _x}};
							case (_x isKindOf "Tank"): {if !(_x in _interacts_with_heavy) then {_interacts_with_heavy pushBack _x}};
							case (_x isKindOf "Car"): {if !(_x in _interacts_with_light) then {_interacts_with_light pushBack _x}};
						};
					};
				};
			} forEach (_unit nearEntities [["Air","Tank","Car"], CTI_AI_TEAMS_COMMAND_VEHICLES_RANGE]);

			//--- Combine the arrays by importance
			_in_range = [];
			{if (_x distance _unit <= CTI_AI_TEAMS_COMMAND_VEHICLES_RANGE) then {_in_range pushBack _x}} forEach _group_vehicles;
			_interacts_with = (_in_range) + ((_interacts_with_air + _interacts_with_heavy + _interacts_with_light) - _in_range);

			//--- Iterate all vehicles available for that unit (exit when they're all browsed or when the unit found one)
			{
				_vehicle = _x;
				_has_vehicle = false;
				if (_vehicle emptyPositions "driver" > 0 && !alive driver _vehicle && !alive assignedDriver _vehicle) then {_assigned_in pushBack _unit; unassignVehicle _unit; _unit assignAsDriver _vehicle; [_unit] orderGetIn true;_has_vehicle = true};
				if (_vehicle emptyPositions "gunner" > 0 && !alive gunner _vehicle && !alive assignedGunner _vehicle && !_has_vehicle) then {_assigned_in pushBack _unit; unassignVehicle _unit; _unit assignAsGunner _vehicle; [_unit] orderGetIn true;_has_vehicle = true};
				if (_vehicle emptyPositions "commander" > 0 && !alive commander _vehicle && !alive assignedCommander _vehicle && !_has_vehicle) then {_assigned_in pushBack _unit; unassignVehicle _unit; _unit assignAsCommander _vehicle; [_unit] orderGetIn true;_has_vehicle = true};

				if (_has_vehicle) then {_i = _i + 1}; //--- The unit has been assigned. Assign the next one

				if (_i >= count _interacts) exitWith {_process = false};
				if (_has_vehicle) exitWith {};
			} forEach _interacts_with;
			if (_i >= count _interacts || count _interacts_with < 1) then {_process = false};
		};

		_remains = _interacts - _assigned_in;
		if (count _remains > 0) then { //--- We got some unassigned units?
			//--- We remove units which are already in the cargo of a group's vehicle
			{
				_roles = assignedVehicleRole _x;
				if (count _roles > 0) then {
					if (_roles select 0 == "cargo" && assignedVehicle _x in _units) then {_remains = _remains - [_x]};
				};
			} forEach +_remains;

			//--- Create a new vehicle list
			_vehicles = [];
			{if (alive assignedVehicle _x && !(assignedVehicle _x in _vehicles)) then {_vehicles pushBack (assignedVehicle _x)}} forEach _units;

			_interacts_with_air = [];
			_interacts_with_heavy = [];
			_interacts_with_light = [];

			{
				if (_x emptyPositions "cargo" > 0 && canMove _x) then { //--- Has cargo room?
					switch (true) do {
						case (_x isKindOf "Air"): {if !(_x in _interacts_with_air) then {_interacts_with_air pushBack _x}};
						case (_x isKindOf "Tank"): {if !(_x in _interacts_with_heavy) then {_interacts_with_heavy pushBack _x}};
						case (_x isKindOf "Car"): {if !(_x in _interacts_with_light) then {_interacts_with_light pushBack _x}};
					};
				};
			} forEach _vehicles;

			_interacts_with = _interacts_with_air + _interacts_with_heavy + _interacts_with_light;
			if (count _interacts_with < 1) exitWith {};

			_process = true;
			_i = 0;
			while {_process} do {
				_unit = _remains select _i;

				//--- Order the list of vehicles near that unit
				_has_vehicle = false;
				{
					if (_unit distance _x <= CTI_AI_TEAMS_COMMAND_VEHICLES_RANGE) then {
						_cargo = abs ((_x emptyPositions "cargo") - count(assignedCargo _x)); //--- Get the vehicle absolute cargo
						if (_cargo > 0) then {_has_vehicle = true; unassignVehicle _unit; _unit assignAsCargo _x; [_unit] orderGetIn true};
					};
					if (_has_vehicle) exitWith {_i = _i + 1;};
				} forEach (_interacts_with);

				if (_i >= count _remains) then {_process = false};
			};
		};
	};
};

//--- AI Duty: Leave commandable vehicles owned by the group (includes the cargo'ed unit of that group)
CTI_FSM_UpdateAI_DisembarkCommandableVehicles = {
	private ["_group"];
	_group = _this;

	{if (!isNull(assignedVehicle _x) || vehicle _x != _x) then {unassignVehicle _x}} forEach units _group;
};

//--- AI Duty: Board in a cargo slots.
CTI_FSM_UpdateAI_EmbarkCargoVehicles = {
	private ["_group", "_units"];
	_group = _this;
	_units = units _group;

	//--- Retrieve the units on foot/in statics
	_interacts = [];
	{
		_roles = assignedVehicleRole _x;
		if (count _roles > 0) then { //--- It's assigned
			if ((_roles select 0 != "cargo") || (vehicle _x isKindOf "StaticWeapon" || assignedVehicle _x isKindOf "StaticWeapon")) then {
				_interacts pushBack _x;
			};
		} else { //--- No given roles
			_interacts pushBack _x;
		};
	} forEach _units;

	// player sidechat format ["%1 %2", _group, count _interacts];

	_local_goto = _group getVariable "cti_order_pos";
	{
		_unit = _x;

		_has_vehicle = false;
		{
			if (local _x && isNil{_x getVariable "cti_ai_prohib"} && canMove _x && !(_x in _units) && alive driver _x && _x emptyPositions "cargo" > 0) then { //--- Vehicle is local to our server, it's usable, it can move
				_remote_goto = (group _x) getVariable "cti_order_pos";
				if (!isNil '_remote_goto' && side _group == side _x) then {
					_cargo = abs ((_x emptyPositions "cargo") - count(assignedCargo _x)); //--- Get the vehicle absolute cargo
					if (_remote_goto distance _x > (CTI_AI_TEAMS_CARGO_VEHICLES_DISEMBARK_RANGE+50) && _local_goto distance _remote_goto <= CTI_AI_TEAMS_CARGO_VEHICLES_MATCH_RANGE && _unit distance _local_goto > (CTI_AI_TEAMS_CARGO_VEHICLES_DISEMBARK_RANGE+50) && _cargo > 0) then { //--- Objectives aligns?
						_has_vehicle = true; unassignVehicle _unit; _unit assignAsCargo _x; [_unit] orderGetIn true;
					};
					// player sidechat format ["%1 %2",_x ,_has_vehicle];
				};
			};

			if (_has_vehicle) exitWith {};
		} forEach (_unit nearEntities [["Air","Tank","Car"], CTI_AI_TEAMS_CARGO_VEHICLES_RANGE]);

		// if (_has_vehicle) then {player sidechat format ["IN: %1", _unit]};//debug
	} forEach _interacts;
};

//--- AI Duty: Leave cargo'ed vehicles
CTI_FSM_UpdateAI_DisembarkCargoVehicles = {
	private ["_group", "_roles"];
	_group = _this;

	{
		_roles = assignedVehicleRole _x;
		if (count _roles > 0) then {if (_roles select 0 == "cargo") then {unassignVehicle _x}};
	} forEach units _group;
};

//--- AI Logic: Attempt to request transport if the group is pure infantry based
CTI_FSM_UpdateAI_CanRequest_CargoTransport = {
	private ["_group"];
	_group = _this;

	if (count ([_group, false] call CTI_CO_FNC_GetTeamVehicles) < 1) then {true} else {false};
};

//--- AI Order: Move an AI group to the desired location
CTI_FSM_UpdateAI_Order_Move = {
	private ["_group", "_position", "_reload", "_side"];
	_group = _this select 0;
	_side = _this select 1;
	_position = _this select 2;
	_reload = _this select 3;

	//--- Notify the side if the order wasn't reloaded
	if !(_reload) then {[["CLIENT", _side], "Client_OnMessageReceived", ["order-move", leader _group]] call CTI_CO_FNC_NetSend};

	_group move _position;
};

//--- AI Order: Take a town (Assign a target if none are given).
CTI_FSM_UpdateAI_Order_TakeTowns = {
	private ["_assigned_target", "_group", "_order", "_reload", "_side"];
	_group = _this select 0;
	_side = _this select 1;
	_order = _this select 2;
	_reload = _this select 3;

	//--- Check if the target is given or assigned
	if ( (missionNamespace getVariable 'CTI_SM_STRATEGIC')==1) then {
		_pos_town=((_side call CTI_CO_FNC_GetSideLogic) getVariable ["CTI_ACTIVE",[]]) + ((_side call CTI_CO_FNC_GetSideLogic) getVariable ["CTI_AVAILLABLE",[]]);
		_assigned_target=[leader _group,_pos_town] call CTI_CO_FNC_GetClosestEntity;
	} else {
		_assigned_target = [leader _group, _side] call CTI_CO_FNC_GetClosestEnemyTown;
	};
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
		if !(unitReady leader _group) then {leader _group move (getPos leader _group)};
	};
};

CTI_FSM_UpdateAI_Order_TakeTown = {
	private ["_group", "_town"];
	_group = _this select 0;
	_town = _this select 1;
	_seed = _this select 2;
	_side = _this select 3;
	_reload = _this select 4;
	_order = _this select 5;

	_sideID = (_side) call CTI_CO_FNC_GetSideID;

	//--- Notify the side if the order wasn't reloaded
	if !(_reload) then {
		switch (true) do {
			case (_order in [CTI_ORDER_TAKETOWN, CTI_ORDER_TAKETOWN_AUTO]): {[["CLIENT", _side], "Client_OnMessageReceived", ["order-taketowns", leader _group]] call CTI_CO_FNC_NetSend};
			case (_order in [CTI_ORDER_TAKEHOLDTOWN, CTI_ORDER_TAKEHOLDTOWN_AUTO]): {[["CLIENT", _side], "Client_OnMessageReceived", ["order-takeholdtowns", leader _group]] call CTI_CO_FNC_NetSend};
		};
	};

	//--- Let's go to the town!
	_group move ([getPos _town, 5, 40] call CTI_CO_FNC_GetRandomPosition);

	//--- Town Taking thread (Auto orders may swap targets if needed)
	_process = true;
	_side_owned = false;
	while {_process} do {
		if (isNil '_group') exitWith {};
		if (_seed != (_group getVariable "cti_order_seed")) exitWith {};

		if ((_town getVariable "cti_town_sideID") == _sideID) exitWith {_side_owned = true};
		if (_order in [CTI_ORDER_TAKETOWN_AUTO, CTI_ORDER_TAKEHOLDTOWN_AUTO]) then {if (([leader _group, _side] call CTI_CO_FNC_GetClosestEnemyTown) != _town) then {_process = false}};

		sleep 5;
	};

	//--- Don't bother any further if nil!
	if (isNil '_group') exitWith {};

	//--- Units using the Take Hold orders will patrol if necessary/in range
	if (_side_owned && _order in [CTI_ORDER_TAKEHOLDTOWN_AUTO, CTI_ORDER_TAKEHOLDTOWN]) then {
		if (_town distance leader _group < CTI_AI_ORDER_TAKEHOLDTOWNS_RANGE) then {
			//--- We patrol!
			_move_defend_last = 0;_move_patrol_reload = true;
			_action = "";_last_action = "";_patrol_area = [];_start_patrol = time;

			for '_i' from 1 to CTI_AI_ORDER_TAKEHOLDTOWNS_HOPS do {_patrol_area pushBack ([_town, 5, CTI_AI_ORDER_TAKEHOLDTOWNS_PATROL_RANGE] call CTI_CO_FNC_GetRandomPosition)};

			while {true} do {
				if (isNil '_group') exitWith {};
				if (_seed != (_group getVariable "cti_order_seed") || time - _start_patrol > CTI_AI_ORDER_TAKEHOLDTOWNS_TIME) exitWith {};

				if (((_town getVariable 'cti_town_capture') < CTI_TOWNS_CAPTURE_VALUE_CEIL && _sideID == (_town getVariable 'cti_town_sideID')) || _sideID != (_town getVariable 'cti_town_sideID')) then {
					_action = "defense";if (_action != _last_action) then {_move_defend_last = -120};
				} else {
					_action = "patrol";if (_action != _last_action) then {_move_patrol_reload = true};
				};

				switch (_action) do {
					case "patrol": {if (_move_patrol_reload || unitReady leader _group && random 100 > (45 + (random 15))) then {if (_move_patrol_reload) then {_move_patrol_reload = false};_move_to = _patrol_area select floor(random count _patrol_area); _group move _move_to}};
					case "defense": {if (unitReady leader _group && time - _move_defend_last > 65) then {_move_defend_last = time; _group move ([_town, 10, 50] call CTI_CO_FNC_GetRandomPosition)}};
				};

				_last_action = _action;

				sleep 2.5;
			};
		};
	};

	//--- Don't bother any further if nil!
	if (isNil '_group') exitWith {};

	//--- Release ! (if order still match the current seed)
	if (_seed == (_group getVariable "cti_order_seed")) then {
		switch (true) do {
			case (_order in [CTI_ORDER_TAKETOWN, CTI_ORDER_TAKETOWN_AUTO]): {_group setVariable ["cti_order", CTI_ORDER_TAKETOWNS, true]};
			case (_order in [CTI_ORDER_TAKEHOLDTOWN, CTI_ORDER_TAKEHOLDTOWN_AUTO]): {_group setVariable ["cti_order", CTI_ORDER_TAKEHOLDTOWNS, true]};
		};

		_group setVariable ["cti_team_reload", true];
	};
};

//--- AI Order: Take a town (Assign a target if none are given).
CTI_FSM_UpdateAI_Order_HoldTownsBases = {
	private ["_group", "_order", "_reload", "_side", "_sideID"];
	_group = _this select 0;
	_side = _this select 1;
	_order = _this select 2;
	_reload = _this select 3;

	_sideID = (_side) call CTI_CO_FNC_GetSideID;

	//--- Check if the target is given or assigned
	_towns = (_sideID) call CTI_CO_FNC_GetSideTowns;
	if (count _towns > 0) then { //--- We have something to defend
		_closest = [getPos leader _group, _towns] call CTI_CO_FNC_GetClosestEntity;
		_group setVariable ["cti_order", CTI_ORDER_HOLDTOWNSBASE, true];
		_group setVariable ["cti_order_pos", _closest, true];
		if (_reload) then {_group setVariable ["cti_team_reload", true]}; //--- No ACK
	} else {
		_bases = (_side) call CTI_CO_FNC_GetSideStructures;
		if (count _bases > 0) then { //--- Assign the closest structure
			_closest = [getPos leader _group, _bases] call CTI_CO_FNC_GetClosestEntity;
			_group setVariable ["cti_order", CTI_ORDER_HOLDTOWNSBASE, true];
			_group setVariable ["cti_order_pos", _closest, true];
			if (_reload) then {_group setVariable ["cti_team_reload", true]}; //--- No ACK
		} else {
			_group setVariable ["cti_team_reload", true]; //--- No ACK
			if !(unitReady leader _group) then {leader _group move (getPos leader _group)};
		};
	};
};

CTI_FSM_UpdateAI_Order_HoldTownsBase = {
	private ["_defend", "_group", "_order"];
	_group = _this select 0;
	_defend = _this select 1;
	_seed = _this select 2;
	_side = _this select 3;
	_reload = _this select 4;
	_order = _this select 5;

	_sideID = (_side) call CTI_CO_FNC_GetSideID;

	//--- Notify the side if the order wasn't reloaded
	if !(_reload) then {[["CLIENT", _side], "Client_OnMessageReceived", ["order-holdtowns", leader _group]] call CTI_CO_FNC_NetSend};

	//--- We patrol!
//todo: improve next node picking (distance > max / 2 or so).
	_move_defend_last = 0;_move_patrol_reload = true;
	_action = "patrol";_last_action = "";_patrol_area = [];_start_patrol = time;
	_pos_patrol = getPos _defend; _pos_patrol_isbase = if (isNil {_defend getVariable "cti_town_sideID"}) then {true} else {false};

	for '_i' from 1 to CTI_AI_ORDER_HOLDTOWNSBASES_HOPS do {_patrol_area pushBack ([_defend, 5, CTI_AI_ORDER_HOLDTOWNSBASES_PATROL_RANGE] call CTI_CO_FNC_GetRandomPosition) };

	_destroyed = false;
	while {true} do {
		if (isNil '_group') exitWith {};
		if (_seed != (_group getVariable "cti_order_seed")) exitWith {};
		if !(alive _defend) exitWith {_destroyed = true};

		if !(isNil {_defend getVariable "cti_town_sideID"}) then {
			if (((_defend getVariable 'cti_town_capture') < CTI_TOWNS_CAPTURE_VALUE_CEIL && _sideID == (_defend getVariable 'cti_town_sideID')) || _sideID != (_defend getVariable 'cti_town_sideID')) then {
				_action = "defense";if (_action != _last_action) then {_move_defend_last = -120};
			} else {
				_action = "patrol";if (_action != _last_action) then {_move_patrol_reload = true};
			};
		};

		switch (_action) do {
			case "patrol": {if (_move_patrol_reload || unitReady leader _group && random 100 > (45 + (random 15))) then {if (_move_patrol_reload) then {_move_patrol_reload = false};_move_to = _patrol_area select floor(random count _patrol_area); _group move _move_to}};
			case "defense": {if (unitReady leader _group && time - _move_defend_last > 65) then {_move_defend_last = time; _group move ([_defend, 10, 50] call CTI_CO_FNC_GetRandomPosition)}};
		};

		_last_action = _action;

		sleep 2.5;
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

CTI_FSM_UpdateAI_Order_SAD = {
	// ah = 0 spawn { while {true} do { sleep 0.5; player sidechat format["TERRAIN:%1 LINE:%2    %3",terrainintersect [player modeltoworld (player selectionposition "pilot"), target modeltoworld (target selectionposition "pilot")],lineIntersects [ATLtoASL (player modeltoworld (player selectionposition "pilot")),ATLtoASL  (target modeltoworld (target selectionposition "pilot")), player, target],time]}};
};
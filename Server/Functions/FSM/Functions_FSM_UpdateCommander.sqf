CTI_FSM_UpdateCommander_Respawn_SP = {
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
	_group selectLeader _leader;
	_leader disableAI "MOVE";

	_group setVariable ["cti_nextrespawn", time + (missionNamespace getVariable "CTI_RESPAWN_TIMER")];
	_respawn_start = time;

	while { time - _respawn_start < (missionNamespace getVariable "CTI_RESPAWN_TIMER") && alive _leader } do { sleep .75 };

	if !(alive _leader) exitWith {};

	_leader enableAI "MOVE";

	_hq = (_side) call CTI_CO_FNC_GetSideHQ;
	if (alive _hq) then {
		_leader setPos ([getPos _hq, 8, 30] call CTI_CO_FNC_GetRandomPosition);
	} else {
		_structures = (_side) call CTI_CO_FNC_GetSideStructures;
		_factory_commandCenter = [CTI_CONTROLCENTER, leader _sideCommander, _structures] call CTI_CO_FNC_GetClosestStructure;

		if !(isNull _factory_commandCenter) then {
			_leader setPos ([getPos _factory_commandCenter, 8, 30] call CTI_CO_FNC_GetRandomPosition);
		} else {
			_leader setPos ([[_side, _position] call CTI_FSM_UpdateAI_GetRespawnLocation, 8, 30] call CTI_CO_FNC_GetRandomPosition);
		};
	};

	//if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {_leader enableFatigue false}; //--- Disable the unit's fatigue
};

CTI_FSM_UpdateCommander_Respawn_MP = {
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

	_newUnit enableAI "MOVE";

	_hq = (_side) call CTI_CO_FNC_GetSideHQ;
	if (alive _hq) then {
		_newUnit setPos ([getPos _hq, 8, 30] call CTI_CO_FNC_GetRandomPosition);
	} else {
		_structures = (_side) call CTI_CO_FNC_GetSideStructures;
		_factory_commandCenter = [CTI_CONTROLCENTER, leader _sideCommander, _structures] call CTI_CO_FNC_GetClosestStructure;

		if !(isNull _factory_commandCenter) then {
			_newUnit setPos ([getPos _factory_commandCenter, 8, 30] call CTI_CO_FNC_GetRandomPosition);
		} else {
			_newUnit setPos ([[_side, _position] call CTI_FSM_UpdateAI_GetRespawnLocation, 8, 30] call CTI_CO_FNC_GetRandomPosition);
		};
	};

	//if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {_newUnit enableFatigue false}; //--- Disable the unit's fatigue
};

CTI_FSM_UpdateCommander_SetAIRole = {
	//check for max too!
	_category = _this select 0;
	_group = _this select 1;
	_side = _this select 2;
	_teams = _this select 3;

	_type = _group getVariable "cti_role_evo";

	_flaten = [];
	{ for '_i' from 1 to (_x select 1) do { _flaten pushBack _x } } forEach _category;

	_pool = _flaten call CTI_CO_FNC_ArrayShuffle;

	_can_use = false;
	_attemps = 0;
	while {!_can_use && _attemps < 100} do {
		_picked = _pool select floor(random count _pool);
		_squad = _picked select 0;
		_probability = if (count _picked > 2) then { _picked select 2 } else { 100 };
		_max_assigned = if (count _picked > 3) then {ceil(count _teams * (_picked select 3))} else {-1};

		_max_reached = false;
		_probability_pass = true;
		if (_probability != 100) then {
			if (random 100 > _probability) then { _probability_pass = false };
		};

		if (_max_assigned != -1) then {
			_same = 0;
			{
				if ((_x getVariable "cti_role") == _squad) then {_same = _same + 1};
			} forEach _teams;

			if (_same >= _max_assigned) then { _max_reached = true };
		};

		if (!_max_reached && _probability_pass) exitWith {
			_group setVariable ["cti_role", _squad, true];

			_allowed = missionNamespace getVariable format["CTI_SQUADS_%1_TOWN_DEFENSE", _side];
			if !(isNil '_allowed') then {
				_defenders = ({(_x getVariable "cti_order") == CTI_ORDER_HOLDTOWNSBASES} count _teams);
				if (_defenders < CTI_AI_TEAMS_DEFEND_TOWNS) then {
					if (_squad in _allowed) then { _group setVariable ["cti_order", CTI_ORDER_HOLDTOWNSBASES, true] };
				};
			};
		};
		_attemps = _attemps + 1;
	};
};

CTI_FSM_UpdateCommander_GetMostValuedTowns = {
	private ["_sideID", "_towns"];
	_sideID = _this;

	if (typeName _sideID == "SIDE") then { _sideID = _this call CTI_CO_FNC_GetSideID };

	_towns = [];
	{if ((_x getVariable "cti_town_sideID") == _sideID && (_x getVariable "cti_town_value") > CTI_AI_TEAMS_DEFEND_TOWNS_WORTH) then {_towns pushBack _x}} forEach CTI_Towns;

	_towns
};

CTI_FSM_UpdateCommander_GetStructureEmplacement = {
	private ["_side", "_template", "_var"];
	_side = _this select 0;
	_var = _this select 1;
	_template = _this select 2;

	_sideLogic = (_side) call CTI_CO_FNC_GetSideLogic;

	_hq = (_side) call CTI_CO_FNC_GetSideHQ;
	_structures = ((_side) call CTI_CO_FNC_GetSideStructures) + [_hq];
	_structures = _structures + (_sideLogic getVariable "cti_structures_wip");

	_position = getPos _hq;
	_position = [(_position select 0) + ((_template select 2) select 0), (_position select 1) + ((_template select 2) select 1), 0];
	_distance = (_var select 4) select 1;
	_direction = 0;//todo template defines it.

	_i = 0;
	_radius = 70;
	_done = false;
	while {_i < 1000 && !_done} do {
		_tpos = [(_position select 0)+(_radius - (random (_radius * 2))),(_position select 1)+(_radius - (random (_radius * 2)))];
		_fpos = _tpos isFlatEmpty [13, 1, 0.5, 10, 0, false, objNull];
		if (count _fpos > 0 && count(_tpos nearRoads 17) == 0 && ([_tpos, _structures] call CTI_CO_FNC_GetClosestEntity) distance _tpos > 25) then {
			_position = _fpos; _done = true
		};
		_i = _i + 1;
	};

	_position set [2, 0];
	_position
};
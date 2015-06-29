/*
  # HEADER #
	Script: 		Server\Functions\Server_CreateWorker.sqf
	Alias:			CTI_SE_FNC_CreateWorker
	Description:	Create a worker for a given side
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013

  # PARAMETERS #
    0	[Side]: The side which requested the worker
    1	[Boolean]: Was it an AI Request

  # RETURNED VALUE #
	None

  # SYNTAX #
	[SIDE, AI REQUEST] spawn CTI_SE_FNC_CreateWorker

  # DEPENDENCIES #

	Common Function: CTI_CO_FNC_GetRandomPosition
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideLogic

  # EXAMPLE #
    [_side, true] spawn CTI_SE_FNC_CreateWorker
	  -> AI request a worker
*/

private ["_ai_order", "_group", "_hq", "_index", "_logic", "_model", "_side", "_worker", "_workers"];

_side = _this select 0;
_ai_order = if (count _this > 1) then { _this select 1 } else { false }; //--- AI Commander requested it?

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_hq = (_side) call CTI_CO_FNC_GetSideHQ;

sleep (random 0.5); //--- Prevent a stack
while {CTI_Worker_Lock} do { sleep (random 0.5);};
CTI_Worker_Lock=True;
_workers = (_logic getVariable ["cti_workers",[]]) - [objNull] - [nil];
if ((count _workers) >= (missionNamespace getVariable "CTI_BASE_WORKERS_LIMIT")) exitWith {sleep (random 0.5); CTI_Worker_Lock=False;};
//_index = -1;
//if !(_ai_order) then {{if (typeName _x == "STRING") exitWith {_index = _forEachIndex}} forEach _workers};

//if (_index < 0 && !_ai_order) exitWith {diag_log "couldn't find a value to set a worker into"};

_group = createGroup _side;
_group setSpeedMode "LIMITED";

_model = missionNamespace getVariable format["CTI_%1_Worker", _side];
if (isNil '_model') then {_model = "C_man_1"};
if (typeName _model == "ARRAY") then {_model = _model select floor(random count _model)};

_worker = _group createUnit [_model, [_hq, 5, 20] call CTI_CO_FNC_GetRandomPosition, [], 0, "FORM"];
//if !(_ai_order) then {_workers set [_index, _worker]} else {_workers pushback _worker};
_workers pushBack _worker;
_logic setVariable ["cti_workers", _workers, true];
sleep (random 0.5);
CTI_Worker_Lock=False;
removeAllWeapons _worker;
_worker disableAI "TARGET";
_worker disableAI "AUTOTARGET";

if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [[_worker],true];};

[_side, _worker] execFSM "Server\FSM\update_worker.fsm";
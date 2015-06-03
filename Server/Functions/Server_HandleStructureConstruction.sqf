/*
  # HEADER #
	Script: 		Server\Functions\Server_HandleStructureConstruction.sqf
	Alias:			CTI_SE_FNC_HandleStructureConstruction
	Description:	Handle the lifespan of a structure's construction
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013

  # PARAMETERS #
    0	[Side]: The side of the structure
    1	[Object]: The ruin
    2	[String]: The structure variable name
    3	[Array]: The position
    4	[Array]: The direction

  # RETURNED VALUE #
	None

  # SYNTAX #
	[SIDE, RUIN, STRUCTURE VARIABLE, POSITION, DIRECTION] spawn CTI_SE_FNC_HandleStructureConstruction

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayPush
	Common Function: CTI_CO_FNC_GetClosestEntity
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_GetSideStructures
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_OnBuildingDestroyed
	Server Function: CTI_SE_FNC_OnBuildingHandleDamage
	Server Function: CTI_SE_FNC_OnBuildingHandleVirtualDamage
	Server Function: CTI_SE_FNC_OnBuildingHit

  # EXAMPLE #
    [_side, _structure, _variable, _position, _direction] spawn CTI_SE_FNC_HandleStructureConstruction;
*/

private ["_completion", "_completion_ratio", "_completion_last", "_direction", "_lasttouch", "_position", "_side", "_structure", "_variable"];

_side = _this select 0;
_side_id= (_side) call CTI_CO_FNC_GetSideID;
_structure = _this select 1;
_variable = _this select 2;
_position = _this select 3;
_direction = _this select 4;

if (CTI_DEBUG) then {_structure setVariable ["cti_completion", 100,true]};
waitUntil {!isNil {_structure getVariable "cti_completion"}};
_completion = _structure getVariable "cti_completion";
_completion_ratio = _structure getVariable "cti_completion_ratio";
_completion_last = _completion;

_lasttouch = time;

//--- Await for the site to be constructed or "abandonned"
while {_completion > 0 && _completion < 100} do {
	waitUntil {!isNil {_structure getVariable "cti_completion"}};
	_completion = _structure getVariable "cti_completion";
	sleep CTI_BASE_CONSTRUCTION_DECAY_DELAY;

	if (_completion > _completion_last) then { _lasttouch = time };

	if (time - _lasttouch > CTI_BASE_CONSTRUCTION_DECAY_TIMEOUT) then {_structure setVariable ["cti_completion", _completion - CTI_BASE_CONSTRUCTION_DECAY_FROM,true]};

	_completion_last = _completion;
};

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_logic setVariable ["cti_structures_wip", (_logic getVariable "cti_structures_wip") - [_structure, objNull],true];

deleteVehicle _structure;

if (_completion >= 100) then {
	_var = missionNamespace getVariable _variable;
	_structure = ((_var select 1) select 0) createVehicle _position;
	_structure setDir _direction;
	_structure setPos _position;
	_structure setDir _direction;
	_structure setVectorUp [0,0,0];
	_structure setVariable ["cti_save", _variable,false];
	_structure setVariable ["cti_structure_type", ((_var select 0) select 0)];

	//--- Do we use our alternative damage system to prevent some bisteries from happening?
	_alternative_damages = false;
	_reduce_damages = 0;
	{if ("DMG_Alternative" in _x) then {_alternative_damages = true}; if ("DMG_Reduce" in _x) then {_reduce_damages = _x select 1}; if ("Connected" in _x) then {_structure setVariable ["AN_iNet",_side_id,true]; _structure setVariable ["AN_Parrents",[_structure],false];} } forEach (_var select 5);
	if (_alternative_damages) then {
		_structure setVariable ["cti_altdmg", 0,true];
		_structure addEventHandler ["handledamage", format ["[_this select 0, _this select 2, _this select 3, '%1', %2, %3, %4, %5, %6] call CTI_SE_FNC_OnBuildingHandleVirtualDamage", _variable, (_side) call CTI_CO_FNC_GetSideID, _position, _direction, _completion_ratio, _reduce_damages]];
	} else {
		_structure addEventHandler ["killed", format ["[_this select 0, _this select 1, '%1', %2, %3, %4, %5] spawn CTI_SE_FNC_OnBuildingDestroyed", _variable, (_side) call CTI_CO_FNC_GetSideID, _position, _direction, _completion_ratio]];
		if (_reduce_damages > 0 || CTI_BASE_NOOBPROTECTION == 1) then {
			_structure addEventHandler ["handledamage", format ["[_this select 0, _this select 2, _this select 3, %1, %2, '%3', %4] call CTI_SE_FNC_OnBuildingHandleDamage", (_side) call CTI_CO_FNC_GetSideID, _reduce_damages, _variable, _position]];
		} else {
			_structure addEventHandler ["hit", format ["[_this select 0, _this select 2, %1, '%2', %3] spawn CTI_SE_FNC_OnBuildingHit", (_side) call CTI_CO_FNC_GetSideID, _variable, _position]];
		};
	};

	_logic setVariable ["cti_structures", (_logic getVariable "cti_structures") + [_structure], true];

	[_structure, _var, _side] call CTI_SE_FNC_InitializeStructure;

	[["CLIENT", _side], "Client_OnStructureConstructed", [_structure, _variable]] call CTI_CO_FNC_NetSend;
} else {
	private ["_areas", "_closest", "_need_update", "_structures_positions"];
	//--- We update the base area array to remove potential empty areas. First we get the 2D positions of our structures
	_areas = _logic getVariable "cti_structures_areas";
	_structures_positions = [];
	{
		_pos = getPos _x;
		_pos = [_pos select 0, _pos select 1];
		[_structures_positions, _pos] call CTI_CO_FNC_ArrayPush;
	} forEach ((_side call CTI_CO_FNC_GetSideStructures) + (_logic getVariable "cti_structures_wip"));

	//--- Check for empty areas now
	/*_need_update = false;
	{
		_closest = [_x, _structures_positions] call CTI_CO_FNC_GetClosestEntity;
		if (_closest distance _x > CTI_BASE_AREA_RANGE) then {_need_update = true; _areas set [_forEachIndex, "!nil!"]};
	} forEach +_areas;*/

	//--- Only update if we have to
	//if (_need_update) then {
	//	_areas = _areas - ["!nil!"];
	//	_logic setVariable ["cti_structures_areas", _areas, true];
	//};

	//todo: add message bout structure expiration
};

if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [[_structure],true];};

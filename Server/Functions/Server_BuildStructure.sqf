/*
  # HEADER #
	Script: 		Server\Functions\Server_BuildStructure.sqf
	Alias:			CTI_SE_FNC_BuildStructure
	Description:	Construct a structure at a given position (ruins first)
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013

  # PARAMETERS #
    0	[String]: The structure variable name
    1	[Side]: The Side which requested it
    2	[Array]: The position of the defense
    3	[Number]: The direction of the defense
    4	{Optionnal} [Object]: The person which requested it (send it back for undo)

  # RETURNED VALUE #
	[Object]: The ruins

  # SYNTAX #
	[STRUCTURE VARIABLE, SIDE, POSITION, DIRECTION] call CTI_SE_FNC_BuildStructure
	[STRUCTURE VARIABLE, SIDE, POSITION, DIRECTION, SOURCE] call CTI_SE_FNC_BuildStructure

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_HandleStructureConstruction

  # EXAMPLE #
    _placed = [_placed, CTI_CL_VAR_SideJoined, getPos _preview, getDir _preview] call CTI_SE_FNC_BuildStructure;
*/
_save=(_this select 0);
_var = missionNamespace getVariable (_this select 0);
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_origin = if (count _this > 4) then {_this select 4} else {objNull};

_position set [2, 0];

_structure = ((_var select 1) select 1) createVehicle _position;
_structure setDir _direction;
_structure setPos _position;
_structure setDir _direction;
_structure setVectorUp [0,0,0];


_structure setVariable ["cti_save", _save,true];
_structure setVariable ["cti_completion", 10,true];
_structure setVariable ["cti_completion_ratio", CTI_BASE_CONSTRUCTION_RATIO_INIT,true];
// _structure setVariable ["cti_structures_iteration", round(CTI_BASE_WORKERS_BUILD_COEFFICIENT / ((_var select 3)/100))];
_structure setVariable ["cti_structures_iteration", (_var select 3)/100,true];
_structure setVariable ["cti_structure_type", ((_var select 0) select 0)];

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_logic setVariable ["cti_structures_wip", (_logic getVariable "cti_structures_wip") + [_structure] - [objNull],true];

[_side, _structure, _this select 0, _position, _direction] spawn CTI_SE_FNC_HandleStructureConstruction;

[["CLIENT", _side], "Client_OnMessageReceived", ["structure-preplaced", [_this select 0, _position]]] call CTI_CO_FNC_NetSend;
[["CLIENT", _side], "Client_structurepreplaced", [_structure]] call CTI_CO_FNC_NetSend;
if !(isNull _origin) then {
	[["CLIENT", _origin], "Client_ReceiveStructureBase", _structure] call CTI_CO_FNC_NetSend;
};

if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [[_structure],true];};

_structure

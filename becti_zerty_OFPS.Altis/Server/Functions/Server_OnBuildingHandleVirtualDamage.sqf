/*
  # HEADER #
	Script: 		Server\Functions\Server_OnBuildingHandleVirtualDamage.sqf
	Alias:			CTI_SE_FNC_OnBuildingHandleVirtualDamage
	Description:	Triggered by the handleDamage EH whenever a structure get hit
					Note this function shall only be called by an Event Handler (EH).
					The damages are virtual so we return 0 all the time.
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013

  # PARAMETERS #
    0	[Object]: The hit structure
    1	[Number]: The inflicted damage by the hit
    2	[Object]: The shooter
    3	[String]: The structure variable name
    4	[Integer]: The Side ID of the structure
    5	[Array]: The structure's position
    6	[Number]: The structure's direction
    7	[Number]: The structure completion speed ratio
    8	[Number]: Damage reduction

  # RETURNED VALUE #
	[Number]: The negated afflicted damage

  # SYNTAX #
	[STRUCTURE, DAMAGES, SHOOTER, STRUCTURE VARIABLE, SIDE ID, POSITION, DIRECTION, COMPLETION RATIO, POSITION] call CTI_SE_FNC_OnBuildingHandleDamage

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_OnBuildingDestroyed

  # EXAMPLE #
    _structure addEventHandler ["handledamage", format ["[_this select 0, _this select 2, _this select 3, '%1', %2, %3, %4, %5, %6] call CTI_SE_FNC_OnBuildingHandleVirtualDamage", _variable, (_side) call CTI_CO_FNC_GetSideID, _position, _direction, _completion_ratio, _reduce_damages]];
*/

private ["_completion_ratio", "_damage", "_damaged", "_direction", "_logic", "_position", "_reduce_damages", "_shooter", "_side", "_sideID", "_variable", "_virtual_damages"];

_damaged = _this select 0;
_damage = _this select 1;
_shooter = _this select 2;
_variable = _this select 3;
_sideID = _this select 4;
_position = _this select 5;
_direction = _this select 6;
_completion_ratio = _this select 7;
_reduce_damages = _this select 8;

_side = (_sideID) call CTI_CO_FNC_GetSideFromID;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;

if (CTI_BASE_NOOBPROTECTION == 1 && side _shooter in [_side, sideEnemy]) exitWith {0};

//--- Do we have to reduce the damages?
_ratio=if (_damaged getvariable ["CTI_protected",false]&& CTI_SM_BASEP_M > 0) then { CTI_SM_BASEP_M} else {1};
_damage= _damage / _ratio;
if (_reduce_damages > 0) then {_damage = _damage / _reduce_damages};

_virtual_damages = _damaged getVariable "cti_altdmg";
if (isNil '_virtual_damages') then {_virtual_damages = 0};
_virtual_damages = _virtual_damages + _damage;
if (_virtual_damages > 1) then { _virtual_damages = 1 };

_damaged setVariable ["cti_altdmg", _virtual_damages,true];

if (_virtual_damages >= 1 || !alive _damaged) then {
	_damaged removeAllEventHandlers "handleDamage";
	_damaged setDammage 1;
	[_damaged, _shooter, _variable, _sideID, _position, _direction, _completion_ratio] spawn CTI_SE_FNC_OnBuildingDestroyed
};

//--- Display a message to the team
if (time - (_logic getVariable "cti_structures_lasthit") > 30 && _damage >= 0.02 && alive _damaged) then {
	_logic setVariable ["cti_structures_lasthit", time];
	[["CLIENT", _side], "Client_OnMessageReceived", ["structure-attacked", [_variable, _position]]] call CTI_CO_FNC_NetSend;
};

0
/*
  # HEADER #
	Script: 		Server\Functions\Server_OnBuildingHandleDamage.sqf
	Alias:			CTI_SE_FNC_OnBuildingHandleDamage
	Description:	Triggered by the handleDamage EH whenever a structure get hit
					Note this function shall only be called by an Event Handler (EH)
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	16-10-2013

  # PARAMETERS #
    0	[Object]: The hit structure
    1	[Number]: The inflicted damage by the hit
    2	[Object]: The shooter
    3	[Integer]: The Side ID of the structure
    4	[Number]: Damage reduction
    5	[Number]: The structure variable name
    6	[Array]: The position of the structure

  # RETURNED VALUE #
	[Number]: The afflicted damage

  # SYNTAX #
	[STRUCTURE, DAMAGES, SHOOTER, SIDE ID, DAMAGE REDUCTION, VARIABLE, POSITION] call CTI_SE_FNC_OnBuildingHandleDamage

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    _structure addEventHandler ["handledamage", format ["[_this select 0, _this select 2, _this select 3, %1, %2, '%3', %4] call CTI_SE_FNC_OnBuildingHandleDamage", (_side) call CTI_CO_FNC_GetSideID, _reduce_damages, _variable, _position]];
*/

private ["_damage", "_damaged", "_logic", "_position", "_reduce_damages", "_shooter", "_side", "_sideID", "_variable"];

_damaged = _this select 0;
_damage = _this select 1;
_shooter = _this select 2;
_sideID = _this select 3;
_reduce_damages = _this select 4;
_variable = _this select 5;
_position = _this select 6;

_side = (_sideID) call CTI_CO_FNC_GetSideFromID;
_ratio=if (_damaged getvariable ["CTI_protected",false]&& CTI_SM_BASEP_M > 0) then { CTI_SM_BASEP_M} else {1};
_currentdmg = getDammage _damaged;
_damage = _currentdmg + ((_damage - _currentdmg) / _ratio);
if (CTI_BASE_NOOBPROTECTION == 1 && side _shooter in [_side, sideEnemy]) exitWith {0};
if (_reduce_damages > 0) then {_currentdmg = getDammage _damaged; _damage = _currentdmg + ((_damage - _currentdmg) / _reduce_damages)};
if (_damaged getvariable ["CTI_protected",false]&& CTI_SM_BASEP_M > 0) then { CTI_SM_BASEP_M} else {1};
_logic = (_side) call CTI_CO_FNC_GetSideLogic;

if (time - (_logic getVariable "cti_structures_lasthit") > 30 && _damage >= 0.02 && alive _damaged) then {
	_logic setVariable ["cti_structures_lasthit", time];
	[["CLIENT", _side], "Client_OnMessageReceived", ["structure-attacked", [_variable, _position]]] call CTI_CO_FNC_NetSend;
};

_damage
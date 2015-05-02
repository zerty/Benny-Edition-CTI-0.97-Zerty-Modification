/*
  # HEADER #
	Script: 		Server\Functions\Server_OnBuildingHit.sqf
	Alias:			CTI_SE_FNC_OnBuildingHit
	Description:	Triggered by the Hit EH whenever a structure get hit
					Note this function shall be called by an Event Handler (EH) but can also be called manually
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013
	
  # PARAMETERS #
    0	[Object]: The destroyed structure
    1	[Number]: The afflicted damage
    2	[Intenger]: The Side ID of the structure
    3	[String]: The structure variable name
    4	[Array]: The position of the structure
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[STRUCTURE, DAMAGE, SIDE ID, STRUCTURE VARIABLE, POSITION] spawn CTI_SE_FNC_OnBuildingHit
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    _structure addEventHandler ["hit", format ["[_this select 0, _this select 2, %1, '%2', %3] spawn CTI_SE_FNC_OnBuildingHit", (_side) call CTI_CO_FNC_GetSideID, _variable, _position]];
*/

private ["_damage", "_logic", "_position", "_side", "_sideID", "_structure", "_variable"];

_structure = _this select 0;
_damage = _this select 1;
_sideID = _this select 2;
_variable = _this select 3;
_position = _this select 4;

_side = (_sideID) call CTI_CO_FNC_GetSideFromID;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;

if (time - (_logic getVariable "cti_structures_lasthit") > 30 && _damage >= 0.02 && (_damage + getDammage _structure) < 1) then {
	_logic setVariable ["cti_structures_lasthit", time];
	[["CLIENT", _side], "Client_OnMessageReceived", ["structure-attacked", [_variable, _position]]] call CTI_CO_FNC_NetSend;
};
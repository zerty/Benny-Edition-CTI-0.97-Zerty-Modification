/*
  # HEADER #
	Script: 		Client\Functions\Client_OnExplosivePlaced.sqf
	Alias:			CTI_CL_FNC_OnExplosivePlaced
	Description:	Triggered from the "Fired" EH whenever the player places an explosive
					Note this function shall be called inside an Event Handler (EH)
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Object]: The shooter
    1	[Object]: The explosive object
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SHOOTER, EXPLOSIVE] call CTI_CL_FNC_OnExplosivePlaced
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetClosestEntity
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideStructures
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    [_unit, _projectile] spawn CTI_CL_FNC_OnExplosivePlaced
	  -> Check if the explosive placement is valid or not, if near a friendly structure then it's removed
*/

_unit = _this select 0;
_projectile = _this select 1;

_structures = (CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures) + [CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ];
_closest = [_unit, _structures] call CTI_CO_FNC_GetClosestEntity;

if (_closest distance _unit < 30) then {
	deleteVehicle _projectile;
	
	_label = "Headquarters";
	if !(isNil {_closest getVariable "cti_structure_type"}) then {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _closest getVariable "cti_structure_type"];
		_label = (_var select 0) select 1;
	};
	
	[["CLIENT", CTI_P_SideJoined], "Client_OnMessageReceived", ["structure-teamkill-attempt", [name _unit, (group _unit) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], _label]]] call CTI_CO_FNC_NetSend;
	if (isPlayer _unit) then {["SERVER", "Request_NoobLogger", [_unit, 1]] call CTI_CO_FNC_NetSend};
};
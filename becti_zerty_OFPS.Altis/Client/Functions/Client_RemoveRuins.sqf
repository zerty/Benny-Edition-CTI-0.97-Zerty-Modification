/*
  # HEADER #
	Script: 		Client\Functions\Client_RemoveRuins.sqf
	Alias:			CTI_CL_FNC_RemoveRuins
	Description:	Called by the server whenever a structure get destroyed to remove the "local" ruins
					The PVF "CTI_PVF_Client_RemoveRuins" calls it
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	20-09-2013
	
  # PARAMETERS #
    0	[Array]: The structure posistion
    1	[String]: The ruins classname
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[POSITION, RUINS] call CTI_CL_FNC_RemoveRuins
	
  # EXAMPLE #
    [_position, _ruins] call CTI_CL_FNC_RemoveRuins
*/

private ["_classnames", "_position", "_var", "_variable"];

_position = _this select 0;
_variable = _this select 1;

_var = missionNamespace getVariable _variable;
_classnames = _var select 1;
_classnames = if (count _classnames > 2) then {[_classnames select 1] + (_classnames select 2)} else {[_classnames select 1]};

//--- Only pure clients will have to clean it
if !(CTI_IsHostedServer) then {{if (local _x) then {deleteVehicle _x}} forEach (nearestObjects [_position, _classnames, 25])};
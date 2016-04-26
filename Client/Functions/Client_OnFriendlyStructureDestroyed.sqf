/*
  # HEADER #
	Script: 		Client\Functions\Client_OnFriendlyStructureDestroyed.sqf
	Alias:			CTI_CL_FNC_OnFriendlyStructureDestroyed
	Description:	Called by the server "Killed" EH whenever a friendly structure is destroyed
					Note this function is automatically called by the EH but can be called manually
					It is called from the PVF "CTI_PVF_Client_OnStructureKilled"
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Array]: The position of the destroyed structure
    1	[String]: The variable used by the structure

  # RETURNED VALUE #
	None

  # SYNTAX #
	[POSITION, STRUCTURE VARIABLE] call CTI_CL_FNC_OnFriendlyStructureDestroyed

  # EXAMPLE #
    [_position, _variable] call CTI_CL_FNC_OnFriendlyStructureDestroyed
	  -> Update the client purchase queue and display a message
*/

private ["_position", "_sell", "_var", "_variable"];

_position = _this select 0;
_variable = _this select 1;
_sell = _this select 2;

_var = missionNamespace getVariable _variable;

//todo move to displaymessage
if !(_sell) then {
	HUD_NOTIFICATIONS pushBack [format [localize "STR_Structure_Destroyed", (_var select 0) select 1, mapGridPosition _position],time+18000,"ffff00"];
} else {
	HUD_NOTIFICATIONS pushBack [ format [localize "STR_Structure_Sold", (_var select 0) select 1, mapGridPosition _position],time+10,"ffffff"];
};

{
	if !(alive (_x select 3)) then {CTI_P_PurchaseRequests set [_forEachIndex, "!REMOVE!"]};
} forEach +CTI_P_PurchaseRequests;

CTI_P_PurchaseRequests = CTI_P_PurchaseRequests - ["!REMOVE!"];
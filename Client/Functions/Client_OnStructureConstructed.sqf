/*
  # HEADER #
	Script: 		Client\Functions\Client_OnStructureConstructed.sqf
	Alias:			CTI_CL_FNC_OnStructureConstructed
	Description:	Called by the server whenever a friendly structure construction is achieved
					Note this function is called automatically by the PVF "Client_OnStructureConstructed"
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	14-10-2013

  # PARAMETERS #
    0	[Object]: The structure
    1	[String]: The structure variable name

  # RETURNED VALUE #
	None

  # SYNTAX #
	[STRUCTURE, VARIABLE] call CTI_CL_FNC_OnStructureConstructed

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
	[_structure, _variable] call CTI_CL_FNC_OnStructureConstructed
*/

private ["_marker", "_score", "_structure", "_var", "_variable"];

_structure = _this select 0;
_variable = _this select 1;

_var = missionNamespace getVariable _variable;

//todo move to displaymessage
HUD_NOTIFICATIONS pushBack [format [localize "STR_Structure_Constructed", (_var select 0) select 1, mapGridPosition getPos _structure],time +180 ,"ffffff"];

//--- Add score for the commander
if (isNull (CTI_P_SideLogic getVariable "cti_commander")) then {
	if (group player == (CTI_P_SideLogic getVariable "cti_commander")) then {
		_score = round((_var select 2) / CTI_SCORE_BUILD_VALUE_PERPOINT);
		if (_score > 0) then {["SERVER", "Request_AddScore", [player, _score]] call CTI_CO_FNC_NetSend}; //--- Award some score
	};
};

[_structure, _var] call CTI_CL_FNC_InitializeStructure;
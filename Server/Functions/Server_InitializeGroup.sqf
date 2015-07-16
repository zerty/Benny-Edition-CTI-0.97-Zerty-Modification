/*
  # HEADER #
	Script: 		Server\Functions\Server_InitializeGroup.sqf
	Alias:			CTI_SE_FNC_InitializeGroup
	Description:	Initialize a CTI Groups with the needed variables
	Author: 		Benny
	Creation Date:	15-10-2013
	Revision Date:	15-10-2013

  # PARAMETERS #
    0	[Group]: The group to initialize
    1	[Side]: The side of the group

  # RETURNED VALUE #
	None

  # SYNTAX #
	[GROUP, SIDE] call CTI_SE_FNC_InitializeGroup

  # EXAMPLE #
    [group player, side player] call CTI_SE_FNC_InitializeGroup
	  -> Will initialize the player's group on his own side
*/

private ["_side", "_team"];

_team = _this select 0;
_side = _this select 1;
_players=_this select 2;
_side_logic=_side call CTI_CO_FNC_GetSideLogic;


if (isNil {_team getVariable "cti_role_evo"}) then {_team setVariable ["cti_role_evo", "Infantry"]}; //--- Evolutive role
if (isNil {_team getVariable "cti_order"}) then {_team setVariable ["cti_order", CTI_ORDER_TAKETOWNS, true]};
if (isNil {_team getVariable "cti_order_pos"}) then {_team setVariable ["cti_order_pos", [0,0], true]};
if (isNil {_team getVariable "cti_nextrespawn"}) then {_team setVariable ["cti_nextrespawn", -600]};
if (isNil {_team getVariable "cti_role"}) then {_team setVariable ["cti_role", "Infantry", true]}; //--- AI use Infantry by default
if (isNil {_team getVariable "cti_independent"}) then {_team setVariable ["cti_independent", true, true]}; //--- AI leaders may purchase things by their own
//if (isNil {_team getVariable "last_known_players"}) then {_team setVariable ["last_known_players",[],true]};
if (isNil {_team getVariable "cti_funds"}) then {
	if (isPlayer leader _team) then {_team setVariable ["cti_funds", 0, true]} else {_team setVariable ["cti_funds",  missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", _side], true]};
	};
//if (isNil {_team getVariable "last_known_players"}) then {_team setVariable ["last_known_players",_players,true]};
//if (isNil {_team getVariable "cti_funds"}) then {_team setVariable ["cti_funds", missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", _side], true]};


if !(_team in ((_side) call CTI_CO_FNC_GetSideGroups) ) then {_side_logic setvariable ["cti_teams",(_side_logic getVariable ["cti_teams",[]] ) - [grpNull] + [_team],true]};


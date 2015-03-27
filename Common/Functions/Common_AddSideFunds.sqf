/*
  # HEADER #
	Script: 		Common\Functions\Common_AddSideFunds.sqf
	Alias:			CTI_CO_FNC_AddSideFunds
	Description:	Add funds to a side. The funds are shared in two,
					the commander get his share depending on the percentage set
					while the players receive a divided share of the remains
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Side]: The desired side
    1	[Number]: The amount to add (int, float, double...)
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, AMOUNT] call CTI_CO_FNC_AddSideFunds
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ChangeFunds
	Common Function: CTI_CO_FNC_GetSideCommander
	Common Function: CTI_CO_FNC_GetSideGroups
	Common Function: CTI_CO_FNC_GetSideLogic
	
  # EXAMPLE #
	[West, 500] call CTI_CO_FNC_AddSideFunds
	  -> Asuming Players Pool is on 50% and that there is 4 Players aside from the commander:
	   -> Commander get 250
	   -> Players get 250 / 4 (62.5 each)
*/

private ["_commander", "_funds", "_groups", "_logic", "_side", "_total_groups", "_value", "_value_commander", "_value_player", "_value_players"];

_side = _this select 0;
_value = _this select 1;

if (isNil '_value') exitWith {};
if (typeName _value != "SCALAR") exitWith {};

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_commander = (_side) call CTI_CO_FNC_GetSideCommander;
_groups = (_side) call CTI_CO_FNC_GetSideGroups;
_groups = _groups - [_commander];

//--- Split among players and commander
_total_groups = count _groups;
_value_players = round(_value * (_logic getVariable "cti_pool_resources"));
_value_commander = round(_value - _value_players);

if (_total_groups < 1) then {_value_commander = _value_commander + _value_players};

//--- Change the players' funds if possible
_value_player = 0;
if (_total_groups > 0) then {
	_value_player = round(_value_players / _total_groups);
	if (_value_player > 0) then {
		{[_x, _side, _value_player] call CTI_CO_FNC_ChangeFunds} forEach _groups;
	};
};

//--- Change the commander funds
if (_value_commander > 0) then {_logic setVariable ["cti_commander_funds", (_logic getVariable "cti_commander_funds") + _value_commander, true]};

[_value_player, _value_players, _value_commander]

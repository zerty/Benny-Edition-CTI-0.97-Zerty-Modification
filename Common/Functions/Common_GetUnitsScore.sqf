/*
  # HEADER #
	Script: 		Common\Functions\Common_GetUnitsScore.sqf
	Alias:			CTI_CO_FNC_GetUnitsScore
	Description:	Retrieve the sum of the score of a given units array
					Note that this function only work in MP (Lan/Dedi)
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Array]: The units
	
  # RETURNED VALUE #
	[Integer]: The sum of units' score
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetUnitsScore
	
  # EXAMPLE #
    _score = [player, ...] call CTI_CO_FNC_GetUnitsScore
	  -> Return the sum of the units score (or 0 in SP)
*/

private ["_logic", "_score"];

if (typeName _this != "ARRAY") exitWith {0};

_score = 0;
{_score = _score + score leader _x} forEach _this;

_score
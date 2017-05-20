/*
  # HEADER #
	Script: 		Common\Functions\Common_ArrayReverse.sqf
	Alias:			CTI_CO_FNC_ArrayReverse
	Description:	Reverse an array
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array]: A generic array
	
  # RETURNED VALUE #
	[Array]: The reversed array
	
  # SYNTAX #
	(ARRAY) call CTI_CO_FNC_ArrayReverse
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayPush
	
  # EXAMPLE #
	_myArray = [0,1,2];
	(_myArray) call CTI_CO_FNC_ArrayReverse; -> [2,1,0]
*/

private ["_array", "_array2"];

_array = _this;
_array2 = [];

for '_i' from count(_array)-1 to 0 step -1 do {[_array2, _array select _i] call CTI_CO_FNC_ArrayPush};

_array2
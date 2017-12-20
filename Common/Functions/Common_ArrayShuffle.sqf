/*
  # HEADER #
	Script: 		Common\Functions\Common_ArrayShuffle.sqf
	Alias:			CTI_CO_FNC_ArrayShuffle
	Description:	Shuffle (mix) an array
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array]: A generic array
	
  # RETURNED VALUE #
	[Array]: A shuffled array
	
  # SYNTAX #
	(ARRAY) call CTI_CO_FNC_ArrayShuffle
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayShift
	
  # EXAMPLE #
	_myArray = [0,1,2,3,4];
	(_myArray) call CTI_CO_FNC_ArrayShuffle; 
	  -> Random result like: [1,2,0,4,3]
*/

private ["_array","_count","_ran","_selected","_shuffled"];

_array = +_this;
_shuffled = [];
_count = (count _array) -1;

for '_i' from 0 to _count do {
	_ran = floor random(count _array);
	_selected = _array select _ran;
	_shuffled set [_i, _selected];
	_array = [_array, [_ran]] Call CTI_CO_FNC_ArrayShift;
};

_shuffled
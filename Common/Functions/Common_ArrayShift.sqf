/*
  # HEADER #
	Script: 		Common\Functions\Common_ArrayShift.sqf
	Alias:			CTI_CO_FNC_ArrayShift
	Description:	Remove one or multiple elements present in an array
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array]: A generic array
    1	[Array]: A generic array containing the elements to remove
	
  # RETURNED VALUE #
	[Array]: The shifted array
	
  # SYNTAX #
	[ARRAY, ARRAY] call CTI_CO_FNC_ArrayShift
	
  # EXAMPLE #
	_myArray = [0,1,2,East,West];
	_removes = [1,East];
	[_myArray, _removes] call CTI_CO_FNC_ArrayShift; -> [0,2,West]
*/

private ["_array", "_i", "_remove", "_shifted"];

_array = +(_this select 0);
_remove = _this select 1;

_shifted = [];
_i = 0;
for '_j' from 0 to count(_array)-1 do {
	if !(_j in _remove) then {
		_shifted set [_i, _array select _j];
		_i = _i + 1;
	};
};

_shifted
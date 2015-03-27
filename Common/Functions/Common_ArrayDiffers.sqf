/*
  # HEADER #
	Script: 		Common\Functions\Common_ArrayDiffers.sqf
	Alias:			CTI_CO_FNC_ArrayDiffers
	Description:	Check if two arrays are different either by their size or content
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array]: A generic array
    1	[Array]: A generic array
	
  # RETURNED VALUE #
	[Boolean]: Return true if the arrays differs
	
  # SYNTAX #
	[ARRAY, ARRAY] call CTI_CO_FNC_ArrayDiffers
	
  # EXAMPLE #
	_myArray = [0,1,2];
	_myArray2 = [0,1];
	_myArray3 = [2,1,0];
	_myArray4 = [2,1,3];
	
	[_myArray, _myArray2] call CTI_CO_FNC_ArrayDiffers; -> True
	[_myArray2, _myArray3] call CTI_CO_FNC_ArrayDiffers; -> False
	[_myArray3, _myArray4] call CTI_CO_FNC_ArrayDiffers; -> False
*/

private ["_array1", "_array2", "_different", "_item"];

_array1 = _this select 0;
_array2 = _this select 1;

_different = false;

if (count _array1 != count _array2) then { 
	_different = true;
} else {
	{
		_item = _x;
		if (({_x == _item} count _array1) != ({_x == _item} count _array2)) exitWith { _different = true };
	} forEach _array1;
};

_different
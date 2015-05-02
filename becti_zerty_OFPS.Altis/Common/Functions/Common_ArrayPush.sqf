/*
  # HEADER #
	Script: 		Common\Functions\Common_ArrayPush.sqf
	Alias:			CTI_CO_FNC_ArrayPush
	Description:	Push a new element at the end of an existing array.
					Note that due to array inheritance, the source array is
					automatically updated.
	Author: 		Benny
	Creation Date:	13-05-2013
	Revision Date:	13-05-2013
	
  # PARAMETERS #
    0	[Array]: A generic array
    1	[Value]: A value, it can be anything (object, scalar, string...)
	
  # RETURNED VALUE #
	[Array]: The array
	
  # SYNTAX #
	[ARRAY, VALUE] call CTI_CO_FNC_ArrayPush
	
  # EXAMPLE #
	_myArray = [0];
	[_myArray, 1] call CTI_CO_FNC_ArrayPush; -> [0, 1]
	[_myArray, west] call CTI_CO_FNC_ArrayPush; -> [0, 1, west]
*/

private ["_array", "_value"];

_array = _this select 0;
_value = _this select 1;

_array set [count _array, _value];
_array
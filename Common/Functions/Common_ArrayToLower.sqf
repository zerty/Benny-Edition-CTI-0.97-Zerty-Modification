/*
  # HEADER #
	Script: 		Common\Functions\Common_ArrayToLower.sqf
	Alias:			CTI_CO_FNC_ArrayToLower
	Description:	Convert all string elements in an array to lowercase
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013
	
  # PARAMETERS #
    0	[Array]: A generic strings array
	
  # RETURNED VALUE #
	[Array]: The converted array
	
  # SYNTAX #
	(ARRAY) call CTI_CO_FNC_ArrayToLower
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayPush
	
  # EXAMPLE #
	_myArray = ["benny","Benny","BENNY"];
	(_myArray) call CTI_CO_FNC_ArrayToLower; -> ["benny","benny","benny"]
*/

private ["_array","_index"];

_array = +_this;
_tolower = [];

{[_tolower, toLower _x] call CTI_CO_FNC_ArrayPush} forEach _array;

_tolower
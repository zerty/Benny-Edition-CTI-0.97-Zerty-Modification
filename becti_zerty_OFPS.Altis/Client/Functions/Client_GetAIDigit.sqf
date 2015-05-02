/*
  # HEADER #
	Script: 		Client\Functions\Client_GetAIDigit.sqf
	Alias:			CTI_CL_FNC_GetAIDigit
	Description:	Attempt to get the AI squad digit
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Object]: The unit
	
  # RETURNED VALUE #
	[String]: The unit's digit
	
  # SYNTAX #
	(UNIT) call CTI_CL_FNC_GetAIDigit
	
  # EXAMPLE #
    (player) call CTI_CL_FNC_GetAIDigit 
	  -> Will return "Leader" if the player is the leader of his own group
    (unit2) call CTI_CL_FNC_GetAIDigit 
	  -> Will return 2 Assuming the unit is #2 in the group
*/

private ["_split", "_unit", "_yield"];

_unit = _this;

if (_unit == leader (group _unit)) exitWith {"Leader"};
if (isPlayer _unit && _unit != leader (group _unit)) exitWith {"Player"};

_split = toArray(str _unit);

_find = _split find 58;
_yield = [];

if (_find != -1) then {
	for '_i' from (_find+1) to count(_split)-1 do {
		if ((_split select _i) == 65 || (_split select _i) == 32) exitWith {};
		_yield = _yield + [_split select _i];
	};
};

if (count _yield == 0) exitWith {"0"};

toString(_yield)
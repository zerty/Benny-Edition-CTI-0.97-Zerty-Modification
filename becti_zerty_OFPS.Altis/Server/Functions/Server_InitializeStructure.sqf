/*
  # HEADER #
	Script: 		Server\Functions\Server_InitializeStructure.sqf
	Alias:			CTI_SE_FNC_InitializeStructure
	Description:	Initialize a structure upon construction completion
					Note that this script is only triggered on the server
	Author: 		Benny
	Creation Date:	14-10-2013
	Revision Date:	14-10-2013
	
  # PARAMETERS #
    0	[Object]: The structure
    1	[Array]: The structure variable array
    2	[Side]: The structure's side
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[STRUCTURE, STRUCTURE ARRAY, SIDE] call CTI_SE_FNC_InitializeStructure
	
  # EXAMPLE #
    [Barracks1, BarrackCoreInfo, East] call CTI_SE_FNC_InitializeStructure
*/

private ["_side", "_structure", "_var"];

_structure = _this select 0;
_var = _this select 1;
_side = _this select 2;

switch ((_var select 0) select 0) do {
	case CTI_BARRACKS: {
		//--- Handle the nearby statics
		if (CTI_BASE_DEFENSES_AUTO_LIMIT > 0) then {[_structure, _side] spawn CTI_SE_FNC_HandleStaticDefenses};
	};
};
/*
  # HEADER #
	Script: 		Common\Functions\Common_GetVehicleTurrets.sqf
	Alias:			CTI_CO_FNC_GetVehicleTurrets
	Description:	Return the vehicle's turret on 2 levels
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	14-10-2013
	
  # PARAMETERS #
    0	[String/Object]: The vehicle classname
	
  # RETURNED VALUE #
	[Array]: The vehicle turrets
	
  # SYNTAX #
	(CLASSNAME) call CTI_CO_FNC_GetVehicleTurrets
	
  # EXAMPLE #
    _turrets = ("B_MRAP_01_hmg_F") call CTI_CO_FNC_GetVehicleTurrets
	  -> Returns: [[0]]
*/

private ["_classname", "_config", "_config_sub", "_turrets"];

_classname = _this;
if (typeName _classname == "OBJECT") then {_classname = typeOf _classname};

_turrets = [];
_config = configFile >> "CfgVehicles" >> _classname >> "turrets";
for '_i' from 0 to (count _config)-1 do {
	_turret_main = _config select _i;
	_turrets = _turrets + [[_i]];
	
	_config_sub = _turret_main >> "turrets";
	for '_j' from 0 to (count _config_sub) -1 do {
		_turret_sub = _config_sub select _j;
		_turrets = _turrets + [[_i, _j]];
	};
};

_turrets
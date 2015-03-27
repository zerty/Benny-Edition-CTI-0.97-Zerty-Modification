/*
  # HEADER #
	Script: 		Common\Functions\Common_OnUnitGetOut.sqf
	Alias:			CTI_CO_FNC_OnUnitGetOut
	Description:	Triggered by the GetOut EH whenever a unit leaves the vehicles (similar to GetIn)
					Note this function shall be called by an Event Handler (EH)
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Object]: The vehicle
    1	[String]: The position in the vehicle
    2	[Object]: The unit

  # RETURNED VALUE #
	None

  # SYNTAX #
	[VEHICLE, POSITION, UNIT] call CTI_CO_FNC_OnUnitGetOut

  # EXAMPLE #
    _vehicle addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
*/

private ["_unit", "_vehicle"];

_vehicle = _this select 0;
_unit = _this select 2;

if (alive _unit) then {
	_side = side _unit;
	if (_side == sideEnemy) then {_side = switch (getNumber(configFile >> "CfgVehicles" >> typeOf _unit >> "side")) do {case 0: {east}; case 1: {west}; case 2: {resistance}; default {civilian}}};
	_vehicle setVariable ["cti_occupant", _side,true];
};
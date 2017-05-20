/*
  # HEADER #
	Script: 		Common\Functions\Common_OnUnitHit.sqf
	Alias:			CTI_CO_FNC_OnUnitHit
	Description:	Triggered by the Hit EH whenever a unit/vehicle receive a consequant damage
					Note this function shall be called by an Event Handler (EH)
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Object]: The unit/vehicle
    1	[Object]: The shooter
    2	[Number]: The damage iteration

  # RETURNED VALUE #
	None

  # SYNTAX #
	[VEHICLE, POSITION, UNIT] call CTI_CO_FNC_OnUnitHit

  # EXAMPLE #
    _vehicle addEventHandler ["hit", {_this spawn CTI_CO_FNC_OnUnitHit}];
*/

private ["_causedby","_damage","_unit"];

_unit = _this select 0;
_causedby = _this select 1;
_damage = _this select 2;

if !(simulationEnabled (_this select 0)) then {
		(_this select 0 ) enableSimulation true;
		["SERVER", "Uncache", (_this select 0 )] call CTI_CO_FNC_NetSend;
};

if (_damage >= 0.001 && !((side _causedby) == (side _unit))&& ! isNull _causedby) then {
	_unit setVariable ["cti_lasthit", _causedby,true];
	_unit setVariable ["cti_lasthit_time", time,true];

};
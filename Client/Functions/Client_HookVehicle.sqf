/*
  # HEADER #
	Script: 		Client\Functions\Client_HookVehicle.sqf
	Alias:			CTI_CL_FNC_HookVehicle
	Description:	Determine whether the Micro AI order changed or not
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Object]: The hooked vehicle
    1	[Object]: The hooking vehicle

  # RETURNED VALUE #
	None

  # SYNTAX #
	[VEHICLE, LIFTER] call CTI_CL_FNC_HookVehicle

  # EXAMPLE #
    [vehicle player, myChopper1] call CTI_CL_FNC_HookVehicle
	  -> This will hook the player's vehicle to the chopper "myChopper1"
*/

private ["_hooked", "_hooker", "_mpos"];

_hooked = _this select 0;
_hooker = _this select 1;

//--- Determine where to hook.
_mpos = switch (true) do {
	case (_hooker isKindOf "Air"): {[0,0,-4]};
	case (_hooker isKindOf "Ship"): {[0,-10,1]};
	default {[0,-5,0]};
};

_hooked attachTo [_hooker, _mpos];
{ unassignVehicle _x } forEach crew _hooked;
//--- Hook lifespan
while {true} do {
	sleep 0.1;
	{ unassignVehicle _x } forEach crew _hooked;
	_current_hooked = _hooker getVariable "cti_hooked";
	if (isNil '_current_hooked') then {_current_hooked = objNull};

	if (!canMove _hooker || getDammage _hooker > 0.3  || _hooked != _current_hooked) exitWith {
		if (_current_hooked == _hooked) then {
			_hooker setVariable ["cti_hooked", nil, true];
			detach _current_hooked;
			_velocity = velocity _hooker;
			_velocity set [2, (_velocity select 2) - 1];
			_current_hooked setVelocity _velocity;
		};
	};
};
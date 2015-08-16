/*
  # HEADER #
	Script: 		Server\Functions\Server_TrashObject.sqf
	Alias:			CTI_SE_FNC_TrashObject
	Description:	Trashing process of an entity, the delay can vary depending on the nature
					of the object.
					Note that empty non-playable groups are also trashed there
					This function is called automatically by the Garbage Collector FSM:
					 - Server\FSM\update_garbage_collector.fsm
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	23-09-2013

  # PARAMETERS #
    0	[Object]: The object/entity
    1	{Optionnal} [Delay]: A custom delay (override)

  # RETURNED VALUE #
	None

  # SYNTAX #
	[OBJECT] spawn CTI_SE_FNC_TrashObject
	[OBJECT, DELAY] spawn CTI_SE_FNC_TrashObject

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_IsGroupPlayable

  # EXAMPLE #
    [tankwreck1] spawn CTI_SE_FNC_TrashObject
	  -> Will delete the Tank wreck after the delay defined in CTI_GC_DELAY_TANK
	[tankwreck1, 20] spawn CTI_SE_FNC_TrashObject
	  -> Will delete the Tank wreck after a delay of 20 seconds
*/

private ["_delay", "_object", "_object_group", "_object_isman", "_object_seed", "_object_type"];

_object = _this select 0;
_delay = if (count _this > 1) then {_this select 1} else {-1};

_object_isman = if (_object isKindOf "Man") then {true} else {false};
_object_group = if (_object_isman) then {group _object} else {grpNull};
_object_seed = time + random 100 - random 50 + diag_frameno;

if (isNull _object) exitWith {
	if (CTI_Log_Level >= CTI_Log_Error) then { ["ERROR", "FILE: Server\Functions\Server_TrashObject.sqf", "Cannot delete a null object"] call CTI_CO_FNC_Log };
};

_object_type = typeOf  _object;

//--- Determine the nature of the given entity if the delay is not specified
if (_delay == -1) then {
	with missionNamespace do {
		_delay = switch (true) do {
			case (_object isKindOf "Man"): { CTI_GC_DELAY_MAN };
			case (_object isKindOf "Car"): { CTI_GC_DELAY_CAR };
			case (_object isKindOf "Tank"): { CTI_GC_DELAY_TANK };
			case (_object isKindOf "Air"): { CTI_GC_DELAY_AIR };
			case (_object isKindOf "Ship"): { CTI_GC_DELAY_SHIP };
			case (_object isKindOf "StaticWeapon"): { CTI_GC_DELAY_STATIC };
			case (_object isKindOf "Building"): { CTI_GC_DELAY_BUILDING };
			default { CTI_GC_DELAY }
		};
	};
};

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_TrashObject.sqf", format ["Begining the trashing process of object [%1] [%2] with a delay of [%3] with seed [%4].", _object_type, _object, _delay, _object_seed]] call CTI_CO_FNC_Log };

//--- Wait before cleaning up the object.

if (diag_fps <20) then {_delay =_delay/3};
if (_delay > 0) then { sleep _delay };

if (isNull _object) exitWith {
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_TrashObject.sqf", format["Cannot delete an object of type [%1] since it became null, seed [%2]. It has probably been removed during the delay of [%3] seconds", _object_type, _object_seed, _delay]] call CTI_CO_FNC_Log	};
};
if !(simulationEnabled _object) then {_object enableSimulationGlobal true};
waitUntil {simulationEnabled _object};
if (_object_isman) then {
	hideBody _object; //todo: broadcast too in mp (nearby players only tho)!
	deleteVehicle _object; //--- Delete the body first just in case we have to remove the group

	//--- If we're dealing with the last man in a group then we may aswel remove the group if it isn't playable
	if !(isNull _object_group) then {
		//--- A group may only be removed if it isn't playable AND if there isn't any units in it anymore (they have to be removed, even the dead ones)
		if (!(_object_group call CTI_CO_FNC_IsGroupPlayable) && count (units _object_group) <= 0) then {
			if (CTI_Log_Level >= CTI_Log_Information) then { //--- Information
				["INFORMATION", "FILE: Server\Functions\Server_TrashObject.sqf", format ["Trashing the group [%1] of object type [%2] with seed [%3].", _object_group, _object_type, _object_seed]] call CTI_CO_FNC_Log
			};
			deleteGroup _object_group;
		};
	};
} else {
	_object setPosASL [0,0,0];

	deleteVehicle _object; //--- Delete the generic object
};

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Server\Functions\Server_TrashObject.sqf", format["An object of type [%1] with seed [%2] has been removed after [%3] seconds", _object_type, _object_seed, _delay]] call CTI_CO_FNC_Log };
// Create Patrol and AI
// Input: None
// Output : [group, vehicle]



private ["_resistance_towns","_possible_town","_starting_town","_roads","_pos","_class","_v","_veh"];
_group=grpnull;
_v=objNull;
_resistance_towns=((CTI_RESISTANCE_ID) call CTI_CO_FNC_GetFriendlyTowns);
_possible_town=[];
{ if ((_x getVariable "cti_town_capture") == CTI_TOWNS_CAPTURE_VALUE_CEIL && !( _x getVariable "cti_town_occupation_active") && !( _x getVariable "cti_town_resistance_active")) then {_possible_town set [count _possible_town,_x]};true} count _resistance_towns;
if (count _possible_town == 0) exitWith {false};
_starting_town=(_possible_town select floor random count _possible_town);
_roads=_starting_town nearRoads 500;
if (count _roads >0 ) then {
	_pos = _roads select floor random count _roads;
	_class= GUER_VEHICLES_PATROL select floor( random (count GUER_VEHICLES_PATROL));
	_v=[_class, _pos, random(360), resistance, true, false, true] call CTI_CO_FNC_CreateVehicle;
	//waitUntil {!isnull _group && !isNull _v};
	_group=createGroup resistance;
	[_v,_group] call bis_fnc_spawncrew;
	if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [[_v],true];};
	_group setvariable ["defending",false,true];
	["SERVER", "Request_HandleAction", ["empty", [_v]]] call CTI_CO_FNC_NetSend;
	diag_log format [":: Patrols :: Creating %1 :: %2",_v,position _pos];
};
[_group,_v]

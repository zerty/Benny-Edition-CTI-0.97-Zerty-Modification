// What is making patrols move across towns
// Input: [group, vehicle]
// Output : NONE

_group=_this select 0;
_vehicle=_this select 1;

waitUntil {!isnull _group};
diag_log format [":: Patrols ::Starting AI for %1",_group];
_current_town= _vehicle call CTI_CO_FNC_GetClosestTown;
_previous=_current_town;
while {!CTI_GameOver && ! isNull _group && alive _vehicle && !isNull _vehicle && (_vehicle getvariable ["cti_occupant",civilian] )== resistance} do {
	if (_current_town getVariable "cti_town_sideID" == CTI_RESISTANCE_ID &&  !(_current_town getVariable "cti_town_occupation_active") && !(_current_town getVariable "cti_town_resistance_active") &&( (currentWaypoint _group)+1 > count (waypoints _group))) then {
		_neigh=_current_town getVariable "CTI_Neigh";
		_not_valid=[];
		_priority = [];
		{
			if (count (_x nearRoads 100) <1 ) then {_not_valid=_not_valid+[_x];};
			if (_x getVariable "cti_town_sideID" != CTI_RESISTANCE_ID ) then {_priority=_priority+[_x];};
		} forEach _neigh;

		_neigh=_neigh- _not_valid -[_previous] ;
		_next_target=if (count _priority >0) then { _priority select floor random (count _priority)} else {_neigh select floor random (count _neigh)};
		if (isNil "_next_target") then {_next_target= CTI_Towns select floor random (count CTI_Towns)};
		{deleteWaypoint _x; true} count (waypoints _group);
		_wp=_group addWaypoint [(getPos _next_target),0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "AWARE" ;
		_wp setWaypointFormation "COLUMN";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointSpeed "NORMAL";
		_group setCurrentWaypoint _wp;
		diag_log format [":: Patrols :: %1 moving from %2 to %3",_group,(_current_town getVariable "cti_town_name"),(_next_target getVariable "cti_town_name")];
		_previous=_current_town;
		_current_town=_next_target;
	};
	if ((_current_town getVariable "cti_town_occupation_active") || (_current_town getVariable "cti_town_resistance_active")) then {
		_group setvariable ["defending",true,false];
	} else {
		_group setvariable ["defending",false,false];
	};
	sleep (SM_PATROLS_TO/10);
};
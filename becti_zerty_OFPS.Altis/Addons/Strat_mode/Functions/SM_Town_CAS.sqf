SM_TCAS_MAINLOOP=compile '
	private ["_town","_type","_fly","_pos","_ppos","_dir","_v","_wp","_wp2"];
	_town=_this select 0;
	_type=_this select 1;
	_fly=_this select 2;
	_group=createGroup resistance;
	_pos=[_town,500,2000] call CTI_CO_FNC_GetRandomPosition;
	if (_fly == "FORM") then {
		_ppos=[_town,HELO_STARTUP] call CTI_CO_FNC_SortByDistance;
		_pos= _ppos select (floor random (4));
	};
	_dir=[_pos, _town] call CTI_CO_FNC_GetDirTo;
	if (_fly == "FLY") then {_pos set [2,1000];};
	_dir=[_pos, _town] call CTI_CO_FNC_GetDirTo;
	_v=[_type,_pos , _dir, resistance, false, true, true,_fly] call CTI_CO_FNC_CreateVehicle;

	[_v,_group] call bis_fnc_spawncrew;
	if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [([_v]),true];};
	if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [(units _group),true];};
	//_v flyInHeight 300;
	_wp=_group addWaypoint [(getPos _town), 500];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointCombatMode "GREEN";
	_wp setWaypointTimeout [0,0,0];
	_wp setWaypointCompletionRadius 1000;
	_wp setWaypointSpeed "FULL";
	for "_i" from 1 to 5 /* step +1 */ do {
	_wp2=_group addWaypoint [[[[(getPos _town),700]]] call BIS_fnc_randomPos, 0];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointBehaviour "COMBAT";
	_wp2 setWaypointCombatMode "RED";
	_wp2 setWaypointTimeout [0,0,0];
	_wp2 setWaypointCompletionRadius 100;
	};
	_wp3=_group addWaypoint [[[[(getPos _town),700]]] call BIS_fnc_randomPos, 0];
	_wp3  setwaypointtype "CYCLE";
	_group setCurrentWaypoint _wp;
	diag_log format [ "Town CAS ::  %1 Calling CAS %2", _town,_type];
	[_group,_v]';



SM_TCAS_CREATE=compile '
	private ["_town","_rn","_cas"];
	_town=_this;
	_rn= random (1);
	_cas="";
	if (_rn > 0.90) then {
		_cas = [_town, "I_Plane_Fighter_03_CAS_F","FLY"] call SM_TCAS_MAINLOOP;
	} else {
		_cas = [_town, "I_Heli_light_03_F","FORM"] call SM_TCAS_MAINLOOP;
	};
	diag_log _cas;
	_cas';


SM_TCAS_CLEANUP=compile '
	private ["_cas"];
	_cas=_this;
	if (count _cas >0 ) then {
		if (! isNull (_cas select 0 )) then {
			{deleteVehicle vehicle (_x); deleteVehicle _x;} count units (_cas select 0);
			deleteGroup (_cas select 0);
		};
	};';

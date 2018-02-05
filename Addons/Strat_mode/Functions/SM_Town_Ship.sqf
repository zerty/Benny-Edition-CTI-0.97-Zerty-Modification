SM_TShip_MAINLOOP=compile '
	private ["_town","_type","_form","_pos","_ppos","_dir","_v","_wp","_wp2","_wp3"];
	_town=_this select 0;
	_type=_this select 1;
	_form=_this select 2;
	_group=createGroup resistance;
	_townpos = getpos _town;
	_pos=[[[_townpos, 500]],["ground"]] call BIS_fnc_randomPos;
	_dir=([_pos, _town] call CTI_CO_FNC_GetDirTo) + 90;
	_v=[_type,_pos , _dir, resistance, false, true, true,_form] call CTI_CO_FNC_CreateVehicle;
	[_v,_group] call bis_fnc_spawncrew;
	if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [([_v]),true];};
	if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [(units _group),true];};
	_pos1=[[[_townpos, 500]],["ground"]] call BIS_fnc_randomPos;
	_wp=_group addWaypoint [_pos1, 25];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointCombatMode "GREEN";
	_wp setWaypointTimeout [0,0,0];
	_wp setWaypointCompletionRadius 25;
	_wp setWaypointSpeed "FULL";
	for "_i" from 1 to 5 /* step +1 */ do {
	_pos2=[[[_townpos, 500]],["ground"]] call BIS_fnc_randomPos;
	_wp2=_group addWaypoint [_pos2, 25];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointBehaviour "COMBAT";
	_wp2 setWaypointCombatMode "RED";
	_wp2 setWaypointTimeout [0,0,0];
	_wp2 setWaypointCompletionRadius 25;
	_wp2 setWaypointSpeed "NORMAL";
	};
	_pos3=[[[_townpos, 500]],["ground"]] call BIS_fnc_randomPos;
	_wp3=_group addWaypoint [_pos3, 25];
	_wp3  setwaypointtype "CYCLE";
	_group setCurrentWaypoint _wp;
	diag_log format [ "Town Ship ::  %1 Calling Ship %2", _town,_type];
	[_group,_v]';



SM_TShip_CREATE=compile '
	private ["_town","_ship"];
	_town=_this;
	_ship="";
	_ship = [_town, "I_Boat_Armed_01_minigun_F","FORM"] call SM_TShip_MAINLOOP;
	diag_log _ship;
	_ship';


SM_TShip_CLEANUP=compile '
	private ["_ship"];
	_ship=_this;
	if (count _ship >0 ) then {
		if (! isNull (_ship select 0 )) then {
			{deleteVehicle vehicle (_x); deleteVehicle _x;} count units (_ship select 0);
			deleteGroup (_ship select 0);
		};
	};';

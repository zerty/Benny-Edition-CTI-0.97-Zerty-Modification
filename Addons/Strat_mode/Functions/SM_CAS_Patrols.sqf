/*SM_CAS_EAST=[[],[],[]];
SM_CAS_WEST=[[],[],[]];

SM_CAS_UNITS_WEST=["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Plane_CAS_01_F"];
SM_CAS_UNITS_EAST=["O_Heli_Light_02_F","O_Heli_Attack_02_F","O_Plane_CAS_02_F"];

SM_CAS_LOG=true;


SM_CAS_CREATE={
	private ["_side","_number","_to_create","_type","_pos","_dir","_v"];
	_side=_this select 0;
	_number=_this select 1;
	_to_create=missionNamespace getVariable format ["SM_CAS_UNITS_%1", _side];
	_type= _to_create select _number;
	_group=createGroup _side;
	_pos=[(_side) call CTI_CO_FNC_GetSideHQ,1000,3000] call CTI_CO_FNC_GetRandomPosition;
	//_pos set [2,1000];
	_dir=random (360);

	_v=[_type,_pos , _dir, _side, false, true, true] call CTI_CO_FNC_CreateVehicle;
	[_v,_group] call bis_fnc_spawncrew;
		if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [[_v],true];};
	if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [(units _group),true];};
	//_v flyInHeight 250;
	[_side,_group,_v] spawn SM_CAS_AI_LOOP;
	[_side,_group,_v,_number] spawn SM_CAS_PURGE;
	if (SM_CAS_LOG) then { diag_log format ["CAS :: creating %1 , group %2 at %3 (upgrage %4 for %5)",_v,_group,_pos,_number, _side]};
	[_group,_v]
};

SM_CAS_MAIN_LOOP={
	private ["_side","_upgrades","_cas_up"];
	_side=_this select 0;
	while {! CTI_Gameover} do {
		if (SM_CAS_LOG) then { diag_log format ["CAS :: Checking upgrades and units for %1", _side]};
		_upgrades=(_side) call CTI_CO_FNC_GetSideUpgrades;
		_cas_up= _upgrades select CTI_UPGRADE_CAS;
		//_cas_up=5;
		_units=missionNamespace getVariable format ["SM_CAS_%1", _side];

		if (_cas_up >0) then {
			if (_cas_up>=1 && count (_units select 0) == 0) then { _units set [0,[_side,0] call SM_CAS_CREATE];};
			if (_cas_up>=2 && count (_units select 1) == 0) then { _units set [1,[_side,1] call SM_CAS_CREATE];};
			if (_cas_up>=3 && count (_units select 2) == 0) then { _units set [2,[_side,2] call SM_CAS_CREATE];};
		};
		missionNamespace setVariable [format ["SM_CAS_%1", _side],_units];
		sleep 60;
	};
};



SM_CAS_AI_LOOP={
	private ["_side","_v","_friendly_town","_territory","_t","_wp","_town","_wps","_cw"];
	_side= _this select 0;
	_group = _this select 1;
	_v= _this select 2;
	while {! CTI_Gameover && !isNull _group && side _v == _side && alive _v} do {
		{deleteWaypoint _x} count  (waypoints _group);
		_friendly_town= (_side) call CTI_CO_FNC_GetSideTowns;
		_territory=[];
		{
			_t=_x;
			if ({	_x in ((_side) call CTI_CO_FNC_GetSideTowns) 	} count (_t getVariable "CTI_Neigh") ==  count (_t getVariable "CTI_Neigh")) then {_territory set [count _territory, _t]};true
		} count _friendly_town;
		{
			_wp=_group addWaypoint [(getPos _town), 250];
			_wp setWaypointType "CYCLE";
			_wp setWaypointBehaviour "COMBAT";
			_wp setWaypointCombatMode "RED";
			_wp setWaypointTimeout [10,15, 20];
			_wp setWaypointCompletionRadius 500;
		} count _friendly_town;
		if (count _friendly_town == 0) then {
			_wp=_group addWaypoint [(getPos ((_side) call CTI_CO_FNC_GetSideHQ)), 250];
			_wp setWaypointType "SAD";
			_wp setWaypointBehaviour "COMBAT";
			_wp setWaypointCombatMode "RED";
			_wp setWaypointTimeout [100000,100000, 100000];
			_wp setWaypointCompletionRadius 500;
		};
		if (SM_CAS_LOG) then { diag_log format ["CAS ::  %1 group %2  :: %3 waypoints (%4)",_side,_group,(count _territory),_territory]};
		_wps= waypoints _group;
		_cw= _wps select floor random (count _wps);
		_group setCurrentWaypoint _cw;
		[_v, _side] call CTI_CO_FNC_RearmVehicle;
		_v setFuel 1;
		sleep 600;
	};


};

SM_CAS_PURGE={
	private ["_side","_v","_number","_unitclear","_unit","_cas"];
	_side=_this select 0;
	_group = _this select 1;
	_v= _this select 2;
	_number= _this select 3;
	sleep 10;
	_unitclear={
		_unit=_this;
		waitUntil {(vehicle _unit == _unit) || !(alive _unit)};
		if !(alive _unit ) exitWith {false};
		_to=time+600;
		waitUntil {time > _to || !(alive _unit)};
		_unit setDamage 1;
	};
	{_x spawn _unitclear; true} count (units _group);
	waitUntil {isNull _group || {alive _x} count (units _group) == 0 || !(alive _v) || {vehicle _x == _x} count (units _group)>0};
	if (! isNull (_group)) then {
			{deleteVehicle _x} count units _group;
			deleteGroup _group;
	};
	if (! isNull _v && side _v == _side && alive _v && count (crew _v) > 0) then {
			deleteVehicle (_cas select 1);
	};
	_units=missionNamespace getVariable format ["SM_CAS_%1", _side];
	_units set [_number, []];
	if (SM_CAS_LOG) then { diag_log format ["CAS ::  Loop end for %1 lvl %2 , removing unit",_side,_number]};
	missionNamespace setVariable [format ["SM_CAS_%1", _side],_units];
};

{[_x] spawn  SM_CAS_MAIN_LOOP;true }count [east,west];*/
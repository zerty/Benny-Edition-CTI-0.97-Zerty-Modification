/*
  # HEADER #
	Script: 		Server\Functions\Server_HandleStaticDefenses.sqf
	Alias:			CTI_SE_FNC_HandleStaticDefenses
	Description:	Handle of all static defense of a side
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	06-03-2018

  # PARAMETERS #
    0	[Side]: The side to manage

  # RETURNED VALUE #
	None

  # SYNTAX #
	[SIDE] spawn CTI_SE_FNC_HandleStaticDefenses

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_CreateUnit

  # EXAMPLE #
    [ _side] spawn CTI_SE_FNC_HandleStaticDefenses
	  -> Will manage manable statics for side _side
*/



private ["_side","_logic","_sideID","_net","_man_timeout","_defs","_defense_team","_nearest_b","_var","_direction","_distance","_position","_ai","_ammo_trucks","_nearest"];


_side= _this;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_sideID = (_side) call CTI_CO_FNC_GetSideID;

_net = if ((missionNamespace getVariable "CTI_MARKERS_INFANTRY") == 1) then {true} else {false};
_man_timeout = 180;
_skipRearms = 10;
while {! CTI_GAMEOVER} do {

	_defs=_logic getVariable ["cti_defences",[]];


	{
		if ((_x  getVariable ["cti_aman_enabled", false])|| (typeof _x )in ["B_AAA_System_01_F","B_SAM_System_01_F","B_SAM_System_02_F","B_Radar_System_01_F","B_SAM_System_03_F","O_Radar_System_02_F","O_SAM_System_04_F"]) then {
			_defense_team = _logic getVariable "cti_defensive_team";
			if (((_x emptyPositions "gunner" > 0)|| (gunner _x ) != (_x getvariable ["CTI_assigned_gunner",objnull]) || ((isnull (_x getvariable ["CTI_assigned_gunner",objnull])) && ! isnull (gunner _x))) && alive _x && isNull attachedTo _x) then {
				_nearest_b = [CTI_BARRACKS, _x, (_side) call CTI_CO_FNC_GetSideStructures, CTI_BASE_DEFENSES_AUTO_REARM_RANGE] call CTI_CO_FNC_GetClosestStructure;
				if (!(isnull _nearest_b) && alive _nearest_b && (getDammage _x) < 0.4 ) then {
					if (isnull (_x getvariable ["CTI_assigned_gunner",objnull]) && count(_defense_team call CTI_CO_FNC_GetLiveUnits) < CTI_BASE_DEFENSES_AUTO_LIMIT) then {
						_var = missionNamespace getVariable [format ["CTI_%1_%2", _side, _nearest_b getVariable "cti_structure_type"],[[0,"Town"],0,0,0,[0,0]]];
						_direction = 360 - ((_var select 4) select 0);
						_distance = (_var select 4) select 1;
						_position = _nearest_b modelToWorld [(sin _direction * _distance), (cos _direction * _distance), 0];

						if ((typeof _x )in ["B_AAA_System_01_F","B_SAM_System_01_F","B_SAM_System_02_F","B_Radar_System_01_F","B_SAM_System_03_F","O_Radar_System_02_F","O_SAM_System_04_F"] ) then {
							if  (isnull (gunner _x) || !alive (gunner _x)) then {
								_x deleteVehicleCrew ( gunner _x);
								createVehicleCrew _x;
								_x joinAsSilent [createGroup _side, 99];
								(group _x) setBehaviour "COMBAT";
								(group _x) setCombatMode "RED";
								_x setVehicleRadar 1;
								_x setVehicleLock "LOCKED";
								diag_log format [":: DEF NG :: creating crew for %1 of side %2 at time %3 ", _x,_side,(_x getVariable ["CTI_assigned_gunner_time",0])];
							};
						} else {
							if ( isNull _defense_team) then {_defense_team = createGroup _side; _logic setVariable ["cti_defensive_team",_defense_team,true];};
							_ai = [missionNamespace getVariable format["CTI_%1_Soldier", _side], _defense_team, _position, _sideID, _net] call CTI_CO_FNC_CreateUnit;
							[_ai] allowGetIn true;
							_ai assignAsGunner _x;
							_ai setvariable ["CTI_assigned_def",_x,false];
							_x setvariable ["CTI_assigned_gunner",_ai,false];
							_x setVariable ["CTI_assigned_gunner_time",time,false];
							[_ai] orderGetIn true;
							_defense_team setBehaviour "AWARE";
							_defense_team setCombatMode "RED";
							_defense_team setSpeedMode "FULL";
							diag_log format [":: DEF NG :: creating crew for %1 of side %2 at time %3 : %4", _x,_side,(_x getVariable ["CTI_assigned_gunner_time",0]),_ai];
						};

					} else {
						if (!(isnull (_x getvariable ["CTI_assigned_gunner",objnull])) && alive (_x getvariable ["CTI_assigned_gunner",objnull])) then {
							if (time > ((_x getVariable ["CTI_assigned_gunner_time",0])+_man_timeout)) then {
								diag_log format [":: DEF NG :: Moving late crew for %1 of side %2 expected at %3 (rt: %4) : %5", _x,_side,((_x getVariable ["CTI_assigned_gunner_time",0])+_man_timeout),time,(_x getvariable ["CTI_assigned_gunner",objnull])];
								moveout (gunner _x);
								(_x getvariable ["CTI_assigned_gunner",objnull]) moveInGunner _x;
							} else {
								[(_x getvariable ["CTI_assigned_gunner",objnull])] allowGetIn true;
								(_x getvariable ["CTI_assigned_gunner",objnull]) assignAsGunner _x;
								[(_x getvariable ["CTI_assigned_gunner",objnull])] orderGetIn true;
							};
						} else {
							if (!(isnull (_x getvariable ["CTI_assigned_gunner",objnull]))) then {
								diag_log format [":: DEF NG :: deleting dead crew for %1 of side %2 : %3", _x,_side,(_x getvariable ["CTI_assigned_gunner",objnull])];
								deleteVehicle (_x getvariable ["CTI_assigned_gunner",objnull]);
								_x setvariable ["CTI_assigned_gunner",objnull,false];
								_x setVariable ["CTI_assigned_gunner_time",-1,false];
							};
						};
					};
				};
			};


			if !(someAmmo _x) then {
				//--- Check if we have a nearby ammo source
				_ammo_trucks = [_x, CTI_SPECIAL_AMMOTRUCK, CTI_BASE_DEFENSES_AUTO_REARM_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
				_nearest = [CTI_AMMO, _x, (_side) call CTI_CO_FNC_GetSideStructures, CTI_BASE_DEFENSES_AUTO_REARM_RANGE] call CTI_CO_FNC_GetClosestStructure;

				if (count _ammo_trucks > 0 || (!isNull _nearest && alive _nearest)) then {
					if ((gunner _x) == (_x getvariable ["CTI_assigned_gunner",objnull])) then {
						_x setVehicleAmmoDef 1;
						diag_log format [":: DEF NG :: %1 of side %2 rearmed", _x,_side];
					};
					//rearm special Defenenses only ever "_skipRearms" minutes
					if((typeof _x )in ["B_AAA_System_01_F","B_SAM_System_01_F","B_SAM_System_02_F","B_SAM_System_03_F","O_SAM_System_04_F"]) then {
						_skippedR = _x getVariable["skipped_rearms", 0];
						_x setVariable["skipped_rearms", _skippedR+1];
						if(_skippedR >= _skipRearms) then {
							_x setVehicleAmmoDef 1;
							diag_log format [":: DEF NG :: %1 of side %2 rearmed", _x,_side];
							_x setVariable["skipped_rearms", 0];
						};
					};
				};
			};
		};
	} forEach _defs;


	_defense_team = _logic getVariable "cti_defensive_team";
	if !(isnull _defense_team) then {
		{
			if (isnull (_x getVariable ["CTI_assigned_def",objNull]) || (!alive (_x getVariable ["CTI_assigned_def",objNull])) || ( getDammage (_x getVariable ["CTI_assigned_def",objNull]) >= 0.4 ) ) then {deleteVehicle _x;};
		} forEach (units _defense_team);
	};

	sleep 60;
};

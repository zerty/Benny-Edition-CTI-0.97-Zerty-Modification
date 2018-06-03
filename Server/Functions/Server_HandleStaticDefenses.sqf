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





_side= _this;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_sideID = (_side) call CTI_CO_FNC_GetSideID;

_net = if ((missionNamespace getVariable "CTI_MARKERS_INFANTRY") == 1) then {true} else {false};
_man_timeout = 180;

while {! CTI_GAMEOVER} do {

	_defs=_logic getVariable ["cti_defences",[]];


	{
		if ((_x  getVariable ["cti_aman_enabled", false])||(_x isKindOf "B_AAA_System_01_F" || _x isKindOf "B_SAM_System_01_F" || _x isKindOf "B_SAM_System_02_F")) then {
			_defense_team = _logic getVariable "cti_defensive_team";
			if (_x emptyPositions "gunner" > 0 && alive _x) then {
				_nearest_b = [CTI_BARRACKS, _x, (_side) call CTI_CO_FNC_GetSideStructures, CTI_BASE_DEFENSES_AUTO_REARM_RANGE] call CTI_CO_FNC_GetClosestStructure;
				if (!(isnull _nearest_b) && alive _nearest_b) then {
					if (isnull (assignedGunner _x) && count(_defense_team call CTI_CO_FNC_GetLiveUnits) < CTI_BASE_DEFENSES_AUTO_LIMIT) then {
						_var = missionNamespace getVariable [format ["CTI_%1_%2", _side, _nearest_b getVariable "cti_structure_type"],[[0,"Town"],0,0,0,[0,0]]];
						_direction = 360 - ((_var select 4) select 0);
						_distance = (_var select 4) select 1;
						_position = _nearest_b modelToWorld [(sin _direction * _distance), (cos _direction * _distance), 0];
						if ( isNull _defense_team) then {_defense_team = createGroup _side; _logic setVariable ["cti_defensive_team",_defense_team,true];};
						_ai = [missionNamespace getVariable format["CTI_%1_Soldier", _side], _defense_team, _position, _sideID, _net] call CTI_CO_FNC_CreateUnit;
						[_ai] allowGetIn true;
						_ai assignAsGunner _x;
						_x setVariable ["CTI_assigned_gunner_time",time,false];
						[_ai] orderGetIn true;
						diag_log format [":: DEF NG :: creating crew for %1 of side %2 at time %3 : %4", _x,_side,(_x getVariable ["CTI_assigned_gunner_time",0]),_ai];
					} else {
						if (!(isnull (assignedGunner _x)) &&alive (assignedGunner _x)) then {
							if (time > ((_x getVariable ["CTI_assigned_gunner_time",0])+_man_timeout)) then {
								diag_log format [":: DEF NG :: Moving late crew for %1 of side %2 expected at %3 (rt: %4) : %5", _x,_side,((_x getVariable ["CTI_assigned_gunner_time",0])+_man_timeout),time,(assignedGunner _x)];
								(assignedGunner _x) moveInGunner _x;
							};
						} else {
							if (!(isnull (assignedGunner _x))) then {
								diag_log format [":: DEF NG :: deleting dead crew for %1 of side %2 : %3", _x,_side,(assignedGunner _x)];
								deleteVehicle (assignedGunner _x);
								objnull assignAsGunner _x;
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
					_x setVehicleAmmoDef 1;
					diag_log format [":: DEF NG :: %1 of side %2 rearmed", _x,_side];
				};
			};
		};
	} forEach _defs;

	sleep 60;
};
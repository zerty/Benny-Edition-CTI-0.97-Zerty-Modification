/*
  # HEADER #
	Script: 		Server\Functions\Server_HandleStaticDefenses.sqf
	Alias:			CTI_SE_FNC_HandleStaticDefenses
	Description:	Handle the lifespan of a static defense
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	14-10-2013

  # PARAMETERS #
    0	[Object]: The structure which act as a center
    1	[Side]: The side of that structure

  # RETURNED VALUE #
	None

  # SYNTAX #
	[STRUCTURE, SIDE] spawn CTI_SE_FNC_HandleStaticDefenses

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_CreateUnit

  # EXAMPLE #
    [_structure, _side] spawn CTI_SE_FNC_HandleStaticDefenses
	  -> Will search for manable statics around _structure
*/

private ["_ai", "_defense_team", "_direction", "_distance", "_last_scan", "_logic", "_manned", "_net", "_position", "_side", "_sideID", "_statics", "_structure", "_var"];

_structure = _this select 0;
_side = _this select 1;

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_sideID = (_side) call CTI_CO_FNC_GetSideID;
_defense_team = _logic getVariable "cti_defensive_team";

_var = missionNamespace getVariable format ["CTI_%1_%2", _side, _structure getVariable "cti_structure_type"];
_direction = 360 - ((_var select 4) select 0);
_distance = (_var select 4) select 1;
_position = _structure modelToWorld [(sin _direction * _distance), (cos _direction * _distance), 0];

_last_scan = -5000;
_statics = [];

_net = if ((missionNamespace getVariable "CTI_MARKERS_INFANTRY") == 1) then {true} else {false};

//--- Perform a defense manning routine while we can
while {alive _structure} do {

	if (time - _last_scan > 30) then {
		_last_scan = time;
		_statics = _structure nearEntities [["StaticWeapon"], CTI_BASE_DEFENSES_AUTO_RANGE];
	};

	//--- We man only one defense per loop as we skip the usual queue
	_manned = false;
	{
		if !(isNil {_x getVariable "cti_aman_enabled"}) then {
			_last_occupied = _x getVariable "cti_aman_time_occupied";
			if (isNil '_last_occupied') then {_last_occupied = -6000};

			//--- The static is occupied
			if (alive gunner _x || alive assignedGunner _x) then {
				_x setVariable ["cti_aman_time_occupied", time];
			} else {;
				//--- The static is empty
				if (!alive gunner _x && !alive assignedGunner _x && !_manned && time - _last_occupied > CTI_BASE_DEFENSES_AUTO_DELAY && count(_defense_team call CTI_CO_FNC_GetLiveUnits) < CTI_BASE_DEFENSES_AUTO_LIMIT && ! isNull _x  && alive _x) then {
					_manned = true;

					//--- Create the unit
					_ai = [missionNamespace getVariable format["CTI_%1_Soldier", _side], _defense_team, _position, _sideID, _net] call CTI_CO_FNC_CreateUnit;

					//--- Assign him to the defense
					[_ai] allowGetIn true;
					_ai assignAsGunner _x;
					_x setVariable ["CTI_assigned_gunner_obj",_ai,false];
					[_ai] orderGetIn true;

					_ai setVariable ["cti_aman_time_expected", time + ((((_ai distance _x)/(14*1000))*3600)+20)];
				};

				//--- The static is empty but it has an assigned gunner... but could he make it into the static..?
				if (!alive gunner _x && alive assignedGunner _x) then {
					_ai = assignedGunner _x;
					_time_expected = _ai getVariable "cti_aman_time_expected";

					if !(isNil '_time_expected') then {
						if (vehicle _ai != _x && alive _ai && time >= _time_expected) then {
							if ((_x emptyPositions "gunner" > 0) && alive _x) then {_ai moveInGunner _x} else {deleteVehicle _ai};
						};
					};
				};
				if !(alive _x) then {
					if (!(isnull (_x getVariable ["CTI_assigned_gunner_obj",objnull])) && alive (_x getVariable ["CTI_assigned_gunner_obj",objnull]) ) then { deleteVehicle (_x getVariable ["CTI_assigned_gunner_obj",objnull]) };
				};
			};

			//--- But.. our defense may run out of ammo?
			if !(someAmmo _x) then {
				//--- Check if we have a nearby ammo source
				_ammo_trucks = [_x, CTI_SPECIAL_AMMOTRUCK, CTI_BASE_DEFENSES_AUTO_REARM_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
				_nearest = [CTI_AMMO, _x, (_side) call CTI_CO_FNC_GetSideStructures, CTI_BASE_DEFENSES_AUTO_REARM_RANGE] call CTI_CO_FNC_GetClosestStructure;

				if (count _ammo_trucks > 0 || !isNull _nearest) then {_x setVehicleAmmoDef 1; player sidechat "rearmed!"};
			};
		};
	} forEach _statics;

	sleep 15;
};
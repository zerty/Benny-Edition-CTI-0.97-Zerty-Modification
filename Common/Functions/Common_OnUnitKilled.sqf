/*
  # HEADER #
	Script: 		Common\Functions\Common_OnUnitKilled.sqf
	Alias:			CTI_CO_FNC_OnUnitKilled
	Description:	Triggered by the Killed EH whenever a unit/vehicle dies
					Note this function can be called by an Event Handler (EH) or outside
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Object]: The killed entity
    1	[Object]: The killer
    2	[Integer]: The Side ID of the killed unit

  # RETURNED VALUE #
	None

  # SYNTAX #
	[KILLED, KILLER, SIDE ID] call CTI_CO_FNC_OnUnitKilled

  # EXAMPLE #
    _vehicle addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _side]];
*/

_killed = _this select 0;
_killer = _this select 1;
_sideID_killed = _this select 2;

_side_killed = (_sideID_killed) call CTI_CO_FNC_GetSideFromID;
_side_killed_original = _side_killed;

_isvehicle_killed = if (_killed isKindOf "Man") then {false} else {true};


if !(simulationEnabled (_this select 0)) then {
		(_this select 0 ) enableSimulation true;
		["SERVER", "Uncache", (_this select 0 )] call CTI_CO_FNC_NetSend;
};

if (_killed isKindOf "Man" && (vehicle _killed) isKindOf "Man" &&_side_killed == resistance && local _killed && (missionNamespace getVariable "CACHE_EMPTY") == 1) then {
	_killed spawn {
		sleep 2;
		_this enableSimulationGlobal false;
	};
};


//--- VEHICLES: The killed may be the killer (suicide), if so we determine determine who the proxy killer may be
_killed_proxy = false;
if ((_killer == _killed || vehicle (_killer) == _killed|| isNull _killer) && _isvehicle_killed) then {
	_last_hit = _killed getVariable "cti_lasthit";
	if !(isNil "_last_hit") then {
		if (alive _last_hit) then {
			if (side _last_hit != _side_killed && time - (_killed getVariable "cti_lasthit_time") < 120) then {_killed_proxy = true; _killer = _last_hit};

			//if (time - (_killed getVariable "cti_lasthit_time") < 120) then {_killed_proxy = true; _killer = _last_hit};
		};
	};
};

// player sidechat format ["%1",_killer];
if !(alive _killer) exitWith {}; //--- Killer is null or dead, nothing to see here

//--- VEHICLES: Determine the side of the last occupant of the vehicle
if (_isvehicle_killed) then {
	_last_side = _killed getVariable "cti_occupant";
	if !(isNil "_last_side") then {_side_killed = _last_side};
};

if ((_killer isKindOf "UAV" || _killer isKindOf "UGV_01_base_F" ) && ! isNull((uavControl _killer) select 0)  ) then {_killer = ((uavControl _killer) select 0)};

_side_killer = side _killer;
_group_killed = group _killed;
_group_killer = group _killer;
_type_killed = typeOf _killed;
_type_killer = typeOf _killer;
_isplayable_killed = (_group_killed) call CTI_CO_FNC_IsGroupPlayable;
_isplayable_killer = (_group_killer) call CTI_CO_FNC_IsGroupPlayable;
// _isplayer_killer = if (isPlayer leader _group_killer) then {true} else {false};

_renegade_killer = if (_side_killer == sideEnemy) then {true} else {false};

if (_renegade_killer) then { //--- Make sure the killer is not renegade, if so, get the side from the config.
	if !(_killer isKindOf "Man") then {_type_killer = typeOf effectiveCommander(vehicle _killer)};
	_side_killer = switch (getNumber(configFile >> "CfgVehicles" >> _type_killer >> "side")) do {case 0: {east}; case 1: {west}; case 2: {resistance}; default {civilian}};
};

_var_name = if (isNil {_killed getVariable "cti_customid"}) then {_type_killed} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _killed getVariable "cti_customid"]};
_var = missionNamespace getVariable _var_name;

//todo check what happens when crew bails out. side become civ?!
// this addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", 0]];this addEventHandler ["hit", {_this spawn CTI_CO_FNC_OnUnitHit}];
// this addEventHandler ["getIn", {_this spawn CTI_CO_FNC_OnUnitGetOut}]; this addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}]; this setVariable ["cti_occupant", west call CTI_CO_FNC_GetSideFromID];
// player sidechat format ["killed:%1 (%2)    killer:%3 (%4)",_killed, _side_killed,_killer, _side_killer];
if (!isNil '_var' && _isplayable_killer) then {
	_cost = _var select CTI_UNIT_PRICE;

	if (_side_killer != _side_killed) then { //--- Kill
		if (_side_killed != civilian) then {
			//--- The kill does not come from the leader, award the score to the leader in any cases.
			if (_killer != leader _group_killer) then {
				_points = switch (true) do {case (_type_killed isKindOf "Infantry"): {1};case (_type_killed isKindOf "Car"): {2};case (_type_killed isKindOf "Ship"): {4};case (_type_killed isKindOf "Motorcycle"): {1};case (_type_killed isKindOf "Tank"): {4};case (_type_killed isKindOf "Helicopter"): {4};case (_type_killed isKindOf "Plane"): {6};case (_type_killed isKindOf "StaticWeapon"): {2};case (_type_killed isKindOf "Building"): {2};default {1}};
				if (CTI_IsServer) then {[leader _group_killer, _points] spawn CTI_SE_FNC_AddScore} else {["SERVER", "Request_AddScore", [leader _group_killer, _points]] call CTI_CO_FNC_NetSend};
			};

			if (_side_killed_original == _side_killed) then {
			//--- If the side of the vehicle was different from the side of the illed unit (which can be the last occupant), then we skip the bounty part.
				_award_groups = [_group_killer];

				//--- The kill was not made by proxy and the killer is in a vehicle
				if (!_killed_proxy && vehicle _killer != _killer) then {
					_vehicle = vehicle _killer;
					{if (alive _x) then {if !(group _x in _award_groups) then { _award_groups pushBack (group _x)}}} forEach [driver _vehicle, gunner _vehicle, commander _vehicle];
				};

				//--- If there is more than one group to award then we split the bounty equally
				//_mult=if ((missionNamespace getVariable "CTI_GROUP_AWARD_MULT") == 1) then {(count (_group_killer getVariable ["last_known_players",[""]]))} else {1};
				//_bounty = round( _mult * _cost * CTI_VEHICLES_BOUNTY /100);
				_bounty = round( _cost * CTI_VEHICLES_BOUNTY /100);
				if (count _award_groups > 1) then { _bounty = round(_bounty / (count _award_groups))};

				//--- Award
				{
					if (_x call CTI_CO_FNC_IsGroupPlayable) then {
						if (isPlayer leader _x) then {[["CLIENT", leader _x], "Client_AwardBounty", [_var_name, _bounty]] call CTI_CO_FNC_NetSend} else {[_x, _side_killer, _bounty] call CTI_CO_FNC_ChangeFunds};
					};
				} forEach _award_groups;

			};
			// zeus guerilla

		} else {
			//civ tk
		};
	} else { //--- Teamkill
		//--- Don't bother with local entities on MP.
		if ((!local _killer && isMultiplayer) || !isMultiplayer) then {
		// if ((!local _killed && isMultiplayer) || !isMultiplayer) then {
			if (_killed != _killer && _isplayable_killer) then {
				//--- Compensate the killed units with the killer's funds on non-captured entities
				if ((_side_killer call CTI_CO_FNC_GetSideID) == _sideID_killed) then {
					_killer_funds = [_group_killer, _side_killer] call CTI_CO_FNC_GetFunds;
					_penalty = _cost;
					_cashout = _killer_funds - _cost;
					if (_cashout < 0) then {_penalty = _cost - (-_cashout)};

					if (_penalty > 0) then {
						if (_isplayable_killed) then {[_group_killed, _side_killed, _penalty] call CTI_CO_FNC_ChangeFunds}; //--- If the killed unit belong to a playable group, then we compensate that group.
						if (_isplayable_killer) then { //--- If the killer unit belong to a playable group, then we penalize that group.
							[_group_killer, _side_killer, -(_penalty)] call CTI_CO_FNC_ChangeFunds;
							_show_local = if (CTI_IsHostedServer || CTI_IsClient) then {true} else {false};
							["CLIENT", "Client_OnMessageReceived", ["penalty", [_var_name, _group_killer, _penalty,_side_killer]], _show_local] call CTI_CO_FNC_NetSend;
							[["CLIENT", _killer], "Client_OnTeamkill"] call CTI_CO_FNC_NetSend;
							["SERVER", "Request_NoobLogger", [_killer,1]] call CTI_CO_FNC_NetSend;
						};
					};
				};
			};
		};
	};
};


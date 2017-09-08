private ["_groups", "_positions", "_side", "_teams", "_town"];

_town = _this select 0;
_side = _this select 1;
_teams = _this select 2;
_groups = _this select 3;
_positions = _this select 4;

_sideID = (_side) call CTI_CO_FNC_GetSideID;

_created_vehicles = [];
_t_groups=[];
//--- Create all the requested units for a town at the explicit given location
for '_i' from 0 to count(_groups)-1 do {
	_position = _positions select _i;
	_team = _teams select _i;
	_group = _groups select _i;
	_t_groups set [count _t_groups,_group];
	//--- Create the given team
	_return = [_team, _position, _side, _group, true, true, true] call CTI_CO_FNC_CreateTeam;
	_vehicles = _return select 1;

	//--- Patrol the town
	[_town, _group, _sideID] execFSM "Server\FSM\town_patrol.fsm";

	//--- Our units are strong!
	_group allowFleeing 0;

	_created_vehicles = _created_vehicles + _vehicles;
};

{[_town, group _x, _sideID] execFSM "Server\FSM\town_patrol.fsm";_t_groups set [count _t_groups,group _x];true } count (_created_vehicles);
{
	if (CTI_IsServer) then {
		[_x] spawn CTI_SE_FNC_HandleEmptyVehicle;
	} else {
		["SERVER", "Request_HandleAction", ["empty", [_x]]] call CTI_CO_FNC_NetSend;
	};
} forEach _created_vehicles;

[_created_vehicles,_t_groups]
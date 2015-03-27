/*
  # HEADER #
	Script: 		Client\Functions\Client_OnJailed.sqf
	Alias:			CTI_CL_FNC_OnJailed
	Description:	Sent by a server whenever the client reach a new plane of existence
					Note this function is automatically called by the server (PVF)
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    None

  # RETURNED VALUE #
	None

  # SYNTAX #
	0 spawn CTI_CL_FNC_OnJailed

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
	0 spawn CTI_CL_FNC_OnJailed
*/

CTI_P_Jailed = true;
_song_loop = 17.55;
_last_loop = -600;
_over = time + _this;

_pos = getMarkerPos "prison";
_rpos = [(_pos select 0) + random 2 - random 2, (_pos select 1) + random 2 - random 2, 0.75];
(vehicle player) lock false;
unassignVehicle player;
player action ["EJECT", (vehicle player)];
player action ["GETOUT", (vehicle player)];
waitUntil {(vehicle player) == player};
player setPos _rpos;
player allowdammage false;
0 spawn {
	waitUntil {!(alive player )|| (player distance (getMarkerPos "prison")) > 50};
	if (CTI_P_Jailed) then {(vehicle player) setDamage 1;(player) setDamage 1;hintSilent "Nice Try!";};
};
for '_i' from 0 to 25 do { player removeAction _i };

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeAllContainers player;

while {true} do {
	if (time > _over) exitWith {};

	if (time - _last_loop > _song_loop) then {_last_loop = time;playSound "prison"};
	hintSilent format ["Time Left in jail: %1!", round(_over - time)];

	sleep .1;
};

CTI_P_Jailed = false;
["SERVER", "Request_NoobLoggerEnd", player] call CTI_CO_FNC_NetSend;

hintSilent "You are free!\n\nWe hope that you've enjoyed your stay!";
player setDamage 1;
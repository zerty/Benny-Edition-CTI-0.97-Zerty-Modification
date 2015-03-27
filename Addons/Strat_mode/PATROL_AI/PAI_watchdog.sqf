// Tack patrol AI and ownership of the vehicle
// Input: [group, vehicle]
// Output : NONE

private ["_vehicle","_position","_v"];
_group=_this select 0;
_vehicle=_this select 1;

sleep 10;
diag_log format ["Patrols ::Starting Watchdog for %1",_group];
_position=[0,0,0];
while {!CTI_GameOver && ! isNull _group && alive _vehicle && !isNull _vehicle && (_vehicle getvariable ["cti_occupant",civilian] )== resistance} do {
	{if (vehicle _x == _x) then {deletevehicle _x };true} count (units _group);
	if ( (_vehicle distance _position ) < 300 && ! (_group getvariable ["defending",false]) ) then {
		diag_log format ["Patrols :: Deleting %1",_group];
		{deletevehicle _x;true}count (units _group);
		_vehicle setdamage 1;
	} else {
		_position=getpos _vehicle;
	};
	sleep SM_PATROLS_TO;
};

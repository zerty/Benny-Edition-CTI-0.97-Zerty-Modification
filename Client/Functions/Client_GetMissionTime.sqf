/*
  # HEADER #
	Script: 		Client\Functions\Client_GetMissionTime.sqf
	Alias:			CTI_CL_FNC_GetMissionTime
	Description:	Return a time format of the mission time
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    None
	
  # RETURNED VALUE #
	[Array]: The translated time format
	
  # SYNTAX #
	call CTI_CL_FNC_GetMissionTime
	
  # EXAMPLE #
    call CTI_CL_FNC_GetMissionTime 
	  -> Will return [Days, Hours, Minutes, Seconds]
*/

private ["_days","_hours","_minutes","_seconds","_uptime"];

_days = 0;
_hours = 0;
_minutes = 0;
_seconds = 0;

_uptime = time;
_days = floor(_uptime / 86400);
_hours = floor((_uptime - (_days * 86400)) / 3600);
_minutes = floor((_uptime - (_hours * 3600) - (_days * 86400)) / 60);
_seconds = floor(_uptime - (_minutes * 60) - (_hours * 3600) -(_days * 86400));

//--- Preformat
if (_hours < 10) then {_hours = format["0%1",_hours]};
if (_minutes < 10) then {_minutes = format["0%1",_minutes]};
if (_seconds < 10) then {_seconds = format["0%1",_seconds]};

[_days, _hours, _minutes, _seconds]
/*
  # HEADER #
	Script: 		Addons\Strat_mode\Functions\UAV_Fix_Crew.sqf
	Alias:			UAV_FIX_CREW
	Description:	Replaces the crew of a vehicle to resolve issue with AI getting stuck, 
					or behaving weirdly. Will disconnect the player in the process
	Author: 		Yoshi_E
	Creation Date:	16-08-2019
	Revision Date:	16-08-2019
	

  # EXAMPLE #
	_veh addAction ["Reset Crew", UAV_FIX_CREW];

*/
params ["_target", "_caller", "_actionId", "_arguments"];
player connectTerminalToUAV objNull;
_target removeAction _actionId;
sleep 1;
{_target deleteVehicleCrew _x} forEach crew _target;
createVehicleCrew _target;
hint "Crew has been replaced";
sleep 300; //Can be used every 5min
_target addAction ["Reset Crew", UAV_FIX_CREW, [], 0.01, false, true, "", "true", 0.1];



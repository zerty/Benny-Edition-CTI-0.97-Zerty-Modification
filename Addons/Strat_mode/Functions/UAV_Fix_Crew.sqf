/*
  # HEADER #
	Script: 		Addons\Strat_mode\Functions\UAV_Fix_Crew.sqf
	Alias:			UAV_FIX_CREW
	Description:	Replaces the crew of a vehicle to resolve issue with AI getting stuck, 
					or behaving weirdly. Will disconnect the player in the process
	Author: 		Yoshi_E
	Creation Date:	16-08-2019
	Revision Date:	05-09-2019
	

  # EXAMPLE #
	[_drone, player] spawn UAV_FIX_CREW;

*/
params ["_target", "_caller"];
//(group _target) setGroupOwner (owner _caller); //make local
player connectTerminalToUAV objNull;
sleep 1;
{_target deleteVehicleCrew _x} forEach crew _target;
createVehicleCrew _target;
//This might help with AI target behaviour.
sleep 1;
{ _x disableAI "TARGET"} forEach crew _target; 
sleep 1;
{ _x enableAI "TARGET"} forEach crew _target;
hint "Crew has been replaced";



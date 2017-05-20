/*
  # HEADER #
	Script: 		Client\Functions\Client_OnHQDestroyed.sqf
	Alias:			CTI_CL_FNC_OnHQDestroyed
	Description:	Triggered by the Killed EH whenever the HQ dies
					Note this function is automatically called by the EH
					This function behave as a "proxy" EH, the real code is done on the server
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Object]: The unit killed
    1	[Object]: The killer
    2	[Integer]: The HQ's Side ID
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[KILLED, KILLER, SIDE ID] call CTI_CL_FNC_OnHQDestroyed
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    _hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CL_FNC_OnHQDestroyed", CTI_P_SideID]];
	  -> The EH will only fire is the HQ is local to the client, then it'll forward it to the server
*/

["SERVER", "Request_EventDestroyedHQ", _this] call CTI_CO_FNC_NetSend;
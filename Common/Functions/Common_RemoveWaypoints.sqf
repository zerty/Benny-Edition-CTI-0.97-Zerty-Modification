/*
  # HEADER #
	Script: 		Common\Functions\Common_RemoveWaypoints.sqf
	Alias:			CTI_CO_FNC_RemoveWaypoints
	Description:	Remove the waypoints of a group
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Group]: The group
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	(GROUP) call CTI_CO_FNC_RemoveWaypoints
	
  # EXAMPLE #
    (group player) call CTI_CO_FNC_RemoveWaypoints;
	  -> Remove the existing player's group waypoints
*/

private ['_team'];

_team = _this;

for '_i' from (count waypoints _team)-1 to 0 step -1 do { deleteWaypoint [_team, _i] };
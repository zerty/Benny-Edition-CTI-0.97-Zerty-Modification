/*
  # HEADER #
	Script: 		Common\Functions\Common_HasOrderedChanged.sqf
	Alias:			CTI_CO_FNC_IsGroupPlayable
	Description:	Check if a group is a CTI Group or not
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Group]: The group
	
  # RETURNED VALUE #
	[Boolean]: True if differs
	
  # SYNTAX #
	(GROUP) call CTI_CO_FNC_IsGroupPlayable
	
  # EXAMPLE #
    (group player) call CTI_CO_FNC_IsGroupPlayable
	  -> Return true if the player is synced to his/her side Game Logic
*/

if !(isNil {_this getVariable "cti_order"}) then {true} else {false}
/*
  # HEADER #
	Script: 		Common\Functions\Common_HasOrderedChanged.sqf
	Alias:			CTI_CO_FNC_HasOrderedChanged
	Description:	Check if two orders differs
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Group]: The group
    1	[Integer]: The "new" order
    2	[Array/Object]: The "new" order's position
	
  # RETURNED VALUE #
	[Boolean]: True if differs
	
  # SYNTAX #
	[GROUP, NEW ORDER, NEW ORDER POSITION] call CTI_CO_FNC_HasOrderedChanged
	
  # EXAMPLE #
    _changed = [group player, CTI_ORDER_TAKETOWN, Town1] call CTI_CO_FNC_HasOrderedChanged
    _changed = [group player, CTI_ORDER_TAKEHOLDTOWNS, [0,0]] call CTI_CO_FNC_HasOrderedChanged
*/

private ["_changed", "_group", "_order", "_order_current", "_order_pos", "_order_pos_current"];

_group = _this select 0;
_order_current = _this select 1;
_order_pos_current = _this select 2;

_order = _group getVariable "cti_order";

_changed = false;
if (_order != _order_current) then { //--- Order itself changed?
	_changed = true;
} else { //--- Order position changed?
	_order_pos = _group getVariable "cti_order_pos";
	switch (true) do {
		case (typeName _order_pos_current == "ARRAY" && typeName _order_pos == "ARRAY"): {if (_order_pos_current select 0 != _order_pos select 0 || _order_pos_current select 1 != _order_pos select 1) then {_changed = true}};
		case (typeName _order_pos_current == "OBJECT" && typeName _order_pos == "OBJECT"): {if (_order_pos_current != _order_pos) then {_changed = true}};
	};
};

_changed
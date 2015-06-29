/*
  # HEADER #
	Script: 		Common\Functions\Common_SortByDistance.sqf
	Alias:			CTI_CO_FNC_SortByDistance
	Description:	Get the closest town from a center
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Array/Object]: The center
    1	[Array]: The list of entities to sort

  # RETURNED VALUE #
	[Array]: The sorted entities

  # SYNTAX #
	[CENTER, LIST] call CTI_CO_FNC_SortByDistance

  # DEPENDENCIES #


  # EXAMPLE #
    _sort = [player, [Town0, Town1, Town2, Town3]] call CTI_CO_FNC_SortByDistance
	  -> Will sort the towns by their distance from the player (closest to furthest)
*/

private["_current","_nearest","_nearestDistance","_object","_objects","_sorted"];

_object = _this select 0;
_objects = +(_this select 1);

_sorted = [];
for '_i' from 0 to count(_objects)-1 do {
	_nearest = objNull;
	_nearestDistance = 100000;
	_index = -1;

	for '_j' from count(_objects)-1 to 0 step -1 do {
		_current = _objects select _j;
		_distance = _current distance _object;
		if (_distance < _nearestDistance) then {_nearest = _current;_nearestDistance = _distance;_index = _j};
	};

	_sorted pushBack _nearest;
	_objects set [_index, "!"];
	_objects = _objects - ["!"];
};

_sorted
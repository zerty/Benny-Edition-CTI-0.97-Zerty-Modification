/*
  # HEADER #
	Script: 		Common\Functions\Common_MarkerUpdate.sqf
	Alias:			CTI_CO_FNC_MarkerUpdate
	Description:	Track an object until it's death
					Note that this function must be spawned
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013

  # PARAMETERS #
    0	[Object]: The object to track
    1	[String]: The marker type
    2	[String]: The marker color
    3	[Array]: The marker size
    4	[String]: The marker label
    5	[String]: The marker name
    6	[Number]: The refresh delay between each reposition
    7	{Optionnal} [String]: The dead marker type
    8	{Optionnal} [String]: The dead marker color
    9	{Optionnal} [Array]: The dead marker size

  # RETURNED VALUE #
	None

  # SYNTAX #
	[OBJECT, MARKER TYPE, MARKER COLOR, MARKER SIZE, MARKER LABEL, MARKER NAME, MARKER REFRESH] spawn CTI_CO_FNC_MarkerUpdate
	[OBJECT, MARKER TYPE, MARKER COLOR, MARKER SIZE, MARKER LABEL, MARKER NAME, MARKER REFRESH, DEAD MARKER TYPE] spawn CTI_CO_FNC_MarkerUpdate
	[OBJECT, MARKER TYPE, MARKER COLOR, MARKER SIZE, MARKER LABEL, MARKER NAME, MARKER REFRESH, DEAD MARKER TYPE, DEAD MARKER COLOR] spawn CTI_CO_FNC_MarkerUpdate
	[OBJECT, MARKER TYPE, MARKER COLOR, MARKER SIZE, MARKER LABEL, MARKER NAME, MARKER REFRESH, DEAD MARKER TYPE, DEAD MARKER COLOR, DEAD MARKER SIZE] spawn CTI_CO_FNC_MarkerUpdate

  # EXAMPLE #
    [player, "b_inf", "ColorGreen", [0.75,0.75], "Me on the Map", "MySuperMarker1", .96] spawn CTI_CO_FNC_MarkerUpdate
	  -> Track the player until it's death with the marker "MySuperMarker1", refresh each 0.96 ms
    [player, "b_inf", "ColorGreen", [0.75,0.75], "Me on the Map", "MySuperMarker1", .96, "b_unknown", [0.75,0.75], "ColorBlack"] spawn CTI_CO_FNC_MarkerUpdate
	  -> Track the player until it's death with the marker "MySuperMarker1", refresh each 0.96 ms and keep a dead marker on death for x seconds
*/

private ["_marker_color", "_marker_dead_color", "_marker_dead_size", "_marker_dead_type", "_marker_label", "_marker_name", "_marker_size", "_marker_type", "_target", "_type", "_update_delay"];

_target = _this select 0;
_marker_type = _this select 1;
_marker_color = _this select 2;
_marker_size = _this select 3;
_marker_label = _this select 4;
_marker_name = _this select 5;
_update_delay = _this select 6;
_marker_dead_type = if (count _this > 7) then {_this select 7} else {""};
_marker_dead_color = if (count _this > 8) then {_this select 8} else {""};
_marker_dead_size = if (count _this > 9) then {_this select 9} else {""};

if !(alive _target) exitWith {};
_type = typeOf _target;

createMarkerLocal [_marker_name,visiblePosition _target];


if (_marker_label != "") then {_marker_name setMarkerTextLocal _marker_label};
_marker_name setMarkerTypeLocal _marker_type;
_marker_name setMarkerColorLocal _marker_color;
_marker_name setMarkerSizeLocal _marker_size;



while {alive _target} do {
	if ((_target getVariable "cti_net")== CTI_P_SideID) then {
		_marker_name setMarkerPosLocal (visiblePosition _target);
		//[_target,_marker_l] call AN_Draw;
		if !(( markerAlpha _marker_name) == 1) then {_marker_name setMarkerAlphaLocal 1;};
	} else {
		if !(( markerAlpha _marker_name) == 0) then {_marker_name setMarkerAlphaLocal 0;};
	};
	sleep _update_delay;
};

if (_marker_dead_type != "" && !(isNull _target)) then {
	_marker_name setMarkerTypeLocal _marker_dead_type;
	_marker_name setMarkerColorLocal _marker_dead_color;
	_marker_name setMarkerSizeLocal _marker_dead_size;

	_delay = if (_type isKindOf "Man") then {CTI_MARKERS_UNITS_DEAD_DELAY} else {CTI_MARKERS_VEHICLES_DEAD_DELAY};
	sleep _delay;
};

deleteMarkerLocal _marker_name;
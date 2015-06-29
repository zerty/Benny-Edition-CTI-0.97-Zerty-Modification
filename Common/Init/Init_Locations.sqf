private ["_town"];

CTI_Towns = [];

if (CTI_isServer) then
	{
	for '_i' from 0 to 1000 do {
		if (isNil Format ["Town%1", _i]) exitWith {};

		_town = call compile Format ["Town%1", _i];
		//waitUntil {!isNil {_town getVariable "cti_town_value"}};
		CTI_Towns pushBack _town;
	};
	if (MIN_TOWNS==0) then {
		_CENTER_POS=getMarkerPos "CENTER_POS";
		_CENTER_RADIUS=(getMarkerSize "CENTER_POS")select 0;
		_new_towns=[];
		{if ((_x distance _CENTER_POS)<_CENTER_RADIUS ) then {_new_towns set [count _new_towns,_x]};true} count CTI_Towns;
		CTI_Towns=[];
		CTI_Towns=_new_towns;
	}else {
		_center=CTI_Towns select (floor random (count CTI_Towns));
		"CENTER_POS" setmarkerpos [(position _center) select 0,(position _center) select 1];
		_radius=1000;
		while {({_x distance _center < _radius} count CTI_Towns )< MIN_TOWNS} do {
			_radius=_radius+200;
		};
		"CENTER_POS" setmarkersize [_radius,_radius];
		_new_towns=[];
		{if ((_x distance _center)<_radius ) then {_new_towns set [count _new_towns,_x]};true} count CTI_Towns;
		CTI_Towns=[];
		CTI_Towns=_new_towns;
	};
	CTI_WEST setVariable ["CTI_TOWNS", CTI_TOWNS,true];
	CTI_EAST setVariable ["CTI_TOWNS", CTI_TOWNS,true];
} else {
	waitUntil {!isNil {CTI_P_SideLogic getVariable "CTI_Towns"} };
	CTI_TOWNS=(CTI_P_SideLogic getVariable "CTI_Towns");

};
CTI_InitTowns = true;

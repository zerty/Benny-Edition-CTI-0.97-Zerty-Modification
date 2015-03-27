private ["_unit","_side","_side_id"];
_unit=_this;
waitUntil {alive _unit && ! (isNull _unit) && CTI_Init_Server};
_side = side _unit;
_side_id =(side _unit)  call CTI_CO_FNC_GetSideID;
while {!CTI_GameOver} do {
	waitUntil {alive _unit };
	[_unit,_side_id] call AN_Launch;
	waitUntil {!alive _unit};
};
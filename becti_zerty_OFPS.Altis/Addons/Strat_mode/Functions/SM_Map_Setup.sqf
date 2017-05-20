private ["_neigh","_ot","_oneigh"];
waitUntil {CTI_InitTowns};
{
		_x setVariable ["CTI_Neigh",[],true];
		waitUntil {!isNil {_x getVariable "CTI_Neigh"}};
} forEach CTI_Towns;


{
		[_x] call CTI_SM_Connect_Towns;
} forEach CTI_Towns;

{
	if !( isNil {_x getVariable "cti_town_fneigh"}) then {
		_neigh= _x getVariable "CTI_Neigh";
		_ot=missionNamespace getVariable (_x getVariable "cti_town_fneigh");
		if !(isNil {_ot getVariable "CTI_Neigh"}) then {

			_oneigh=_ot getVariable "CTI_Neigh";
			_x setVariable ["CTI_Neigh",_neigh+[_ot],True];
			_ot setVariable ["CTI_Neigh",_oneigh+[_x],True];
		};
	};
} forEach CTI_Towns;
SM_MAP_READY=true;

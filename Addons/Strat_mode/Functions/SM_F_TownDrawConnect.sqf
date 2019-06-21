private ["_ct","_neigh","_o"];
if (!(CTI_P_SideJoined == resistance))then {
	{
		_ct= _x;
		_neigh= _ct getVariable "CTI_Neigh";
		while {isNil "_neigh"} do
		{
		  	_neigh= _ct getVariable "CTI_Neigh";
		  	sleep 0.3;
		};
		{
			[getPos _ct,getPos _x,"ColorBlack",CTI_MARKERS_TOWN_AREA_RANGE] call CTI_SM_Connect;
		} forEach _neigh;
	} forEach CTI_Towns;
};
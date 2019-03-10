// Server Loop for patrols
// Input: None
// Output : None
#define MIN_FPS 25

waitUntil {CTI_Init_Server && CTI_Init_Strat&& CTI_InitTowns};
sleep 240;

if ((missionNamespace getVariable ["CTI_SM_PATROLS",0])==0) exitWith {false};
while { !CTI_GameOver} do
{
	_current_patrols=(CTI_GUER getVariable ["patrols",[]]);
	SM_MAX_PATROLS=ceil (count ((resistance) call CTI_CO_FNC_GetSideTowns)/9);
	{
		if (count (units _x) == 0) then {_current_patrols set [_forEachindex,grpNull]};
	} forEach _current_patrols;
	_current_patrols=_current_patrols-[grpNull];
	CTI_GUER setVariable ["patrols",_current_patrols,true];
	if ( count (CTI_GUER getVariable ["patrols",[]]) < SM_MAX_PATROLS) then{ //we need to create patrols
		if (diag_fps > MIN_FPS) then {0 spawn CTI_PVF_Patrol_Create} else {
			{
				{deleteVehicle (vehicle _x) ;true}count (units _x);
			} forEach _current_patrols;
		};
	};
	sleep 60;
};
// Server Loop for patrols
// Input: None
// Output : None
waitUntil {CTI_Init_Server && CTI_Init_Strat&& CTI_InitTowns};
sleep 30;

if ((missionNamespace getVariable ["CTI_SM_PATROLS",0])==0) exitWith {false};
while { !CTI_GameOver} do
{
	_current_patrols=(PATROL_logic getVariable ["patrols",[]]);
	SM_MAX_PATROLS=ceil (count ((resistance) call CTI_CO_FNC_GetSideTowns)/9);
	{
		if (count (units _x) == 0) then {_current_patrols set [_forEachindex,grpNull]};
	} forEach _current_patrols;
	_current_patrols=_current_patrols-[grpNull];
	PATROL_logic setVariable ["patrols",_current_patrols,true];
	if (count (PATROL_logic getVariable ["patrols",[]]) < SM_MAX_PATROLS) then{ //we need to create patrols
		if ((0 call HCGA_GETHC) isEqualTo ["0"]) then {	0 spawn CTI_PVF_Patrol_Create} else {
			_hcs=[];
			{
				if (isplayer _x )then {_hcs set [count _hcs, _x]};true
			} count (entities "headlessclient_f");
			_hc = _hcs select floor random (count _hcs);
			[["CLIENT",_hc], "Patrol_Create",[]] call CTI_CO_FNC_NetSend;
		};
	};
	sleep 60;
};
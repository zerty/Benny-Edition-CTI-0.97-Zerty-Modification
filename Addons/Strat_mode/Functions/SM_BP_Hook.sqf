private ["_side","_sidelogic","_count_bases","_bases"];


_side = _this ;
_sidelogic= (_side) call CTI_CO_FNC_GetSideLogic;
_index=-1;


while {!CTI_GameOver} do {
	_bases = (_sidelogic getVariable "cti_structures_areas");
	if (_index < ((count _bases) -1) ) then {
		_index = _index +1;
		if ( (missionNamespace getVariable 'CTI_SM_BASEP_M')!=0) then
		{
			[_bases select _index,_side, _index] spawn SM_BP_Init;
		};
		[["CLIENT",_side], "Client_Base_Zone",[_side,_index,_bases select _index]] call CTI_CO_FNC_NetSend;

	};
	sleep 1;
};

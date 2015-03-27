private ["_side","_sidelogic","_count_bases","_bases"];
_side = _this ;
_sidelogic= (_side) call CTI_CO_FNC_GetSideLogic;
_count_bases=0;
while {!CTI_GameOver} do {
	_bases = (_sidelogic getVariable "cti_structures_areas");
	if (count _bases > _count_bases) then {
		if ( (missionNamespace getVariable 'CTI_SM_BASEP_M')!=0) then {[_bases select ((count _bases) -1),_side, ((count _bases) -1)] spawn SM_BP_Init};
		_count_bases= count _bases;
		[["CLIENT",_side], "Client_Base_Zone",[_side,((count _bases) -1),_bases select ((count _bases) -1)]] call CTI_CO_FNC_NetSend;
	};
	sleep 1;
};

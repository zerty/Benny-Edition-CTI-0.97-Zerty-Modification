private ["_divisions","_sections","_new_owner"];

HCGA_GETHC=compile preprocessfilelinenumbers "Addons\Strat_mode\HC_GA\HCGA_GetHC.sqf";

HCGA_Use_Server=if (missionnamespace getvariable ["HC_MODE",1] == 0) then {true} else {false};

if !(CTI_isServer) exitwith{false};

waituntil {CTI_Init_Server};

HCGA_current= ["0"];
/*diag_log "HC :: Starting HC mitigation loop";
while {!(CTI_GameOver)} do {
	if !((HCGA_current) isEqualTo (call HCGA_GETHC)) then {
		HCGA_current= call HCGA_GETHC;
		diag_log (format ["HC :: HC variation detected %1",HCGA_current ]);
		_divisions=count (HCGA_current);
		diag_log (format ["HC :: Dividing town space by %1", _divisions ]);
		_sections=ceil ((count (CTI_TOWNS) +1)/(_divisions));
		{
			_new_owner=HCGA_current select (floor (_forEachIndex / _sections));
			diag_log (format ["HC :: Changing owner of  %1 from %2 to %3",_x getvariable "cti_town_name",_x getvariable ["cti_town_owner","0"], _new_owner  ]);
			_x setvariable ["cti_town_owner",_new_owner,true];

		} forEach (CTI_TOWNS);
	};
	sleep 60;
};

*/
_last_funds = -1;
_last_workercount = -1;


while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_buildmenu"}) exitWith {}; //--- Menu is closed.
	if !(alive (CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ)) exitWith {closeDialog 0}; //--- The target has been destroyed

	_count = 0;
	{
		switch (typeName _x) do {
			case "STRING": { _count = _count + 1 };
			case "OBJECT": { if (alive _x) then { _count = _count + 1 } };
		};
	} forEach (CTI_P_SideLogic getVariable "cti_workers");
	_funds = call CTI_CL_FNC_GetPlayerFunds;

	if (_last_funds != _funds) then {
		((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100008) ctrlSetStructuredText (parseText format["Resources: <t color='%2'>$%1</t>", _funds, CTI_P_Coloration_Money]);
	};

	if (_last_workercount != _count&& (missionnamespace getVariable "CTI_BASEBUILDING") < 1) then {
		((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100009) ctrlSetStructuredText (parseText format["Workers: <t color='#66baff'>%1</t>/%2", _count, CTI_BASE_WORKERS_LIMIT]);
	};

	_last_funds = _funds;
	_last_workercount = _count;

	sleep .5;
};

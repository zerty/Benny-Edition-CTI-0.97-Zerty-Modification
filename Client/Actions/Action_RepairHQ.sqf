_vehicle = _this select 0;
_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;

CTI_P_LastRepairTime = time;

if (alive _hq) exitWith {}; //--- Don't bother if the HQ is alive

if (_hq distance _vehicle <= CTI_BASE_HQ_REPAIR_RANGE) then {
	_funds = call CTI_CL_FNC_GetPlayerFunds;
	
	if (_funds >= CTI_BASE_HQ_REPAIR_PRICE) then {
		_delay = CTI_BASE_HQ_REPAIR_TIME;
		hint parseText localize "STR_RepairHQ";
		while {_delay > 0} do {
			_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
			if (alive _hq || _hq distance _vehicle > CTI_BASE_HQ_REPAIR_RANGE || !alive _vehicle) exitWith {};
			_delay = _delay - 1;
			sleep 1;
		};
		
		if (_delay <= 0) then {
			if (_funds >= CTI_BASE_HQ_REPAIR_PRICE) then {
				-CTI_BASE_HQ_REPAIR_PRICE call CTI_CL_FNC_ChangePlayerFunds;
				["SERVER", "Request_HQRepair", CTI_P_SideJoined] call CTI_CO_FNC_NetSend;
			} else {
				hint parseText format[localize "STR_Needed_RepairHQ", CTI_P_Coloration_Money, CTI_BASE_HQ_REPAIR_PRICE];
			};
		} else {
			if (alive _hq) exitWith {
				hint parseText localize "STR_Already_RepairHQ"
			};
			if !(alive _vehicle) exitWith {
				hint parseText localize "STR_Destroyed_RepairHQ"
			};
			if (_hq distance _vehicle > CTI_BASE_HQ_REPAIR_RANGE) exitWith {
				hint parseText localize "STR_Moved_RepairHQ"
			};
		};
	} else {
		hint parseText format[localize "STR_Needed_RepairHQ", CTI_P_Coloration_Money, CTI_BASE_HQ_REPAIR_PRICE];
	};
};
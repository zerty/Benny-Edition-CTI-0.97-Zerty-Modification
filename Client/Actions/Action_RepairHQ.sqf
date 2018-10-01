_vehicle = _this select 0;
_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;

CTI_P_LastRepairTime = time;
if(missionNamespace getVariable [format["CTI_HQ_Repair_Lock_%1", CTI_P_SideJoined], false]) exitWith {};
missionNamespace setVariable [format["CTI_HQ_Repair_Lock_%1", CTI_P_SideJoined], true, true];
if (alive _hq) exitWith {}; //--- Don't bother if the HQ is alive

_base_repair_HQ_cost = CTI_BASE_HQ_REPAIR_PRICE;
//Reduce repair cost in early game
if(scoreSide CTI_P_SideJoined <= 1000) then {_base_repair_HQ_cost = round(_base_repair_HQ_cost / 2);};
if(scoreSide CTI_P_SideJoined <= 500) then {_base_repair_HQ_cost = round(_base_repair_HQ_cost / 4);};

_attempting_repair = false;
if (_hq distance _vehicle <= CTI_BASE_HQ_REPAIR_RANGE) then {
	_funds = call CTI_CL_FNC_GetPlayerFunds;
	
	if (_funds >= _base_repair_HQ_cost) then {
		_delay = CTI_BASE_HQ_REPAIR_TIME;
		hint parseText localize "STR_RepairHQ";
		while {_delay > 0} do {
			_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
			if (alive _hq || _hq distance _vehicle > CTI_BASE_HQ_REPAIR_RANGE || !alive _vehicle) exitWith {};
			_delay = _delay - 1;
			sleep 1;
		};
		
		if (_delay <= 0) then {
			if (_funds >= _base_repair_HQ_cost) then {
				-_base_repair_HQ_cost call CTI_CL_FNC_ChangePlayerFunds;
				["SERVER", "Request_HQRepair", CTI_P_SideJoined] call CTI_CO_FNC_NetSend;
				_attempting_repair = true;
			} else {
				hint parseText format[localize "STR_Needed_RepairHQ", CTI_P_Coloration_Money, _base_repair_HQ_cost];
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
		hint parseText format[localize "STR_Needed_RepairHQ", CTI_P_Coloration_Money, _base_repair_HQ_cost];
	};
};
if(!_attempting_repair) then {missionNamespace setVariable [format["CTI_HQ_Repair_Lock_%1", CTI_P_SideJoined], false, true];};
private ["_town","_objects","_sideID","_side","_west","_east","_awest","_aeast"];


_side=_this;

_sl=_side call CTI_CO_FNC_GetSideLogic;
_id_s=missionNamespace getVariable  format[ "CTI_%1_ID",_side];
waitUntil {SM_MAP_READY && CTI_InitTowns};
sleep 25;



while  {!CTI_GameOver} do {
	_time=time;
	// get variables
	_av_s=_sl getVariable  "CTI_AVAILLABLE";
	_ac_s=_sl getVariable  "CTI_ACTIVE";
	_pr_s=_sl getVariable  "CTI_PRIORITY";
	_stop_s=_sl getVariable  "CTI_PREVENT";

	if (isNull _pr_s) then {_sl setVariable ["CTI_PREVENT",objNull,true];};
	// cleenup activation
	_n_ac_s=  _ac_s;
	{
		_t=_x;
		_neigh=if ({((_x) getVariable "cti_town_sideID") == _id_s} count (_t getVariable "CTI_Neigh") == 0 && count ((_side) call CTI_CO_FNC_GetSideTowns)>0 && (missionNamespace getVariable "CTI_SM_STRATEGIC" == 1)) then {false} else {true}; // neighbours check
		_prevent=if (_t ==_stop_s) then {true} else {false}; //prevent check
		_priority=if (_pr_s == _t) then {true} else {false}; //priority check
		_ours=if ((_t) getVariable "cti_town_sideID" == _id_s) then {true} else {false};
		_forces=if ((_t getVariable "cti_town_occupation_active") && !_ours || (_t getVariable "cti_town_resistance_active")) then {true} else {false}; //forces present

		if !(!_prevent && _neigh && (_forces || _priority && ! _ours)) then {
			if (_pr_s == _t) then {_pr_s=objNull;_sl setVariable ["CTI_PRIORITY",objNull,true];};
			[["CLIENT",_side],"SM_message",format [localize "STR_TownInactive",(_t getVariable "cti_town_name")]] call CTI_CO_FNC_NetSend ;
			_n_ac_s = _n_ac_s - [_t];
		};
			true
	} count _ac_s;
	_ac_s=_n_ac_s;


	// compute available
	_n_av_s=[];
	{
		_t=_x;
		_neigh=if (({((_x) getVariable "cti_town_sideID") == _id_s} count (_t getVariable "CTI_Neigh") == 0 && count ((_side) call CTI_CO_FNC_GetSideTowns)>0)&& (missionNamespace getVariable "CTI_SM_STRATEGIC" == 1) )then {false} else {true}; // neighbours check
		_ours=if ((_t) getVariable "cti_town_sideID" == _id_s) then {true} else {false}; // ours
		if (_neigh && ! _ours) then {_n_av_s set [count _n_av_s,_t];};
		true
	} count CTI_TOWNS;
	_av_s = _n_av_s;


	// Tries to activate towns
	// 2 steps : first priority activation then other activation

	_n_ac_s=  _ac_s;

	if( !( isnull _pr_s) && (_pr_s in _n_av_s) && !(_pr_s in _n_ac_s)&& (count _n_ac_s <CTI_SM_STRATEGIC_NB)) then {_n_ac_s set [count _n_ac_s,_pr_s];_sl setVariable ["CTI_PREVENT",objNull,true]; };

	{
		_t=_x;
		_currently_a=if ({_x == _t} count _n_ac_s >0) then {true} else {false}; // active check
		_priority=if (_pr_s == _t) then {true} else {false}; //priority check
		// own many of our side around?
		//_groups=   (_side) call CTI_CO_FNC_GetSideGroups;
		//_a_objects= switchableUnits + playableUnits;
		_a_objects=[];
		{_a_objects pushBack (leader _x);true} count (_sl getVariable ["CTI_Teams",[]]);
		//{if (!isNull leader _x ) then {_a_objects set [count _a_objects,leader _x]};true} count _groups;
		_objects = [];
		{if (((side _x) ==_side)  && (_x distance _t)<= CTI_TOWNS_RESISTANCE_DETECTION_RANGE ) then {_objects set [count _objects,_x]};true } count _a_objects;
		_objects=_objects unitsBelowHeight CTI_TOWNS_RESISTANCE_DETECTION_RANGE_AIR;
		_forces=if (count _objects > 0) then {true} else {false}; //some of ours can activate this town
		_no_limit=if (count _n_ac_s <CTI_SM_STRATEGIC_NB) then {true} else {false}; // we can still active
		_prevent=if (_t ==_stop_s) then {true} else {false}; //prevent check

		if (!_currently_a && _no_limit && !_priority && _forces && ! _prevent) then {_n_ac_s set [count _n_ac_s,_t];};
		true
	} count _av_s;
	_ac_s=  _n_ac_s;

	_sl setVariable  ["CTI_AVAILLABLE",_av_s,true];
	_sl setVariable  ["CTI_ACTIVE",_ac_s,true];
	waitUntil {time > (_time +5)};
	//if (_side == west) then {diag_log format ["%1 ( %6s):: Available : %2 | Active : %3 | Priority : %4 | Prevent :%5 ", _side,_av_s,_ac_s,_pr_s,_stop_s,(time-_time)];};

};


#define	AN_Range_V	1000
#define	AN_Range_I	100



/*
_vehicle getVariable "AN_Conn"
_vehicle getVariable "AN_iNet"
_vehicle getVariable "CTI_Net"
*/
private ["_vehicle","_connected_to","_global","_side_id","_side","_forced","_candidates","_max_distance","_up_r","_up","_structures","_ccs","_town","_hq","_final"];

_vehicle=_this;
if (CTI_isServer) then {waituntil {CTI_Init_Server}};
_connected_to=objNull;
_global=if (_vehicle isKindOf "Man") then {false} else  {true};
_side_id=_vehicle getVariable ["CTI_Net",-11];
if (_side_id < 0 || isNil {_vehicle getVariable "AN_iNet"}) exitWith {false};


if ((_vehicle isKindOf "FlagPole_F") && (_vehicle getVariable ["cti_town_sideID",CTI_RESISTANCE_ID]) == CTI_RESISTANCE_ID)  exitWith {false};

// always connected objects (cc)
_side =(_side_id)  call CTI_CO_FNC_GetSideFromID;
_forced=_vehicle getVariable ["AN_Forced",false];
if (_forced) exitWith {
	if !(_vehicle getVariable ["AN_Conn",objNull] == _vehicle ) then {_vehicle setVariable ["AN_Conn",_vehicle,_global];};
	if !( count (_vehicle getVariable ["AN_Parrents",[objNull]]) == 0 ) then {_vehicle setVariable ["AN_Parrents",[],false];};
};

// HQ
if (_vehicle == (_side) call CTI_CO_FNC_GetSideHQ  ) exitwith {
	if !(_vehicle getVariable "AN_Conn" == _vehicle ) then {_vehicle setVariable ["AN_Conn",_vehicle,true];};
	if !(_vehicle getVariable "AN_iNet" == _side_id ) then {_vehicle setVariable ["AN_iNet",_side_id,true];};
	if !({_x == _vehicle} count  (_vehicle getVariable "AN_Parrents")>1 ) then {_vehicle setVariable ["AN_Parrents",[_vehicle],false];};
 	false
};

// man and inside vehicle

if (_vehicle isKindOf "Man" && !(vehicle _vehicle == _vehicle)&& (vehicle _vehicle) getVariable "AN_iNet" == _side_id  ) exitwith {
	if !(_vehicle getVariable "AN_Conn" == (vehicle _vehicle) ) then {_vehicle setVariable ["AN_Conn",vehicle _vehicle,true];}; };

//CONNEnct to leader
//if (_vehicle isKindOf "Man" && ! (_vehicle == leader _vehicle)) exitwith {_vehicle setVariable ["AN_Conn",leader _vehicle,true]; };

// Candidates and max distance
_candidates=[];
_max_distance=5000;
_up_r=0;
if (_side in [east,west] ) then {
	_up=(_side) call CTI_CO_FNC_GetSideUpgrades;
	_up_r=_up select CTI_UPGRADE_NETR;
} else {
	_up_r=0;
};
if (_vehicle isKindOf "Man") then {_max_distance=AN_Range_I+200*_up_r;} else {_max_distance=AN_Range_V+1000*_up_r;};
if (_vehicle isKindOf "FlagPole_F") then {_max_distance=100000};

// Try to connect to closest CC
if (_side in [east,west]) then {
	_structures = (_side) call CTI_CO_FNC_GetSideStructures;
	_ccs = [CTI_CONTROLCENTER, _structures] call CTI_CO_FNC_GetSideStructuresByType;
	{ if (_vehicle distance2D _x <= _max_distance) then {_candidates set [count _candidates,_x];}; true}count _ccs;
};
// Try to connect to closest town
if (count _candidates == 0 ) then {
	{
		_town=_x;
		if (!(isNull _town) && !(_town == _vehicle) && _vehicle distance2D _town <=  _max_distance && (_town getVariable "AN_iNet" == _side_id )&& ! (_x getVariable "AN_Conn" == _vehicle) && {_x == _vehicle} count (_x getVariable ["AN_Parrents",[]]) == 0 ) then
		{
			_candidates set [count _candidates,_town];
		};
	true
	} count ( (_side_id) call CTI_CO_FNC_GetSideTowns);
};

// try to connect to the HQ
if ((count _candidates == 0) && _side in [east,west]) then {
	_hq = (_side) call CTI_CO_FNC_GetSideHQ;
	if ((_vehicle distance2D _hq <= _max_distance) && alive _hq) then { _candidates set [count _candidates,_hq]};
};

// try to connect to another connected vehicle
if (!(_vehicle isKindOf "FlagPole_F"))  then {
	{
		if (!(_x == _vehicle) && !(_x ==(_side) call CTI_CO_FNC_GetSideHQ) && alive _x && (_x getVariable "AN_iNet" == _side_id ) && ! (_x getVariable "AN_Conn" == _vehicle) && {_x == _vehicle} count (_x getVariable ["AN_Parrents",[]]) == 0 ) then {_candidates set [count _candidates,_x]};
	true
	} count vehicles;
};

// sort candidates
_final = [_vehicle, _candidates] call CTI_CO_FNC_GetClosestEntity;

// Connect to the closest connected  & update
if ! (isNull _final) then {
	if !(_final == _vehicle getVariable "AN_Conn" || {_x == _vehicle} count (_final getVariable ["AN_Parrents",[]]) > 0) then {
		_vehicle setVariable ["AN_Conn",_final,_global];
	};
	_vehicle setVariable ["AN_Parrents",((_vehicle getVariable "AN_Conn") getVariable ["AN_Parrents",[]]) + [_vehicle],false];
	_vehicle setVariable ["AN_iNet",-1,true];
	if (NET_LOG) then {diag_log format [":: NET :: Sucess in reconf %1 to %2 through %3",_vehicle,_final,((_vehicle getVariable "AN_Conn") getVariable ["AN_Parrents",[]]) ]};
} else {
	_vehicle setVariable ["AN_Conn",_final,_global];
	_vehicle setVariable ["AN_iNet",-1,true];
	_vehicle setVariable ["AN_Parrents",[],false];
	if (NET_LOG) then {diag_log format [":: NET ::Failure in reconf %1",_vehicle ]};

};
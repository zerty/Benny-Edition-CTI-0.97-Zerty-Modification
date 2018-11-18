#define	AN_Range_V	1000
#define	AN_Range_I	100

/*
_vehicle getVariable "AN_Conn"
_vehicle getVariable "AN_iNet"
_vehicle getVariable "CTI_Net"
*/

private ["_vehicle","_side_id","_side","_forced","_connection","_max_distance","_up","_up_r"];
if (CTI_isServer) then {waituntil {CTI_Init_Server}};
_vehicle = _this;



if !(alive _vehicle) exitWith {false};



//resistance town no need to run reconnect:
if ((_vehicle isKindOf "FlagPole_F") && (_vehicle  getVariable ["cti_town_sideID",CTI_RESISTANCE_ID])  == CTI_RESISTANCE_ID) exitWith {true};

_side_id=_vehicle getVariable ["CTI_Net",-11];
if (_side_id < 0 ) exitWith {false};
_side =(_side_id)  call CTI_CO_FNC_GetSideFromID;

_forced=_vehicle getVariable ["AN_Forced",false];
if (_forced) exitWith {true};

// grab Connection
_connection=_vehicle getVariable ["AN_Conn",objNull];

// disconnected
if (isNull _connection ) exitWith {false};


//dead
if !(alive _connection ) exitWith {false};

//check distance
_max_distance=1000;
_up_r=0;
if (_side in [east,west] ) then {
	_up=(_side) call CTI_CO_FNC_GetSideUpgrades;
	_up_r=_up select CTI_UPGRADE_NETR;
} else {
	_up_r=0;
};

if (_vehicle isKindOf "Man") then {_max_distance=AN_Range_I+200*_up_r;} else {_max_distance=AN_Range_V+1000*_up_r;};
if (_vehicle isKindOf "FlagPole_F") then {_max_distance=100000};
if (_vehicle distance _connection > _max_distance) exitWith {false};


if (! (alive _connection && _connection getVariable "AN_iNet" == _side_id) ) exitWith {false};

true
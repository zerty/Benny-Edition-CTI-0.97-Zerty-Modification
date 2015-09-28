/*
  # HEADER #
	Script: 		Server\Functions\Server_OnHQDestroyed.sqf
	Alias:			CTI_SE_FNC_OnHQDestroyed
	Description:	Triggered by the Killed EH whenever the HQ get destroyed
					Note this function shall be called by an Event Handler (EH) but can also be called manually
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	23-09-2013

  # PARAMETERS #
    0	[Object]: The Killed defense
    1	[Object]: The Killer
    2	[Integer]: The Side ID of the defense

  # RETURNED VALUE #
	None

  # SYNTAX #
	[KILLED, KILLER, SIDE ID] spawn CTI_SE_FNC_OnHQDestroyed

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    _hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideID]];
*/

_killed = _this select 0;
_killer = _this select 1;
_sideID = _this select 2;

diag_log format ["::HQ DESTROYED:: %1 killed by %2 sideid %3", _this select 0, _this select 1, _this select 2 ];
if (((_this select 0) isKindOf "Pod_Heli_Transport_04_base_F") ||((_this select 0) isKindOf "Slingload_base_F")) then {
	_target =(_this select 0);
	_initial_pos=getposatl _target;
	_initial_pos set [2,0];
	_initial_dir=getdir _target;
	_side = _target getVariable "cti_occupant";
	deletevehicle _target;
	waitUntil {isNull _target};
	_hq = [missionNamespace getVariable Format["CTI_%1_HQ", _side], _initial_pos, _initial_dir, _side, true, true,false, "CAN_COLLIDE"] call CTI_CO_FNC_CreateVehicle;
	_hq setVariable ["cti_gc_noremove", true,true]; //--- HQ wreck cannot be removed nor salvaged
	_hq setVariable ["cti_ai_prohib", true,true]; //--- HQ may not be used by AI as a commandable vehicle
	//_hq addEventHandler ["getIn", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	//_hq addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	_hq setVariable ["cti_occupant", _side,true];
	//["CLIENT", "CLIENT_SA_PROTECT_HQ",[_hq],true] call CTI_CO_FNC_NetSend;
	["SERVER", "SERVER_SA_PROTECT_HQ",[_hq,_side]] call CTI_CO_FNC_NetSend;
	((_side) call CTI_CO_FNC_GetSideLogic) setVariable ["cti_hq", _hq, true];
	[["CLIENT", _side], "Client_givehqlock", [],true] call CTI_CO_FNC_NetSend;
	_hq setDamage 1;
};

if !(simulationEnabled _killed) then {_killed enableSimulationGlobal true;};


[["CLIENT", leader group _killer], "Client_AwardBounty", [(typeOf _killed), 30000]] call CTI_CO_FNC_NetSend;

[["CLIENT", _sideID call CTI_CO_FNC_GetSideFromID], "Client_OnMessageReceived", ["hq-destroyed"],true] call CTI_CO_FNC_NetSend;


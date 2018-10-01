/*
  # HEADER #
	Script: 		Server\Functions\Server_RepairHQ.sqf
	Alias:			CTI_SE_FNC_RepairHQ
	Description:	Perform an HQ repair over the old HQ wreck.
					Note that the PVF "CTI_PVF_Request_HQRepair" calls it
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	23-09-2013

  # PARAMETERS #
    0	[Side]: The side which requested the repair

  # RETURNED VALUE #
	None

  # SYNTAX #
	(SIDE) call CTI_SE_FNC_RepairHQ

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_GetSideCommander
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_OnHQDestroyed
	Server Function: CTI_CO_FNC_OnHQHandleDamage

  # EXAMPLE #
    (West) call CTI_SE_FNC_RepairHQ
	  -> Will repair the West HQ if destroyed
*/

private ["_commander", "_direction", "_hq", "_hq_wreck", "_logic", "_position", "_side", "_sideID"];

_side = _this;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_sideID = (_side) call CTI_CO_FNC_GetSideID;

_hq_wreck = (_side) call CTI_CO_FNC_GetSideHQ;
_position = getPos _hq_wreck;
_direction = getDir _hq_wreck;


//_position =[_position, 50] call CTI_CO_FNC_GetEmptyPosition;
_ep = _position findEmptyPosition [0,100,"O_T_VTOL_02_vehicle_dynamicLoadout_F"];
if (count _ep == 0) then {_ep = _position findEmptyPosition [0,250,"O_T_VTOL_02_vehicle_dynamicLoadout_F"];};
_position = _ep;

//_position = _position findEmptyPosition [0,50,typeOf ((_side) call CTI_CO_FNC_GetSideHQ)];
//_position set [2,1];

if (alive _hq_wreck) exitWith {};
deleteVehicle _hq_wreck;

_hq = [missionNamespace getVariable Format["CTI_%1_HQ", _side], _position, _direction, _side, true, false] call CTI_CO_FNC_CreateVehicle;
_hq setVariable ["cti_gc_noremove", true]; //--- HQ wreck cannot be removed nor salvaged
_hq setVariable ["cti_ai_prohib", true]; //--- HQ may not be used by AI as a commandable vehicle
_hq addEventHandler ["getIn", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
_hq addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
_hq setVariable ["cti_occupant", _side,true];
_hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideID]];
if (CTI_BASE_NOOBPROTECTION == 1) then {
	_hq addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage", _sideID]]; //--- You want that on public
};

_logic setVariable ["cti_hq", _hq, true];

// [["CLIENT", _side], "Client_HQAddDefense", _hq] call CTI_CO_FNC_NetSend;

[["CLIENT", _side], "Client_OnMessageReceived", ["hq-repair"]] call CTI_CO_FNC_NetSend;
[["CLIENT", _side], "Client_RenewHQ", []] call CTI_CO_FNC_NetSend;


//check if HQ was sucessfully repaired, else refound repair cost
[_hq, _logic, _side] spawn {
	_hq = _this select 0;
	_logic = _this select 1;
	_side = _this select 2;
	
	sleep(5);
	_hq setVelocity [0, 5, 0]; //move it a little to check if its inside an object
	sleep(5);
	if(_logic getVariable ["cti_hq", objNull] == _hq && !alive _hq) then {
		//refound cash
		_comMoney = _logic getvariable ["cti_commander_funds", 0] ;
		_base_repair_HQ_cost = CTI_BASE_HQ_REPAIR_PRICE;
		//Reduce repair cost in early game
		if(scoreSide CTI_P_SideJoined <= 1000) then {_base_repair_HQ_cost = round(_base_repair_HQ_cost / 2);};
		if(scoreSide CTI_P_SideJoined <= 500) then {_base_repair_HQ_cost = round(_base_repair_HQ_cost / 4);};
		_logic setvariable ["cti_commander_funds",_comMoney+_base_repair_HQ_cost,true];
	};
	missionNamespace setVariable [format["CTI_HQ_Repair_Lock_%1", _side], false, true];
};


//--- Set the HQ to be local to a player commander if possible.
_commander = (_side) call CTI_CO_FNC_GetSideCommander;
if (isPlayer leader _commander) then {
	_hq setOwner (owner leader _commander);
	[["CLIENT", _side], "Client_AddHQActions", _hq] call CTI_CO_FNC_NetSend;
};
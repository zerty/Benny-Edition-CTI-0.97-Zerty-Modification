
{
	[_x] call CTI_PVF_Client_structurepreplaced;
} forEach (CTI_P_SideLogic getVariable ["cti_structures_wip",[]]);

{
	if (alive _x) then {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, typeOf _x];
		if !(isNil '_var') then {[_x, _var] call CTI_CL_FNC_InitializeStructure};
	};
} forEach (CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures);

0 spawn {
	_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
	//_hq addAction ["<t color='#a5c4ff'>MENU: Defense (HQ)</t>", "Client\Actions\Action_DefenseMenu.sqf", "", 93, false, true, "", " !CTI_P_PreBuilding &&CTI_Base_HQInRange && _this == player "];
	_marker = createMarkerLocal ["HQ", getPos _hq];
	_marker setMarkerTypeLocal (CTI_P_MarkerPrefix+"hq");
	_marker setMarkerTextLocal "HQ";
	_marker setMarkerColorLocal CTI_P_SideColor;
	_marker setMarkerSizeLocal [1,1];

	while {!CTI_GameOver} do {
		_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
		_marker setMarkerPosLocal getPos _hq;

		if !(alive _hq) then {
			if (markerColor _marker != "ColorBlack") then {_marker setMarkerColorLocal "ColorBlack"; _marker setMarkerTextLocal "HQ Wreck"};
		} else {
			if (markerColor _marker != CTI_P_SideColor) then {_marker setMarkerColorLocal CTI_P_SideColor; _marker setMarkerTextLocal "HQ"};
		};

		sleep 0.5;
	};

	deleteMarkerLocal _marker;
};
if (CTI_P_SideJoined == resistance) exitWith {false};
if (isMultiplayer) then {sleep 5}; //--- Wait in MP for the net var to kick in
{
	if (isNil {_x getVariable "cti_net"}) then {_x setVariable ["cti_net", CTI_P_SideID]};
	_x setVariable ["cti_ai_order", CTI_ORDER_CLIENT_NONE];
	_x setVariable ["cti_ai_order_pos", [0,0]];
} forEach ((units player - [player]) call CTI_CO_FNC_GetLiveUnits); //--- Track players AI if needed

//--- Track FOB if needed
{[_x, "FOB"] spawn CTI_PVF_Client_OnSpecialConstructed} forEach (CTI_P_SideLogic getVariable ["cti_fobs", []]);

0 spawn {
	waitUntil {(! isNil "CTI_PVF_Protect_Wheels") && (! isNil "H_PROTECT_WHEELS")};
	{if (_x getvariable ["wheel_prot",false]) then {_x call CTI_PVF_Protect_Wheels }; true}count vehicles;
};
{_x spawn CTI_PVF_Client_HandleDefense} forEach (CTI_P_SideLogic getVariable ["cti_defences", []]);
//--- Add lock/unlock to team vehicles if needed. === Deprecated with group system
/*
{
	if (effectiveCommander _x in units player) then {
		_x addAction ["<t color='#86F078'>Unlock</t>","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player &&alive _target && locked _target == 2'];
		_x addAction ["<t color='#86F078'>Lock</t>","Client\Actions\Action_ToggleLock.sqf", [], 99, false, true, '', '_this != player &&alive _target && locked _target == 0'];
		_x setVariable ["v_keys",[getPlayerUID player],true];
	};
} forEach ([group player, false] call CTI_CO_FNC_GetTeamVehicles);

{
	if (vehicle _x == _x) then { //--- On foot
		_x setPos ([player, 8, 30] call CTI_CO_FNC_GetRandomPosition);
	} else { //--- In vehicle
		if ((effectiveCommander vehicle _x) in units player) then { //--- The vehicle is lead by us
			vehicle _x setPos ([player, 10, 35] call CTI_CO_FNC_GetRandomPosition);
		} else { //--- The vehicle is lead by someone else
			unassignVehicle _x;
			_x setPos ([player, 8, 30] call CTI_CO_FNC_GetRandomPosition);
		};
	};
} forEach (units player call CTI_CO_FNC_GetLiveUnits);
*/



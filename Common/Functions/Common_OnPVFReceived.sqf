/*
  # HEADER #
	Script: 		Common\Functions\Common_OnPVFReceived.sqf
	Alias:			CTI_CO_FNC_OnPVFReceived
	Description:	This file is automatically called by the Public Variable Event Handler
					It doesn't and shouldn't need to be called manually
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	05-11-2013

  # PARAMETERS #
    0	[String/Array]: The PVF destination
    1	[String]: The PVF which should be called
    2	[Array]: The PVF parameters

  # RETURNED VALUE #
	None

  # SYNTAX #
	[DESTINATION, PVF, PARAMETERS] call CTI_CO_FNC_OnPVFReceived

  # EXAMPLE #
    ["CLIENT", Client_OnTownCaptured, [_town, _newSideID, _currentSideID]] call CTI_CO_FNC_OnPVFReceived
*/

private ["_pv_can_exec", "_pv_destination", "_pv_filter_exec", "_pv_parameters"];
//--- Parse the header
_pv_destination = "";
_pv_filter_exec = "";
switch (typeName (_this select 0)) do {
	case "STRING": {_pv_destination = _this select 0};
	case "ARRAY": {_pv_destination = (_this select 0) select 0; _pv_filter_exec = (_this select 0) select 1; };
};

//--- Check if we can execute the PV
_pv_can_exec = false;
switch (_pv_destination) do {
	case "CLIENT": {
		if (CTI_IsClient || CTI_IsHeadless) then {
			switch (typeName _pv_filter_exec) do {
				case "OBJECT": { if (_pv_filter_exec == player) then { _pv_can_exec = true } }; //--- An object (SP oriented).
				case "STRING": { _pv_can_exec = true }; //--- Everyone
				case "SIDE": { if (_pv_filter_exec == CTI_P_SideJoined) then { _pv_can_exec = true } }; //--- Side only
			};
		};
	};
	case "SERVER": { if (CTI_IsServer) then { _pv_can_exec = true } };
};

//--- Execute if we can
if (_pv_can_exec) then {
	//waitUntil {!isNil {(missionNamespace getVariable format ["CTI_PVF_%1", _this select 1])}};
	if !(isNil {missionNamespace getVariable format ["CTI_PVF_%1", _this select 1]}) then { //--- Make sure that the desired PVF is set as a function
		_pv_parameters = if (count _this > 2) then { _this select 2 } else { [] };
		//waitUntil {!isNil "_pv_parameters"};
		_pv_parameters spawn (missionNamespace getVariable format ["CTI_PVF_%1", _this select 1]);
	} else {
		if (CTI_Log_Level >= CTI_Log_Error && !CTI_IsHeadless) then { //--- Error (Skip for HC)
			["ERROR", "FILE: Common\Functions\Common_OnPVFReceived.sqf", format ["[%1] PVF [%2] was received but could not be called since it isn't defined as a function.", _pv_destination, _this select 1]] call CTI_CO_FNC_Log
		};
	};
};
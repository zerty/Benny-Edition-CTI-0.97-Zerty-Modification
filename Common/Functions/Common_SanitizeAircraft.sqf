/*
  # HEADER #
	Script: 		Common\Functions\Common_SanitizeAircraft.sqf
	Alias:			CTI_CO_FNC_SanitizeAircraft
	Description:	Sanitize the equipment of an aircraft
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Object]: The vehicle
    1	[Side]: The side of the vehicle

  # RETURNED VALUE #
	None

  # SYNTAX #
	[VEHICLE, SIDE] call CTI_CO_FNC_SanitizeAircraft

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideUpgrades
	Common Function: CTI_CO_FNC_SanitizeAircraftFFAR
	Common Function: CTI_CO_FNC_SanitizeAircraftAT
	Common Function: CTI_CO_FNC_SanitizeAircraftAA
	Common Function: CTI_CO_FNC_SanitizeAircraftCM

  # EXAMPLE #
    [vehicle player, CTI_P_SideJoined] call CTI_CO_FNC_SanitizeAircraft;
	  -> Sanitize the player's vehicle depending on the upgrade levels/parameters
*/

private ["_side", "_vehicle", "_upgrades"];

_vehicle = _this select 0;
_side = _this select 1;

_upgrades = (_side) call CTI_CO_FNC_GetSideUpgrades;

//--- We check the FFAR loadout
if (_upgrades select CTI_UPGRADE_AIR_FFAR < 1) then {_vehicle call CTI_CO_FNC_SanitizeAircraftFFAR};

//--- We check the AT Loadout
switch (missionNamespace getVariable "CTI_VEHICLES_AIR_AT") do {
	case 0: {_vehicle call CTI_CO_FNC_SanitizeAircraftAT};//--- Remove
	case 1: {if (_upgrades select CTI_UPGRADE_AIR_AT < 1) then {_vehicle call CTI_CO_FNC_SanitizeAircraftAT}};//--- Remove if not yet ugpraded
};

//--- We check the AA Loadout
switch (missionNamespace getVariable "CTI_VEHICLES_AIR_AA") do {
	case 0: {_vehicle call CTI_CO_FNC_SanitizeAircraftAA};//--- Remove
	case 1: {if (_upgrades select CTI_UPGRADE_AIR_AA < 1) then {_vehicle call CTI_CO_FNC_SanitizeAircraftAA}};//--- Remove if not yet ugpraded
};

//--- We check the CM Loadout
switch (missionNamespace getVariable "CTI_VEHICLES_AIR_CM") do {
	case 0: {_vehicle call CTI_CO_FNC_SanitizeAircraftCM};//--- Remove
	case 1: {if (_upgrades select CTI_UPGRADE_AIR_CM < 1) then {_vehicle call CTI_CO_FNC_SanitizeAircraftCM}};//--- Remove if not yet ugpraded
};

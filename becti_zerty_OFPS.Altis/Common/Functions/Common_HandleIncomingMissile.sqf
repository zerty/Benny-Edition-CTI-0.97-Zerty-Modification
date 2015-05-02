private ["_unit","_ammo", "_source"];
_unit = _this select 0 ;
_ammo = _this select 1 ;
_source = _this select 2 ;

_missile = nearestObject [_source,_ammo];
if (isNull _missile) exitWith {};
_irLock = getNumber(configFile >> "CfgAmmo" >> _ammo >> "irLock"); //--- Get the ammo type.

if (_irLock == 1) then { //--- IR Lock is affected
	_source = getPos _source;
	_distance = _unit distance _source;

	_limit = missionNamespace getVariable "CTI_GAMEPLAY_MISSILES_RANGE";

	if (_distance > _limit || _limit != 0) then {
		waitUntil {_missile distance _source > _limit};
		deleteVehicle _missile;
	};
};
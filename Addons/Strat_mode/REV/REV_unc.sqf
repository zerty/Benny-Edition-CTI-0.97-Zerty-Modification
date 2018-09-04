private ["_unit","_source","_side"];
_unit = _this select 0;
_source = _this select 1;
_unit setDamage 0;
_side= side _unit;
_unit setVelocity [0,0,0];
_unit setCaptive true;
_unit setVariable ["REV_UNC", true, true];
_unit spawn REV_UNC_LOOP;
//if (isplayer _unit) then { CTI_P_PreBuilding=True;};
_unit spawn {
	private ["_unit"];
	_unit=_this;

	// Release UAV and AI remote control
	if (cameraOn != _unit) then {
		_unit connectTerminalToUAV objNull;
		cameraOn action ["BackFromUAV", _unit];
	};

	// Eject unit if inside vehicle
	while {vehicle _unit != _unit} do
	{
		(vehicle player) lock false;
		unAssignVehicle _unit;
		_unit action ["eject", vehicle _unit];
		_unit action ["getOut", (vehicle _unit)];
		sleep 1;
	};

	_unit playMove "AinjPpneMstpSnonWrflDnon_rolltoback";
	sleep 4;
	_unit switchMove "AinjPpneMstpSnonWrflDnon";
	_unit enableSimulation false;
	//[_unit, _source, _side] call CTI_CO_FNC_OnUnitKilled;

};
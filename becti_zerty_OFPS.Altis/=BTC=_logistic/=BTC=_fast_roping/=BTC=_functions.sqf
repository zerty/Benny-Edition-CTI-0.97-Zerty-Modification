BTC_deploy_rope =
{
	hint "Rope deployed";
	_veh = vehicle player;
	_veh setVariable ["BTC_rope",1,true];
	WaitUntil {!Alive _veh || !Alive player || (((getPos player) select 2) > BTC_fast_rope_h) || format ["%1",_veh getVariable "BTC_rope"] != "1"};
	_veh setVariable ["BTC_rope",0,true];
};
BTC_cut_rope =
{
	hint "Rope cut";
	_veh = vehicle player;
	_veh setVariable ["BTC_rope",0,true];
};
BTC_fast_rope =
{
	hint "Fast roping";
	_unit = _this select 0;
	_veh = vehicle _unit;
	_unit action ["EJECT",_veh];unassignVehicle _unit;
	_unit setPos (_veh modelToWorld [2,1,-2]);
	_unit switchMove "LadderRifleStatic";
	_unit setDir (getDir _veh - 90);
	While {Alive _unit && (((getPos _unit) select 2) > 1.5)} do {_unit switchMove "LadderRifleStatic";};
	if (Alive _unit && format ["%1",_veh getVariable "BTC_rope"] == "1") then
	{
		_unit setVelocity [0,0,0];
		_unit playMove "LadderRifleDownOff";
		if !(isPlayer _unit) then {_unit move [((getPos _unit) select 0) + 3,((getPos _unit) select 1) + 3,0];};
	};
	if (format ["%1",_veh getVariable "BTC_rope"] != "1") then {hint "The chopper flew away! The rope has been cut!";_unit playMove "LadderRifleDownOff";};
};
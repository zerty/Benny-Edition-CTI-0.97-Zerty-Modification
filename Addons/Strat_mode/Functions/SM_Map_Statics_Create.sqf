
private ["_type","_town","_pos","_veh"];

_type= _this select 0;
_town=  _this select 1;
_group = grpNull;

switch (_type) do
{
	case "AA":
	{
		//Find location
		_pos=[getpos _town,2000,800] call BIS_fnc_findOverwatch;
		// Create group
		_group= createGroup resistance;
		// Create vehicle
		_veh = ["I_LT_01_AA_F", _pos, random(360), resistance, true, true, true] call CTI_CO_FNC_CreateVehicle;
		[_veh, "I_crew_F", _group, CTI_RESISTANCE_ID] call CTI_CO_FNC_ManVehicle;
		// remove fuel
		_veh setFuel 0 ;
	};


	case "AT":
	{
		//Find location
		_pos=[getpos _town,2000,800] call BIS_fnc_findOverwatch;
		// Create group
		_group= createGroup resistance;
		// Create vehicle
		_veh = ["I_LT_01_AT_F", _pos, random(360), resistance, true, true, true] call CTI_CO_FNC_CreateVehicle;
		[_veh, "I_crew_F", _group, CTI_RESISTANCE_ID] call CTI_CO_FNC_ManVehicle;
		// remove fuel
		_veh setFuel 0 ;
	};

	default
	{
		/* STATEMENT */
	};
};

_group
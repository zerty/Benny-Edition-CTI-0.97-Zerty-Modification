#define	SENSIVITY	2
#define MAX_RANGE 4000



while {!CTI_GameOver} do
{
	waitUntil {!isnil "SM_ST_Groups"};
	{
		_x setformdir  (random(360));
		_x setCombatMode "YELLOW";

		//rearm
		{
			_x setAmmo [secondaryWeapon  _x, 1000000];
			if ((typeOf _x )== "I_Soldier_AT_F" && count (backpackItems _x) ==0 ) then {
				_x addItemToBackpack "Titan_AT";
	   			_x addItemToBackpack "Titan_AT";
			};
			if ((typeOf _x )== "I_Soldier_AA_F" && count (backpackItems _x) ==0 ) then {
				_x addItemToBackpack "Titan_AA";
	   			_x addItemToBackpack "Titan_AA";
			};
			if ( {(_x select 2) in [east,west]} count(_x nearTargets 2500) == 0  )  then {_x selectWeapon "Laserdesignator_03";};
			_town = _x getVariable "cti_duty_place";
			if (((_town getVariable "cti_town_sideID") != CTI_RESISTANCE_ID) && !(_town getVariable "cti_town_resistance_active")) then {deleteVehicle _x;};
			true
		} count (units _x);

		//set active

		true
	}count SM_ST_Groups;

	sleep 30;
};
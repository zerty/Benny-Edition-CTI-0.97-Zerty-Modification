#define	SENSIVITY	2
#define MAX_RANGE 4000



while {!CTI_GameOver} do
{
	waitUntil {!isnil "SM_ST_Groups"};
	{


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
			true
		} count (units _x);

		//set active
		_x setformdir  (random(360));
		_x setCombatMode "RED";
		_x  setBehaviourStrong "COMBAT";
		true
	}count SM_ST_Groups;

	sleep 10;
};
#define	SENSIVITY	2
#define MAX_RANGE 4000



while {!CTI_GameOver} do
{
	waitUntil {!isnil "SM_ST_Groups"};


	//rearm
	{
		_x setVehicleAmmo  1;
		true
	} count (units SM_ST_Groups);

	//set active
	SM_ST_Groups setCombatMode "RED";

	sleep 30;
};
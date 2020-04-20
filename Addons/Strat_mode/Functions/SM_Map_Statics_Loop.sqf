#define	SENSIVITY	2
#define MAX_RANGE 4000



while {!CTI_GameOver} do
{
	waitUntil {!isnil "SM_ST_Groups"};
	//remove empty groups (destroyed units)
	SM_ST_Groups=SM_ST_Groups-[grpNull];
	_targets=[];

	{
		_group=_x;

		//rearm
		{
			_x setVehicleAmmo  1;
			true
		} count (units _x);

		//set active
		_x setCombatMode "RED";

		//register targets
		_group_targets=(leader _group) nearTargets (MAX_RANGE);

		{
			if ((_group knowsAbout (_x select 4))>SENSIVITY && (_x select 2) != resistance ) then {_targets pushBackUnique (_x select 4)};
			true
		} count _group_targets;

		true
	} count SM_ST_Groups;

	_targets=_targets-[objNull];
	diag_log _targets;
	//share targets because fuck players
	{
		_group=_x;
		{
			if !(isnull _x) then {_group reveal [_x,SENSIVITY+1]};
			true
		} count _targets;
		true
	} count SM_ST_Groups;
	sleep 30;
};
/*
 * Name: CTI_AC_GET_VEHCICLE_LOADOUT_COST
 *
 * Purpose: Gets the cost of a vehicle based on the current loadout equiped
 *
 * Input: _vehicle => Vehicle to determine loadout cost from
 *
 * Return: _return => _total_cost value of loadout
 *
 * Side effects: <NONE>
 *
*/

_vehicle = _this;
_vehicle_classname = typeOf _vehicle;

// Currently mounted loadout
_vehicle_mount_options = _vehicle getVariable "CTI_AC_AIRCRAFT_LOADOUT_MOUNTED";

// Full list of vehicle mount options// Get loadout options
_vehicle_loadout_options = _vehicle call CTI_AC_GET_VEHICLE_LOADOUT_OPTIONS;

//Get weapons from the chosen loadout
//Format: [0]:Name, [1]:format, [2]: mounts 
_chosen_loadout = _vehicle_loadout_options select ( _vehicle_mount_options select 0 );
//Format: [0]: weapon, [1]: Magazine
_chosen_loadout_mounts = _chosen_loadout select 2;
_total_cost = 0;

// Loop through each mounted weapon and tally cost
for [ {_mounted_index = 0},{ _mounted_index < ( count ( _chosen_loadout_mounts ))},{ _mounted_index = _mounted_index + 1}] do
{
	//Select mount out of currently mounted weapons
	//Format: [0,0, true]
	_mounted_mount_array = _vehicle_mount_options select (_mounted_index +1) ;
	//player sideChat format [ "_mounted_mount_array %1" , _mounted_mount_array];
	// Pull out the mounted details
	_mounted_weapon_index = _mounted_mount_array select 0;
	_mounted_magazine_index = _mounted_mount_array select 1;
	_is_mounted = _mounted_mount_array select 2;

	//player sideChat format [ "_mounted_options %1" , _chosen_loadout_mounts];
	//player sideChat format [ "_mounted_weapon_index %1" , _mounted_weapon_index];
	//player sideChat format [ "_mounted_magazine_index %1" , _mounted_magazine_index];

	//Drill down to find the cost in the options list
	_mounted_mount = _chosen_loadout_mounts select _mounted_index;
	//player sideChat format [ "_mounted_mount %1" , _mounted_mount];
	//player sideChat format [ "_chosen_loadout_mounts %1" , _chosen_loadout_mounts];
	//diag_log  format ["_mounted_mount %1", _mounted_mount];
	_weapon_chosen = (_mounted_mount select _mounted_weapon_index) select 1;
	//player sideChat format [ "_weapon_chosen %1" , _weapon_chosen];
	//TODO: fix weapon_name
	_weapon_name = _mounted_mount select 1 ;
	//player sideChat format [ "_weapon_name %1" , _weapon_name];

	_magazine_chosen = _weapon_chosen select ( _mounted_magazine_index );
	//player sideChat format [ "_magazine_chosen %1" , _magazine_chosen];

	_magazine_cost = _magazine_chosen select 1;
	//player sideChat format [ "_magazine_cost %1" , _magazine_cost];

	if ( _is_mounted ) then
	{
		_total_cost = ( _total_cost +  parseNumber ( _magazine_cost ) );
	};
};

_total_cost
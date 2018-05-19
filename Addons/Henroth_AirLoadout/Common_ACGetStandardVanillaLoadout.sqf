/*
	 * Name: CTI_AC_GET_STANDARD_VANILLA_LOADOUT
	 *
	 * Purpose: Gets an array representation of a standard ( vanilla ) loadout on the vehicle
	 *
	 * Input: _vehicle => Vehicle to determine loadout from
	 *
	 * Return: _return => Array representation of vanilla loadout
	 *
	 * Side effects: <NONE>
	 *
	*/

_vehicle = _this;
_vehicle_classname = typeOf _vehicle;

_loadout_options = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , _vehicle_classname ] );
//_first_loadout Format: [0]: NAME, [1]: format, [2]: Mounts
_first_loadout = _loadout_options select 0;
//Format: [0] Mount 1, [1] Mount 2....
_default_option_mount_points = _first_loadout select 2; 

_return = [ 0 ]; // Add the first loadout as default
{	//Format: [index_weapon, index_magazin, boolean_is_mounted]
	_element = [ 0 , 0 , true ];
	_return pushBack _element;
} forEach ( _default_option_mount_points );
_return
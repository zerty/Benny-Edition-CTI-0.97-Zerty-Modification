/*
 * Name: CTI_AC_GET_STANDARD_EMPTY_LOADOUT
 *
 * Purpose: Gets an array representation of an empty loadout for a particular vehicle
 *
 * Input: _vehicle => Vehicle to determine empty loadout from
 *
 * Return: _return => Array representation of empty loadout
 *
 * Side effects: <NONE>
 *
*/

_vehicle = _this;
_vehicle_classname = typeOf _vehicle;

_loadout_options = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , _vehicle_classname ] );
_default_option_mount_points = _loadout_options select 1; // First element is name, second element is loadout array tree ...

_return = [ 1 ]; // Add the first loadout as default
{
	_element = [ 0 , 0 , false ];
	_return pushBack _element;
} forEach ( _default_option_mount_points );
_return
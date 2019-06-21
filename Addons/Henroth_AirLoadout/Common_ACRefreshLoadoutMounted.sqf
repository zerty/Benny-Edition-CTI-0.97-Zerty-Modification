/*
	 * Name: CTI_AC_REFRESH_LOADOUT_ON_MOUNTED
	 *
	 * Purpose: Refreshses the weapon mount points on a vehicle
	 * 
	 * Input: _vehicle => Vehicle to refresh mount point
	 *        
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
*/
	
private ["_side", "_vehicle", "_upgrades"];

_vehicle = _this select 0;
_side = _this select 1;

_upgrades = (_side) call CTI_CO_FNC_GetSideUpgrades;


// Grab vehicle loadout choices
_loadout_selections = _vehicle getVariable "CTI_AC_AIRCRAFT_LOADOUT_MOUNTED";

// Determine vehicle type
_typeOfValue = typeOf _vehicle;

// Grab the weapon configurations available for this vehicle
_gun_configs = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , _typeOfValue ] );

//Loadout chosen index
_loadout_index = _loadout_selections select 0;

// Mountpoint options for chosen loadout
_all_mountpoint_options = (_gun_configs select _loadout_index) select 2;


// Loop through each mount point
for [ {_mount_index = 0},{ _mount_index < ( count ( _all_mountpoint_options ))},{ _mount_index = _mount_index + 1}] do 
{
	
	//Get options for mountpoint
	_a_mountpoint_options = _all_mountpoint_options select _mount_index;
	
	// Extract chosen mountpoint options
	_mount_loadout = _loadout_selections select ( _mount_index + 1 );
	
	if ( CTI_DEBUG ) then
	{
		systemChat format [ "_mount_loadout  %1" , _mount_loadout ];
	};
	_mount_loadout_weapon_index = _mount_loadout select 0;
	_mount_loadout_magazine_index = _mount_loadout select 1;
	_mount_loadout_enabled  = _mount_loadout select 2;
	
	//Get chosen weapon and magazine classnames 
	_weapon_classname = (_a_mountpoint_options select _mount_loadout_weapon_index) select 0;
	
	//Plyon name to plyon index
	_pylon_index = 0;
	{
		_pylon = configName(_x);
		if(_pylon == _weapon_classname) then {
			_pylon_index = _forEachIndex + 1;
		};
	} forEach (configProperties [configFile >> "CfgVehicles" >> _typeOfValue  >> "Components" >> "TransportPylonsComponent" >> "Pylons"]);

	
	_magazine_options = (( _a_mountpoint_options select ( _mount_loadout_weapon_index)) select 1) select ( _mount_loadout_magazine_index );
	_magazine_classname = _magazine_options select 0;
	_magazine_cost = _magazine_options select 1;
	
	
	_not_resreached_magzine = false;
	if(not (_vehicle isKindof "Tank")) then {
		//No ATGM  if upgrade not present 
		if (((_upgrades select CTI_UPGRADE_AIR_AT) == 0) 
			&& (_magazine_classname in CTI_ALM_ATGM_RESEARCHED_MAGAZINES)) then {
			_not_resreached_magzine = true;
		};
		//No AA  if upgrade not present 
		if (((_upgrades select CTI_UPGRADE_AIR_AA) == 0) 
			&& (_magazine_classname in CTI_ALM_AA_RESEARCHED_MAGAZINES)) then {
			_not_resreached_magzine = true;
		};
		//No FFAR  if upgrade not present 
		if (((_upgrades select CTI_UPGRADE_AIR_FFAR) == 0) 
			&& (_magazine_classname in CTI_ALM_FFAR_RESEARCHED_MAGAZINES)) then {
			_not_resreached_magzine = true;
		};
		//No CM  if upgrade not present 
		if (((_upgrades select CTI_UPGRADE_AIR_CM) == 0) 
			&& (_magazine_classname in CTI_ALM_CM_RESEARCHED_MAGAZINES)) then {
			_not_resreached_magzine = true;
		};
	};
	
	
	if ( CTI_DEBUG ) then
	{
		systemChat format [ "_magazine_options  %1" , _magazine_options ];
		systemChat format [ "count ( _magazine_options )  %1" , (count ( _magazine_options )) ];
	};
	if(_weapon_classname == "FakeHorn") then {
		_turret_position = ( _magazine_options select 2 );
		_vehicle addWeaponTurret ["M2", _turret_position];
	} else 
	{
	
		if ( ( count ( _magazine_options ) ) > 2 ) then
		{
			if ( CTI_DEBUG ) then
			{
				systemChat format [ "Adding weapon %1 to position %2" , _weapon_classname , ( _magazine_options select 2 )  ];
				systemChat format [ "Adding magazine %1 to position %2" , _magazine_classname , ( _magazine_options select 2 )  ];
			};
			_turret_position = ( _magazine_options select 2 );
			if ( _vehicle turretLocal _turret_position ) then
			{
					if(isNil "_turret_position") then {
						_turret_position = [];
					} else {
						diag_log format ["_turret_position01: %1", _turret_position];
						if (
						(_weapon_classname != "CMFlareLauncher" 
						&& _weapon_classname != "SmokeLauncher") && (_turret_position select 0) == -1) then {
					
							_turret_position = [];
						};
					};
				//Mounts pylon, not weapon
				if((_weapon_classname find "Pylon") >= 0) then {
					_vehicle setPylonLoadOut [_weapon_classname, _magazine_classname,  true, _turret_position];
					if ( not _mount_loadout_enabled || _not_resreached_magzine) then {
						// does not work correctly parseNumber((_weapon_classname splitString "Pylons") select 0);
						_vehicle setPylonLoadOut [_weapon_classname, "",  true, _turret_position];
					};				
				} else {
					_already_mounted =  ( _weapon_classname in ( _vehicle weaponsTurret ( _turret_position ) ) );
					if ( not _already_mounted ) then
					{
						_vehicle addWeaponTurret [ _weapon_classname , _turret_position ];
					};
					if ( not _not_resreached_magzine ) then
					{ 
						_vehicle addMagazineTurret [ _magazine_classname , _turret_position ];
					};
					if ( not _mount_loadout_enabled ) then
					{
						_vehicle setAmmo [ _weapon_classname , 0 ];
						_vehicle removeWeaponTurret [ _weapon_classname , _turret_position ];
					};
				};
			}
			else
			{
				_unit_in_turret = _vehicle turretUnit ( _turret_position );
				
				[["CLIENT", leader _unit_in_turret], "Client_RefreshLoadoutOnAVehicle", [_vehicle]] call CTI_CO_FNC_NetSend;
			};
		}
		else
		{
			if ( CTI_DEBUG ) then
			{
				systemChat format [ "Adding magazine %1" , _magazine_classname ];
				systemChat format [ "Adding weapon %1" , _weapon_classname ];
			};
			
			if  ( local _vehicle ) then
			{
				_turret_position = ( _magazine_options select 2 );
				if(isNil "_turret_position") then {
					_turret_position = [];
				} else {
					if ((_weapon_classname != "CMFlareLauncher" && _weapon_classname != "SmokeLauncher") 
					&& (_turret_position select 0) == -1) then {
						_turret_position = [];
					};
				};
				
				if((_weapon_classname find "Pylon") >= 0) then {
				//(vehicle player) setPylonLoadOut ["PylonLeft1", "PylonRack_12Rnd_PG_missiles",  true, [-1]]
					_vehicle setPylonLoadOut [_weapon_classname, _magazine_classname,  true, _turret_position];
					if ( not _mount_loadout_enabled  || _not_resreached_magzine) then {	
						_vehicle setPylonLoadOut [_weapon_classname, "",  true, _turret_position];
					};	
				} else {
					// Check if weapon is already mounted and this is another "instance"
					_already_mounted =  ( _weapon_classname in ( weapons _vehicle ) );
					
					if (_already_mounted && _weapon_classname == "SmokeLauncher") then {
						_vehicle removeWeapon _weapon_classname;
						_vehicle addMagazine [ _magazine_classname , 0 ];
					};
					
					if ( not _already_mounted ) then
					{
						_vehicle addWeapon _weapon_classname;
					};
					
					
					if ( not _mount_loadout_enabled ) then
					{
						// Add the place holder magazine
						_vehicle addMagazine [ _magazine_classname , 0 ];
						
						// Remove weapon is not from a previous instance
						if ( not _already_mounted ) then
						{
							_vehicle removeWeapon _weapon_classname;
						};
					}
					else
					{
						_vehicle addMagazine _magazine_classname;
					};
				};
			};
		};
	};
	
};
	
// Force flush of flares ... magic

_vehicle addWeaponTurret [ "FakeHorn" , [-1] ];
_vehicle removeWeaponTurret [ "FakeHorn" , [-1] ];
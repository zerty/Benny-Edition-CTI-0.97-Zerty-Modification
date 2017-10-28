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
	
_vehicle = _this;

// Grab vehicle loadout choices
_loadout_selections = _vehicle getVariable "CTI_AC_AIRCRAFT_LOADOUT_MOUNTED";

// Determine vehicle type
_typeOfValue = typeOf _vehicle;

// Grab the weapon configurations available for this vehicle
_gun_configs = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , _typeOfValue ] );

//Loadout chosen index
_loadout_index = _loadout_selections select 0;

// Mountpoint options for chosen loadout
_all_mountpoint_options = _gun_configs select _loadout_index;

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
	_weapon_classname = _a_mountpoint_options select _mount_loadout_weapon_index;
	_magazine_options = ( _a_mountpoint_options select ( _mount_loadout_weapon_index + 1 ) ) select ( _mount_loadout_magazine_index );
	_magazine_classname = _magazine_options select 0;
	_magazine_cost = _magazine_options select 1;
		
	if ( CTI_DEBUG ) then
	{
		systemChat format [ "_magazine_options  %1" , _magazine_options ];
		systemChat format [ "count ( _magazine_options )  %1" , (count ( _magazine_options )) ];
	};
	
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
		
			_already_mounted =  ( _weapon_classname in ( _vehicle weaponsTurret ( _turret_position ) ) );
			
			if ( not _already_mounted ) then
			{
				_vehicle addWeaponTurret [ _weapon_classname , _turret_position ];
			};
			
			_vehicle addMagazineTurret [ _magazine_classname , _turret_position ];
			
			if ( not _mount_loadout_enabled ) then
			{
				_vehicle setAmmo [ _weapon_classname , 0 ];
				_vehicle removeWeaponTurret [ _weapon_classname , _turret_position ];
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
			// Check if weapon is already mounted and this is another "instance"
			_already_mounted =  ( _weapon_classname in ( weapons _vehicle ) );
			if ( not _already_mounted ) then
			{
				_vehicle addWeaponGlobal _weapon_classname;
			};
			
			
			if ( not _mount_loadout_enabled ) then
			{
				// Add the place holder magazine
				_vehicle addMagazine [ _magazine_classname , 0 ];
				
				// Remove weapon is not from a previous instance
				if ( not _already_mounted ) then
				{
					_vehicle removeWeaponGlobal _weapon_classname;
				};
			}
			else
			{
				_vehicle addMagazineGlobal _magazine_classname;
			};
		};
	};
	
};
	
// Force flush of flares ... magic

_vehicle addWeaponTurret [ "FakeHorn" , [-1] ];
_vehicle removeWeaponTurret [ "FakeHorn" , [-1] ];
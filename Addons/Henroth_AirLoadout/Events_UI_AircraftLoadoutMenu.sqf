/*
 * Filename: Events_UI_AircraftLoadoutMenu.sqf
 *
 * Purpose: House the event related functions related to the Aircraft Loadout Menu.
 * Author: Henroth
 * Date: 07/Sept/2014
 * Version: 1.0
 *
 * Change log:
 * -------------------------------------------
 * 07/Sept/2014 - Henroth - Initial code
 *
 *
 *
*/

private ["_action"];
_action = _this select 0;
_target= uiNamespace getVariable ['HAL_TARG',objnull];
disableserialization;
switch (_action) do {

	case "onLoad":
	{
		call CTI_AC_UI_CLEAR_ALL_PREVIOUS_CHOICES;
		call CTI_AC_UI_HIDE_ALL_MOUNTPOINTS;
		if !(isNull _target) then {
			// Update list of possible loadouts for this vehicle
			_target call CTI_AC_UPDATE_UI_LOADOUT_OPTIONS;

			// Set loadout to first choice
			call CTI_AC_SET_UI_LOADOUT_FIRST_CHOICE;

			// Read and update current vehicle loadout
			_target call CTI_AC_UPDATE_UI_CURRENT_LOADOUT;
		};
		//call CTI_AC_UPDATE_UI_VEHICLE_SELECT_LIST;
	};
	case "onUnload":
	{
		call CTI_AC_UI_CLEAR_ALL_PREVIOUS_CHOICES;
	};

	//Select a weapon loadout options
	case "onAmmoListLBSelChanged":
	{
		if ( CTI_DEBUG ) then
		{
			systemChat format [ "Triggering onAmmoListLBSelChanged()" ];
		};
		// Get relative mount row
		_mount_row = _this select 2;

		// Disable if not researched
		_mount_row call CTI_AC_UI_LOCK_IF_NOT_RESEARCHED_MOUNT_N;

		// Update cost field
		_mount_row call CTI_AC_UI_UPDATE_TEXT_COST_ROW_N;

		// Get current selected vehicle
		_selected_vehicle = call CTI_AC_UI_GET_SELECTED_VEHICLE;

		// Refresh costs of chosen loadout
		_selected_vehicle call CTI_AC_UPDATE_UI_CURRENT_LOADOUT;

	};
	case "onWeaponMountPressed":
	{
		if ( CTI_DEBUG ) then
		{
			systemChat format [ "Triggering onWeaponMountPressed()" ];
		};

		_idc = _this select 1;
		_control = ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( _idc ));
		if ( ( ctrlText _control ) == "NO" ) then
		{
			_control ctrlSetTextColor [0.1, 1, 0.1, 1];
			_control ctrlSetText "YES";
		}
		else
		{
			_control ctrlSetTextColor [1, 0.1 , 0.1, 1];
			_control ctrlSetText "NO";
		};

		// Get current selected vehicle
		_selected_vehicle = call CTI_AC_UI_GET_SELECTED_VEHICLE;

		// Refresh costs of chosen loadout
		_selected_vehicle call CTI_AC_UPDATE_UI_CURRENT_LOADOUT;

	};
	case "onWeaponListLBSelChanged":
	{

		DEBUG_onWeaponListLBSelChanged = false;

		if ( DEBUG_onWeaponListLBSelChanged ) then
		{
			systemChat format [ "Triggering onWeaponListLBSelChanged()" ];
		};
		_control_select = _this select 1;
		_relative_idc = _this select 2;
		_current_idc = _control_select select 0;
		_changeto = _control_select select 1;

		_vehicle = call CTI_AC_UI_GET_SELECTED_VEHICLE;

		// Grab vehicle loadout choices
		//_loadout_selections = _vehicle getVariable "CTI_AC_AIRCRAFT_LOADOUT_MOUNTED";

		// Determine vehicle type
		_typeOfValue = typeOf _vehicle;

		// Grab the weapon configurations available for this vehicle
		_gun_configs = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , _typeOfValue ] );

		//Loadout chosen index
		_loadout_index = ( ( ( call CTI_AC_UI_GET_SELECTED_LOADOUT_INDEX ) *2 ) + 1 );

		if ( DEBUG_onWeaponListLBSelChanged ) then
		{
			systemChat format [ "_loadout_index = %1" , _loadout_index  ];
		};

		// Mountpoint options for chosen loadout
		_all_mountpoint_options = _gun_configs select _loadout_index;

		//Get options for mountpoint
		if ( _relative_idc < ( count ( _all_mountpoint_options ) ) ) then
		{
			if ( DEBUG_onWeaponListLBSelChanged ) then
			{
				systemChat format [ "_relative_idc = %1" , _relative_idc  ];
			};

			_a_mountpoint_options = _all_mountpoint_options select _relative_idc;

			// Extract chosen mountpoint options
			//_mount_loadout = _loadout_selections select ( _relative_idc + 1 );
			//_mount_loadout_weapon_index = _mount_loadout select 0;
			//_mount_loadout_magazine_index = _mount_loadout select 1;
			//_mount_loadout_enabled  = _mount_loadout select 2;

			// if ( DEBUG_onWeaponListLBSelChanged ) then
			// {
				// systemChat format [ "_mount_loadout_weapon_index = %1" , _mount_loadout_weapon_index  ];
				// systemChat format [ "_mount_loadout_magazine_index = %1" , _mount_loadout_magazine_index  ];
				// systemChat format [ "_mount_loadout_enabled = %1" , _mount_loadout_enabled  ];
			// };

			//Get chosen weapon and magazine classnames
			// _weapon_classname = _a_mountpoint_options select _mount_loadout_weapon_index;
			// _selected_magazine_config = ( _a_mountpoint_options select ( _mount_loadout_weapon_index + 1 ) );

			_weapon_classname = _a_mountpoint_options select ( _changeto * 2 );
			_selected_magazine_config = ( _a_mountpoint_options select ( ( _changeto * 2 ) + 1 ) );

			if ( DEBUG_onWeaponListLBSelChanged ) then
			{
				systemChat format [ "_weapon_classname = %1" , _weapon_classname  ];
			};

			// Clear out configuration details for the magazine related to this mount point
			lbClear ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( 39040 + ( _relative_idc ) ) );

			// Loop through each of the magazine options for this weapon
			for [ {_index_magazine = 0},{ _index_magazine < ( count ( _selected_magazine_config ))},{ _index_magazine = _index_magazine + 1}] do
			{

				// Extract the magazine option ( classname , cost );
				_magazine_options = _selected_magazine_config select _index_magazine;
				_magazine_classname = _magazine_options select 0;
				_magazine_cost = _magazine_options select 1;

				// Determine magazine name to display
				_magazine_name = getText ( configFile >> "CfgMagazines" >> _magazine_classname >> "displayName" );
				if ( _magazine_name == "" ) then { _magazine_name = getText ( configFile >> "CfgMagazines" >> _magazine_classname >> "displayNameShort" ); };
				if ( _magazine_name == "" ) then { _magazine_name = "Rounds" };

				// Determine count to display
				_magazine_count = getNumber  ( configFile >> "CfgMagazines" >> _magazine_classname >> "count" );

				// Update magazine list of options
				((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( 39040 + _relative_idc )) lbAdd ( format[ "%1 X %2" , _magazine_count , _magazine_name ] );
			};

			// Default select first element
			((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( 39040 + _relative_idc )) lbSetCurSel 0;
		}
		else
		{
			if ( DEBUG_onWeaponListLBSelChanged ) then
			{
				systemChat format [ "_relative_idc = %1" , _relative_idc  ];
				systemChat format [ "count ( _all_mountpoint_options ) = %1" , count ( _all_mountpoint_options )  ];
				systemChat format [ "_relative_idc >=( count ( _all_mountpoint_options ) )" ];
			};
		};


	};
	case "onLoadoutListLBSelChanged":
	{
		if ( CTI_DEBUG ) then
		{
			systemChat format [ "Triggering onLoadoutListLBSelChanged()" ];
		};

		// Get current selected vehicle
		_selected_vehicle = call CTI_AC_UI_GET_SELECTED_VEHICLE;

		call CTI_AC_UI_HIDE_ALL_MOUNTPOINTS;

		_selected_vehicle call CTI_AC_UPDATE_UI_WEAPON_OPTIONS;

		call CTI_AC_SET_UI_WEAPON_MOUNTS_FIRST_CHOICE;

		call CTI_AC_SET_UI_MAGAZINES_MOUNTS_FIRST_CHOICE;

		call CTI_AC_UNSET_UI_ALL_MOUNT_BUTTONS;

		if ( CTI_DEBUG ) then
		{
			systemChat format [ "Exiting onLoadoutListLBSelChanged()" ];
		};
	};
	case "onVehicleListLBSelChanged":
	{
		if ( CTI_DEBUG  ) then
		{
			systemChat format [ "Triggering onVehicleListLBSelChanged()" ];

		};

		// Hide all visible mount points
		call CTI_AC_UI_HIDE_ALL_MOUNTPOINTS;

		// Get current selected vehicle
		_selected_vehicle = call CTI_AC_UI_GET_SELECTED_VEHICLE;


		if ( CTI_DEBUG  ) then
		{
			// Determine vehicle type
			_typeOfValue = typeOf _selected_vehicle;
			_array_stuff = _typeOfValue call funcGetTurretsWeapons;
			player sideChat format [ "Stuff: %1" , _array_stuff ];
		};

		// Update list of possible loadouts for this vehicle
		_selected_vehicle call CTI_AC_UPDATE_UI_LOADOUT_OPTIONS;

		// Set loadout to first choice
		call CTI_AC_SET_UI_LOADOUT_FIRST_CHOICE;

		// Read and update current vehicle loadout
		_selected_vehicle call CTI_AC_UPDATE_UI_CURRENT_LOADOUT;

	};
	case "onAcceptPressed":
	{
		if ( CTI_DEBUG ) then
		{
			systemChat format [ "Triggering onAcceptPressed()" ];
		};

		if ( !isnull  (uiNamespace getVariable ['HAL_TARG',objnull]) ) then
		{
			// Get current selected vehicle
			_selected_vehicle = call CTI_AC_UI_GET_SELECTED_VEHICLE;

			if ( ! local ( _selected_vehicle ) ) then
			{
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Vehicle is not under your ownership.";
			}
			else
			{
				if ( _selected_vehicle call CTI_AC_ACQUIRE_BUSY_LOCK ) then
				{
					// Don't need to hold onto lock
					_selected_vehicle call CTI_AC_RELEASE_BUSY_LOCK;

					// Calculate cost total cost
					_selected_cost_total = call CTI_AC_CALCULATE_CHOSEN_LOADOUT_COST;
					_vehicle_loadout_value = _selected_vehicle getVariable "CTI_AC_AIRCRAFT_LOADOUT_COST";

					// Get current funds
					_funds = call CTI_CL_FNC_GetPlayerFunds;

					// Subtract from players funds
					_total_cost_difference = ( _vehicle_loadout_value - _selected_cost_total );

					if ( ( _funds + _total_cost_difference ) >= 0 ) then
					{
						( _total_cost_difference ) call CTI_CL_FNC_ChangePlayerFunds;

						//Remove all existing weapons
						_wait = _selected_vehicle call CTI_AC_PURGE_ALL_WEAPONS;

						// Accept vehicle loadout
						_wait = _selected_vehicle call CTI_AC_ACCEPT_VEHICLE_LOADOUT;

						// Save the selected cost onto the vehicle
						_selected_vehicle setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_COST" , _selected_cost_total , true ];

						// Reresh vehicle loadout
						_wait = _selected_vehicle call CTI_AC_UPDATE_UI_CURRENT_LOADOUT;
						//[_selected_vehicle, CTI_P_SideJoined] call CTI_CO_FNC_RearmVehicle;
						_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
						_ammo_depots = [CTI_AMMO, _structures, _selected_vehicle] call CTI_CO_FNC_GetSideStructuresByType;
						_available_ammo_depots = [_selected_vehicle, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
						[_selected_vehicle,  [[],[["Base", _available_ammo_depots], ["Mobile",[]]],[],[]], [CTI_SERVICE_AMMO_DEPOT_RANGE, CTI_SERVICE_AMMO_TRUCK_RANGE], [CTI_SERVICE_AMMO_DEPOT_TIME, CTI_SERVICE_AMMO_TRUCK_TIME], 1] spawn CTI_UI_Service_ProcessRearm;
					}
					else
					{
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot equip this loadout. Insufficient funds.";
					};
				}
				else
				{
					hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Cannot perform this operation on a unit currently being re-armed. Please try again once re-arming completes.";
				};
			};
		};
	};
	case "onCancelPressed":
	{
		// Clear all previous choices
		call CTI_AC_UI_CLEAR_ALL_PREVIOUS_CHOICES;

		//Close main dialog
		closeDialog 39000;
	};
};
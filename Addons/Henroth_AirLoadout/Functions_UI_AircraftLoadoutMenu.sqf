/*
 * Filename: Functions_UI_AircraftLoadoutMenu.sqf
 *
 * Purpose: House the functions related to the Aircraft Loadout Menu UI and its interactions.
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


// Explicit list of IDC values
CTI_AC_UI_ALL_MAGAZINE_COMBOBOX_IDCS = [ 710000 , 710001 , 710002 , 710003 , 710004 , 710005 , 710006, 710007, 710008, 710009, 710010, 710011, 710012, 710013, 710014, 710015];
CTI_AC_UI_ALL_MAGAZINE_COMBOBOX_FRAMES_IDCS = [ 720000 , 720001 , 720002 , 720003 , 720004 , 720005 , 720006, 720007, 720008, 720009, 720010, 720011, 7200012, 720013, 720014, 720015];
CTI_AC_UI_ALL_WEAPON_COMBOBOX_IDCS = [ 730000 , 730001 , 730002 , 730003 , 730004 , 730005 , 730006, 730007, 730008, 730009, 730010, 730011, 730012, 730013, 730014, 730015];
CTI_AC_UI_ALL_WEAPON_COMBOBOX_FRAMES_IDCS = [ 740000, 740001 , 740002 , 740003 , 740004 , 740005 , 740006 , 740007, 740008, 740009, 740010, 740011, 740012, 740013, 740014, 740015];
CTI_AC_UI_ALL_WEAPON_CHECKBOX_IDCS = [ 750000 , 750001 , 750002 , 750003 , 750004 , 750005 , 750006, 750007, 750008, 750009, 750010, 750011, 750012, 750013, 750014, 750015];
CTI_AC_UI_ALL_COST_TEXTBOX_IDCS = [ 760000 , 760001 , 760002 , 760003 , 760004 , 760005 , 760006, 760007, 760008, 760009, 760010, 760011, 760012, 760013, 760014, 760015];

// IDC starting reference points
CTI_AC_UI_MAGAZINE_COMBOBOX_START_IDC = CTI_AC_UI_ALL_MAGAZINE_COMBOBOX_IDCS select 0;
CTI_AC_UI_MAGAZINE_COMBOBOX_FRAMES_START_IDC = CTI_AC_UI_ALL_MAGAZINE_COMBOBOX_FRAMES_IDCS select 0;
CTI_AC_UI_WEAPON_COMBOBOX_START_IDC = CTI_AC_UI_ALL_WEAPON_COMBOBOX_IDCS select 0;
CTI_AC_UI_WEAPON_CHECKBOX_START_IDC = CTI_AC_UI_ALL_WEAPON_CHECKBOX_IDCS select 0;
CTI_AC_UI_WEAPON_CHECKBOX_FRAMES_START_IDC = CTI_AC_UI_ALL_WEAPON_COMBOBOX_FRAMES_IDCS select 0;
CTI_AC_UI_WEAPON_COST_TEXTBOX_START_IDC = CTI_AC_UI_ALL_COST_TEXTBOX_IDCS select 0;


CTI_AC_UI_VEHICLE_SELECT_LIST_IDC = 739010;
CTI_AC_UI_LOADOUT_SELECT_LIST_IDC = 739021;

CTI_AC_UI_WEAPON_COMBOBOX_START_IDC = 730000;
CTI_AC_UI_MAGAZINE_COMBOBOX_START_IDC = 710000;
CTI_AC_UI_WEAPON_CHECKBOX_START_IDC = 750000;
CTI_AC_UI_COST_TEXT_START_IDC = 760000;



CTI_AC_UI_IDC_LOADOUT_DISPLAY = 739303;

CTI_AC_FORCE_UNLOCK_TIME = 180;

CTI_AC_UI_COLOR_REDNO = [ 1 , 0.1 , 0.1 , 1 ];
CTI_AC_UI_COLOR_GREENYES = [0.1, 1, 0.1, 1];
CTI_AC_UI_COLOR_GREYNA = [ 0.2, 0.2 , 0.2, 1 ];

CTI_AC_UPDATE_UI_CURRENT_LOADOUT =
{
	/*
	 * Name: CTI_AC_UPDATE_UI_CURRENT_LOADOUT
	 * Purpose: Refresh the UI window in the aircraft customisation window
	 *          with the currently mounted vehicle weapons.
	 *
	 * Input:
	 *        _vehicle   => Vehicle to examine and update the loadout from.
	 *
	 * Return: <NONE>
	 * Side effects: UI window updated with vehicle loadout details.
	 *
	*/

	// Function inputs
	private ["_vehicle","_text_to_display","_typeOfValue","_loadout_details","_loadout_index_chosen","_loadout_options","_loadout_name","_loadout_specifics","_mount_index","_mount_details","_mount_options","_weapon_classname","_magazine_chosen","_magazine_classname","_magazine_cost","_magazine_displayname","_weapon_displayname","_is_mounted","_current_value","_selected_cost_total","_difference","_signage","_colour"];
	_vehicle = _this;

	_text_to_display = "";

	if ( local ( _vehicle ) ) then
	{

		// Get vehicle class name
		_typeOfValue = typeOf _vehicle;

		// Extract current vehicle loadout configuration details
		_loadout_details = _vehicle getVariable "CTI_AC_AIRCRAFT_LOADOUT_MOUNTED";

		// Extract selected loadout
		_loadout_index_chosen = _loadout_details select 0;

		// Lookup weapon details for this vehicle
		_loadout_options = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , _typeOfValue ] );

		// Start building up the displayed message
		_text_to_display = "<br />";

		// Extract the name of the loadout and append to message
		_loadout_name = (_loadout_options select _loadout_index_chosen) select 0;
		_text_to_display = format [ "%1<t size='0.9' color='#3399ff'>Loadout: %2</t><br />" , _text_to_display , _loadout_name ];

		// Get specific loadout
		_loadout_specifics = _loadout_options select _loadout_index_chosen;
		// Loop through each mount point of the vehicle
		for [ {_mount_index = 1},{ _mount_index < ( count ( _loadout_details ) )},{ _mount_index = _mount_index + 1}] do
		{
			// Extract possible mounting options for a particular mount point
			//Format: [index_weapon, index_magazin, boolean_mounted]
			_mount_details =_loadout_details select _mount_index;
			// Loadout mount specific options
			_mount_options = (_loadout_specifics select 2) select ( _mount_index - 1 );

			// Extract chosen weapon details for the mount
			_weapon_classname = (_mount_options select ( _mount_details select 0 ) select 0);
			
			_magazine_chosen = ((_mount_options select ( _mount_details select 0 )) select 1) select ( _mount_details select 1);
			_magazine_classname = _magazine_chosen select 0;
			_magazine_cost = _magazine_chosen select 1;

			_magazine_displayname = _magazine_classname call CTI_AC_GET_MAGAZINE_DISPLAY_NAME;
			_weapon_displayname = _weapon_classname call CTI_AC_GET_WEAPON_DISPLAY_NAME;

			_is_mounted = _mount_details select 2;

			_text_to_display = format [ "%1<t size='0.85' color='#6699ff'>" , _text_to_display ];
			if ( _is_mounted ) then
			{
				_text_to_display = format [ "%1Mount #%2: %3 | %4 <br />" , _text_to_display , _mount_index , _weapon_displayname , _magazine_displayname ];

				// Add the weapon so that the player can see it empty and has desire to "rearm"
				//_vehicle addWeaponGlobal _weapon_classname;
			}
			else
			{
				_text_to_display = format [ "%1Mount #%2: ** EMPTY ** <br />" , _text_to_display ,_mount_index ];
			};
			_text_to_display = format [ "%1</t>" , _text_to_display ];

		};

		_text_to_display = format [ "%1<br /><br />" , _text_to_display ];

		// Get value of current loadout
		_current_value = _vehicle getVariable "CTI_AC_AIRCRAFT_LOADOUT_COST";

		// Get value of selected loadout
		_selected_cost_total = call CTI_AC_CALCULATE_CHOSEN_LOADOUT_COST;
		_selected_cost_total = _selected_cost_total + ([ _vehicle, CTI_SERVICE_PRICE_REAMMO, CTI_SERVICE_PRICE_REAMMO_COEF] call CTI_UI_Service_GetPrice);
		_text_to_display = format [ "%1<t size='1' color='#CCFFFF'>Mounted    $: %2</t><br />" , _text_to_display , _current_value ];
		_text_to_display = format [ "%1<t size='1' color='#CCFFFF'>Selected    $: %2</t><br />" , _text_to_display , _selected_cost_total ];
		_text_to_display = format [ "%1<t size='1' color='#CCFFFF'>------------------------------</t><br />" , _text_to_display , _current_value ];
		_difference = ( _current_value - _selected_cost_total );
		_signage = '';
		_colour = 'FF0000';
		if ( _difference > 0 ) then
		{
			_signage='+';
			_colour = '0099FF';
		};
		if ( _difference == 0 ) then
		{
			_signage='';
			_colour = 'FFFFFF';
		};

		_text_to_display = format [ "%1<t size='1' color='#FFFFFF'>Difference  $: " , _text_to_display ];
		_text_to_display = format [ "%1<t size='1' color='#%4'>%2%3</t><br />" , _text_to_display , _signage , _difference , _colour ];


	}
	else
	{
		_text_to_display = format [ "%1<t size='0.9' color='#FF0000'>  **     YOU DO NOT OWN THIS VEHICLE    **<br />" , _text_to_display ];
		_text_to_display = format [ "%1<t size='0.9' color='#FF0000'>  ** Customisation will not be possible **<br />" , _text_to_display ];
	};

	((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl CTI_AC_UI_IDC_LOADOUT_DISPLAY ) ctrlSetStructuredText parseText ( _text_to_display );
};


CTI_AC_SET_UI_WEAPON_MOUNTS_FIRST_CHOICE =
{
	/*
	 * Name: CTI_AC_SET_UI_WEAPON_MOUNTS_FIRST_CHOICE
	 *
	 * Purpose: Sets all the available weapon mount points to their first
	 *          choice in the list.
	 *
	 * Input: <NONE>
	 *
	 * Return: <NONE>
	 *
	 * Side effects: Each weapon mount point combo-box will be set to their
	 *               first option. Note this can trigger "events" attached
	 *               to each combo box in the same way a user clicking it would.
	 *
	*/
	{
		// Only if it contains elements ...
		if ( ( lbSize _x ) > 0 ) then
		{
			lbSetCurSel [_x, 0];
		};
	} forEach ( CTI_AC_UI_ALL_WEAPON_COMBOBOX_IDCS );
};


CTI_AC_SET_UI_LOADOUT_FIRST_CHOICE =
{
	/*
	 * Name: CTI_AC_SET_UI_LOADOUT_FIRST_CHOICE
	 *
	 * Purpose: Sets the loadout combo box to the first available choice.
	 *
	 * Input: <NONE>
	 *
	 * Return: <NONE>
	 *
	 * Side effects: Loadout combo box will be set to the
	 *               first option. Note this can trigger "events" attached
	 *               to each combo box in the same way a user clicking it would.
	 *
	*/
	lbSetCurSel [ CTI_AC_UI_LOADOUT_SELECT_LIST_IDC , 0];
};


CTI_AC_SET_UI_MAGAZINES_MOUNTS_FIRST_CHOICE =
{
	/*
	 * Name: CTI_AC_SET_UI_MAGAZINES_MOUNTS_FIRST_CHOICE
	 *
	 * Purpose: Sets all the available magazine mount points to their first
	 *          choice in the list.
	 *
	 * Input: <NONE>
	 *
	 * Return: <NONE>
	 *
	 * Side effects: Each magazine mount point combo-box will be set to their
	 *               first option. Note this can trigger "events" attached
	 *               to each combo box in the same way a user clicking it would.
	 *
	*/
	{
		// Only if it contains elements ...
		if ( ( lbSize _x ) > 0 ) then
		{
			lbSetCurSel [_x, 0];
		};
	} forEach ( CTI_AC_UI_ALL_MAGAZINE_COMBOBOX_IDCS );
};


CTI_AC_UNSET_UI_ALL_MOUNT_BUTTONS =
{
	/*
	 * Name: CTI_AC_UNSET_UI_ALL_MOUNT_BUTTONS
	 *
	 * Purpose: Unsets all the mount buttons by setting their text to 'YES' where it was once
	 *          set to 'NO'
	 *
	 * Input: <NONE>
	 *
	 * Return: <NONE>
	 *
	 * Side effects: Each mount button will be set to YES with the exclusion of those with the value
	 *				 of 'N/A'
	 *
	*/
	{
		// Only if it's a researched item ...
		if ( ( ctrlText _control ) != "N/A" ) then
		{
			_control = ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( _x ));
			_control ctrlSetTextColor CTI_AC_UI_COLOR_GREENYES;
			_control ctrlSetText "YES";
		};
	} forEach ( CTI_AC_UI_ALL_WEAPON_CHECKBOX_IDCS );
};


CTI_AC_UI_WEAPON_MOUNT_BUTTON_IS_SET =
{
	/*
	 * Name: CTI_AC_UI_WEAPON_MOUNT_BUTTON_IS_SET
	 *
	 * Purpose: Returns whether a weapon mount point has been it's button selected for mounting.
	 *
	 * Input:  _relative_index => Relative index of the button, countin from the top as position 0.
	 *
	 * Return: _return => Boolean value denoting if weapon point selected for mounting.
	 *
	 * Side effects: <NONE>
	 *
	*/

	_relative_index = _this;
	_control = ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_CHECKBOX_START_IDC + _relative_index ));
	_return = false;

	// Only if visible and set to the value of yes ... then return true
	if ( ( ( ctrlText _control  ) == "YES" ) && ( ctrlShown _control ) ) then
	{
		_return = true;
	};
	_return
};

CTI_AC_UPDATE_UI_VEHICLE_SELECT_LIST =
{
	/*
	 * Name: CTI_AC_UPDATE_UI_VEHICLE_SELECT_LIST
	 *
	 * Purpose: Update the vehicle list available for weapon customisation.
	 *
	 * Input: <NONE>
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/

	// Get the locations of the ammo replenishing vehicles and structures
	_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
	_repair_depots = [CTI_REPAIR, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;
	_ammo_depots = [CTI_AMMO, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;

	// Get the vehicles from this players team
	_list = [group player, false] Call CTI_CO_FNC_GetTeamVehicles;
	{if ( (vehicle _x == _x ) && ( local ( vehicle _x ) )) then {_list pushback _x}} forEach units player;

	// Only ammo depots permit weapon customisation
	_available_ammo_depots = [vehicle player, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;

	// Check distance against the depot and get those vehicles near the depot
	{
		_range = _x select 1;
		{
			{
				if !(_x in _list) then {_list pushBack _x};
			} forEach (_x nearEntities [["Car", "Ship", "Motorcycle", "Tank", "Air", "StaticWeapon"], _range]);
		} forEach (_x select 0);
	} forEach [[_available_ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE]];

	_list_real = [];

	{ // Loop through each vehicle in range of a ammo/repair building/vehicle


		_load_content = false;
		if (_x isKindOf "Air") then
		{
			_vehicle = vehicle _x;
			_available_ammo_depots = [_vehicle, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
			if (count _available_ammo_depots > 0 ) then { _load_content = true };
		};

		if (_load_content) then
		{ //--- Load in the list
			_list_real pushBack _x;

			// Applies only to aircraft
			if (_x isKindOf "Air") then
			{
				_vehicle = vehicle _x;
				_var_name = if (isNil {_vehicle getVariable "cti_customid"}) then {typeOf _vehicle} else {missionNamespace getVariable format["CTI_CUSTOM_ENTITY_%1", _vehicle getVariable "cti_customid"]};
				_var_classname = missionNamespace getVariable _var_name;
				_label = if !(isNil '_var_classname') then {_var_classname select CTI_UNIT_LABEL} else {getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")};
				_crew = crew _vehicle;
				_digits = "";
				if (count _crew > 0 && group _vehicle == group player) then
				{
					_digit_parsed = [];
					{if (group _x == group player) then {_digit_parsed pushback (_x call CTI_CL_FNC_GetAIDigit)}} forEach _crew;
					{
						if (_forEachIndex >= 3) exitWith {_digits = _digits + "..."};
						_digits = _digits + (_x);
						if (_forEachIndex < (count _digit_parsed)-1 && _forEachIndex < 2) then {_digits = _digits + ","};
					} forEach _digit_parsed;
					if (_digits != "") then {_digits = format["[%1] ",_digits]};
				};
				((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl CTI_AC_UI_VEHICLE_SELECT_LIST_IDC ) lnbAddRow [_digits+_label];
			};
		};
	} forEach _list;

	// Save list of vehicles
	uiNamespace setVariable ["CTI_AC_DIALOG_UI_AC_LOADOUT_MENU_VEHICLE_LIST", _list_real];
};

CTI_AC_UI_CLEAR_ALL_PREVIOUS_CHOICES =
{
	/*
	 * Name: CTI_AC_UPDATE_UI_VEHICLE_SELECT_LIST
	 *
	 * Purpose: Clears all global variables associated with AC UI
	 *
	 * Input: <NONE>
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/

	// Clear selected vehicle
	uiNamespace setVariable ["CTI_AC_DIALOG_UI_AC_LOADOUT_MENU_VEHICLE_LIST", nil];
};


CTI_AC_UI_HIDE_ALL_MOUNTPOINTS =
{
	/*
	 * Name: CTI_AC_UI_HIDE_ALL_MOUNTPOINTS
	 *
	 * Purpose: Hides all the elements associated with all mount points.
	 *
	 * Input: <NONE>
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/

	for "_index" from 0 to ((count (CTI_AC_UI_ALL_MAGAZINE_COMBOBOX_IDCS))-1) do
	{
		// Hide weapon combo boxes
		((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_COMBOBOX_START_IDC + _index ) ) ctrlShow false;
		// Hide weapon combo frames
		((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_CHECKBOX_FRAMES_START_IDC + _index ) ) ctrlShow false;
		// Hide magazine combo boxes
		((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_MAGAZINE_COMBOBOX_START_IDC + _index ) ) ctrlShow false;
		// Hide magazine frames
		((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_MAGAZINE_COMBOBOX_FRAMES_START_IDC + _index ) ) ctrlShow false;
		// Hide weapon check boxes
		((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_CHECKBOX_START_IDC + _index ) ) ctrlShow false;
		// Hide weapon costs
		((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_COST_TEXTBOX_START_IDC + _index ) ) ctrlShow false;
	};
};

CTI_AC_UI_SHOW_MOUNTPOINT_N =
{
	/*
	 * Name: CTI_AC_UI_HIDE_ALL_MOUNTPOINTS
	 *
	 * Purpose: Hides all the elements associated with all mount points.
	 *
	 * Input: _n => Index of mountpoint to show.
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/
	_n = _this;
	((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_COMBOBOX_START_IDC + _n ) ) ctrlShow true;
	// Hide weapon combo frames
	((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_CHECKBOX_FRAMES_START_IDC + _n ) ) ctrlShow true;
	// Hide magazine combo boxes
	((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_MAGAZINE_COMBOBOX_START_IDC + _n ) ) ctrlShow true;
	// Hide magazine frames
	((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_MAGAZINE_COMBOBOX_FRAMES_START_IDC + _n ) ) ctrlShow true;
	// Hide weapon check boxes
	((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_CHECKBOX_START_IDC + _n ) ) ctrlShow true;
	// Hide weapon costs
	((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_COST_TEXTBOX_START_IDC + _n ) ) ctrlShow true;
};


CTI_AC_UPDATE_UI_LOADOUT_OPTIONS =
{
	/*
	 * Name: CTI_AC_UPDATE_UI_LOADOUT_OPTIONS
	 *
	 * Purpose: Hides all the elements associated with all mount points.
	 *
	 * Input: _vehicle => Vehicle to read loadout options from
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/

	_vehicle = _this;

	// Grab vehicle type
	_typeOfValue = typeOf _vehicle;

	// Grab the weapon configurations available for the vehicle
	_gun_configs = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , _typeOfValue ] );

	// Clear loadout menu
	lbClear ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl CTI_AC_UI_LOADOUT_SELECT_LIST_IDC );

	_loudout_values = [];
	for [ {_index_loadout = 0},{ _index_loadout < ( count ( _gun_configs ))},{ _index_loadout = _index_loadout + 1}] do
	{
		_loadout_name = (_gun_configs select _index_loadout) select 0;

		((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl CTI_AC_UI_LOADOUT_SELECT_LIST_IDC ) lbAdd _loadout_name;

	};

};


CTI_AC_UPDATE_UI_WEAPON_OPTIONS =
{
	/*
	 * Name: CTI_AC_UPDATE_UI_WEAPON_OPTIONS
	 *
	 * Purpose: Update the weapon drop boxes based on the vehicle loadout chosen
	 *
	 * Input: _vehicle => Vehicle to read loadout options from
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/
	_vehicle = _this;

	_typeOfValue = typeOf _vehicle;

	_changeto = ( call CTI_AC_UI_GET_SELECTED_LOADOUT_INDEX );

	// Grab the weapon configurations available for the vehicle
	_gun_configs = missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , _typeOfValue ] );

	// Extract weapon options for chosen loadout
	_selected_weapon_config =  (_gun_configs select _changeto) select 2;


	// Loop through each mount point
	for [ {_index_mount = 0},{ _index_mount < ( count ( _selected_weapon_config ))},{ _index_mount = _index_mount + 1}] do
	{
		// Display mount point elements
		_index_mount call CTI_AC_UI_SHOW_MOUNTPOINT_N;

		// Clear the weapon combobox
		lbClear ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_COMBOBOX_START_IDC + ( _index_mount ) ) );

		// Extract list of weapon options for mount point
		_weapon_options = _selected_weapon_config select _index_mount;

		// Loop through each weapon option for this mount point
		for [ {_index_weapon = 0},{ _index_weapon < ( count ( _weapon_options ))},{ _index_weapon = _index_weapon + 2}] do
		{
			// Extract weapon name
			_weapon_classname = (_weapon_options select _index_weapon) select 0;
			
			_weapon_name = _weapon_classname;
			if((_weapon_classname find "Pylon") == -1) then {
				_weapon_name = getText ( configFile >> "CfgWeapons" >> _weapon_classname >> "displayName" );
			};
			if(_weapon_name == "FakeHorn") then {
				_weapon_name = "Weapon Safty";
			};
			
			// Add to weapon mount point combobox
			((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_COMBOBOX_START_IDC + _index_mount )) lbAdd _weapon_name;
		};

	};

};


CTI_AC_UI_GET_SELECTED_VEHICLE_LIST_ROW_COUNT =
{
	/*
	 * Name: CTI_AC_UI_GET_SELECTED_VEHICLE_LIST_ROW_COUNT
	 *
	 * Purpose: Returns the number of rows in the vehicle select list
	 *
	 * Input: <NONE>
	 *
	 * Return: _rows => Returns the number of rows
	 *
	 * Side effects: <NONE>
	 *
	*/
	_rows = lnbCurSelRow CTI_AC_UI_VEHICLE_SELECT_LIST_IDC;
	_rows
};

CTI_AC_UI_GET_SELECTED_VEHICLE =
{
	/*
	 * Name: CTI_AC_UI_GET_SELECTED_VEHICLE
	 *
	 * Purpose: Returns the vehicle currently selected in the vehicle select list of the AC menu
	 *
	 * Input: <NONE>
	 *
	 * Return: _selected => Returns selected vehicle
	 *
	 * Side effects: <NONE>
	 *
	*/

	//_selected_index = lnbCurSelRow CTI_AC_UI_VEHICLE_SELECT_LIST_IDC;
	//_selected = (uiNamespace getVariable "CTI_AC_DIALOG_UI_AC_LOADOUT_MENU_VEHICLE_LIST") select _selected_index;
	//_selected
	 (uiNamespace getVariable ['HAL_TARG',objnull])
};

CTI_AC_UI_GET_SELECTED_LOADOUT_INDEX =
{
	/*
	 * Name: CTI_AC_UI_GET_SELECTED_LOADOUT_INDEX
	 *
	 * Purpose: Returns the index of the selected weapon loadout
	 *
	 * Input: <NONE>
	 *
	 * Return: _selected_index => Index of selected loadout
	 *
	 * Side effects: <NONE>
	 *
	*/
	_selected_index = lbCurSel CTI_AC_UI_LOADOUT_SELECT_LIST_IDC;
	_selected_index
};

CTI_AC_UI_GET_SELECTED_WEAPON_ROW_N =
{
	/*
	 * Name: CTI_AC_UI_GET_SELECTED_WEAPON_ROW_N
	 *
	 * Purpose: Returns the selected index of a given mount point _n
	 *
	 * Input: _n => Index of mountpoint
	 *
	 * Return: _selected_index => Index of selected weapon at mount point _n
	 *
	 * Side effects: <NONE>
	 *
	*/
	_n = _this;
	_selected_index = lbCurSel ( CTI_AC_UI_WEAPON_COMBOBOX_START_IDC + _n );
	_selected_index
};

CTI_AC_UI_GET_SELECTED_MAGAZINE_ROW_N =
{
	/*
	 * Name: CTI_AC_UI_GET_SELECTED_MAGAZINE_ROW_N
	 *
	 * Purpose: Returns the selected index of a given mount point _n
	 *
	 * Input: _n => Index of mountpoint
	 *
	 * Return: _selected_index => Index of selected magazine at mount point _n
	 *
	 * Side effects: <NONE>
	 *
	*/
	_n = _this;
	_selected_index = lbCurSel ( CTI_AC_UI_MAGAZINE_COMBOBOX_START_IDC + _n );
	_selected_index
};

CTI_AC_UI_GET_SELECTED_MAGAZINE_NAME_ROW_N =
{
	/*
	 * Name: CTI_AC_UI_GET_SELECTED_MAGAZINE_NAME_ROW_N
	 *
	 * Purpose: Returns the name of the selected magazine from mount point _n
	 *
	 * Input: _n => Index of mountpoint
	 *
	 * Return: _chosen_magazine_classname => Classname of the chosen magazine
	 *
	 * Side effects: <NONE>
	 *
	*/

	_n = _this;

	_chosen_magazine_classname = "";

	// Get current selected vehicle
	_selected_vehicle = call CTI_AC_UI_GET_SELECTED_VEHICLE;

	// Get loadout options
	_vehicle_loadout_options = _selected_vehicle call CTI_AC_GET_VEHICLE_LOADOUT_OPTIONS;

	// Get the selected row from the loadout combobox
	_loadout_selected_row = ( call CTI_AC_UI_GET_SELECTED_LOADOUT_INDEX );

	// Get the selected row from weapon combobox
	_weapon_selected_row = ( _mount_row call CTI_AC_UI_GET_SELECTED_WEAPON_ROW_N );

	// Get the selected row from magazine combobox
	_magazine_selected_row = ( _mount_row call CTI_AC_UI_GET_SELECTED_MAGAZINE_ROW_N );

	if (_loadout_selected_row < count ( _vehicle_loadout_options ) ) then
	{
		_chosen_loadout = (_vehicle_loadout_options select _loadout_selected_row ) select 2;

		if ( _n < count ( _chosen_loadout ) ) then
		{
			//Weapon + Magazine
			_chosen_mount = _chosen_loadout select _n; 

			if (_weapon_selected_row < count ( _chosen_mount ) ) then
			{

				_chosen_weapon_magazine_options = (_chosen_mount select _weapon_selected_row) select 0;

				_chosen_magazine_options = ((_chosen_mount select _weapon_selected_row) select 1) select _magazine_selected_row;
				_chosen_magazine_classname = _chosen_magazine_options select 0;

			};
		};
	};

	_chosen_magazine_classname

};

CTI_AC_UI_LOCK_IF_NOT_RESEARCHED_MOUNT_N =
{

	/*
	 * Name: CTI_AC_UI_LOCK_IF_NOT_RESEARCHED_MOUNT_N
	 *
	 * Purpose: Locks a mount point if the selected magazine is part of a weapon group that is not yet
	 *          researched.
	 *
	 * Input: _n => Index of mountpoint
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/
	_n = _this;

	// Grab magazine name
	_mount_magazine_classname = _n call CTI_AC_UI_GET_SELECTED_MAGAZINE_NAME_ROW_N;

	//Obtain side upgrades
	_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;


	_disable = 0; // Track if disabled

	// Check if AA
	switch (missionNamespace getVariable "CTI_VEHICLES_AIR_AA") do
	{
		case 0: { _disable = 1; };
		case 1:
		{
			if ( ( _mount_magazine_classname in CTI_ALM_AA_RESEARCHED_MAGAZINES ) && ( ( _upgrades select CTI_UPGRADE_AIR_AA ) == 0 ) ) then
			{
				_disable = 1;
			};
		};
	};

	// Check if AT
	switch (missionNamespace getVariable "CTI_VEHICLES_AIR_AT") do
	{
		case 0: { _disable = 1; };
		case 1:
		{
			if ( ( _mount_magazine_classname in CTI_ALM_ATGM_RESEARCHED_MAGAZINES ) && ( ( _upgrades select CTI_UPGRADE_AIR_AT ) == 0 ) ) then
			{

				_disable = 1;
			};
		};
	};

	// Check if FFAR
	if ( ( _mount_magazine_classname in CTI_ALM_FFAR_RESEARCHED_MAGAZINES ) && ( ( _upgrades select CTI_UPGRADE_AIR_FFAR ) == 0 ) ) then
	{
		_disable = 1;
	};

	// Check if CM
	switch (missionNamespace getVariable "CTI_VEHICLES_AIR_CM") do
	{
		case 0: { _disable = 1; };
		case 1:
		{
			if ( ( _mount_magazine_classname in CTI_ALM_CM_RESEARCHED_MAGAZINES ) && ( ( _upgrades select CTI_UPGRADE_AIR_CM ) == 0 ) ) then
			{

				_disable = 1;
			};
		};
	};

	// Grab control for mount point button
	_control = ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_WEAPON_CHECKBOX_START_IDC + _n ));

	if ( _disable == 1 ) then
	{
		_control ctrlEnable false;
		_control ctrlSetTextColor CTI_AC_UI_COLOR_GREYNA;
		_control ctrlSetText "N/A";
	}
	else
	{
		_control ctrlEnable true;
		_control ctrlSetTextColor CTI_AC_UI_COLOR_GREENYES;
		_control ctrlSetText "YES";
	};


};

CTI_AC_UI_GET_CURRENT_TEXT_COST_ROW_N =
{
	/*
	 * Name: CTI_AC_UI_GET_CURRENT_TEXT_COST_ROW_N
	 *
	 * Purpose: Returns the cost of the currently selected mount at _n
	 *
	 * Input: _n => Index of mountpoint
	 *
	 * Return: Cost of mounting options at _n
	 *
	 * Side effects: <NONE>
	 *
	*/
	_n = _this;
	_text = ctrlText ( CTI_AC_UI_COST_TEXT_START_IDC + _n );
	_text
};


CTI_AC_UI_SET_TEXT_COST_ROW_N =
{
	/*
	 * Name: CTI_AC_UI_GET_CURRENT_TEXT_COST_ROW_N
	 *
	 * Purpose: Sets the cost text box at mount point _n
	 *
	 * Input: _newtext => New text
	 *        _n => Index of mountpoint
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/
	_newtext = _this select 0;
	_n = _this select 1;
	_cost_text_control = ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( CTI_AC_UI_COST_TEXT_START_IDC + _n ));
	_cost_text_control ctrlSetText format [ "%1" , _newtext ];
};

CTI_AC_UI_UPDATE_TEXT_COST_ROW_N =
{

	/*
	 * Name: CTI_AC_UI_UPDATE_TEXT_COST_ROW_N
	 *
	 * Purpose: Updates the cost text field of a mount point _n
	 *
	 * Input: _n => Index of mountpoint
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/
	_n = _this;

	// Get current selected vehicle
	_selected_vehicle = call CTI_AC_UI_GET_SELECTED_VEHICLE;

	// Get loadout options
	_vehicle_loadout_options = _selected_vehicle call CTI_AC_GET_VEHICLE_LOADOUT_OPTIONS;

	// Get the selected row from the loadout combobox
	_loadout_selected_row = ( call CTI_AC_UI_GET_SELECTED_LOADOUT_INDEX );

	// Get the selected row from weapon combobox
	_weapon_selected_row = ( _mount_row call CTI_AC_UI_GET_SELECTED_WEAPON_ROW_N );

	// Get the selected row from magazine combobox
	_magazine_selected_row = ( _mount_row call CTI_AC_UI_GET_SELECTED_MAGAZINE_ROW_N );

	_chosen_loadout_name = (_vehicle_loadout_options select _loadout_selected_row) select 0;

	_chosen_loadout = (_vehicle_loadout_options select _loadout_selected_row) select 2;

	_chosen_magazine_cost = 0;
	//TODO: adjust array access
	if ( _n < count ( _chosen_loadout ) ) then
	{
		_chosen_mount = _chosen_loadout select _n;

		_chosen_weapon_classname = (_chosen_mount select _weapon_selected_row) select 0;

		_chosen_weapon_magazine_options = (_chosen_mount select _weapon_selected_row) select 1;

		_chosen_magazine_options = _chosen_weapon_magazine_options select _magazine_selected_row;

		_chosen_magazine_classname = _chosen_magazine_options select 0;

		_chosen_magazine_cost = _chosen_magazine_options select 1;
	};

	// Update cost of mount row
	[ _chosen_magazine_cost , _mount_row ] call CTI_AC_UI_SET_TEXT_COST_ROW_N;
};

CTI_AC_GET_WEAPON_DISPLAY_NAME =
{
	/*
	 * Name: CTI_AC_GET_WEAPON_DISPLAY_NAME
	 *
	 * Purpose: Gets a string of a weapon type
	 *
	 * Input: _weapon_classname => Weapon classname to generate display name from
	 *
	 * Return: _weapon_name => Weapon display name as a string
	 *
	 * Side effects: <NONE>
	 *
	*/

	_weapon_classname = _this;
	_weapon_name = _weapon_classname;
	if((_weapon_classname find "Pylons") == -1) then {
		_weapon_name = getText ( configFile >> "CfgWeapons" >> _weapon_classname >> "displayName" );
	};
	_weapon_name
};


// CANDIDATES FOR MIGRATION TO OTHER .sqf file ... possiblye a COMMON / FUNCTIONS ?

CTI_AC_GET_VEHICLE_LOADOUT_OPTIONS =
{
	/*
	 * Name: CTI_AC_GET_VEHICLE_LOADOUT_OPTIONS
	 *
	 * Purpose: Gets the available weapon options for a given vehicle type
	 *
	 * Input: _vehicle => Vehicle to get list of weapon options for.
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/

	_vehicle = _this;

	missionNamespace getVariable ( format [ "CTI_LOADOUT_%1_MNT_OPTIONS" , ( typeOf _vehicle ) ] );
};

CTI_AC_ACCEPT_VEHICLE_LOADOUT =
{
	/*
	 * Name: CTI_AC_ACCEPT_VEHICLE_LOADOUT
	 *
	 * Purpose: Updates the cost text field of a mount point _n
	 *
	 * Input: _n => Index of mountpoint
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/

	_selected = _this;

	_loadout_details = [];

	// Determine the chosen loadout index
	_selected_loadout_index = ( lbCurSel CTI_AC_UI_LOADOUT_SELECT_LIST_IDC);

	// Add the loadout index
	_loadout_details = _loadout_details + [ _selected_loadout_index ];

	// Get the weapons for each of the mounts
	{
		_weapon_combobox_idc = _x;

		// Check if mount point is visible
		if ( ctrlShown ((uiNamespace getVariable "cti_dialog_ui_aircraftloadoutmenu") displayCtrl ( _weapon_combobox_idc )) ) then
		{

			_index_position = (_weapon_combobox_idc - CTI_AC_UI_WEAPON_COMBOBOX_START_IDC );
			_magazine_combobox_idc = _index_position + CTI_AC_UI_MAGAZINE_COMBOBOX_START_IDC;
			_selected_weapon_index = lbCurSel _weapon_combobox_idc;
			_selected_magazine_index = lbCurSel _magazine_combobox_idc;
			_mount_set = _index_position call CTI_AC_UI_WEAPON_MOUNT_BUTTON_IS_SET;


			_loadout_details pushback ( [ _selected_weapon_index , _selected_magazine_index , _mount_set ] ) ;
		};
	} forEach ( CTI_AC_UI_ALL_WEAPON_COMBOBOX_IDCS );


	_selected setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_MOUNTED" , _loadout_details , true ];
};

CTI_AC_PURGE_ALL_WEAPONS =
{
	/*
	 * Name: CTI_AC_PURGE_ALL_WEAPONS
	 *
	 * Purpose: Purges all weapons from selected vehicle
	 *
	 * Input: _vehicle => Vehicle to purge weapons from
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
	_all_mountpoint_options = (_gun_configs select _loadout_index) select 2;

	_turret_skip_list = [];

	// Loop through each mount point
	for [ {_mount_index = 0},{ _mount_index < ( count ( _all_mountpoint_options ))},{ _mount_index = _mount_index + 1}] do
	{

		//Get options for mountpoint
		_a_mountpoint_options = _all_mountpoint_options select _mount_index;

		// Extract chosen mountpoint options
		_mount_loadout = _loadout_selections select ( _mount_index + 1 );
		_mount_loadout_weapon_index = _mount_loadout select 0;
		_mount_loadout_magazine_index = _mount_loadout select 1;
		_mount_loadout_enabled  = _mount_loadout select 2;
		
		_magazine_options = (( _a_mountpoint_options select ( _mount_loadout_weapon_index)) select 1) select ( _mount_loadout_magazine_index );
		_magazine_classname = _magazine_options select 0;

		//Get chosen weapon and magazine classnames
		_weapon_classname = (_a_mountpoint_options select _mount_loadout_weapon_index) select 0;
		//Mounts pylon, not weapon
		if((_weapon_classname find "Pylon") >= 0) then {
			_vehicle setPylonLoadOut [_weapon_classname, ""]; 
		} else {
			if ( count ( _magazine_options ) > 2 ) then
			{

				_turret_position = ( _magazine_options select 2 );

				if ( local _vehicle ) then
				{
					if ( ( not ( _vehicle turretLocal _turret_position ) ) && ( not ( _turret_position in _turret_skip_list ) ) ) then
					{
						// If position held by other player's unit
						_unit_in_turret = _vehicle turretUnit ( _turret_position );

						_turret_skip_list = _turret_skip_list + _turret_position;

						[["CLIENT", leader _unit_in_turret], "Client_PurgeWeaponsOnAVehicle", [_vehicle]] call CTI_CO_FNC_NetSend;

					};
				};

				// No harm to always try to remove just in case
				_vehicle removeMagazineTurret [ _magazine_classname , _turret_position ];
				_vehicle removeWeaponTurret [ _weapon_classname , _turret_position ];

			}
			else
			{
				_default_turret_position = [0];

				if ( local _vehicle ) then
				{
					_is_local_turret = _vehicle turretLocal _default_turret_position;

					if ( _default_turret_position in ( allTurrets [ _vehicle , true ] ) ) then
					{
						if ( ( not ( _is_local_turret ) ) && ( not ( _default_turret_position in _turret_skip_list ) ) ) then
						{
							// If position held by other player's unit
							_unit_in_turret = _vehicle turretUnit ( _default_turret_position );

							_turret_skip_list = _turret_skip_list + _default_turret_position;

							[["CLIENT", leader _unit_in_turret], "Client_PurgeWeaponsOnAVehicle", [_vehicle]] call CTI_CO_FNC_NetSend;

						};
					};
				};
				_vehicle removeMagazineGlobal _magazine_classname;
				_vehicle removeWeaponGlobal _weapon_classname;
			};
		};

	};

	// Remove all current weapons
	{
		_vehicle removeWeaponGlobal _x;
	} foreach ( weapons _vehicle );

	// Remove all current magazines
	{
		_vehicle removeMagazineGlobal _x;
	} foreach ( magazines _vehicle );

};

CTI_AC_CALCULATE_CHOSEN_LOADOUT_COST =
{

	/*
	 * Name: CTI_AC_CALCULATE_CHOSEN_LOADOUT_COST
	 *
	 * Purpose: Calculates the total cost of accepting the chosen mounts
	 *
	 * Input: <NONE>
	 *
	 * Return: _total_cost => Total cost of chosen mount points
	 *
	 * Side effects: <NONE>
	 *
	*/

	_total_cost = 0;

	// Loop through each visible mount point
	for [ { _mount_row = 0 },{ _mount_row < ( count ( CTI_AC_UI_ALL_COST_TEXTBOX_IDCS ) ) },{ _mount_row = _mount_row + 1 } ] do
	{
		// Add the cost if the checkbox is set and visible
		if ( _mount_row call CTI_AC_UI_WEAPON_MOUNT_BUTTON_IS_SET ) then
		{
			_total_cost = _total_cost + parseNumber ( _mount_row call CTI_AC_UI_GET_CURRENT_TEXT_COST_ROW_N );
		};
	};
	_total_cost
};

CTI_AC_ACQUIRE_BUSY_LOCK =
{
	/*
	 * Name: CTI_AC_ACQUIRE_BUSY_LOCK
	 *
	 * Purpose: Locks the vehicle from further actions until unlock.
	 *
	 * Input: <NONE>
	 *
	 * Return: _return => boolean as to wether lock has been acquired
	 *
	 * Side effects: <NONE>
	 *
	*/
	_return = false;

	if  ( ( isNil { _this getVariable "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY" } ) || ( ! ( _this getVariable "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY" ) ) ) then
	{
		_this setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY_TIME" , serverTime , true ];
		_this setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY" , true , true ];
		_return = true;
	}
	else
	{
		//Force unlock/lock if it has been locked for longer than 'CTI_AC_FORCE_UNLOCK_TIME' seconds
		_time_difference = ( serverTime - ( _this getVariable "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY_TIME" ) );

		if ( _time_difference >= CTI_AC_FORCE_UNLOCK_TIME ) then
		{
			_this setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY_TIME" , serverTime , true ];
			_this setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY" , true , true ];
			_return = true;
		};
	};
	_return
};


CTI_AC_RELEASE_BUSY_LOCK =
{
	/*
	 * Name: CTI_AC_RELEASE_BUSY_LOCK
	 *
	 * Purpose: Releases the busy lock on vehicle.
	 *
	 * Input: <NONE>
	 *
	 * Return: <NONE>
	 *
	 * Side effects: <NONE>
	 *
	*/
	_this setVariable [ "CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY" , false , true ];
	_return = true;
	_return
};


CTI_AC_GET_MAGAZINE_DISPLAY_NAME =
{
	/*
	 * Name: CTI_AC_GET_MAGAZINE_DISPLAY_NAME
	 *
	 * Purpose: Gets a string of a magazine type
	 *
	 * Input: _magazine_classname => Magazine classname to generate display name from
	 *
	 * Return: _return => Magazine display name as a string
	 *
	 * Side effects: <NONE>
	 *
	*/

	_magazine_classname = _this;
	_magazine_name = getText ( configFile >> "CfgMagazines" >> _magazine_classname >> "displayName" );
	_magazine_count = getNumber ( configFile >> "CfgMagazines" >> _magazine_classname >> "count" );
	if ( _magazine_name == "" ) then { _magazine_name = getText ( configFile >> "CfgMagazines" >> _magazine_classname >> "displayNameShort" ); };
	if ( _magazine_name == "" ) then { _magazine_name = "Rounds" };
	_magazine_name = format [ "%1 x %2" , _magazine_count , _magazine_name ];
	_magazine_name
};


// Debug function
// Credit to: https://community.bistudio.com/wiki/User:DenV
// Found: https://community.bistudio.com/wiki/weaponsTurret
 funcGetTurretsWeapons = {
     private ["_result", "_getAnyMagazines", "_findRecurse", "_class"];
     _result = [];
	 if((_this find "Pylon") == -1) then {
		 _getAnyMagazines = {
			 private ["_weapon", "_mags"];
			 _weapon = configFile >> "CfgWeapons" >> _this;
			 _mags = [];
			 {
				 _mags = _mags + getArray (
					 (if (_x == "this") then { _weapon } else { _weapon >> _x }) >> "magazines"
				 )
			 } foreach getArray (_weapon >> "muzzles");
			 _mags
		 };
		 _findRecurse = {
			 private ["_root", "_class", "_path", "_currentPath"];
			 _root = (_this select 0);
			 _path = +(_this select 1);
			 for "_i" from 0 to count _root -1 do {
				 _class = _root select _i;
				 if (isClass _class) then {
					 _currentPath = _path + [_i];
					 {
						 _result set [count _result, [_x, _x call _getAnyMagazines, _currentPath, str _class]];
					 } foreach getArray (_class >> "weapons");
					 _class = _class >> "turrets";
					 if (isClass _class) then {
						 [_class, _currentPath] call _findRecurse;
					 };
				 };
			 };
		 };
		 _class = (
			 configFile >> "CfgVehicles" >> (
				 switch (typeName _this) do {
					 case "STRING" : {_this};
					 case "OBJECT" : {typeOf _this};
					 default {nil};
				 }
			 ) >> "turrets"
		 );
		 [_class, []] call _findRecurse;
	 };
     _result;
	 
 };

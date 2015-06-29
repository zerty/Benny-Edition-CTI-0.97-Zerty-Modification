_templates = profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined];

_side_gear = missionNamespace getVariable "cti_gear_all";

//--- Attempt to load the "proper" templates
_list = [];
if (typeName _templates == "ARRAY") then { //--- The variable itself is an array
	{
		_flag_load = true;
		// [_label, _picture, _cost, _x]
		if (typeName _x == "ARRAY") then { //--- Each items are arrays >> [_label, _picture, _cost, _x, upgrade]
			_gear = _x select 3;
			if (typeName (_x select 0) == "STRING" && typeName (_x select 1) == "STRING" && typeName _gear == "ARRAY") then { //--- The label is a string, the picture is a string and the template is an array. Cost and upgrade are re-calculated at the end to prevent third party modification
				if (count _gear == 4) then { //--- Make sure that we have the sections (weapons/container+mags/equipment/equipment2)
					_flag_load = true;

					//--- #1 Now the party begin! first we check the weapons (primary/secondary/handgun)
					_gear_sub = _gear select 0;
					if (typeName _gear_sub == "ARRAY") then { //--- The weapons items are stored in an array >> [["arifle_mxc_f",["","acc_pointer_ir","optic_Aco"],["30rnd_65x39_caseless_mag"]],["launch_nlaw_f",[],["nlaw_f"]],["",[],[]]]
						{
							//--- Check that the weapon... is a weapon! >> ["arifle_mxc_f",["","acc_pointer_ir","optic_Aco"],["30rnd_65x39_caseless_mag"]]
							if (typeName _x == "ARRAY") then {
								if (count _x == 3) then { //--- Make sure that we have the weapon/accessories/current magazine
									_weapon = toLower(_x select 0);
									_accessories = (_x select 1) call CTI_CO_FNC_ArrayToLower;
									_magazine = (_x select 2) call CTI_CO_FNC_ArrayToLower;

									if (typeName _weapon == "STRING" && typeName _accessories == "ARRAY" && typeName _magazine == "ARRAY") then { //--- The data format is valid
										if ((!isClass (configFile >> "CfgWeapons" >> _weapon) || !(_weapon in _side_gear)) && _weapon != "") exitWith {_flag_load = false}; //--- Abort if: the weapon is invalid or if it's not within the side's owned templates
										if (!(getNumber(configFile >> "CfgWeapons" >> _weapon >> "type") in [CTI_TYPE_RIFLE,CTI_TYPE_PISTOL,CTI_TYPE_LAUNCHER,CTI_TYPE_RIFLE2H]) && _weapon != "") exitWith {_flag_load = false}; //--- Make sure that the weapon is a weapon

										if !(count _accessories in [0,4]) exitWith {_flag_load = false}; //--- The data format is invalid for the accesories
										{
											if (typeName _x == "STRING") then { //--- The accessory is a string
												if (_x != "") then { //--- Empty accessories are skipped
													if (!isClass (configFile >> "CfgWeapons" >> _x) || !(_x in _side_gear)) exitWith {_flag_load = false}; //--- The accessory ain't valid or it's not within the side's gear
													if (getNumber(configFile >> "CfgWeapons" >> _x >> "type") != CTI_TYPE_ITEM) exitWith {_flag_load = false}; //--- The accessory is not a valid base class!
													if !(getNumber(configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "type") in [CTI_SUBTYPE_ACC_MUZZLE,CTI_SUBTYPE_ACC_OPTIC,CTI_SUBTYPE_ACC_SIDE,CTI_SUBTYPE_ACC_BIPOD]) exitWith {_flag_load = false}; //--- The accessory is not a valid base class (we don't care bout the order)!
												};
											};
											if !(_flag_load) exitWith {};
										} forEach _accessories;
										if !(_flag_load) exitWith {}; //--- Something went wrong with the accessories

										if !(count _magazine in [0,1]) exitWith {_flag_load = false};
										if (count _magazine == 1) then { //--- Make sure that the magazine is valid
											_magazine = _magazine select 0;
											if (!isClass (configFile >> "CfgMagazines" >> _magazine) || !(_magazine in _side_gear)) exitWith {_flag_load = false};
										};
										if !(_flag_load) exitWith {}; //--- Something went wrong with the magazine
									} else {
										_flag_load = false;
									};
								} else {
									_flag_load = false;
								};
							} else {
								_flag_load = false;
							};

							if !(_flag_load) exitWith {}; //--- Something went wrong with the process
						} forEach _gear_sub;
					} else {
						_flag_load = false;
					};
					if (_flag_load) then {
						//--- #2 then we check the containers (uniform/vest/backpack)
						_gear_sub = _gear select 1;

						if (typeName _gear_sub == "ARRAY") then { //--- The weapons items are stored in an array >> [["u_b_combatuniform_mcam",[]],["v_platecarrier1_rgr",[]],["b_assaultpack_mcamo",["firstaidkit","firstaidkit","handgr...
							if (count _gear_sub == 3) then { //--- Make sure that we have the sections (uniform/vest/backpack)
								{
									if (typeName _x == "ARRAY") then {
										if (count _x == 2) then { //--- Each array need to have the container and the items
											if (typeName (_x select 0) == "STRING" && typeName (_x select 1) == "ARRAY") then { //--- The container is a string, the items are an array
												_container = toLower(_x select 0);
												_items = (_x select 1) call CTI_CO_FNC_ArrayToLower;

												if (_container != "") then { //--- If the container is empty, we don't bother any further
													switch (true) do {
														case (_forEachIndex in [0,1]): { //--- Uniform & vest
															if (!isClass (configFile >> "CfgWeapons" >> _container) || !(_container in _side_gear)) exitWith {_flag_load = false}; //--- Abort if: the container is invalid or if it's not within the side's owned templates
															if (getNumber(configFile >> "CfgWeapons" >> _container >> "type") != CTI_TYPE_ITEM) exitWith {_flag_load = false}; //--- The container is not a valid base class!
															if !(getNumber(configFile >> "CfgWeapons" >> _container >> "ItemInfo" >> "type") in [CTI_SUBTYPE_UNIFORM,CTI_SUBTYPE_VEST]) exitWith {_flag_load = false}; //--- The container is not a valid uniform/vest
														};
														case (_forEachIndex == 2): { //--- Backpack
															if (!isClass (configFile >> "CfgVehicles" >> _container) || !(_container in _side_gear)) exitWith {_flag_load = false}; //--- Abort if: the container is invalid or if it's not within the side's owned templates
															if (getNumber(configFile >> "CfgVehicles" >> _container >> "isbackpack") != 1) exitWith {_flag_load = false}; //--- The container is not a valid backpack
														};
													};

													if !(_flag_load) exitWith {}; //--- Something went wrong with the container

													//--- We check the items sanity now
													{
														if (typeName _x != "STRING") exitWith {_flag_load = false};
														_config_type = switch (true) do { //--- Determine the kind of item that we're dealing with
															case (isClass (configFile >> "CfgWeapons" >> _x)): {"CfgWeapons"};
															case (isClass (configFile >> "CfgMagazines" >> _x)): {"CfgMagazines"};
															case (isClass (configFile >> "CfgVehicles" >> _x)): {"CfgVehicles"};
															case (isClass (configFile >> "CfgGlasses" >> _x)): {"CfgGlasses"};
															default {"nil"};
														};

														if (_config_type == "nil") exitWith {_flag_load = false};
													} forEach _items;
												};

												if !(_flag_load) exitWith {};
											} else {
												_flag_load = false;
											};
										} else {
											_flag_load = false;
										};
									} else {
										_flag_load = false;
									};
								} forEach _gear_sub;
							} else {
								_flag_load = false;
							};
						}  else {
							_flag_load = false;
						};
					};
					if (_flag_load) then {
						//--- #3 next we check the head equipment (helm/goggles)
						_gear_sub = _gear select 2;

						if (typeName _gear_sub == "ARRAY") then {
							if (count _gear_sub == 2) then {
								_helm = _gear_sub select 0;
								_goggles = _gear_sub select 1;

								if (_helm != "") then {
									if (!isClass (configFile >> "CfgWeapons" >> _helm) || !(_helm in _side_gear)) exitWith {_flag_load = false}; //--- The helm ain't valid or it's not within the side's gear
									if (getNumber(configFile >> "CfgWeapons" >> _helm >> "type") != CTI_TYPE_ITEM) exitWith {_flag_load = false}; //--- The helm do not have a valid base class!
									if (getNumber(configFile >> "CfgWeapons" >> _helm >> "ItemInfo" >> "type") != CTI_SUBTYPE_HEADGEAR) exitWith {_flag_load = false}; //--- The helm is not a valid headgear
								};

								if !(_flag_load) exitWith {};
								if ((!isClass (configFile >> "CfgGlasses" >> _goggles) || !(_goggles in _side_gear)) && _goggles != "") exitWith {_flag_load = false}; //--- The googles ain't valid or it's not within the side's gear
							} else {
								_flag_load = false;
							};
						} else {
							_flag_load = false;
						};

						if (_flag_load) then {
							//--- #4 next we check the items (binoc, nvg, items like gps)
							_gear_sub = _gear select 3;

							if (typeName _gear_sub == "ARRAY") then {
								if (count _gear_sub == 2) then {
									//--- Check nvg/binocs
									if (typeName (_gear_sub select 0) == "ARRAY") then {
										if (count(_gear_sub select 0) == 2) then {
											{
												if (typeName _x != "STRING") exitWith {_flag_load = false};
												if (_x != "") then {
													if (!isClass (configFile >> "CfgWeapons" >> _x) || !(_x in _side_gear)) exitWith {_flag_load = false}; //--- The item ain't valid or it's not within the side's gear
													if (getNumber(configFile >> "CfgWeapons" >> _x >> "type") != CTI_TYPE_EQUIPMENT ) exitWith {_flag_load = false}; //--- The item do not have a valid base class!
												};
											} forEach (_gear_sub select 0);
										} else {
											_flag_load = false;
										};
									};

									if !(_flag_load) exitWith {}; //--- Something went wrong with the binoc/nvg

									//--- Check items
									if (typeName (_gear_sub select 1) == "ARRAY") then {
										if (count(_gear_sub select 1) == 5) then {
											{
												if (typeName _x != "STRING") exitWith {_flag_load = false};
												if (_x != "") then {
													if (!isClass (configFile >> "CfgWeapons" >> _x) || !(_x in _side_gear)) exitWith { _flag_load = false}; //--- The item ain't valid or it's not within the side's gear
													if (getNumber(configFile >> "CfgWeapons" >> _x >> "type") != CTI_TYPE_ITEM) exitWith {  _flag_load = false}; //--- The item do not have a valid base class!
													if (getNumber(configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "type") != CTI_SUBTYPE_ITEM &&  ((getNumber(configFile >> 'CfgWeapons' >> _x >> 'ItemInfo' >> 'type')) !=CTI_SUBTYPE_UAVTERMINAL)) exitWith {  _flag_load = false}; //--- The item is not a valid item
												};
											} forEach (_gear_sub select 1);
										} else {
											_flag_load = false;
										};
									};
								};
							};

							if (_flag_load) then {
								_cost = 0;
								_upgrade = 0;
								_has_nil = false;

								{
									_var = missionNamespace getVariable _x;
									if !(isNil '_var') then {
										_cost = _cost + ((_var select 0) select 1);
										if (((_var select 0) select 0) > _upgrade) then {_upgrade = (_var select 0) select 0};
									} else {
										_has_nil = true;
									};
								} forEach ((_x select 3) call CTI_CO_FNC_ConvertGearToFlat);

								//--- Make sure that our template is sane
								if !(_has_nil) then {
									_x set [2, _cost];
									_x set [4, _upgrade];

									_list pushBack _x;
								} else {
									//todo diaglog error
								};
							};
						};
					};
				};
			};
		};

	} forEach _templates;
};

if (count _list > 0) then { //--- If we have more than one template then we overwrite the existing one
	missionNamespace setVariable ["cti_gear_list_templates", _list];
};
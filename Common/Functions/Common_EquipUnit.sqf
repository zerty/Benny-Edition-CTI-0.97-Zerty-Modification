/*
  # HEADER #
	Script: 		Common\Functions\Common_EquipUnit.sqf
	Alias:			CTI_CO_FNC_EquipUnit
	Description:	Equip a CTI gear variable on a unit
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013

  # PARAMETERS #
    0	[Object]: The unit to equip
    1	[Array]: A CTI gear variable

  # RETURNED VALUE #
	None

  # SYNTAX #
	[UNIT, ARRAY] call CTI_CO_FNC_EquipUnit

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayDiffers
	Common Function: CTI_CO_FNC_ArrayToLower
	Common Function: CTI_CO_FNC_EquipContainerBackpack
	Common Function: CTI_CO_FNC_EquipContainerUniform
	Common Function: CTI_CO_FNC_EquipContainerVest

  # EXAMPLE #
	_gear = [
		[["arifle_mxc_f",["","acc_pointer_ir","optic_Aco"],["30rnd_65x39_caseless_mag"]],["launch_nlaw_f",[],["nlaw_f"]],["",[],[]]],
		[["u_b_combatuniform_mcam",[]],["v_platecarrier1_rgr",[]],["b_assaultpack_mcamo",["firstaidkit","nlaw_f","nlaw_f"]]],
		["h_helmetb",""],
		[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]
	];

	[player, _gear] call CTI_CO_FNC_EquipUnit;
*/

private ["_gear", "_item", "_unit"];

_unit = _this select 0;
_gear = _this select 1;

if (_unit isKindOf "Man") then {
	//--- [Equipment check-in]
	_new = _gear select 1;

	//--- Check if the containers are ok
	if (((_gear select 1) select 2) select 0 != backpack _unit || [((_gear select 1) select 2) select 1, backpackItems _unit] call CTI_CO_FNC_ArrayDiffers) then {
		[_unit, ((_gear select 1) select 2) select 0, ((_gear select 1) select 2) select 1] call CTI_CO_FNC_EquipContainerBackpack;
	};
	if (((_gear select 1) select 1) select 0 != vest _unit || [((_gear select 1) select 1) select 1, vestItems _unit] call CTI_CO_FNC_ArrayDiffers) then {
		[_unit, ((_gear select 1) select 1) select 0, ((_gear select 1) select 1) select 1] call CTI_CO_FNC_EquipContainerVest;
	};
	/*if (((_gear select 1) select 0) select 0 != uniform _unit || [((_gear select 1) select 0) select 1, uniformItems _unit] call CTI_CO_FNC_ArrayDiffers) then {
		[_unit, ((_gear select 1) select 0) select 0, ((_gear select 1) select 0) select 1] call CTI_CO_FNC_EquipContainerUniform;
	};*/
	removeUniform _unit;
	if (( ((_gear select 1) select 0) select 0 ) != "" && uniform _unit == "") then { _unit addUniform ( ((_gear select 1) select 0) select 0 ) };


	//--- [Assigned items check-in]
	removeAllAssignedItems _unit; //--- Due to the lack of commands for some of them, we remove everything first.
	_new = _gear select 2;

	_item = _new select 0;
	if (_item != "") then {_unit addHeadgear _item} else {removeHeadgear _unit;};

	_item = _new select 1;
	if (_item != "") then {_unit addGoggles _item} else {removeGoggles _unit;};

	{ if (_x != "") then {_unit linkItem _x} } forEach ([((_gear select 3) select 0) select 0] + ((_gear select 3) select 1));

	//--- Binoculars are special, they can't be linked like the other items.
	if (((_gear select 3) select 0) select 1 != "") then {_unit addWeapon (((_gear select 3) select 0) select 1)};
	if  ((((_gear select 3) select 0) select 1) in ["Laserdesignator","Laserdesignator_02"] && ! isnull (uniformContainer _unit)) then { (uniformContainer _unit) addItemCargoGlobal ["Laserbatteries",1]} ;

	//--- [Weapons check-in]
	//--- Primary
	_new = (_gear select 0) select 0;
	_item = _new select 0;
	_accessories = (_new select 1) call CTI_CO_FNC_ArrayToLower;
	if ((count (_new select 2)) > 0 && ! isnull (uniformContainer _unit)) then  {
		_mag = (_new select 2)select 0;
		(uniformContainer _unit) addItemCargoGlobal [_mag,1] ;
	};
	// player sidechat format ["%1 %2",primaryWeapon _unit,_item];
	//if (primaryWeapon _unit != _item) then { //--- Replace
		if (primaryWeapon _unit != "") then {_unit removeWeapon (primaryWeapon _unit)};
		if (_item != "") then {
			_unit addWeapon _item;
			{if (_x != "") then {_unit addPrimaryWeaponItem _x}} forEach _accessories;
		};
	/*} else { //--- Same // disabled for magazine fix
		if (_item != "") then {
			_accessories_current = (primaryWeaponItems _unit) call CTI_CO_FNC_ArrayToLower;
			{if (!(_x in _accessories) && (_x != "")) then {_unit removePrimaryWeaponItem _x}} forEach _accessories_current;
			{if (!(_x in _accessories_current) && (_x != "")) then {_unit addPrimaryWeaponItem _x}} forEach _accessories;
		};
	};*/

	//--- Secondary - no removeSecondaryItem :(
	_new = (_gear select 0) select 1;
	_item = _new select 0;
	_accessories = (_new select 1) call CTI_CO_FNC_ArrayToLower;
	if (count (_new select 2)>0 && ! isnull (uniformContainer _unit)) then  {
		_mag = (_new select 2)select 0;
		(uniformContainer _unit) addItemCargoGlobal [_mag,1] ;
	};
	//if (secondaryWeapon _unit != _item) then { //--- Replace
		if (secondaryWeapon _unit != "") then {_unit removeWeapon (secondaryWeapon _unit)};
		if (_item != "") then {
			_unit addWeapon _item;
			{if (_x != "") then {_unit addSecondaryWeaponItem _x}} forEach _accessories;
		};
	/*} else { //--- Same// disabled for magazine fix
		if (_item != "") then {
			_accessories_current = (secondaryWeaponItems _unit) call CTI_CO_FNC_ArrayToLower;
			_replace = false;
			{if (!(_x in _accessories) && (_x != "")) then {_replace = true}} forEach _accessories_current;
			{if (!(_x in _accessories_current) && (_x != "")) then {_replace = true}} forEach _accessories;
			if (_replace) then {
				_unit removeWeapon _item;
				_unit addWeapon _item;
				{_unit addSecondaryWeaponItem _x} forEach _accessories;
			};
		};
	};*/

	//--- Handgun
	_new = (_gear select 0) select 2;
	_item = _new select 0;
	_accessories = (_new select 1) call CTI_CO_FNC_ArrayToLower;
	if (count (_new select 2)>0 && ! isnull (uniformContainer _unit) ) then  {
		_mag = (_new select 2)select 0;
		(uniformContainer _unit) addItemCargoGlobal [_mag,1] ;
	};
	//if (handgunWeapon _unit != _item) then { //--- Replace
		if (handgunWeapon _unit != "") then {_unit removeWeapon (handgunWeapon _unit)};
		if (_item != "") then {
			_unit addWeapon _item;
			{if (_x != "") then {_unit addHandgunItem _x}} forEach _accessories;
		};
	/*} else { //--- Same// disabled for magazine fix
		if (_item != "") then {
			_accessories_current = (handgunItems _unit) call CTI_CO_FNC_ArrayToLower;
			{if (!(_x in _accessories) && (_x != "")) then {_unit removeHandgunItem _x}} forEach _accessories_current;
			{if (!(_x in _accessories_current) && (_x != "")) then {_unit addHandgunItem _x}} forEach _accessories;
		};
	};*/

	//--- Muzzle
	{
		if (_x != "") exitWith {
			_muzzles = getArray (configFile >> "CfgWeapons" >> _x >> "muzzles");
			if !("this" in _muzzles) then {_unit selectWeapon (_muzzles select 0)} else {_unit selectWeapon _x};
		};
	} forEach [primaryWeapon _unit, handgunWeapon _unit, secondaryWeapon _unit];


	//--- [readd uniform]
	[_unit, ((_gear select 1) select 0) select 0, ((_gear select 1) select 0) select 1] call CTI_CO_FNC_EquipContainerUniform;

} else {
	_new_cargo=(((_gear select 1)select 2)select 1);

	_cargo=[];
	{
		_cargo=_cargo+[[_x,1]];
	} forEach _new_cargo;
	[_unit,_cargo] call CTI_CO_FNC_EquipVehicleCargoSpace;
};
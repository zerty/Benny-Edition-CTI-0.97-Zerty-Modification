private ["_cpt", "_faction", "_items", "_prices", "_upgrades"];

_faction = _this select 0;
_items = _this select 1;
_upgrades = _this select 2;
_prices = _this select 3;

_gear_accessories = [];
_gear_primary = [];
_gear_secondary = [];
_gear_pistol = [];
_gear_backpacks = [];
_gear_vests = [];
_gear_headgear = [];
_gear_glasses = [];
_gear_uniforms = [];
_gear_magazines = [];
_gear_misc = [];
_gear_special = [];
_gear_explosives = [];

_cpt = 0;

for '_i' from 0 to count(_items)-1 do {
	_item = _items select _i;
	_pushtogear = true;
	if (typeName _item == "ARRAY") then {
		_pushtogear = false;
		_item = _item select 0;
	};
	_item = toLower(_item);

	_config_type = switch (true) do { //--- Determine the kind of item that we're dealing with
		case (isClass (configFile >> 'CfgWeapons' >> _item)): {"CfgWeapons"};
		case (isClass (configFile >> 'CfgMagazines' >> _item)): {"CfgMagazines"};
		case (isClass (configFile >> 'CfgVehicles' >> _item)): {"CfgVehicles"};
		case (isClass (configFile >> 'CfgGlasses' >> _item)): {"CfgGlasses"};
		default {"nil"};
	};

	if (_config_type != "nil") then { //--- Make sure that it exists
		if (isNil {missionNamespace getVariable _item}) then {
			switch (_config_type) do { //--- Each item is handled differently
				case "CfgGlasses": {
					missionNamespace setVariable [_item, [[_upgrades select _i, _prices select _i], "Goggles", _config_type]];
					if (_pushtogear) then {_gear_glasses pushBack _item};
					_cpt = _cpt + 1;

					if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Common\Config\Gear\Gear_Config_Set.sqf", format ["Set Glasses [%1].", _item]] call CTI_CO_FNC_Log };
				};
				case "CfgMagazines": {
					missionNamespace setVariable [_item, [[_upgrades select _i, _prices select _i], "Magazines", _config_type]];

					if (_pushtogear) then {
						if (getText(configFile >> 'CfgMagazines' >> _item >> "nameSound") in ["mine", "satchelcharge"]) then {
							_gear_explosives pushBack _item;
						} else {
							_gear_magazines pushBack _item;
						};
					};
					_cpt = _cpt + 1;

					if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Common\Config\Gear\Gear_Config_Set.sqf", format ["Set Magazine [%1].", _item]] call CTI_CO_FNC_Log };
				};
				case "CfgVehicles": {
					if (getNumber(configFile >> _config_type >> _item >> 'isbackpack') == 1) then { //--- Make sure that this is a backpack
						missionNamespace setVariable [_item, [[_upgrades select _i, _prices select _i], "Backpack", _config_type]];
						if (_pushtogear) then {_gear_backpacks pushBack _item};
						_cpt = _cpt + 1;

						if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Common\Config\Gear\Gear_Config_Set.sqf", format ["Set Backpack [%1].", _item]] call CTI_CO_FNC_Log };
					};
				};
				case "CfgWeapons": {
					//--- Determine the nature
					_item_subtype = "";
					_item_type = switch (getNumber(configFile >> _config_type >> _item >> "type")) do {
						case CTI_TYPE_RIFLE: {"Rifle"};
						case CTI_TYPE_PISTOL: {"Pistol"};
						case CTI_TYPE_LAUNCHER: {"Launcher"};
						case CTI_TYPE_RIFLE2H: {"Rifle 2H"};
						case CTI_TYPE_EQUIPMENT: {"Equipment"};
						case CTI_TYPE_ITEM: {"Item"};
						default {"nil"};
					};

					if (_item_type == "Item") then { //--- Items are handled differently
						_item_subtype = switch (getNumber(configFile >> _config_type >> _item >> 'ItemInfo' >> 'type')) do {
							case CTI_SUBTYPE_ITEM: {"BaseItem"};
							case CTI_SUBTYPE_ACC_MUZZLE: {"Acc-Muzzle"};
							case CTI_SUBTYPE_ACC_OPTIC: {"Acc-Optics"};
							case CTI_SUBTYPE_ACC_SIDE: {"Acc-Side"};
							case CTI_SUBTYPE_ACC_BIPOD: {"Acc-Bipod"};
							case CTI_SUBTYPE_HEADGEAR: {"Headgear"};
							case CTI_SUBTYPE_VEST: {"Vest"};
							case CTI_SUBTYPE_UNIFORM: {"Uniform"};
							default {""};
						};

						if (_pushtogear) then {
							switch (true) do { //--- Parse
								case (_item_subtype == "Uniform"): { _gear_uniforms pushBack _item };
								case (_item_subtype == "Vest"): { _gear_vests pushBack _item };
								case (_item_subtype == "Headgear"): { _gear_headgear pushBack _item };
								case (_item_subtype in ["Acc-Muzzle", "Acc-Optics", "Acc-Side","Acc-Bipod"]): { _gear_accessories pushBack _item };
								case (_item_subtype in ["BaseItem", ""]): { _gear_misc pushBack _item };
							};
						};
					} else {
						if (_pushtogear) then {
							switch (true) do { //--- Parse
								case (_item_type in ["Rifle", "Rifle 2H"]): { _gear_primary pushBack _item  };
								case (_item_type == "Pistol"): { _gear_pistol pushBack _item  };
								case (_item_type == "Launcher"): { _gear_secondary pushBack _item  };
								case (_item_type == "Equipment"): { _gear_special pushBack _item  };
							};
						};
					};

					if (_item_subtype != "") then {
						_item_type = [_item_type, _item_subtype];
					};
					//diag_log [_item, [[_upgrades select _i, _prices select _i], _item_type, _config_type]];
					missionNamespace setVariable [_item, [[_upgrades select _i, _prices select _i], _item_type, _config_type]];
					_cpt = _cpt + 1;

					if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Common\Config\Gear\Gear_Config_Set.sqf", format ["Set Item [%1] of nature [%2].", _item, _item_type]] call CTI_CO_FNC_Log };
				};
			};
		} else {
			if (CTI_Log_Level >= CTI_Log_Warning) then { ["WARNING", "FILE: Common\Config\Gear\Gear_Config_Set.sqf", format ["Item [%1] was skipped since it is already defined.", _item]] call CTI_CO_FNC_Log };
		};
	} else {
		if (CTI_Log_Level >= CTI_Log_Error) then { ["ERROR", "FILE: Common\Config\Gear\Gear_Config_Set.sqf", format ["Item [%1] does not belong to any known classnames. If it belong to an Addons, make sure that it is loaded.", _item]] call CTI_CO_FNC_Log };
	};
};

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Common\Config\Gear\Gear_Config_Set.sqf", format ["Initialized Gear [%1], set [%2/%3]", _faction, _cpt, count _items]] call CTI_CO_FNC_Log };

//--- Append to the existing items
{
	missionNamespace setVariable [_x select 0, if (isNil {missionNamespace getVariable (_x select 0)}) then {_x select 1} else {(missionNamespace getVariable (_x select 0)) + (_x select 1)}]
} forEach [["cti_gear_list_primary", _gear_primary],["cti_gear_list_secondary", _gear_secondary],["cti_gear_list_pistol", _gear_pistol],["cti_gear_list_magazines", _gear_magazines],
["cti_gear_list_accessories", _gear_accessories],["cti_gear_list_misc", _gear_misc],["cti_gear_list_special", _gear_special],["cti_gear_list_uniforms", _gear_uniforms],
["cti_gear_list_vests", _gear_vests],["cti_gear_list_backpacks", _gear_backpacks],["cti_gear_list_headgear", _gear_headgear],["cti_gear_list_glasses", _gear_glasses],
["cti_gear_list_explosives", _gear_explosives]];

missionNamespace setVariable ["cti_gear_all", (_gear_primary + _gear_secondary + _gear_pistol + _gear_magazines + _gear_accessories + _gear_misc + _gear_special + _gear_uniforms + _gear_vests + _gear_backpacks + cti_gear_list_headgear + _gear_glasses + cti_gear_list_explosives)];
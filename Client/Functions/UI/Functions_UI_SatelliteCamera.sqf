CTI_UI_SatelitteCamera_MapClicked = {
	private ["_button", "_control", "_mx", "_my", "_position"];
	_control = _this select 0;
	_button = _this select 1;
	_mx = _this select 2;
	_my = _this select 3;

	if (_button == 0) then {
		_position = _control ctrlMapScreenToWorld [_mx, _my];
		_position set [2, getPos CTI_SatelitteCamera select 2];
		CTI_SatelitteCamera setPos _position;
	};
};

CTI_UI_SatelitteCamera_GetParsedVehicleRoles = {
	private ["_config", "_config_sub", "_found_commander", "_found_gunner", "_opcrew", "_parsed", "_unit", "_vehicle"];

	_vehicle = _this;

	_found_gunner = false;
	_found_commander = false;

	_parsed = "";
	_opcrew = [];
	if (alive driver _vehicle) then {_opcrew pushBack (driver _vehicle);_parsed = _parsed + format [" <t color='#ae6eef'>Driver:</t> <t color='#d4b4f7'>%1</t>%2<br />", driver _vehicle, if (effectiveCommander _vehicle == driver _vehicle) then {" - <t color='#8ccdff'>Vehicle Commander</t>"} else {""}]};
	_gunner = "";
	_commander = "";
	_turrets = "";

	_config = configFile >> "CfgVehicles" >> typeOf _vehicle >> "turrets";
	for '_i' from 0 to (count _config)-1 do {
		_turret_main = _config select _i;

		_unit = _vehicle turretUnit [_i];
		if (alive _unit) then {
			_roleFound = false;
			if !(_found_gunner) then { if (getNumber (_turret_main >> "primaryGunner") > 0) then {_found_gunner = true; _roleFound = true; _opcrew pushBack _unit;_gunner = format [" <t color='#ae6eef'>Gunner:</t> <t color='#d4b4f7'>%1</t>%2<br />", _unit, if (effectiveCommander _vehicle == _unit) then {" - <t color='#8ccdff'>Vehicle Commander</t>"} else {""}]}};
			if (!_found_commander && !_roleFound) then { if (getNumber (_turret_main >> "primaryObserver") > 0) then {_found_commander = true; _opcrew pushBack _unit;_commander = format [" <t color='#ae6eef'>Commander:</t> <t color='#d4b4f7'>%1</t>%2<br />", _unit, if (effectiveCommander _vehicle == _unit) then {" - <t color='#8ccdff'>Vehicle Commander</t>"} else {""}]}};
			if !(_unit in _opcrew) then {_opcrew pushBack _unit;_turrets = _turrets + format [" <t color='#ae6eef'>Turret [%1]:</t> <t color='#d4b4f7'>%2</t>%3<br />", _i, _unit, if (effectiveCommander _vehicle == _unit) then {" - <t color='#8ccdff'>Vehicle Commander</t>"} else {""}]};
		};

		_config_sub = _turret_main >> "turrets";
		for '_j' from 0 to (count _config_sub) -1 do {
			_turret_sub = _config_sub select _j;

			_unit = _vehicle turretUnit [_i, _j];
			if (alive _unit) then {
				_roleFound = false;
				if !(_found_gunner) then { if (getNumber (_turret_sub >> "primaryGunner") > 0) then {_found_gunner = true; _roleFound = true; _opcrew pushBack _unit;_gunner = format [" <t color='#ae6eef'>Gunner:</t> <t color='#d4b4f7'>%1</t>%2<br />", _unit, if (effectiveCommander _vehicle == _unit) then {" - <t color='#8ccdff'>Vehicle Commander</t>"} else {""}]}};
				if (!_found_commander && !_roleFound) then { if (getNumber (_turret_sub >> "primaryObserver") > 0) then {_found_commander = true; _opcrew pushBack _unit;_commander = format [" <t color='#ae6eef'>Commander:</t> <t color='#d4b4f7'>%1</t>%2<br />", _unit, if (effectiveCommander _vehicle == _unit) then {" - <t color='#8ccdff'>Vehicle Commander</t>"} else {""}]}};
				if !(_unit in _opcrew) then {_opcrew pushBack _unit;_turrets = _turrets + format [" <t color='#ae6eef'>Turret [%1,%2]:</t> <t color='#d4b4f7'>%3</t>%4<br />", _i, _j, _unit, if (effectiveCommander _vehicle == _unit) then {" - <t color='#8ccdff'>Vehicle Commander</t>"} else {""}]};
			};
		};
	};

	_parsed = _parsed + format ["%1%2%3",_gunner,_commander,_turrets];
	//--- Thanksfuly bis gives us a command to get the cargo! ... not!
	{if (alive _x) then {_parsed = _parsed + format [" <t color='#ae6eef'>Cargo:</t> <t color='#d4b4f7'>%1</t><br />", _x]}} forEach (crew _vehicle - _opcrew);

	_parsed
};

CTI_UI_SatelitteCamera_LoadEntityInformation = {
	_entity = _this select 0;
	_namespace = _this select 1;
	_idc = _this select 2;
	_vehicle = vehicle _entity;

	_type = getText(configFile >> "CfgVehicles" >> typeOf _entity >> "displayName");
	_dmg = getDammage _entity;
	_health = format ["%1 (Value: %2)<br />", switch (true) do { case (_dmg <= 0.1): {"<t color='#99f26d'>Healthy</t>"}; case (_dmg > 0.1 && _dmg < 0.6): {"<t color='#f9f461'>Lightly Injured</t>"}; default {"<t color='#f25752'>Heavily Injured</t>"}}, format["%1%2",round((1 - _dmg) * 100), "%"]];
	_weapons = "Weapons:<br />";
	{_weapons = _weapons + format ["%1%2%3", if (_x select 0 != "") then {format [" <t color='#99f26d'>%1</t>",getText(configFile >> "CfgWeapons" >> _x select 0 >> "displayName")]} else {""}, if (count (_x select 1) > 0) then {format[" - <t color='#e6ffc9'>%1</t>",getText(configFile >> "CfgMagazines" >> ((_x select 1) select 0) >> "displayName")]} else {""}, if (_x select 0 != "") then {"<br />"} else {""}]} forEach [[primaryWeapon _entity, primaryWeaponMagazine _entity],[secondaryWeapon _entity, secondaryWeaponMagazine _entity],[handgunWeapon _entity, handgunMagazine _entity]];
	_magazines = "Magazines:<br />";
	_magazines_items = uniformItems _entity + vestItems _entity + backpackItems _entity;
	_magazines_items_added = [];
	{if !(_x in _magazines_items_added) then {_item = _x; _cfg = (_item) call CTI_UI_Gear_GetItemBaseConfig; if (_cfg != "nil") then {_magazines = _magazines + format [" <t color='#e6ffc9'>%1</t> - %2<br />",getText(configFile >> _cfg >> _item >> "displayName"), {_item == _x} count _magazines_items]}}; _magazines_items_added = _magazines_items_added + [_x]} forEach _magazines_items;

_html = format ["<t size='1.3' color='#2394ef'>Infantry :</t><br />
Class: <t color='#8ccdff'>%1</t><br />
Health: %2<br />
%3
%4
", _type, _health, _weapons, _magazines];

	if (_vehicle != _entity) then {
		_type = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
		_dmg = getDammage _vehicle;
		_health = format ["%1 (Value: %2)%3%4<br />", switch (true) do { case (_dmg <= 0.1): {"<t color='#99f26d'>Operational</t>"}; case (_dmg > 0.1 && _dmg < 0.6): {"<t color='#f9f461'>Lightly Damaged</t>"}; default {"<t color='#f25752'>Heavily Damaged</t>"}}, format["%1%2",round((1 - _dmg) * 100), "%"], if (!canMove _vehicle && !(_vehicle isKindOf "StaticWeapon")) then {", <t color='#f25752'>Can't Move</t>"} else {""}, if (!canFire _vehicle && (_vehicle emptyPositions "gunner" > 0 || alive gunner _vehicle)) then {", <t color='#f9f461'>Can't Fire</t>"} else {""}];
		_vehicle_roles = "Crew:<br />";
		_vehicle_roles = _vehicle_roles + (_vehicle call CTI_UI_SatelitteCamera_GetParsedVehicleRoles);

		_weapons = "Weapons:<br />";
		{_weapons = _weapons + format [" <t color='#99f26d'>%1</t><br />",getText(configFile >> "CfgWeapons" >> _x >> "displayName")]} forEach weapons _vehicle;
		_magazines = "Magazines:<br />";
		_magazines_items = magazines _vehicle;
		_magazines_items_added = [];
		{if !(_x in _magazines_items_added) then {_item = _x; _magazines = _magazines + format [" <t color='#e6ffc9'>%1</t> - %2<br />",getText(configFile >> "CfgMagazines" >> _item >> "displayName"), {_x == _item} count _magazines_items]}; _magazines_items_added = _magazines_items_added + [_x];} forEach _magazines_items;

_html = _html + format ["<br /><t size='1.3' color='#2394ef'>Vehicle :</t><br />
Class: <t color='#8ccdff'>%1</t><br />
Health: %2<br />
%3
%4
%5
", _type, _health, _vehicle_roles, _weapons, _magazines];
	};

	((uiNamespace getVariable _namespace) displayCtrl _idc) ctrlSetStructuredText parseText _html;
};
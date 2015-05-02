private ["_restrict","_gear","_func1","_u","_func2"];
_restrict=["optic_NVS","optic_Nightstalker","optic_tws","optic_tws_mg","NVGoggles"];
waitUntil {CTI_InitTowns};
if (CTI_isClient) then {
	waitUntil {!isnil "CTI_InitClient"};
	waitUntil {CTI_InitClient};
	if (side player == resistance) exitWith {false};
	_gear= missionNamespace getVariable "cti_gear_all";
	{
		_gear=_gear-[_x];
		missionNamespace setVariable [_x,nil];
	} forEach _restrict;
	missionNamespace setVariable ["cti_gear_all",_gear];
 	_func1={
 		_restrict = _this;
		while {!CTI_GameOver} do
		{
			{
				_i=_x;
				if ({_i == _x} count _restrict >0) then {
					player removePrimaryWeaponItem _x;
				};
			} forEach primaryWeaponItems player;
			{
				_u=_x;
				{
				 if (getText(configFile >> 'CfgWeapons' >> _x >> 'simulation') == 'NVGoggles') then {
				 	_u removeWeapon _x;
				 };
				}forEach assignedItems _u;
			} forEach units group player;
			sleep 1;
		};
	};
	(_restrict) spawn _func1;
};

if (CTI_IsServer) then {
	_func2={
		while {!CTI_GameOver} do {
			{
				_u=_x;
				if (local _u) then {

					{
					 if (getText(configFile >> 'CfgWeapons' >> _x >> 'simulation') == "NVGoggles") then {
							_u removeWeapon _x;
						};
					}forEach assignedItems _u;
				};
			} forEach allUnits;
			sleep 5;
		};
	};
	0 spawn _func2;
};
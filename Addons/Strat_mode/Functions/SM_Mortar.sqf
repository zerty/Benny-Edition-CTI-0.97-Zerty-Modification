#define MIN_FPS 20

private ["_town","_town_groups","_side","_group","_pos"];

_town= _this select 0;
_town_groups = _this select 1;



//main Loop
_maingrouploop={

	private ["_group","_town","_town_groups","_objects","_o","_cas"];
	_town=_this select 0;
	_cas=[];
	_target=[];
	_group=_this select 1;
	_town_groups=_this select 2;
	_to_mortar=if (ISLAND != 1) then {120} else {60};
	diag_log format [ ":: MORTAR :: Starting mortar from group %1 for town %2 linked to %3", _group,_town,_town_groups];
	while {count(_group call CTI_CO_FNC_GetLiveUnits)>0 &&( _town getVariable "cti_town_sideID")==CTI_RESISTANCE_ID && (_town getVariable "cti_town_resistance_active")} do
	{
		_t=[];
		if (diag_fps > MIN_FPS) then {
			{
				_add=[];
				 {_s= _x select 2;_nt=_x; if ({_x == _s} count [east,west] >0) then {_add set [count _add,_nt ]} ; true}count ((leader _x) nearTargets CTI_TOWNS_RESISTANCE_DETECTION_RANGE);
				_t = _t + _add;


			} count _town_groups;
			if (count _t >4) then {_target = (_t select floor random count _t)};
		};
		if (count _target >0 ) then {
			//if (count _cas == 0) then {_cas = [_town,_t, "I_Heli_light_03_dynamicLoadout_F"] call _create_cas	};
			diag_log format [ ":: MORTAR ::  %1 Firing to %2", _group,_target select 0];
			{
				_x commandArtilleryFire [([ _target select 0, 25, 100] call CTI_CO_FNC_GetRandomPosition), "8Rnd_82mm_Mo_shells", 1];
				_x commandArtilleryFire [([_target select 0, 25, 100] call CTI_CO_FNC_GetRandomPosition), "8Rnd_82mm_Mo_shells", 1];
			} forEach units _group;
			sleep (_to_mortar+ random (120));
		};
	sleep (10);

	};


};


//spawn
_group= createGroup resistance;
_pos= [_town,1000,1500] call CTI_CO_FNC_GetRandomPosition;

_mp=[];
_max_mortar=if (ISLAND != 1) then {3} else {1};

for "_x" from 1 to _max_mortar do {
	_pos2= [_pos,100,400] call CTI_CO_FNC_GetRandomPosition;
	_v = ["I_Mortar_01_F", _pos2, 180, resistance] call CTI_CO_FNC_CreateVehicle;
	_m = [_v,_group] call bis_fnc_spawncrew;
	_mp=_mp + [_v];

};
[_town,_group,_town_groups] spawn _maingrouploop;

[_mp,_group,_pos]
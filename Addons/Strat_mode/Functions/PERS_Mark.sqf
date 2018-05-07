//load and mark found bases [H]Tom

{
	_side = _x;
	_load = profileNamespace getVariable format ["CTI_SAVE_%1", _side];
	_enemy = switch (_side) do {
	   	 	case west: {east};
	    	case east: {west};
			};
	_enemybasepos = (_load select 10);
	_nmybp0 = _enemybasepos select 0; _count0 = (count _nmybp0);
	_nmybp1 = _enemybasepos select 1; _count1 = (count _nmybp1);
	_nmybp2 = _enemybasepos select 2; _count2 = (count _nmybp2);
	_nmybp3 = _enemybasepos select 3; _count3 = (count _nmybp3);
	_nmybp4 = _enemybasepos select 4; _count4 = (count _nmybp4);
	_nmybp5 = _enemybasepos select 5; _count5 = (count _nmybp5);

	while {!CTI_GameOver} do {
		
		sleep 60;
		if (_count0 > 0) then {
			[["CLIENT",_side], "Client_Base_Zone",[_enemy,0,_nmybp0]] call CTI_CO_FNC_NetSend;
			_new_neigh = [_nmybp0,CTI_TOWNS] call CTI_CO_FNC_SortByDistance;
			_neigh_vect = [(_new_neigh select 0),(_new_neigh select 1),(_new_neigh select 2)];
			{
				[["CLIENT",_side], "Client_Connect",[_nmybp0,getPos _x,((_enemy) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2]] call CTI_CO_FNC_NetSend;true
			} count _neigh_vect;
		};
		if (_count1 > 0) then {
			[["CLIENT",_side], "Client_Base_Zone",[_enemy,1,_nmybp1]] call CTI_CO_FNC_NetSend;
			_new_neigh = [_nmybp1,CTI_TOWNS] call CTI_CO_FNC_SortByDistance;
			_neigh_vect = [(_new_neigh select 0),(_new_neigh select 1),(_new_neigh select 2)];
			{
				[["CLIENT",_side], "Client_Connect",[_nmybp1,getPos _x,((_enemy) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2]] call CTI_CO_FNC_NetSend;true
			} count _neigh_vect;
		};
		if (_count2 > 0) then {
			[["CLIENT",_side], "Client_Base_Zone",[_enemy,2,_nmybp2]] call CTI_CO_FNC_NetSend;
			_new_neigh = [_nmybp2,CTI_TOWNS] call CTI_CO_FNC_SortByDistance;
			_neigh_vect = [(_new_neigh select 0),(_new_neigh select 1),(_new_neigh select 2)];
			{
				[["CLIENT",_side], "Client_Connect",[_nmybp2,getPos _x,((_enemy) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2]] call CTI_CO_FNC_NetSend;true
			} count _neigh_vect;
		};
		if (_count3 > 0) then {
			[["CLIENT",_side], "Client_Base_Zone",[_enemy,3,_nmybp3]] call CTI_CO_FNC_NetSend;
			_new_neigh = [_nmybp3,CTI_TOWNS] call CTI_CO_FNC_SortByDistance;
			_neigh_vect = [(_new_neigh select 0),(_new_neigh select 1),(_new_neigh select 2)];
			{
				[["CLIENT",_side], "Client_Connect",[_nmybp3,getPos _x,((_enemy) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2]] call CTI_CO_FNC_NetSend;true
			} count _neigh_vect;
		};
		if (_count4 > 0) then {
			[["CLIENT",_side], "Client_Base_Zone",[_enemy,4,_nmybp4]] call CTI_CO_FNC_NetSend;
			_new_neigh = [_nmybp4,CTI_TOWNS] call CTI_CO_FNC_SortByDistance;
			_neigh_vect = [(_new_neigh select 0),(_new_neigh select 1),(_new_neigh select 2)];
			{
				[["CLIENT",_side], "Client_Connect",[_nmybp4,getPos _x,((_enemy) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2]] call CTI_CO_FNC_NetSend;true
			} count _neigh_vect;
		};
		if (_count5 > 0) then {
			[["CLIENT",_side], "Client_Base_Zone",[_enemy,5,_nmybp5]] call CTI_CO_FNC_NetSend;
			_new_neigh = [_nmybp5,CTI_TOWNS] call CTI_CO_FNC_SortByDistance;
			_neigh_vect = [(_new_neigh select 0),(_new_neigh select 1),(_new_neigh select 2)];
			{
				[["CLIENT",_side], "Client_Connect",[_nmybp5,getPos _x,((_enemy) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2]] call CTI_CO_FNC_NetSend;true
			} count _neigh_vect;
		};	
	};
	
} forEach [east,west];
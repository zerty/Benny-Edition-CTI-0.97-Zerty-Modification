private ["_base","_side","_sidelogic","_enemy","_enemylogic","_ind","_temp","_neigh_vect"];
_base=_this select 0;
_side=_this select 1;
_sidelogic= (_side) call CTI_CO_FNC_GetSideLogic;
_enemy = switch (_side) do
	{
	    case west: {east };
	    case east: {west };
	};
_enemylogic= (_enemy) call CTI_CO_FNC_GetSideLogic;
_found=false;


while {!CTI_GameOver &&  ! _found} do {
	if (( _enemy countSide (((_base) nearEntities ["AllVehicles", (CTI_BASE_AREA_RANGE)]) unitsBelowHeight 40)) >0) then {
		_ind = (_sidelogic getVariable "cti_structures_areas") find _base;
		if (_ind>=0) then {
			_temp= +(_enemylogic getVariable ["CTI_BASES_FOUND",[]]);
			_temp pushBackUnique _ind;
			_enemylogic setVariable ["CTI_BASES_FOUND",_temp,true];
			_neigh_vect=( _sidelogic getVariable "CTI_BASES_NEIGH") select _ind;
			[["CLIENT",_enemy], "Client_Base_Zone",[_side,_ind,_base]] call CTI_CO_FNC_NetSend;
			{
				[["CLIENT",_enemy], "Client_Connect",[_base,getPos _x,((_side) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2]] call CTI_CO_FNC_NetSend;true
			}	count _neigh_vect;
			_found=true;
		};
	};
	sleep 5;
};

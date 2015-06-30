private ["_base","_side","_ind","_side_id","_sidelogic","_neigh","_new_neigh","_neigh_vect"];
_base= _this select 0;
_side = _this select 1;
_ind= _this select 2;

_side_id=(_side) call CTI_CO_FNC_GetSideID;
_sidelogic= (_side) call CTI_CO_FNC_GetSideLogic;
_neigh=( _sidelogic getVariable "CTI_BASES_NEIGH");
_new_neigh = [_base,CTI_TOWNS] call CTI_CO_FNC_SortByDistance;
_neigh_vect=[(_new_neigh select 0),(_new_neigh select 1),(_new_neigh select 2)];
_neigh set [_ind,_neigh_vect];
_sidelogic setVariable ["CTI_BASES_NEIGH",_neigh,true];

{
	// Connect Marker 2 positions (POs1,POs2, color, offset)
	[["CLIENT",_side], "Client_Connect",[_base,getPos _x,((_side) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2]] call CTI_CO_FNC_NetSend;true
}count _neigh_vect;
private ["_ct","_tv","_neigh","_towns","_new_neigh","_nt","_oneigh"];
_ct= _this select 0;
_tv= _ct getVariable "cti_town_value";
_neigh= _ct getVariable "CTI_Neigh";

_towns=CTI_Towns;

_ct setVariable ["CTI_Neigh",synchronizedObjects _ct,true] ;
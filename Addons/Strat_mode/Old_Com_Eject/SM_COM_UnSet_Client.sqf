private ["_side","_side_logic","_hq"];

_side=CTI_P_SideJoined;
_side_logic=(_side) call CTI_CO_FNC_GetSideLogic;
_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
0 spawn {
	hint parseText localize "STR_LeftCommand";
	sleep 10;
	hintsilent "";
};
removeAllActions _hq;

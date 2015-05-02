_a=0.08;
_b=7;

while {! CTI_GameOver} do {
	_nbp={isPlayer _x} count playableUnits;
	_next=0 max ceil(_b-(_a*_nbp));
	if !(missionNamespace getVariable "CTI_PLAYERS_GROUPSIZE" == _next ) then {
		missionNamespace setVariable ["CTI_PLAYERS_GROUPSIZE",_next] ;
		CTI_P_ChatID commandChat format ["Group size is now : %1 ",_next];
	};
	sleep 60;
};
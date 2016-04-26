_a=0.08;
_b=7;

while {! CTI_GameOver} do {
	_nbp={isPlayer _x} count playableUnits;
	_next=0 max ceil(_b-(_a*_nbp));
	if !(missionNamespace getVariable "CTI_PLAYERS_GROUPSIZE" == _next ) then {
		missionNamespace setVariable ["CTI_PLAYERS_GROUPSIZE",_next] ;
		HUD_NOTIFICATIONS pushBack [format [localize "STR_AdaptGroup",_next],time+10,"ffffff"];

	};
	sleep 60;
};
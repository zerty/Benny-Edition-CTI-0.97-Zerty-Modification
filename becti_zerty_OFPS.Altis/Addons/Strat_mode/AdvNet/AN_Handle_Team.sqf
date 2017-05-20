_team=_this select 0;
_side=_this select 1;
while {!CTI_GameOver && local leader _team} do{
	waitUntil {alive leader _team && isnil {(leader _team) getvariable "AN_iNet"} };
	[leader _team,_side] call AN_Launch;
};
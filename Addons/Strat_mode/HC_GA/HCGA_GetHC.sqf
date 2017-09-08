_hc=[];
if (HCGA_Use_Server) then { _hc=["0"]};
{
	if (isplayer _x )then {_hc set [count _hc, getPlayerUID _x]};true
} count (entities "headlessclient_f");
if (count _hc == 0) then {_hc=["0"]};
_hc
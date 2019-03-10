private ["_side","_ejected","_side_logic","_hq","_curent_com_gr","_curent_com_pl"];


_side=_this select 0;
_ejected=_this select 1;

_side_logic=(_side) call CTI_CO_FNC_GetSideLogic;

waitUntil {!isNil {(_side_logic) getVariable "cti_commander"} && !isNil {_side_logic getVariable "cti_hq"} && !isNil {_side_logic getVariable "cti_salvagers"}};



_hq = (_side) call CTI_CO_FNC_GetSideHQ;
diag_log format [":: COM %1 :: Found HQ %2",_side,_hq];
_curent_com_gr=_side_logic getvariable  "cti_commander";
diag_log format [":: COM %1 :: Found COM group %2",_side,_curent_com_gr];
_curent_com_pl=objnull;
{if (isplayer _x) then {_curent_com_pl=_x};true}count (units _curent_com_gr);
diag_log format [":: COM %1 :: Found Player %2",_side,_curent_com_pl];
if !(isnull _curent_com_pl) then {
	{[["CLIENT", _x], "Client_Com_Eject","",true] call CTI_CO_FNC_NetSend;true}count (units _curent_com_gr);
	if (_ejected) then {
		[["CLIENT", _side], "Client_OnMessageReceived", ["eject_com", [name _curent_com_pl]]] call CTI_CO_FNC_NetSend;
	} else {
		[["CLIENT", _side], "Client_OnMessageReceived", ["leave_com", [name _curent_com_pl]]] call CTI_CO_FNC_NetSend;
	};


};

diag_log format [":: COM %1 :: Cleaning crew of HQ %2",_side,_hq];
{_x setdammage 1;true} count (crew _hq);
//if (isMultiplayer) then {diag_log format [":: COM %1 :: Trying to get locality of HQ %2",_side,_hq];["SERVER", "Request_HQLocality", [_side, objnull]] call CTI_CO_FNC_NetSend; waitUntil {local _hq};};


_side_logic setVariable ["cti_commander", grpNull, true];
diag_log format [":: COM %1 :: Reseting group to %2",_side,_side_logic getvariable  "cti_commander"];

diag_log format [":: COM %1 :: Locking HQ %2",_side,_hq];
if (_hq iskindof "Car") then {
	if (local _hq) then {_hq lock 2} else {["CLIENT", "Client_LockHQ", [],true] call CTI_CO_FNC_NetSend;};
};
_hq setVariable ["v_keys",["",grpNull],true];
diag_log format [":: COM %1 :: HQ %2 locks: %3",_side,_hq,_hq getVariable "v_keys"];


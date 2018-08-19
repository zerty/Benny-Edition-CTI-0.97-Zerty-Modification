private ["_targs","_sl","_a_targs","_to_share","_t","_pt","_input","_return","_o","_side","_text","_dis","_fade","_size","_shared","_p_icon","_s_icon","_icon","_color"];
_targs =[];
_sl= (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;

_a_targs= player nearTargets (HUD_MAX_RANGE);

{
	if (!((_x select 2) == civilian) && !((_x select 2) == CTI_P_SideJoined) && (group player ) knowsAbout (_x select 4) >(missionNamespace getVariable "CTI_EW_HUD_S")) then {
		if (((missionNamespace getVariable "CTI_EW_HUD_I") == 1) && (_x select 4) isKindOf "CAManBase" && vehicle (_x select 4) == (_x select 4) && !((_x select 2) == CTI_P_SideJoined) ) then {_targs pushBack _x;};
		if ((_x select 4) isKindOf "Car") then {_targs pushBack _x;};
		if ((_x select 4) isKindOf "Tank") then {_targs pushBack _x;};
		if ((_x select 4) isKindOf "Air") then {_targs pushBack _x;};
		if ((_x select 4) isKindOf "Ship") then {_targs pushBack _x;};
	};
} count _a_targs;

HUD_T_OBJ=HUD_T_OBJ-[objNull];
_to_share=[];
{
	_t=(_x select 4);
	_pt=getPosASL (_x select 4);
	_pt set [2,(_pt select 2) + 2];
	if (Client_AN_Connected) then {
		if ({_x == _t} count (_sl getVariable "CTI_HUD_SHARED") == 0 && ((player getVariable ["CTI_net",-10])  call CTI_CO_FNC_GetSideFromID) == CTI_P_SideJoined && !((_x select 2) == CTI_P_SideJoined)&& vehicle _t == _t) then {
			_to_share pushback _t;
		};
	};
	if ({_x == _t} count HUD_T_OBJ == 0 ) then {
		HUD_T_OBJ pushback _t;
		_t spawn {_to=time+120 + random 10; waitUntil {time > _to}; HUD_T_OBJ = HUD_T_OBJ - [_this];};
	};

 true
} count _targs;

if (count _to_share > 0) then {
	["SERVER", "Server_Hud_Share_Add",[_to_share,CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;

	//Send your intel to enemy network
	/*if(CTI_P_SideJoined == east) then {
		["SERVER", "Server_Hud_Share_Add_Enemy",[_to_share,west]] call CTI_CO_FNC_NetSend;
	} else {
		["SERVER", "Server_Hud_Share_Add_Enemy",[_to_share,east]] call CTI_CO_FNC_NetSend;
	};*/
};

_return=[];

_return
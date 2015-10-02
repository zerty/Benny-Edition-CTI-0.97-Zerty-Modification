_targs =[];
_sl= (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;

_a_targs= player nearTargets (HUD_MAX_RANGE);

{
	if (!((_x select 2) == civilian) && !((_x select 2) == CTI_P_SideJoined) && (group player ) knowsAbout (_x select 4) >(missionNamespace getVariable "CTI_EW_HUD_S")) then {
		if (((missionNamespace getVariable "CTI_EW_HUD_I") == 1) && (_x select 4) isKindOf "CAManBase" && vehicle (_x select 4) == (_x select 4) && !((_x select 2) == CTI_P_SideJoined) ) then {_targs =_targs + [_x];};
		if ((_x select 4) isKindOf "Car") then {_targs =_targs + [_x];};
		if ((_x select 4) isKindOf "Tank") then {_targs =_targs + [_x];};
		if ((_x select 4) isKindOf "Air") then {_targs =_targs + [_x];};
		if ((_x select 4) isKindOf "Ship") then {_targs =_targs + [_x];};
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
			_to_share set [count _to_share,_t];
		};
	};
	if ({_x == _t} count HUD_T_OBJ == 0 ) then {
		HUD_T_OBJ set [count  HUD_T_OBJ ,_t];
		_t spawn {_to=time+120 + random 10; waitUntil {time > _to}; HUD_T_OBJ = HUD_T_OBJ - [_this];};
	};

 true
} count _targs;

if (count _to_share > 0) then { ["SERVER", "Server_Hud_Share_Add",[_to_share,CTI_P_SideJoined]] call CTI_CO_FNC_NetSend; };

_return=[];
{
	_o=_x;
	_side = side _x ;
	_text="";
	if (_x isKindOf "Man" ) then { _side = side (group _x);};
	_dis= player distance _x;
	if (_dis <= HUD_MAX_RANGE && (vehicle _o == _o)  && !((side _o) == civilian) ) then
	{

		_fade=1-(_dis/HUD_MAX_RANGE) max 0;
		_size=(1-((_dis)/HUD_MAX_RANGE)*0.8) max 0;
		_shared=false;

		if (_x isKindOf "Man" ) then {
			_size=_size *0.75;

		};

		_p_icon= switch (_side) do
		{
	    case 	west:{ "b_" };
	    case 	east:{ "o_" };
	    case 	resistance:{ "n_" };
	    default { "n_"  };
	  };
	  _s_icon=0 call {
	  	if (_x isKindOf "Man") exitWith { "inf" };
			if ((_x isKindOf "Car" || _x isKindOf "Motorcycle") && !(_x isKindOf "Wheeled_APC_F")) exitWith { "motor_inf" };
			if  (_x isKindOf "Wheeled_APC_F")exitWith { "mech_inf" };
			if  (_x isKindOf "Ship")exitWith { "naval" };
			if  (_x isKindOf "Tank")exitWith { "armor" };
			if  (_x isKindOf "Helicopter")exitWith { "air" };
			if  (_x isKindOf "Plane")exitWith { "plane" };
		};
		_icon=format ["a3\ui_f\data\map\Markers\NATO\%1.paa",(_p_icon+_s_icon)];
		_color = switch (_side) do
		{
	    case 	west:{ [0,0,1,1] };
	    case 	east:{ [1,0,0,1] };
	    case 	resistance:{ [0,1,0,1] };
	    default { [1,1,1,1]  };
		};
		_color set [3,_fade];
		if ( {_x == _o} count (_sl getVariable "CTI_HUD_SHARED") >0 ) then {_shared=true};
		_return set [count _return,[_x,_icon,_color,_shared,_size,_text]];
	};
} count (HUD_T_OBJ + (_sl getVariable "CTI_HUD_SHARED"));
_return
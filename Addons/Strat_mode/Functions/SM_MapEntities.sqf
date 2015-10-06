private ["_side_id","_side","_sl","_hud_targets","_return","_lines","_cache","_ug","_object","_texture","_color","_pos","_size","_text","_p_icon","_unc","_s_icon","_special"];
waitUntil {! isNil {player getVariable "CTI_Net"}};
_side_id= player getVariable ["CTI_Net",-10];
_side = _side_id call CTI_CO_FNC_GetSideFromID;
_sl=CTI_P_SideJoined call  CTI_CO_FNC_GetSideLogic;
_hud_targets = _sl getvariable ["CTI_HUD_SHARED",[]];

//_side_id=player getVariable "CTI_Net";
_return=[];
_lines=[];
_group=[];
_cache= SHOWTOMAP;

waitUntil {! isNil {player getVariable "AN_iNet" }};
_ug=units player;
//if ( (player) getVariable "AN_iNet" == _side_id && (player getVariable ["CTI_Net",-10])>= 0 ) then {_ug=_ug-[player];};
// player group
{

	_object = _x;
	_size = [18, 18];
	if (vehicle _object != vehicle player || vehicle player == player) then {
		_texture= format ["a3\ui_f\data\map\Markers\NATO\%1inf",CTI_P_MarkerPrefix];
		_color = [1,1,0,1];
		if (! alive _object) then {_color = [0,0,0,1];};
		_pos = getPosASL _x;

		_text = (_object) call CTI_CL_FNC_GetAIDigit;
		if (isPlayer _object) then {_text =  format ["[%1]%2",(group _object) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], name _object] };
		_group set [count _group,[_object,_texture, _color, _pos,_size select 0,_size select 1, 0, _text, 0, 0.05,'TahomaB', 'right']];
	};
	if (!isnull (lasertarget _object)) then {_return set [count _return,[lasertarget _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [1,0,0,1],  getPos (lasertarget _object),_size select 0,_size select 1, 0, "", 0, 0.05,'TahomaB', 'right']];};
	if (!isnull (laserTarget getConnectedUAV _object)) then {_return set [count _return,[lasertarget getConnectedUAV _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [1,0,0,1],  getPos (lasertarget getConnectedUAV _object),_size select 0,_size select 1, 0, "", 0, 0.05,'TahomaB', 'right']];};

	/*if (_x call AN_Check_Connection && ! isNull(_x getVariable "AN_Conn") ) then {
			_lines set [count _lines , [_x,visiblePosition _x, visiblePosition (_x getVariable "AN_Conn"),[1,1,0,1]]];
	};*/
} count _ug;



	if ! ( ( player) getVariable "AN_iNet" == _side_id && (player getVariable ["CTI_Net",-10])>= 0) exitWith {[_group,[],[]]};



// switchableUnits
{
	_pgroup=_x;
	{	_object = _x;
		_side_id=-1;
		if (!isNil {_object getVariable "CTI_Net"}) then {_side_id=_object getVariable "CTI_Net";};
		if (!isNil {_object getVariable "AN_iNet"}) then {_side_id=_object getVariable "AN_iNet";};
		_side= (_side_id)  call CTI_CO_FNC_GetSideFromID;
		if (vehicle _x == _x && _side_id == (player getVariable ["CTI_Net",-10]) && (vehicle _x == _x || !(((vehicle _x ) getVariable ["AN_iNet",-10] )== (_x getVariable ["CTI_Net",-11])))) then {
			_p_icon= switch (_side) do
			{
		    case 	west:{ "b_" };
		    case 	east:{ "o_" };
		    case 	resistance:{ "n_" };
		    default { "n_"  };
		  };
			_texture= format ["a3\ui_f\data\map\Markers\NATO\%1inf",_p_icon];
			_color = switch (_side) do
				{
			    case 	west:{ [0,0,1,1] };
			    case 	east:{ [1,0,0,1] };
			    case 	resistance:{ [0,1,0,1] };
			    default { [1,1,1,1]  };
				};
			if (! alive _object) then {_color = [0,0,0,1];};
			if (_object getvariable ["REV_UNC",false]) then {_color = [0.5,0.32,0.09,1]};
			_pos =getPosASL _x;
			_size = [18, 18];
			_text="";
			if (isplayer _object && _object isKindOf "Man") then {
				if (_pgroup == ((_side) call CTI_CO_FNC_GetSideCommander)) then {
					_text =  format ["[%1]%2","Commander", name _object];
				}else {
					_text =  format ["[%1]%2",(group _object) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], name _object];
				};
			};
			_return set [count _return,[_object,_texture, _color, _pos,_size select 0,_size select 1, 0, _text, 0, 0.05,'TahomaB', 'right']];
			if (!isnull (lasertarget _object)) then {_return set [count _return,[lasertarget _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [0,0,1,1],  getPos (lasertarget _object),_size select 0,_size select 1, 0, "", 0, 0.05,'TahomaB', 'right']];};
			if (!isnull (laserTarget getConnectedUAV _object)) then {_return set [count _return,[lasertarget getConnectedUAV _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [1,0,0,1],  getPos (lasertarget getConnectedUAV _object),_size select 0,_size select 1, 0, "", 0, 0.05,'TahomaB', 'right']];};
			/*if (!isNil {_object getVariable "AN_Conn"}) then {
				if (_object call AN_Check_Connection && ! isNull(_object getVariable "AN_Conn") ) then {
					_lines set [count _lines , [_object,visiblePosition _object, visiblePosition (_object getVariable "AN_Conn"),[1,1,0,1]]];
				};
			};*/
		};TRUE} count units _x;TRUE
}count ((_side call CTI_CO_FNC_GetSideGroups)-[group player] );

//towns

{
	_side_id=-1;
	if (!isNil {_x getVariable "AN_iNet"}) then {_side_id=_x getVariable "AN_iNet";};
	_side= (_side_id)  call CTI_CO_FNC_GetSideFromID;
	_color = switch (_side) do
	{
    case 	west:{ [0,0,1,1] };
    case 	east:{ [1,0,0,1] };
    case 	resistance:{ [0,1,0,1] };
    default { [1,1,1,1]  };
	};
	if ( ! isNull(_x getVariable "AN_Conn") && _side_id == (player getVariable ["CTI_NET",-11]) && !(_x isKindOf "Man")) then {
		_lines set [count _lines , [_x,visiblePosition _x, visiblePosition (_x getVariable "AN_Conn"),_color]];
	};
} count CTI_Towns;


// Team Vehicles

{
	_object = _x;
	if (true) then {
		_side_id =	_object getVariable ["CTI_Net",-10]; ;
		//if (!isNil {_object getVariable "AN_iNet"}) then {_side_id=_object getVariable "AN_iNet";};
		_side= if (_side_id<0) then {side _object} else {(_side_id)  call CTI_CO_FNC_GetSideFromID};

		if ((_side_id == player getvariable ["CTI_Net",-1] &&( _object getVariable ["AN_iNet",-100])==player getvariable ["CTI_Net",-20] || _object in HUD_T_OBJ || _object in (_sl getVariable "CTI_HUD_SHARED")) && (player getVariable ["CTI_Net",-10])>= 0) then {

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
				"inf"
			};
			_special = _object getVariable "cti_spec";
			if (isNil '_special') then { _special = [] };
			if (CTI_SPECIAL_REPAIRTRUCK in _special) then {_s_icon="maint"};
			if (CTI_SPECIAL_AMMOTRUCK in _special) then {_s_icon="support"};
			if (CTI_SPECIAL_MEDICALVEHICLE in _special) then {_s_icon="med"};
			_texture= format ["a3\ui_f\data\map\Markers\NATO\%1%2",_p_icon,_s_icon];
			if (_x isKindOf "ReammoBox_F" && !(_x isKindOf "Slingload_base_F"))  then {_texture= "\A3\ui_f\data\map\vehicleicons\iconCrateAmmo_ca"};

			_color = switch (_side) do
			{
		    case 	west:{ [0,0,1,1] };
		    case 	east:{ [1,0,0,1] };
		    case 	resistance:{ [0,1,0,1] };
		    default { [1,1,1,1]  };
			};
			if (! alive _object) then {_color = [0,0,0,1];};
			_keys=_object getVariable ["v_keys",["",grpNull]];
			_second_color=_color;
			if (_object == vehicle player || group player == _keys select 1 || getPlayerUID player == _keys select 0) then  {_second_color = [1,1,0,1];};
			_pos = getPosASL _x;
			_size = [25, 25];
			if (_object isKindOf "Man") then {_size = [18, 18];};
			_text="";
			if (!(_object isKindOf "Man") && (_side_id == player getvariable ["CTI_Net",-11])) then {
				{
					if (isplayer _x) then {
						if ((group _x) == ((_side) call CTI_CO_FNC_GetSideCommander)) then {
							_text =  _text+" "+format ["[%1]%2","Commander", name _x];
						}else {
							_text =  _text+" "+format ["[%1]%2",(group _x) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], name _x];
						};

					}; true
				}count crew _x;
			};

			_return set [count _return,[_object,_texture, _second_color, _pos,_size select 0,_size select 1, 0, _text, 0, 0.05,'TahomaB', 'right']];
			if (!isNil {_object getVariable "AN_Conn"} && !(_object isKindOf "Man") && _side_id == (player getvariable ["AN_iNet",-1])) then {
				if (! isNull(_object getVariable "AN_Conn")) then {
					_lines set [count _lines , [_object,visiblePosition _object, visiblePosition (_object getVariable "AN_Conn"),_color]];
				};
			};
			if (!isnull (lasertarget _object)) then {_return set [count _return,[lasertarget _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [1,0,0,1],  getPos (lasertarget _object),_size select 0,_size select 1, 0, "", 0, 0.05,'TahomaB', 'right']];};
		};
	};

}count (vehicles );

//[texture, color, position, width, height, angle, text, shadow, textSize, font, align]

[_group,_return,_lines]
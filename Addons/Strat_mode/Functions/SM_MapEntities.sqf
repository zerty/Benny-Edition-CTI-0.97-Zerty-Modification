private ["_side_id","_side","_sl","_hud_targets","_return","_lines","_cache","_ug","_object","_texture","_color","_pos","_size","_text","_p_icon","_unc","_s_icon","_special"];
waitUntil {! isNil {player getVariable "CTI_Net"}};
_side_id= player getVariable ["CTI_Net",-10];
_side = _side_id call CTI_CO_FNC_GetSideFromID;
_sl=CTI_P_SideJoined call  CTI_CO_FNC_GetSideLogic;
_hud_targets = _sl getvariable ["CTI_HUD_SHARED",[]];

//_side_id=player getVariable "CTI_Net";
_return=+[];
_lines=+[];
_group=+[];
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
		_group pushBack [_object,_texture, _color, _pos,_size select 0,_size select 1, 0, _text, 0, 0.05,'TahomaB', 'right'];
	};

	//gets name for laser marker
	_unitName = getText (configFile >> "cfgVehicles" >> typeOf _object >> "displayName");
	if(_object isKindOf "Man") then {
		if(isPlayer _object) then {
			_unitName = name _object;
		} else {
			_unitName = groupId (group _object);
		};
	} else {
		if(_object isKindOf "UAV" && (count(UAVControl _object) > 0)) then {
			_unitName = name ((UAVControl _object) select 0);
		};
	};

	if (!isnull (lasertarget _object)) then {_return pushBack [lasertarget _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [1,0,0,1],  getPos (lasertarget _object),_size select 0,_size select 1, 0, _unitName, 0, 0.05,'TahomaB', 'right'];};
	if (!isnull (laserTarget getConnectedUAV _object)) then {_return pushBack [lasertarget getConnectedUAV _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [1,0,0,1],  getPos (lasertarget getConnectedUAV _object),_size select 0,_size select 1, 0, _unitName, 0, 0.05,'TahomaB', 'right'];};
	true
} count _ug;


{
	_object = _x;
	_connected=player call AN_Check_Connection;
	_side_id = _object getVariable ["CTI_Net",-10];
	//if (!isNil {_object getVariable "AN_iNet"}) then {_side_id=_object getVariable "AN_iNet";};
	_side= if (_side_id<0) then {side _object} else {(_side_id)  call CTI_CO_FNC_GetSideFromID};

	if ( HUD_T_OBJ findif {_object == _x select 0 && _x select 1 > time} >-1 ||  												// object detected by local tack hud
	    _object getVariable ["AN_iNet",-1000] == player getvariable ["CTI_Net",-10] && _connected ||	// both connected to same network
	    _connected && (_hud_targets findif {_object == _x select 0 && time < _x select 1} >-1)			//shared by team
	    ) then {
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


		// WUT IS COLOR?
		_keys=_object getVariable ["v_keys",["",grpNull]];
		_is_owner=(_object == vehicle player || group player == _keys select 1 || getPlayerUID player == _keys select 0);

		//When data link upgrade is present, it markers your units diffrent when they are spotted by enemy.
		if(	_side == CTI_P_SideJoined && 															//only on same sidethan player
		   ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_DATA == 1 && 	// side of player has upgrade
			_object getvariable["CTI_HUD_Detected", -1] > time 										// and did not timeout on enemy side shares
			) then {
				_color = switch (_side) do
				{
				    case 	west:{ [0,0.3,0.6,1] };
				    case 	east:{ [0.5,0,0,1] };
				    case 	resistance:{ [0,1,0,1] };
				    default { [1,1,1,1]  };
				};
				if (_is_owner) then {_color=[0.85,0.4,0,1]};
		} else {
				_color = switch (_side) do
				{
				    case 	west:{ [0,0,1,1] };
				    case 	east:{ [1,0,0,1] };
				    case 	resistance:{ [0,1,0,1] };
				    default { [1,1,1,1]  };
				};
				if (_is_owner) then {_color=[1,1,0,1]};
		};

		if (! alive _object) then {_color = [0,0,0,1];};

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

		_return pushBack [_object,_texture, _color, _pos,_size select 0,_size select 1, 0, _text, 0, 0.05,'TahomaB', 'right'];

		if (!isnull (lasertarget _object)) then {_return pushBack [lasertarget _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [1,0,0,1],  getPos (lasertarget _object),_size select 0,_size select 1, 0, "", 0, 0.05,'TahomaB', 'right'];};
	};
	true

}count (vehicles );




if ! (player call AN_Check_Connection) exitWith {[_group,_return,[]]};



// switchableUnits
{
	_inigroup=_x;

	{
		_object = _x;

		_sidef =side _inigroup;

		if (vehicle _x == _x &&
		    _object getVariable ["CTI_Net",-1] == player getvariable ["CTI_NET",-1001] &&
		    _object getVariable ["CTI_Net",-1] == _object getVariable ["AN_iNet",-2]
		    ) then {

			_p_icon= switch (_sidef) do
				{
				    case 	west:{ "b_" };
				    case 	east:{ "o_" };
				    case 	resistance:{ "n_" };
				    default { "n_"  };
			  	};
			_texture= format ["a3\ui_f\data\map\Markers\NATO\%1inf",_p_icon];
			_color = switch (_sidef) do
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
				if (_inigroup == ((_sidef) call CTI_CO_FNC_GetSideCommander)) then {
					_text =  format ["[%1]%2","Commander", name _object];
				}else {
					_text =  format ["[%1]%2",(group _object) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], name _object];
				};
			};
			_return pushBack [_object,_texture, _color, _pos,_size select 0,_size select 1, 0, _text, 0, 0.05,'TahomaB', 'right'];
			if (!isnull (lasertarget _object)) then {_return pushBack [lasertarget _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [0,0,1,1],  getPos (lasertarget _object),_size select 0,_size select 1, 0, "", 0, 0.05,'TahomaB', 'right'];};
			if (!isnull (laserTarget getConnectedUAV _object)) then {_return pushBack [lasertarget getConnectedUAV _object,"\a3\ui_f\data\IGUI\RscIngameUI\RscOptics\laser_designator_iconlaseron", [1,0,0,1],  getPos (lasertarget getConnectedUAV _object),_size select 0,_size select 1, 0, "", 0, 0.05,'TahomaB', 'right'];};

		};
		TRUE
	} count units _inigroup;
	TRUE
}count ((CTI_P_SideJoined call CTI_CO_FNC_GetSideGroups)-[group player] );

[_group,_return,_lines]
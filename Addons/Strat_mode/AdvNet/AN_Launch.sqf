private ["_vehicle","_side_id"];
_vehicle = _this select 0;
_side_id= _this select 1;
if (NET_LOG) then {diag_log format [":: NET :: Trying to launch for %1 with sideid %2",_vehicle,_side_id]};
if ! (isNil {_vehicle getVariable "AN_iNet"}) exitWith {false};
//diag_log format ["Starting networking for %1 side %2", _this select 0 , _this	 select 1];
if (isNil {_vehicle getVariable "CTI_Net"}) then {_vehicle setVariable ["CTI_Net",_side_id,true];};
if (isNil {_vehicle getVariable "AN_Conn"}) then {_vehicle setVariable ["AN_Conn",objNull,false];};
if (isNil {_vehicle getVariable "AN_iNet"}) then {_vehicle setVariable ["AN_iNet",-1,false];};
if (isNil {_vehicle getVariable "AN_Parrents"}) then {_vehicle setVariable ["AN_Parrents",[],false];};
waitUntil {! (isNil {_vehicle getVariable "CTI_Net"} || isNil {_vehicle getVariable "AN_Conn"} || isNil {_vehicle getVariable "AN_iNet"} || isNil {_vehicle getVariable "CTI_Net"})};
if (NET_LOG) then {diag_log format [":: NET :: Launching for %1 with sideid %2",_vehicle,_side_id]};
_vehicle spawn AN_Update_Connection;
(_vehicle) spawn AN_Reconfigure_loop;
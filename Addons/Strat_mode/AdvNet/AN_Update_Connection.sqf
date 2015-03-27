private ["_vehicle"];
_vehicle=_this;
while {! CTI_GameOver && alive  _vehicle} do {
	if (! local _vehicle && _vehicle isKindOf "Man") exitwith {false};
	if ((_vehicle) call AN_Check_Connection) then {
		if !((_vehicle getVariable "AN_iNet") == (_vehicle getVariable "AN_Conn") getVariable "AN_iNet") then {
			_vehicle setVariable ["AN_iNet",(_vehicle getVariable "AN_Conn") getVariable "AN_iNet" ,true];
			//if (_vehicle isKindOf "Man" && isPlayer _vehicle) then {[["CLIENT",_vehicle], "Client_AN_iNet",(_vehicle getVariable "AN_Conn") getVariable "AN_iNet"] call CTI_CO_FNC_NetSend;};
		};
	} else {
		if !((_vehicle getVariable "AN_iNet") == -1) then {
			_vehicle setVariable ["AN_iNet",-1,true];
			//if (_vehicle isKindOf "Man" && isPlayer _vehicle) then {[["CLIENT",_vehicle], "Client_AN_iNet",-1] call CTI_CO_FNC_NetSend;};
		};
	};
	sleep 3;
};
_vehicle setVariable ["AN_iNet",nil,true];
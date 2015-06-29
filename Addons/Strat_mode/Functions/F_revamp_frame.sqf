if (isnil "CTI_Lastf") then {CTI_Lastf=0};

_current=getFatigue player;

if (_current< CTI_Lastf) exitWith {player setFatigue ( (CTI_Lastf - (CTI_Lastf - _current)*(1+CTI_FATIGUE_RATIO/100)) max 0);CTI_Lastf=getFatigue player} ;
if (_current> CTI_Lastf) exitWith {player setFatigue ( (CTI_Lastf + (_current - CTI_Lastf)*(1-CTI_FATIGUE_RATIO/100)) min 1);CTI_Lastf=getFatigue player} ;
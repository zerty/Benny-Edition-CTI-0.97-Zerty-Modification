_dest = (_this select 1);

hint parseText "<t size='1.3' color='#2394ef'>Healing</t>";
_dest switchMove "AinvPknlMstpSnonWrflDnon_medic4";
sleep 15;
_dest switchMove "";
hint parseText "<t size='1.3' color='#2394ef'>Healed</t>";
_dest setDamage 0 ;
sleep 2;
hintsilent "";
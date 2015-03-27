#define para_alt 250
#define min_alt  1.5

_target = _this;


if (!(_target iskindof "Helicopter") || (isNull  (getSlingLoad _target) && count (attachedObjects _target) ==0)) exitwith {false};


_drop=objNull;
_attached=false;

if (count (attachedObjects _target) ==1) then {_drop=(attachedObjects _target) select 0;_attached=true;};
if !(isNull  (getSlingLoad _target)) then {_drop=getSlingLoad _target};

if (_attached) then {
	detach _drop;_drop enableRopeAttach true;
	_target enableRopeAttach true;
	_target setmass (_target getvariable "initial_mass");
	_target setcenterofmass (_target getvariable "initial_COM");
} else {{ropeDestroy _x;true}count (ropes _target);};
playSound3D ["A3\Sounds_F\vehicles\air\noises\SL_rope_break_ext.wss",_target];
[_drop,(side player),para_alt,min_alt] spawn SA_DROP;
true
#define pods ["Land_Pod_Heli_Transport_04_ammo_F","Land_Pod_Heli_Transport_04_bench_F","Land_Pod_Heli_Transport_04_box_F","Land_Pod_Heli_Transport_04_repair_F","Land_Pod_Heli_Transport_04_medevac_F","Land_Pod_Heli_Transport_04_fuel_F"]
#define taru "O_Heli_Transport_04_F"
#define offset [0,-1,-1]
#define min_length 1
#define max_speed 0.75
#define target_length 0.75

private ["_target_mass","_target_masscenter","_pod","_pod_mass","_pod_masscenter","_mass_ratio","_new_masscenter","_new_mass"];

_target=_this;

diag_log format [":: S A :: trying to attach pod to %1", _target];

if (typeof _target != taru || isNull (getSlingLoad _target) || !((typeof (getSlingLoad _target)) in pods) || count (attachedObjects _target) >0) exitwith {diag_log format [":: S A ::  attach pod to %1 failed", _target]; false};

_pod=getSlingLoad _target;
_target_mass=getmass _target;
_target_masscenter=getcenterofmass _target;
_pod_mass=getmass _pod;
_pod_masscenter=getcenterofmass _pod;
_mass_ratio=_pod_mass /(_pod_mass+_target_mass);
_new_mass=_pod_mass+_target_mass;
_new_masscenter=[];


{ropeUnwind [_x,max_speed,target_length];true}count (ropes _target);
waitUntil {!alive _pod ||!alive _target ||(ropelength (ropes _target select 0))<min_length};
if (!alive _pod || !alive _target) exitwith {false};

_pod attachto [_target,offset];
{ropeDestroy _x;true} count (ropes _target);
_target enableRopeAttach false;
_pod enableRopeAttach false;
_target setvariable ["initial_mass",_target_mass,true];
_target setvariable ["initial_COM",_target_masscenter,true];

for "_i" from 0 to 2 do {
	_new_masscenter set [_i,(_target_masscenter select _i)+((_pod_masscenter select _i)+ (offset select _i)- (_target_masscenter select _i))*_mass_ratio];
};
_target  setCenterOfMass [_new_masscenter,0];
_target setmass _new_mass;

true
#define WHEELS ["wheel_1_1_steering","wheel_1_2_steering","wheel_1_3_steering","wheel_1_4_steering","wheel_2_1_steering","wheel_2_2_steering","wheel_2_3_steering","wheel_2_4_steering"]

_damage=(_this select 2);
_v=_this select 0;
if ( ((_this select 1) in WHEELS )&& (isNull (_this select 3))&& count (crew _v)>0  && ! isNull (driver _v)) then {
	if (({isPlayer _x} count (crew _v) )== 0) then {
		_damage=0;
	} else {
		_damage=_damage*0.2
	};
};
_damage
_target = _this select 0;
_caller = _this	select 1;
_pos=_this select 2;

_currentdamage = getdammage _target;
_currentcallerdamage = getdammage _caller;
_avgdamage = (getAllHitPointsDamage _target select 2) call BIS_fnc_arithmeticMean;
_hitpointname = getallhitpointsdamage _target select 0;
_hps = {_x != 0} count (getAllHitPointsDamage _target select 2);

_repvalue = 0.003;
if (_avgdamage <= 0.10) then {_repvalue = 0.03;};
if (_avgdamage <= 0.25 && _avgdamage > 0.10) then {_repvalue = 0.01;};
if (_avgdamage <= 0.50 && _avgdamage > 0.25) then {_repvalue = 0.005;};

while {alive _caller && alive _target  && _hps > 0 && (_caller distance2d _target) <5 && (_caller distance _target) <7 && (_caller distance _pos)<=1 && (vehicle _caller) ==_caller && _currentdamage > ((getdammage _target) - 0.01) && _currentcallerdamage > ((getdammage _caller) - 0.02)} do {
	sleep 1;

	_avgdamage = (getAllHitPointsDamage _target select 2) call BIS_fnc_arithmeticMean;



	_hitpointdamage = getallhitpointsdamage _target select 2;
	for '_i' from 0 to count(_hitpointname)-1 do {
		if ((_hitpointdamage select _i) >= _repvalue) then {
        _target setHitIndex [_i, ((_hitpointdamage select _i) - _repvalue)];
        } else {
		_target setHitIndex [_i, 0];
		};
	};

	_hps = {_x != 0} count (getAllHitPointsDamage _target select 2);
	_currentdamage = getdammage _target;
};

_hitpointdamage = getallhitpointsdamage _target select 2;
if ((count _hitpointname) == ({_x == 0} count (_hitpointdamage))) then {_target setDammage 0;};

// Returns an array of skills for an AI
// Array representation: [aimingAccuracy, aimingShake, aimingSpeed, spotDistance, spotTime, courage, commanding, general, endurance, reloadSpeed]
// Script by Fluit and Bl1p

_SkillLevel = if (count _this > 0) then { _this select 0;} else { random(4);};

_skill = 0;
_commanding = 0;
_general = 0;

// Randomize the skill
_randomskill = (random(20) / 100);

// Calculate the skill level
switch (_SkillLevel) do {
	case 0: {
			_skill = ((0.00) + _randomskill);
			_commanding = 0.5;
			_general = 0.05;
	};
	case 1: {
			_skill = ((0.05) + _randomskill);
			_commanding = 0.55;
			_general = 0.1;
	};
	case 2: {
			_skill = ((0.1) + _randomskill);
			_commanding = 0.60;
			_general = 0.2;
	};
	case 3: {
			_skill = ((0.2) + _randomskill);
			_commanding = 0.70;
			_general = 0.3;
	};
	case 4: {
			_skill = ((0.3) + _randomskill);
			_commanding = 0.75;
			_general = 0.4;
	};
	case 5: {
			_skill = ((0.4) + _randomskill);
			_commanding = 0.8;
			_general = 0.5;
	};
};

// Skill can't be greater than 1
if (_skill > 1) then {
		_skill = 1;
};

// Skill must be at least 0.05
if (_skill < 0.05) then {
		_skill = 0.05;
};

// Set how the skill is affecting each skill type.
_aimingAccuracyLevel = _skill * 0.7;
_aimingShakeLevel    = _skill * 1.0;
_aimingSpeedLevel    = _skill * 0.7;
_spotDistanceLevel   = _skill * 2.0;
_spotTimeLevel       = _skill * 2.5;
_courageLevel        = _skill * 2.0;
_enduranceLevel      = _skill * 2.0;
_reloadspeedLevel    = _skill * 1.0;

// Round the skills up to 2 decimals
_aimingAccuracyLevel = round (_aimingAccuracyLevel * 100) / 100;
_aimingShakeLevel	   = round (_aimingShakeLevel * 100) / 100;
_aimingSpeedLevel    = round (_aimingSpeedLevel * 100) / 100;
_spotDistanceLevel   = round (_spotDistanceLevel * 100) / 100;
_spotTimeLevel       = round (_spotTimeLevel * 100) / 100;
_courageLevel        = round (_courageLevel * 100) / 100;
_enduranceLevel      = round (_enduranceLevel * 100) / 100;
_reloadspeedLevel    = round (_reloadspeedLevel * 100) / 100;

// Validate each skill type
if (_aimingAccuracyLevel > 1) then { _aimingAccuracyLevel = 1; };
if (_aimingShakeLevel > 1)    then { _aimingShakeLevel = 1; };
if (_aimingSpeedLevel > 1)    then { _aimingSpeedLevel = 1; };
if (_spotDistanceLevel > 1)   then { _spotDistanceLevel = 1; };
if (_spotTimeLevel > 1)       then { _spotTimeLevel = 1; };
if (_courageLevel > 1)        then { _courageLevel = 1; };
if (_enduranceLevel > 1)      then { _enduranceLevel = 1; };
if (_reloadspeedLevel > 1)    then { _reloadspeedLevel = 1; };

_skills = [_aimingAccuracyLevel, _aimingShakeLevel, _aimingSpeedLevel, _spotDistanceLevel, _spotTimeLevel, _courageLevel, _commanding, _general, _enduranceLevel, _reloadspeedLevel];
_skills;
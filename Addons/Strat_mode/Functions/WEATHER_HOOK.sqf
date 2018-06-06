#define MAXFOG 0.3

private ["_fog_forecast","_overcast_forecast","_nexttime","_nextfog","_nextover"];

_fog_forecast=-10000;
_overcast_forecast=-10000;


_nexttime=0;
_nextfog=random MAXFOG ;
if (daytime >= 8 && daytime <= 16) then {
	_nexttime setFog [_nextfog,0.01 + random (0.04),random(10)];
	} else {
	_a = [0.3 + random (0.2), 0.2, 1 + random (1)]; //water fog [H]Tom
	_b = [_nextfog,0.01 + random (0.04),random(10)];
	_c = selectRandom [_a, _a, _b];
	_nexttime setfog _c;
};
_nextover=random 1;
if (CTI_WEATHER_ALLOWRAIN == 0) then {_nexttime setRain 0;} else {
	if (_nextover > 0.7) then {_nexttime setRain random(_nextover);} else {_nexttime setRain 0;};
};
_nexttime setOvercast _nextover;
_fog_forecast=fogForecast;
_overcast_forecast=overcastForecast;

forceWeatherChange;

while {!CTI_GameOver} do {
	waitUntil {_overcast_forecast != overcastForecast || _fog_forecast != fogForecast};
	_nexttime=random(nextWeatherChange-100);
	_nextfog=random MAXFOG ;
	if (daytime >= 8 && daytime <= 16) then {
		_nexttime setFog [_nextfog,0.01 + random (0.04),random(10)];
	} else {
		_a = [0.3 + random (0.2), 0.2, 1 + random (1)]; //water fog [H]Tom
		_b = [_nextfog,0.01 + random (0.04),random(10)];
		_c = selectRandom [_a, _a, _b];
		_nexttime setfog _c;
	};
	_nextover=random 1;
	if (CTI_WEATHER_ALLOWRAIN == 0) then {_nexttime setRain 0;} else {
		if (_nextover > 0.7) then {_nexttime setRain random(_nextover);} else {_nexttime setRain 0;};
	};
	_nexttime setOvercast _nextover;
	_fog_forecast=fogForecast;
    _overcast_forecast=overcastForecast;
};
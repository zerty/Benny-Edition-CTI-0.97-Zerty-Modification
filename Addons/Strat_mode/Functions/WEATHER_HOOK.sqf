#define MAXFOG 0.2

private ["_fog_forecast","_overcast_forecast","_nexttime","_nextfog","_nextover"];

_fog_forecast=-10000;
_overcast_forecast=-10000;

MAXOVERCAST=if (CTI_WEATHER_ALLOWRAIN == 0) then {0.4} else {2};
_nexttime=0;
_nextfog=random MAXFOG ;
_nexttime setFog [_nextfog,0.01 + random (0.02),0];
_nextover=random MAXOVERCAST;
_nexttime setOvercast _nextover;
_fog_forecast=fogForecast;
_overcast_forecast=overcastForecast;
forceWeatherChange;

while {!CTI_GameOver} do {
	waitUntil {_overcast_forecast != overcastForecast || _fog_forecast != fogForecast};
	_nexttime=random(nextWeatherChange-100);
	_nextfog=random MAXFOG ;
	_nexttime setFog [_nextfog,0.01 + random (0.02),0];
	_nextover=random MAXOVERCAST;
	_nexttime setOvercast _nextover;
	_fog_forecast=fogForecast;
    _overcast_forecast=overcastForecast;
}
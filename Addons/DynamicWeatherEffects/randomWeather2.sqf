// randomWeather2 Script
// By Meatball
// v 0.9
//
// Setup Instructions
//
// 1) Copy the randomWeather2.sqf file into your root mission folder.
//
// 2) Set up a call for server and clients in init.sqf:
//		execVM "randomWeather2.sqf";
//
// 3) If you want players to be able to select starting weather conditions, you must
// 	have the following information in your parameters section of your description.ext
/*
class Params
{
        // paramsArray[0]
       class initialWeatherParam {
          title = "Starting Weather";
          values[] = {0,1,2,3,4};
          texts[] = {"Clear","Overcast","Rain","Fog","Random"};
          default = 4;
       };
 };
*/
// If the initialWeather parameter is not the first element in your parameters array, you must update
// the "initialWeatherParam = (paramsArray select 0);" line (Search for *NOTE 1*) and update the '0' to the proper number of the array.
//

// The base weather template information is listed below:

// Weather Types        (#)             [Can Move From/To]      	[Settings: Overcast, Rain/Snow, Fog, WindEW, WindNS]
// Clear                (0)             [0,1,5]                     [0.30,0,0,1,1]
// Overcast             (1)             [0,1,2]                   [0.50,0,0,2,2]
// Light Rain           (2)             [1,2,3,5]                 [0.60,0.3,0.05,3,3]
// Medium Rain          (3)             [2,3,4]                     [0.70,0.5,0.05,4,4]
// Rainstorm            (4)             [3]                         [0.80,0.9,0.1,5,5]
// Light Fog            (5)             [0,2,5,6]                   [0.40,0,[0.2,0.01,15],0,0]
// Medium fog           (6)             [5,6,7]                     [0.40,0,[0.4,0.005,30],0,0]
// Dense Fog            (7)             [6]                         [0.40,0,[0.6,0.0025,45],0,0]


// ============
// Begin Script
// ============

// Debug Messages.  This is set to 1 for the demo mission, but you should set this to 0 for regular missions. | 0 = Debug Messages Off, 1 = Debug Messages On
rw2Debug = 0;

// If you are using settings in your description.ext to allow parameter settings for initial weather, you must update the # below to match which parameter you are using.  Remember, the ordering starts with 0 and goes up from there.
rw2Param = 0;

// Setup Weather Types Array [Weather Name, Possible Weather Forecasts, Weather Settings] - Suggested that they are left as is.

weatherTemplates = [
        ["Clear",[0,1,8,11],[0.30,0,0,1,1]],
        ["Overcast",[0,1,8,11],[0.50,0,0,2,2]],
        ["Overcast",[0,1,8,11],[0.50,0,0,2,2]],
        ["Overcast",[0,1,8,11],[0.50,0,0,2,2]],
        ["Overcast",[0,1,8,11],[0.50,0,0,2,2]],
        ["Overcast",[0,1,8,11],[0.50,0,0,2,2]],
        ["Overcast",[0,1,8,11],[0.50,0,0,2,2]],
        ["Overcast",[0,1,8,11],[0.50,0,0,2,2]],
        ["Light Rain",[1,1,8,11],[0.60,0.3,0.05,3,3]],
        ["Medium Rain",[8,8,9,10],[0.70,0.5,0.05,4,4]],
        ["Rainstorm",[9,9,9,10],[1,1,0.1,5,5]],
        ["Light Fog",[0,0,1,1,8,12],[0.4,0,[0.1,0.001,10],0,0]],
        ["Medium Fog",[11,11,12,13],[0.4,0,[0.2,0.01,30],0,0]],
        ["Dense Fog",[12,12,12,13],[0.5,0,[0.4,0.05,50],0,0]]
	];


if ((missionNamespace getVariable "CTI_WEATHER_ALLOWRAIN") == 0) then {
    {
        _temp=_x;
        _temp_set=_temp select 2;
        _temp_set set [1,0];
        _temp set [2,_temp_set];
        weatherTemplates set [_foreachindex,_temp];
    } forEach weatherTemplates;
};
// DO NOT EDIT BELOW THIS LINE //

// Setup Initial Weather Function
mb_fnc_InitialWeather = {
	private["_weatherInitialArray","_weatherInitialSettings","_weatherInitialOvercast","_weatherInitialRainSnow","_weatherInitialFog","_weatherInitialWindEW","_weatherInitialWindNS"];

	waitUntil {!isNil "rw2_Current_Weather"};
	_weatherInitialArray = weatherTemplates select rw2_Current_Weather;
    weatherCurrentName = _weatherInitialArray select 0;
    _weatherInitialSettings = _weatherInitialArray select 2;

    _weatherInitialOvercast = _weatherInitialSettings select 0;
    _weatherInitialRainSnow = _weatherInitialSettings select 1;
    _weatherInitialFog = _weatherInitialSettings select 2;
    _weatherInitialWindEW = _weatherInitialSettings select 3;
    _weatherInitialWindNS = _weatherInitialSettings select 4;

		skipTime -24;
        86400 setOvercast _weatherInitialOvercast;
        0 setRain _weatherInitialRainSnow;
        86400 setFog _weatherInitialFog;
        setWind [_weatherInitialWindEW,_weatherInitialWindNS,true];
		skipTime 24;
		sleep 1;
	    simulWeatherSync;

		if (rw2Debug == 1) then {hint format ["Debug Initialized Weather - %1\nOvercast: %2\nRain/Snow: %3\nFog: %4\nWind EW|NS: %5|%6",weatherCurrentName,_weatherInitialOvercast,_weatherInitialRainSnow,_weatherInitialFog,_weatherInitialWindEW,_weatherInitialWindNS];};
};

// Setup Update Weather Function
mb_fnc_UpdateWeather = {
	private ["_weatherCurrentArray","_weatherNextArray","_weatherNextSettings","_weatherNextOvercast","_weatherNextRainSnow","_weatherNextFog","_weatherNextWindEW","_weatherNextWindNS"];
    _n_time=_this select 0;
	_weatherCurrentArray = weatherTemplates select rw2_Current_Weather;
	weatherCurrentName = _weatherCurrentArray select 0;
	_weatherNextArray = weatherTemplates select rw2_Next_Weather;
	weatherNextName = _weatherNextArray select 0;
	_weatherNextSettings = _weatherNextArray select 2;

	_weatherNextOvercast = _weatherNextSettings select 0;
	_weatherNextRainSnow = _weatherNextSettings select 1;
	_weatherNextFog = _weatherNextSettings select 2;
	_weatherNextWindEW = _weatherNextSettings select 3;
	_weatherNextWindNS = _weatherNextSettings select 4;

    _n_time setOvercast _weatherNextOvercast;
    _n_time setRain _weatherNextRainSnow;
    _n_time setFog _weatherNextFog;
    setWind [random (_weatherNextWindEW),random (_weatherNextWindNS),true];
    sleep 1;
	if (rw2Debug == 1) then {hint format ["Debug Updating Weather - %1\nOvercast: %2\nRain/Snow: %3\nFog: %4\nWind EW/NS: %5|%6 in %7",weatherNextName,_weatherNextOvercast,_weatherNextRainSnow,_weatherNextFog,_weatherNextWindEW,_weatherNextWindNS,_n_time];};
};

if (isServer) then {
private ["_weatherUpdateArray","_weatherUpdateForecasts"];
    if (CTI_WEATHER_FAST >1) then {setTimeMultiplier CTI_WEATHER_FAST};

// Check if there is no ParamsArray, and pick random if so, otherwise pick from paramsArray.
      if(isNil('paramsArray')) then {
        rw2_Current_Weather = floor(random(count(weatherTemplates)));
	   } else {
        initialWeatherParam = (missionNamespace getVariable "initialWeatherParam");
		switch (initialWeatherParam) do{
			case 0: {rw2_Current_Weather = 0;};    										// Clear
            case 1: {rw2_Current_Weather = 1;};    										// Overcast
            case 2: {rw2_Current_Weather = 2 + (floor (random 3));};  					// Rain
            case 3: {rw2_Current_Weather = 5 + (floor (random 3));};  				 	// Fog
            case 4: {rw2_Current_Weather = floor(random(count(weatherTemplates)));};	// Random
        };
	   };
	// Send out Initial Weather Variable
	publicVariable "rw2_Current_Weather";
	[] spawn mb_fnc_InitialWeather;
   // Start recurring weather loop.
    while {true} do {
		// Pick weather template from possible forecasts for next weather update
		sleep 10;
		_weatherUpdateArray = weatherTemplates select rw2_Current_Weather;
		_weatherUpdateForecasts = _weatherUpdateArray select 1;
		rw2_Next_Weather = _weatherUpdateForecasts select floor(random(count(_weatherUpdateForecasts)));
		publicVariable "rw2_Next_Weather";
        _n_time= (abs((((weatherTemplates select rw2_Next_Weather) select 2) select 1)-(((weatherTemplates select rw2_Current_Weather) select 2) select 1))*6000 / CTI_WEATHER_FAST);
        diag_log _n_time;
        if (_n_time <600) then {_n_time = 600};
        [[_n_time],"mb_fnc_UpdateWeather",true] spawn Bis_fnc_MP;
        sleep _n_time;
		rw2_Current_Weather = rw2_Next_Weather;
		publicVariable "rw2_Current_Weather";
	};
};

// Run Initial Weather Function for all.
[] spawn mb_fnc_InitialWeather;
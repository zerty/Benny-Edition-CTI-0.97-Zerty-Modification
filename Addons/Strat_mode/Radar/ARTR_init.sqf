#define Radar_Range 5000
private ["_structures","_radars"];
ARTR_MARKERS=[];

RADAR_marker={
	private ["_marker_name","_m"];
	_marker_name=format ["RADAR_%1",_this];
	_m=createMarkerLocal [_marker_name,getposATL _this];
	_m setMarkerShapeLocal "ELLIPSE";
	_m setMarkerBrushLocal "Border";
	_m setMarkerSizeLocal [Radar_Range,Radar_Range];
	_m setMarkerColorLocal "ColorBrown";
	_m setMarkerAlphaLocal 1;
	[_marker_name,_this] spawn {waitUntil {!alive (_this select 1)}; deleteMarkerLocal (_this select 0);  };
};


with missionnamespace do {
	ARTR_HANDLER = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Radar\ARTR_handler.sqf";
	ARTR_UPDATE = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Radar\ARTR_update.sqf";
	ARTR_PROJ_HANDLER = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Radar\ARTR_proj_handler.sqf";
	CTI_PVF_Server_ARTR_handle={  _this addEventHandler["Fired","_this call ARTR_HANDLER;"];};
	CTI_PVF_Client_ARTR_update={  (_this) call ARTR_UPDATE;};
	CTI_PVF_Client_ARTR_marker={
		private ["_marker_name","_m"];
		_marker_name=format ["ARTR_%1",_this select 0];
		_m=createMarkerLocal [_marker_name,_this select 1];
		_m setMarkerShapeLocal "RECTANGLE";
		_m setMarkerBrushLocal "Solid";
		_m setMarkerColorLocal "ColorYellow";
		_m setMarkerAlphaLocal 0.8;
		if ((count ARTR_MARKERS) >20) then {_marker_name_del=ARTR_MARKERS deleteat 0; deleteMarkerLocal _marker_name_del;};
		ARTR_MARKERS pushBack _marker_name;
		//_m spawn {sleep 600; deleteMarkerLocal _this; };
	};

};

if (CTI_isClient) then {
	0 spawn {
		while {!(CTI_GameOver)} do {
			_marker_name=ARTR_MARKERS deleteat 0;
			if ! (isnil "_marker_name") then {
				deleteMarkerLocal _marker_name;
				sleep 60;
			} else {
				sleep 400;
			};
		};
	};
};
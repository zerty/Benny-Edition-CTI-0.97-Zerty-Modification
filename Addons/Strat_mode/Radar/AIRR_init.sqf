#define Radar_Range 5000
#define Min_Alt 40

	SM_Radar_Detected =false;
	SM_Radar_Detected_last=-100000;

//sadly air radar needs to be handled by server to prevent failure if players disconnect
if (CTI_isServer) then{
	with missionnamespace do {
		AIRR_HANDLER = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Radar\AIRR_handler.sqf";
		AIRR_OBJ_HANDLER = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Radar\AIRR_obj_handler.sqf";
		CTI_PVF_Server_AIRR_handle={
			_this spawn AIRR_HANDLER;
		};
	};
};

if (CTI_IsClient) then {

	with missionnamespace do {
		CTI_PVF_Client_AIRR_touched={
			SM_Radar_Detected =true;
			SM_Radar_Detected_last=time;
		};
		CTI_PVF_Client_AIRR_mcreate={
			private ["_radar","_obj","_seed","_s","_rs","_color","_marker","_top_radar"];
			_radar=_this select 0;
			_obj= _this select 1;
			_seed=_this select 2;
			_s=getNumber(configFile >> "CfgVehicles" >> typeOf _obj >> "side");
			_rs=switch (_s) do
			{
		  		case 0: { east };
		  		case 1: { west };
		  		case 2: { resistance };
		   		default {resistance};
		  	};
		  	_color=(_rs) call CTI_CO_FNC_GetSideColoration;
			_marker = createMarkerLocal [format ["CTI_R_%1",  _seed], (getPos _obj)];
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerSizeLocal [0.7,0.7];
			_marker setMarkerColorLocal _color;
			_top_radar= (getPosATL _radar);
			_top_radar set [2, (_top_radar select 2 )+35];
			(group player) reveal [_obj, 4];
			_marker setMarkerAlphaLocal 0.7;
			SM_Radar_Detected =true;
			SM_Radar_Detected_last=time;
			While {! CTI_GameOver && alive _obj  && alive _radar } do {
				_alt=(((getPosASLW _obj) select 2) min ((getPosATL _obj) select 2));
				_marker setMarkerTextLocal format ["Unk -- A:%1", floor ( _alt)];
				if (  _alt > Min_Alt && !(terrainIntersect [_top_radar,(getPosATL _obj)]) && !(([_obj,_radar]  call BIS_fnc_distance2D) >Radar_Range) ) then {
					if (markerAlpha _marker == 0) then { _marker setMarkerAlphaLocal 0.7 };
					SM_Radar_Detected_last=time;
				} else {
					if (markerAlpha _marker >0) then { _marker setMarkerAlphaLocal 0 };
				};
				//update
				_marker setMarkerPosLocal (getPos _obj);
				sleep 1;
			};
			deleteMarkerLocal _marker;
		};
	};
	0 spawn{
		while {!CTI_Gameover} do {
			if ((time- SM_Radar_Detected_last) > 180) then {SM_Radar_Detected=false;};
			sleep 1;
		};

	};
};


#define HUD_IDC 1500000
#define	HUD_M_MAX	20
#define	HUD_TARG_MAX	100
#define	HUD_TOWN_MAX	10


HUD_GetRevives=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_GetRevive.sqf";
HUD_ShowRevives=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_ShowRevive.sqf";
HUD_GetTowns=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_GetTowns.sqf";
HUD_ShowTowns=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_ShowTowns.sqf";
HUD_GetTargets=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_GetTargets.sqf";
HUD_ShowTargets=compile preprocessfilelinenumbers "Addons\Strat_mode\HUD\HUD_ShowTargets.sqf";



HUD_UpdateInfo={
	private ["_hud","_basic","_pro","_town","_pb","_t","_co","_running","_ttext","_sl","_marker","_icon","_air_c","_art_c"];
	_hud=_this;

	disableSerialization;
	_basic=(_hud displayCtrl(HUD_IDC+1));
	_pro=(_hud displayCtrl(HUD_IDC+3));
	if (!(profileNamespace getVariable ["HUD_Normal",true]) ||visiblemap) exitWith {_basic ctrlShow false;};
	_basic ctrlShow true;
	// capture
	_town=((player) call CTI_CO_FNC_GetClosestTown);
	if ( player distance _town < CTI_MARKERS_TOWN_AREA_RANGE) then {
		_pro ctrlShow true;
		_pb=((_town getVariable "cti_town_capture")) / CTI_TOWNS_CAPTURE_VALUE_CEIL ;
		if ((_town getVariable ["cti_town_occupation_active",true]) || (_town getVariable ["cti_town_resistance_active",true])) then
		{
			_pro ctrlSetTextColor [1,1,0,1];
		} else {
			_pro ctrlSetTextColor [1,1,1,1];
		};
		_pro progressSetPosition  _pb ;
	} else {
		_pro ctrlShow false;
	};
	//-------INFO -------
	if (CTI_P_SideJoined == resistance) exitWith {};
	_t="<t size='0.75' align='right'>";
	if (missionNamespace getVariable "CTI_EW_ANET" == 1 && ! isNil {( player) getVariable "CTI_Net"} && ! isNil {( player) getVariable "AN_iNet"}) then {
			_co="";
			if (((player) getVariable "AN_iNet") == (player) getVariable "CTI_Net") then {_co=format ["<t color='#00ff00'>%1</t>",(((player) getVariable "CTI_Net") call CTI_CO_FNC_GetSideFromID)]} else {_co=format ["<t color='#ffff00'>%1</t>",(((player) getVariable "CTI_Net") call CTI_CO_FNC_GetSideFromID)]};
			if ((( player) getVariable "CTI_Net"< 0) ) then {_co="<t color='#ff0000'>Forced Dis.</t>"};
		_t=_t+format ["<t size='1'><img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa'/></t> %1 || ",_co];
		};
	_t= _t+format	["%1 <t color='#00ff00'>$$</t> || ",[group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds] ;
	_t=_t+format	["%1 <t color='#ff0000'><img image='A3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa'/></t> || ",ceil( (1- getDammage	player)*100)] ;
	_t=_t+format	["%1 <t color='#0000ff'><img image='\A3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa'/></t><br />",ceil( (1- getfatigue	player)*100)] ;
	_com_name="";
	if (isNull (CTI_P_SideLogic getVariable ["cti_commander",grpnull])) then {
		if (!isnil {CTI_P_SideLogic getVariable ["cti_ai_commander_group", grpNull]}) then {
			if !(isNull (CTI_P_SideLogic getVariable ["cti_ai_commander_group", grpNull])) then {_com_name= format ["%1 (AI)", name leader (CTI_P_SideLogic getVariable ["cti_ai_commander_group", grpNull])]};
		};
	} else {
		_com_name=name (leader  (CTI_P_SideLogic getVariable ["cti_commander",grpnull]));
	};

	if (_com_name == "") then {_com_name = "NONE"};
	_t=_t+ (format ["<t color='#F5D363'>Current Com :</t> %1<br />",_com_name ]);



	_running = CTI_P_SideLogic getVariable "cti_upgrade";
	_ttext = "No Upgrade Running";
		if (_running > -1) then {
			_ttext = format ["%1 :: %2 s left.", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select _running) select 0,CTI_P_SideLogic getVariable "cti_upgrade_lt"];
		};
	_t=_t+ (format ["<t color='#F5D363'>%1 </t><br />",_ttext ]);
	_sl=CTI_P_SideJoined call  CTI_CO_FNC_GetSideLogic;
	{
		_marker = format ["cti_town_marker_%1", _x];

		_icon = switch (getMarkerColor _marker) do
		{
		    case 	"ColorGreen":{ "<t color='#00ff00' size='0.75'><img image='A3\ui_f\data\map\Markers\Military\flag_ca.paa'/></t>" };
		    case 	"ColorBlue":{ "<t color='#0000ff' size='0.75'><img image='A3\ui_f\data\map\Markers\Military\flag_ca.paa'/></t>" };
		    case 	"ColorRed":{ "<t color='#ff0000' size='0.75'><img image='A3\ui_f\data\map\Markers\Military\flag_ca.paa'/></t>" };
		    default { "<t color='#00ff00' size='0.75'><img image='A3\ui_f\data\map\Markers\Military\flag_ca.paa'/></t>"  };
		};
		_t = _t + format ["%2 %1 ",(_x getVariable "cti_town_name"),_icon	]
	} count (_sl getVariable ["CTI_ACTIVE",[]]);
	_t=_t+"<br />";
	if ( (missionNamespace getVariable 'CTI_SM_RADAR')==1 && (count ([CTI_RADAR, ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures)] call CTI_CO_FNC_GetSideStructuresByType) > 0 )) then {
		//_t=_t+"<t underline='true'> Radars:</t><br />";
		_air_c="color='#ffff00'";
		_art_c="color='#ffff00'";
		if (([CTI_P_SideJoined, CTI_UPGRADE_AIRR, 1] call CTI_CO_FNC_HasUpgrade)) then {_air_c="color='#00ff00'";};
		if (([CTI_P_SideJoined, CTI_UPGRADE_ARTR, 1] call CTI_CO_FNC_HasUpgrade)) then {_art_c="color='#00ff00'";};
		if ( SM_Radar_Detected ) then {_air_c="color='#ff0000'";};
		if (count ARTR_MARKERS >0) then {_art_c="color='#ff0000'";};
		_t=_t+"<t size='1.2'><t "+_air_c+"><img image='a3\air_f_gamma\Plane_Fighter_03\Data\UI\map_plane_fighter_03_ca.paa'/></t><t "+_art_c+"><img image='\a3\ui_f\data\gui\cfg\CommunicationMenu\artillery_ca.paa'/></t></t><br />";
		//_t=_t+"<t size='1.75'><t "+_air_c+"><img image='a3\air_f_gamma\Plane_Fighter_03\Data\UI\map_plane_fighter_03_ca.paa'/></t></t><br />";
	};
	_t=_t+"</t>";
	if !(HUD_Normal) then {_t=""};
	_basic ctrlSetStructuredText	parseText	 _t;
};



HUD_UpdateVehicle={
	private ["_hud","_veh","_up_trt","_text","_col2","_col3","_co","_d","_c","_g"];
	_hud=_this;
	disableSerialization;
	_veh=(_hud displayCtrl(HUD_IDC+2));
	if !(profileNamespace getVariable ["HUD_Normal",true]) exitWith {_veh ctrlShow false;};

	_up_trt=if (!( count ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades) == 0)) then {((CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TRT} else {0};

	if (vehicle	player == player  ) then{
		_veh ctrlShow	false;
	} else {
		_veh ctrlShow	true;
		_text="<t align='right'><t size='1'><t color='#00ff00'>";
		_text=_text + getText(configFile >> "CfgVehicles" >> (typeOf (vehicle player)) >> "displayName");
		_text=_text+"</t></t><br /><t size='0.7'>";
		_text=_text+format	["<t color='#00ff00'><img image='A3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa'/>%1</t>", ceil( (1- getDammage	( vehicle player))*100)];
		if ((vehicle player) isKindOf "tank" || (vehicle player) isKindOf "Wheeled_APC_F") then {
			_col2=if ((time - ((vehicle player) getVariable ["TROPHY_time_l",time])) > (60/(1+_up_trt)) )then { "#00ff00" } else {"#ff0000"};
			_col3=if ((time - ((vehicle player) getVariable ["TROPHY_time_r",time])) > (60/(1+_up_trt)) )then { "#00ff00" } else {"#ff0000"};
			_text=_text+format	[" |  Trophy : <t color='%3'>%1</t>|<t color='%4'>%2</t>", (vehicle player) getVariable ["TROPHY_ammo_l",0],(vehicle player) getVariable ["TROPHY_ammo_r",0],_col2,_col3];
		};
		_text=_text+"<br />";
		if (missionNamespace getVariable "CTI_EW_ANET" == 1 && ! isNil {(vehicle player) getVariable "CTI_Net"}) then {
			_co="";
			if (((vehicle player) getVariable ["AN_iNet",-11]) == (vehicle player) getVariable ["CTI_Net",-10]) then {_co=format ["<t color='#00ff00'>%1</t>",(((vehicle player) getVariable "CTI_Net") call CTI_CO_FNC_GetSideFromID)]} else {_co=format ["<t color='#ffff00'>%1</t>",(((vehicle player) getVariable "CTI_Net") call CTI_CO_FNC_GetSideFromID)]};
			if (((vehicle player) getVariable "CTI_Net"< 0) ) then {_co="<t color='#ff0000'>Forced Dis.</t>"};
			if (((vehicle player) getVariable ["AN_Hacked",0])>0) then {_co=_co+format[" | Hacked (<t color='#ff0000'>%1</t> s)",floor ((vehicle player) getVariable ["AN_Hacked",0]) ];};
		_text=_text+format ["Net: %1 <br />---------<br />",_co];
		};
		_d=driver	(vehicle	player);
		if (!isNull	_d && isPlayer	_d) then {_text=_text + 	format	["%1<img image='Rsc\Pictures\i_driver.paa'/><br />",name _d];};
		_c=commander (vehicle	player);
		if (!isNull	_c && isPlayer	_c) then {_text=_text + 	format	["%1<img image='Rsc\Pictures\i_commander.paa'/><br />",name _c];};
		_g=gunner (vehicle	player);
		if (!isNull	_g && isPlayer	_g) then {_text=_text + 	format	["%1<img image='Rsc\Pictures\i_gunner.paa'/><br />",name _g];};
		{
				if (isplayer _x && !(commander (vehicle	player) == _x || driver	(vehicle	player) ==_x || gunner (vehicle	player) ==_x )) then {
					_text=_text + 	format	["%1<img image='Rsc\Pictures\i_turrets.paa'/><br />",name _x];
				};
		} forEach crew (vehicle	player);
		_text=_text+"</t></t>";
		if !(HUD_Normal) then {_t=""};
		_veh ctrlSetStructuredText	parseText	 _text;
	};
};



HUD_Revive_frame={
	["ReviveFrame", "onEachFrame", "{
	 	disableSerialization;
		_hud=uiNamespace getVariable 'HUD';
		[_hud] call HUD_ShowRevives;
	}"] call BIS_fnc_addStackedEventHandler;
};
HUD_AddFrameHandler={
	["hudFrame", "onEachFrame", "{
	 	disableSerialization;
		_hud=uiNamespace getVariable 'HUD';
		[_hud] call HUD_ShowTargets;
		[_hud] call HUD_ShowTowns;
	}"] call BIS_fnc_addStackedEventHandler;
};

HUD_RemoveFrameHandler={
	["hudFrame", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
};
/*
0 spawn {
	disableSerialization;
	_hud=uiNamespace getVariable 'HUD';
	while {!CTI_GameOver} do {
		[_hud] call HUD_ShowTargets;
		//[_hud] call HUD_ShowTowns;
		[_hud] call HUD_ShowRevives;
	};
};*/

0 call HUD_Revive_frame;

0 spawn {
	while {!CTI_GameOver} do {
		waitUntil {([CTI_P_SideJoined, CTI_UPGRADE_HUD, 1] call CTI_CO_FNC_HasUpgrade || CTI_Debug) && profileNamespace getVariable ["HUD_Tactical",true]};
			HUD_Targets = (0) call HUD_GetTargets;
			//HUD_Targets = (0) exec "Addons\Strat_mode\HUD\HUD_GetTargets.sqf";
			HUD_Towns = (0) call HUD_GetTowns;
		sleep 5;
	};
};

0 spawn {
	while {!CTI_GameOver} do {
			disableSerialization;
			_hud=uiNamespace getVariable 'HUD';
			(_hud) call HUD_UpdateInfo;
			(_hud) call HUD_UpdateVehicle;
			HUD_Revives = (0) call HUD_GetRevives;
			sleep 2;
	};
};







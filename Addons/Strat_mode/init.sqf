/* NOTE

* Need to disactivate base allocation
* in init.sqf after < execVM "Common\Init\Init_Locations.sqf"; >

 0 execVM "Addons\Strat_mode\init.sqf";

* in init_location

	if (missionNamespace getVariable "CTI_GAMEPLAY_STRATEGIC" == 0) then {
		(_town) execFSM "Server\FSM\town_capture.fsm";
		(_town) execFSM "Server\FSM\town_resistance.fsm";
		if (missionNamespace getVariable "CTI_TOWNS_OCCUPATION" > 0) then {(_town) execFSM "Server\FSM\town_occupation.fsm"};
	} else {
		(_town) execFSM "Addons\Strat_mode\FSM\town_capture.fsm";
		(_town) execFSM "Addons\Strat_mode\FSM\town_resistance.fsm";
		if (missionNamespace getVariable "CTI_TOWNS_OCCUPATION" > 0) then {(_town) execFSM "Addons\Strat_mode\FSM\town_occupation.fsm"};

	};
};


*/

//Functions
with missionNamespace do {
		CTI_SM_Connect_Towns=compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_F_TownConnect.sqf";
		CTI_SM_Allow_Capture = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Allow_Capture.sqf";
		CTI_SM_Mortars_script = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Mortar.sqf";
		CTI_SM_Draw_Connect_Towns=compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_F_TownDrawConnect.sqf";
		CTI_SM_Map_setup = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Map_Setup.sqf";
		CTI_SM_Connect = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Connect.sqf";
		TR_PROJ_HANDLER = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\TR_proj_handler.sqf";
		TR_HANDLER = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\TR_handler.sqf";
		F_REVAMP = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\F_revamp.sqf";
		SM_BP_Init = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_Init.sqf";
		SM_BP_Hook = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_Hook.sqf";
		SM_BP_Link = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_Link.sqf";
	 	SM_BP_DetectLoop = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_DetectLoop.sqf";
	 	SM_BP_ProtectLoop = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_ProtectLoop.sqf";
		SM_Maps_Hook = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Maps_Hook.sqf";
	  	REV_INIT = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\REV\REV_init.sqf";
	  	SM_ACTION_BUILD = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Action_Build.sqf";
	    SM_ACTION_REPAIR = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Action_Repair.sqf";
	    SM_COM_Init = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Old_Com_Eject\SM_COM_init.sqf";
	   	HCGA_Init = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\HC_GA\HCGA_Init.sqf";
	   	UAV_FUEL = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\UAV_Fuel.sqf";
	   	UAV_RANGE = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\UAV_Range.sqf";
	   	DYNG_WAIT = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\DYNG_waitforgroup.sqf";
	   	DYNG_SERVERLOOP = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\DYNG_serverloop.sqf";

};

//Common stuff
CTI_SM_MAX_ACTIVE = 2;
CTI_REDEPLOY=false;
SM_MAP_READY=false;
HUD_WRITE=false;
CTI_ANET_Con=False;
CTI_ANET_Obj=False;
SM_Ask_Town=objNull;
Client_AN_Connected=True;
HUD_T_OBJ=[];



0 call SM_COM_Init;

if (CTI_IsServer) then {

		//constants for the server
	{
		_sl=_x call CTI_CO_FNC_GetSideLogic;
		_sl setVariable ["CTI_ACTIVE",[],true];
		_sl setVariable ["CTI_AVAILLABLE",[],true];
		_sl setVariable ["CTI_PREVENT",objNull,false];
		_sl setVariable ["CTI_PRIORITY",objNull,true];
		_sl setVariable ["CTI_HUD_SHARED",[],true];
		CTI_BASES_NEIGH=[];
		for "_i" from 1 to CTI_BASE_AREA_MAX do {	CTI_BASES_NEIGH=CTI_BASES_NEIGH + [[]];	};
		_sl setVariable ["CTI_BASES_NEIGH",CTI_BASES_NEIGH,true];
		_sl setVariable ["CTI_BASES_FOUND",[],true];
	} count [east,west];

	//dynamic group loop
	0 spawn DYNG_SERVERLOOP;

	//PVF
	with missionNamespace do {


		CTI_PVF_Server_Mortars_Towns = {
			_req_p=_this;
			_ac_s=((side _this) call CTI_CO_FNC_GetSideLogic) getVariable ["CTI_ACTIVE",[]];
			{
				[["CLIENT", _req_p], "Client_Update_Mortars",[_x, (_x getVariable "cti_town_mortars")]] call CTI_CO_FNC_NetSend;
			} forEach _ac_s;
		};

		CTI_PVF_Server_Priority_Targ ={
			_req_p=_this;
			if (! isNull (missionNamespace getVariable format ["CTI_PRIORITY_%1",(side _req_p)])) then {
				[["CLIENT",_req_p], "Client_SM_priority",(missionNamespace getVariable format ["CTI_PRIORITY_%1",(side _req_p)])] call CTI_CO_FNC_NetSend;
			};
		};


		CTI_PVF_Server_Hud_Share_Add= {
			_this spawn {
				_sl= (_this select 1) call CTI_CO_FNC_GetSideLogic;
				while {HUD_WRITE} do {sleep random (1);};
				HUD_WRITE=true;
				_hud =_sl getVariable "CTI_HUD_SHARED";
				_hud=_hud -[objNull] + (_this select 0);
				{
					[_x,(_this select 1)] spawn {
						_o=(_this select 0);
						_side=(_this select 1);
						_sl= (_this select 1) call CTI_CO_FNC_GetSideLogic;
						_to=time+180;
						//waitUntil {({_x knowsabout _o >(missionNamespace getVariable "CTI_EW_HUD_S")} count (_side call CTI_CO_FNC_GetSidePlayerGroups) == 0 )};
						waitUntil {time > _to};
						while {HUD_WRITE} do {sleep random (1);};
						HUD_WRITE=true;
						_hud =_sl getVariable "CTI_HUD_SHARED";
						_hud=_hud -[objNull] - [_o];
						_sl setVariable ["CTI_HUD_SHARED",_hud,true];
						HUD_WRITE=false;
					}; true
				} count (_this select 0);
				//if !((_this select 0) in _hud) then { _hud set [count _hud, (_this select 0)]};
				_sl setVariable ["CTI_HUD_SHARED",_hud,true];
				HUD_WRITE=false;
				// [["CLIENT",(_this select 1)], "Client_HUD_reveal",[(_this select 0)]] call CTI_CO_FNC_NetSend;
			};
		};

		CTI_PVF_Server_Addeditable= {
    	(_this select 0) addCuratorEditableObjects [[_this select 1],true] ;
		};

		CTI_PVF_Server_Assign_Zeus= {
  		_this  assignCurator ADMIN_ZEUS;
		};
		CTI_PVF_Server_UAV_FUEL={
			if (missionNamespace getvariable "CTI_GAMEPLAY_DARTER_FUEL" > 0) then {
				_this spawn UAV_FUEL;
			};
		};
	};

};

if (CTI_IsClient) then {
	//PFV
	with missionNamespace do {
		//print a message
		CTI_PVF_SM_message={ CTI_P_ChatID commandChat format ["Strat Mode : %1 ",_this] };


		// Connect Marker 2 positions (POs1,POs2, color, offset)
		CTI_PVF_Client_Connect = {(_this) call CTI_SM_Connect;};

		// Update Mortar POsition (town, pos)
		CTI_PVF_Client_Update_Mortars = {
			_town = _this select 0;
			_pos = _this select 1;
			_mortar_zone = Format ["cti_town_mortar_zone_%1", _town];
			_mortar= Format ["cti_town_mortar_%1", _town];
			_mortar setMarkerPosLocal _pos;
			_mortar_zone setMarkerPosLocal _pos;
		};

		// Update  one base zone
		CTI_PVF_Client_Base_Zone = {
			_side=_this select 0;
			_num= _this select 1;
			_pos=_this select 2;
			_marker = createMarkerLocal [(format ["cti_base_%1_%2",_side,_num]), _pos];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerBrushLocal "DiagGrid";
			_marker setMarkerSizeLocal [CTI_BASE_AREA_RANGE,CTI_BASE_AREA_RANGE];
			_marker setMarkerColorLocal  ((_side) call CTI_CO_FNC_GetSideColoration);
			_marker setMarkerAlphaLocal 0.5;
		};
		CTI_PVF_SetFuel={
			diag_log format [":: Fuel :: setting %1 at %2", _this select 0 , _this select 1];
			(vehicle (_this select 0)) setfuel (_this select 1);
		};
	};

	waitUntil {! isNil  {missionNamespace getVariable "CTI_PVF_Client_Base_Zone"} && ! isNil {missionNamespace getVariable "CTI_PVF_Client_Update_Mortars"} && ! isNil  {missionNamespace getVariable "CTI_PVF_Client_Connect"}&&  ! isNil {missionNamespace getVariable "CTI_PVF_SM_message"} };
	if ( (missionNamespace getVariable 'CTI_SM_MORTARS')==1) then {
		{
			_town=_x;
			_marker = createMarkerLocal [format ["cti_town_mortar_%1", _town], getPos _town];
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerTextLocal format ["Mortar Team - %1",(_town getVariable "cti_town_name")];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerSizeLocal [0.5,0.5];
			_marker setMarkerAlphaLocal 0;

			_marker = createMarkerLocal [format ["cti_town_mortar_zone_%1", _town], getPos _town];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerBrushLocal "Border";
			_marker setMarkerSizeLocal [400,400];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerAlphaLocal 0;
		} forEach CTI_Towns;
	};
};


//Game Dynamics

if (CTI_IsServer) then {

		// Date init
		_it=0;
		_possible_it_off=[0,0,0,0,0,0,6,6,6,12,12,12,18];
		if ((missionNamespace getVariable "CTI_WEATHER_INITIAL") < 10) then {
			_it=(missionNamespace getVariable "CTI_WEATHER_INITIAL")*6;
		} else {
			_it= _possible_it_off select floor random (count _possible_it_off);
		};
		skipTime _it;

		// dynamic wheather
		if ( CTI_WEATHER_DYNAMIC == 1) then {
		 execVM "Addons\DynamicWeatherEffects\randomWeather2.sqf"
		};

		// Strat mode init
		0 call CTI_SM_Map_setup;
		//if ( (missionNamespace getVariable 'CTI_SM_STRATEGIC')==1) then {
			{_x spawn CTI_SM_Allow_Capture;true} count [east,west];
		//};

		// Bse prot Init
		//if ( (missionNamespace getVariable 'CTI_SM_BASEP')==1) then {
			 //0 spawn CTI_SM_Base_Prot;
			 {_x spawn SM_BP_Hook;true} count [east,west];
		//};

		// Patrols

		0 execVM "Addons\Strat_mode\PATROL_AI\PAI_Init.sqf";


		// air radar
		if (missionNamespace getVariable "CTI_SM_RADAR" == 1) then {
			0 execVM "Addons\Strat_mode\Radar\ARTR_init.sqf";
			0 execVM "Addons\Strat_mode\Radar\AIRR_init.sqf";
		};
		//sling aug
		0 execVM "Addons\Strat_mode\SLING_AUG\SA_Init.sqf";


		//cleanupS
		0 execVM "Addons\Strat_mode\Functions\SM_CleanUp.sqf";
   		0 execVM "Addons\Strat_mode\Functions\SM_AttachStatics.sqf";
		0 execVM "Addons\Strat_mode\Functions\SM_Town_CAS.sqf";

		// Zeus admin for players
		if !( isNil "ADMIN_ZEUS") then {
			0 spawn {
				while {!CTI_GameOver} do {
					ADMIN_ZEUS addCuratorEditableObjects [playableUnits,true];
					sleep 5;
				};
			};
		};


		// henroth air loadout
		if ((missionNamespace getVariable "CTI_AC_ENABLED")>0) then{
			0 execVM "Addons\Henroth_AirLoadout\init.sqf"
		};
		// hc balance
		0 spawn HCGA_Init;

		// PhysX artifacts cleanup
		/*if ((missionNamespace getVariable "CACHE_EMPTY") == 1) then {
			0 spawn {
				while {!CTI_Gameover} do {
					{if !(simulationEnabled _x ) then {_x enableSimulationGlobal True};True} count (allUnits + vehicles + allDead );
					sleep 600;
				};
			};
		};*/

		/*{
			(_x) execFSM "Addons\Strat_mode\FSM\shared_objectives.fsm";
		} forEach [east,west];*/

};

if (CTI_IsClient) then {


	//New Map if Adv Network
	0 spawn SM_Maps_Hook;

	// Persistent Gear tracking
	if (CTI_PLAYER_REEQUIP == 2) then {
		0 spawn {
			while {true} do {
				if (alive player && !isnull player && !CTI_P_Respawning && vehicle player == player) then {CTI_P_LastPurchase=(player) call CTI_UI_Gear_GetUnitEquipment; };
				sleep 2;
			};
		};
	};

	// dynamic wheather
	if ( CTI_WEATHER_DYNAMIC == 1) then {
	 execVM "Addons\DynamicWeatherEffects\randomWeather2.sqf"
	};

	// NEW Revive
	if (CTI_SM_FAR == 1) then {
		0 spawn REV_INIT;
		//call compileFinal preprocessFileLineNumbers "Addons\FAR_revive\FAR_revive_init.sqf";
	};

	// Thermal / NV restriction
	if ( (missionNamespace getVariable 'CTI_SM_NONV')==1) then {
		0 execVM "Addons\Strat_mode\Functions\SM_NvThermR.sqf";
	};

	//sling aug
	0 execVM "Addons\Strat_mode\SLING_AUG\SA_Init.sqf";

	// 3P restrict
  0 execVM "Addons\Strat_mode\Functions\SM_3pRestrict.sqf";

  // Statics on offroads handlers
  0 execVM "Addons\Strat_mode\Functions\SM_AttachStatics.sqf";
 if ( (missionNamespace getVariable 'CTI_SM_STRATEGIC')==1) then { 0 call CTI_SM_Draw_Connect_Towns;};


	//adaptative group size
	if ( CTI_PLAYERS_GROUPSIZE == 0) then {
		0 execVM "Addons\Strat_mode\Functions\SM_AdaptGroup.sqf";
	};
 	// fatique revamp
  	0 spawn F_REVAMP;

  	// a Radar
	if (missionNamespace getVariable "CTI_SM_RADAR" == 1) then {
		0 execVM "Addons\Strat_mode\Radar\ARTR_init.sqf";
		0 execVM "Addons\Strat_mode\Radar\AIRR_init.sqf";
	};

  // vehicle repairs and forcelock
  if ( (missionNamespace getVariable 'CTI_SM_REPAIR')==1) then {
		0 execVM "Addons\Strat_mode\Functions\SM_RepairVehicule.sqf";
	};

  // Strat Mode Help and fuctions
	//if ( (missionNamespace getVariable 'CTI_SM_STRATEGIC')==1) then {
		0 execVM "Addons\Strat_mode\Functions\SM_DrawHelp.sqf";
		if !((side player) == resistance) then{
			0 execVM "Addons\Strat_mode\Functions\SM_Orders.sqf";
			0 execVM "Addons\Strat_mode\Functions\SM_TownPriority.sqf";
		};
	//};


	// henroth air loadout
	if ((missionNamespace getVariable "CTI_AC_ENABLED")>0) then{
		0 execVM "Addons\Henroth_AirLoadout\init.sqf"
	};

	// Strategic markers
	0 spawn {
		waitUntil {!isNil 'CTI_InitTowns'};
		sleep 1;
		if !(CTI_P_SideJoined == resistance) then {
			//if (missionNamespace getVariable "CTI_SM_STRATEGIC" == 1) then {
				execFSM "Addons\Strat_mode\FSM\town_markers.fsm";
			/*} else {
				execFSM "Client\FSM\town_markers.fsm";
			};*/
		};
	};

	// HUD
	if (missionNamespace getVariable "CTI_EW_HUD" == 1 ) then {
		0 execVM	 "Addons\Strat_mode\HUD\HUD_init.sqf";
	};

	// JIP
	0 spawn {
		if ((side player) == resistance) exitWith {false};
		sleep 5;
		if ( (missionNamespace getVariable 'CTI_SM_MORTARS')==1) then {
			["SERVER", "Server_Mortars_Towns", player] call CTI_CO_FNC_NetSend;
		};

		if ( (missionNamespace getVariable 'CTI_SM_BASEP_M')!=0) then {
			waitUntil {!isNil {CTI_P_SideLogic getVariable "CTI_BASES_NEIGH"} && !isNil {CTI_P_SideLogic getVariable "CTI_BASES_FOUND"} };
			_ci=0;
			{
				_b=_x;
				[CTI_P_SideJoined,_ci,_x] call CTI_PVF_Client_Base_Zone;
				_n= (CTI_P_SideLogic getVariable "CTI_BASES_NEIGH") select _ci;
				{ [_b,getPos _x,((CTI_P_SideJoined) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2] call CTI_SM_Connect;true}count _n;
				_ci=_ci+1;
				true
			} count (CTI_P_SideLogic getVariable "cti_structures_areas");
			_enemy = switch (CTI_P_SideJoined) do
			{
	   	 	case west: {east };
	    	case east: {west };
			};
			_ci=0;
			_enemylogic= (_enemy) call CTI_CO_FNC_GetSideLogic;
			{
				_b=(_enemylogic getVariable "cti_structures_areas") select _x;
				[_enemy,_x,_b] call CTI_PVF_Client_Base_Zone;
				_n= (_enemylogic getVariable "CTI_BASES_NEIGH") select _x;
				{ [_b,getPos _x,((_enemy) call CTI_CO_FNC_GetSideColoration),(CTI_BASE_AREA_RANGE)*2] call CTI_SM_Connect;true}count _n;
				_ci=_ci+1;
				true
			} count (CTI_P_SideLogic getVariable "CTI_BASES_FOUND");

		};
	};

  //UAV lim

	if ((missionNamespace getVariable "CTI_GAMEPLAY_DARTER") >0 ) then {
		["darter","onEachFrame",'call UAV_RANGE ' ] call BIS_fnc_addStackedEventHandler;
	};


};

CTI_Init_Strat=True;
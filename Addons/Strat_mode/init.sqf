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
		F_REVAMP_FRAME = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\F_revamp_frame.sqf";
		SM_BP_Init = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_Init.sqf";
		SM_BP_Hook = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_Hook.sqf";
		SM_BP_Link = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_Link.sqf";
	 	SM_BP_DetectLoop = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_DetectLoop.sqf";
	 	SM_BP_ProtectLoop = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_BP_ProtectLoop.sqf";
		SM_Maps_Hook = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Maps_Hook.sqf";
	  	REV_INIT = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\REV\REV_init.sqf";
	  	SM_ACTION_BUILD = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Action_Build.sqf";
	    SM_ACTION_REPAIR = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Action_Repair.sqf";
	    SM_ACTION_DISMANTLE = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Action_Dismantle.sqf";
	    SM_COM_Init = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Old_Com_Eject\SM_COM_init.sqf";

	   	UAV_FUEL = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\UAV_Fuel.sqf";
	   	UAV_RANGE = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\UAV_Range.sqf";
	   	DYNG_WAIT = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\DYNG_waitforgroup.sqf";
	   	DYNG_SERVERLOOP = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\DYNG_serverloop.sqf";
	   	H_PROTECT_WHEELS= compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\handler_protec_wheels.sqf";
	   	WEATHER_HOOK= compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\WEATHER_HOOK.sqf";
	   	TUTO_Init_Client= compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\TUTORIAL_init_client.sqf";
	   	KK_fnc_setPosAGLS= compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\KK_fnc_setPosAGLS.sqf";
	   	SM_REPAIRVEHICLEREMOTE= compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_RepairVehiculeRemote.sqf";
	   	CTI_SM_Mines_script = compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\SM_Mines.sqf";

	   	TASKS_LOOP= compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Functions\TASKS_loop.sqf";
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

with missionNamespace do {

	CTI_PVF_Protect_Wheels ={
		_this addEventHandler ["HandleDamage",{_this call H_PROTECT_WHEELS}];
	};
	CTI_PVF_Repair_vehicle ={
		if (local (_this select 0)) then {_this call SM_REPAIRVEHICLEREMOTE ;};
	};
};



waitUntil {CTI_EAST getVariable ["CTI_LOAD_COMPLETED",false]};

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
		if (count (_sl getVariable ["CTI_BASES_FOUND",[]]) == 0) then {
			_sl setVariable ["CTI_BASES_FOUND",[],true];
		};
	true
	} count [east,west];

	//dynamic group loop
	0 spawn DYNG_SERVERLOOP;
	0 execFSM "Addons\Strat_mode\FSM\TEAMSTACK_count.fsm";
	//PVF
	with missionNamespace do {
		CTI_PVF_Server_Transfer_funds ={
			_group_from= _this select 0;
			_fund_from= _this select 1;
			_group_to= _this select 2;
			_value= _this select 3;
			_com= (side _group_from) call CTI_CO_FNC_GetSideCommander;
			if (((_group_from getvariable "cti_funds") - (missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side _group_from]) < _value && _group_from != _com )|| (_group_from == _com && ((side _group_from) call CTI_CO_FNC_GetFundsCommander) < _value )  ) exitWith {};
			if (_group_to != _com) then {[_group_to, side _group_to, _value] call CTI_CO_FNC_ChangeFunds;
			} else {
				[(side _group_to), _value] call CTI_CO_FNC_ChangeFundsCommander;
			};
			if (_group_from != _com) then {[_group_from, side _group_from,  - _value] call CTI_CO_FNC_ChangeFunds;
			} else {
				[(side _group_from), - _value] call CTI_CO_FNC_ChangeFundsCommander;
			};


			if (isPlayer leader _group_from) then {
				_uid=getPlayerUID (leader _group_from );
				if !(isNil "_get") then {
					_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid];
					_get set [2,floor (_group_from getVariable "cti_funds")];
					missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _x],_get];
				};
			};
			if (isPlayer leader _group_to) then {
				[["CLIENT", leader _group_to], "Client_OnMessageReceived", ["funds-transfer", [_value ,(_group_from)]]] call CTI_CO_FNC_NetSend;
			};
		};

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

			_sl= (_this select 1) call CTI_CO_FNC_GetSideLogic;
			while {HUD_WRITE} do {sleep random (1);};
			HUD_WRITE=true;
			_hud =_sl getVariable ["CTI_HUD_SHARED",[]];


			//cleanup
			_delete=+ [];
			{
				_obj = _x select 0;
				_timeout= _x select 1;
				if( isNull _obj || time > _timeout) then {_delete pushBack _forEachIndex;};
			}  forEach  _hud;

			{_hud deleteAt _x;true} count _delete;
			//new objects
			{
				_new_obj= _x select 0;
				_new_timeout= _x select 1;
				_find=(_hud findif {_x select 0 == _new_obj});
				if (_find == -1) then {
					_hud pushBack _x;
					_new_obj setVariable ["CTI_HUD_Detected",_new_timeout,true];
				};
				true
			}count (_this select 0);



			_sl setVariable ["CTI_HUD_SHARED",_hud,true];
			HUD_WRITE=false;

		};



		CTI_PVF_Server_Addeditable= {
    	(_this select 0) addCuratorEditableObjects [[_this select 1],true] ;
		};

		CTI_PVF_Server_Assign_Zeus= {
  		_this  assignCurator ADMIN_ZEUS;
		};
	};

};

if (CTI_IsClient) then {
	//PFV
	with missionNamespace do {
		//print a message
		CTI_PVF_SM_message={ HUD_NOTIFICATIONS pushBack [format [localize "STR_Strat",_this],time+10000,"ffffff"] };


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
		CTI_PVF_Client_UAVSetFuel={
			if (_this isKindOf "Helicopter_Base_F") then {_this spawn UAV_FUEL;};
		};
	};

	waitUntil {! isNil  {missionNamespace getVariable "CTI_PVF_Client_Base_Zone"} && ! isNil {missionNamespace getVariable "CTI_PVF_Client_Update_Mortars"} && ! isNil  {missionNamespace getVariable "CTI_PVF_Client_Connect"}&&  ! isNil {missionNamespace getVariable "CTI_PVF_SM_message"} };
	if ( (missionNamespace getVariable 'CTI_SM_MORTARS')==1) then {
		{
			_town=_x;
			_marker = createMarkerLocal [format ["cti_town_mortar_%1", _town], [-99999,-99999,0]];
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerTextLocal format [localize "STR_MortarTeam",(_town getVariable "cti_town_name")];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerSizeLocal [0.5,0.5];
			_marker setMarkerAlphaLocal 0;

			_marker = createMarkerLocal [format ["cti_town_mortar_zone_%1", _town], [-99999,-99999,0]];
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
		//skipTime _it;
		//[H]Tom - loading saved time
		if (!(profileNamespace getvariable ["CTI_SAVE_ENABLED",false])) then {skipTime _it;};

		// dynamic wheather
		0 spawn WEATHER_HOOK;

		// Strat mode init
		0 call CTI_SM_Map_setup;
		{_x spawn CTI_SM_Allow_Capture;true} count [east,west];
		{_x spawn SM_BP_Hook;true} count [east,west];


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
		0 execVM "Addons\Strat_mode\Functions\SM_Town_Ship.sqf";

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

		// time compression
		0 spawn {
			_day_ratio=14/CTI_WEATHER_FAST;
			_nigth_ratio=10/CTI_WEATHER_FAST_NIGTH;
			_sunrise = 5;
			_sunset = 19;
			if (ISLAND == 3) then {_sunrise = 7; _sunset = 18;};
			while {!CTI_Gameover} do {
				if (daytime > _sunrise && daytime < _sunset) then {
					if (timeMultiplier != _day_ratio) then  {setTimeMultiplier _day_ratio;};
				} else {
					if (timeMultiplier !=  _nigth_ratio) then {setTimeMultiplier _nigth_ratio;};
				};
				sleep 120;
			};

		};
		// Tasks loop
		{_x spawn TASKS_LOOP;} foreach [east,west];

};

if (CTI_IsClient) then {

	//tutorial
	0 call TUTO_Init_Client;
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


	// NEW Revive
	if (CTI_SM_FAR == 1) then {
		0 spawn REV_INIT;

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
  	if (missionNamespace getVariable "CTI_UNITS_FATIGUE" == 1) then {
  		["F_FRAME", "onEachFrame", {0 call F_REVAMP_FRAME}] call bis_fnc_addStackedEventHandler;
  	};

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

	//0 execVM "Addons\Strat_mode\Functions\SM_DrawHelp.sqf";
	if !((side player) == resistance) then{
		0 execVM "Addons\Strat_mode\Functions\SM_Orders.sqf";
		0 execVM "Addons\Strat_mode\Functions\SM_TownPriority.sqf";
	};



	// henroth air loadout
	if ((missionNamespace getVariable "CTI_AC_ENABLED")>0) then{
		0 execVM "Addons\Henroth_AirLoadout\init.sqf"
	};

	// Strategic markers
	0 spawn {
		waitUntil {!isNil 'CTI_InitTowns'};
		sleep 1;
		if !(CTI_P_SideJoined == resistance) then {

			execFSM "Addons\Strat_mode\FSM\town_markers.fsm";

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
			waitUntil { (missionNamespace getvariable "CTI_PERSISTANT" == 0) || ((missionNamespace getvariable "CTI_PERSISTANT" == 1) && CTI_P_SideLogic getVariable ["CTI_LOAD_COMPLETED",false])};
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
		["darter","onEachFrame",{0 call UAV_RANGE } ] call BIS_fnc_addStackedEventHandler;
	};




};

CTI_Init_Strat=True;
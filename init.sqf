//--- Initial View Distance and Object View Distance for both clients and server
setViewDistance 4000;
setObjectViewDistance 4000;

NET_LOG=False;

MADE_FOR_STRATIS=false;
//--- Early definition, will be override later on in the init files.
CTI_P_SideJoined = civilian;


//CTI_DEBUG = true;
CTI_DEBUG = false;

//--- Log levels
CTI_Log_Debug = 3;
CTI_Log_Information = 2;
CTI_Log_Warning = 1;
CTI_Log_Error = 0;

//--- Log level to use
CTI_Log_Level = 0;

//--- We define the log function early so that we can use it
CTI_CO_FNC_Log = compile preprocessFileLineNumbers "Common\Functions\Common_Log.sqf";

//--- Global gameplay variables
CTI_GameOver = false;
CTI_Init_Client=false;
CTI_InitTowns=false;
CTI_Init_Server =false;
CTI_Init_Strat=false;
//--- Determine which machine is running this init script
CTI_IsHostedServer = if (isServer && !isDedicated) then {true} else {false};
CTI_IsServer = if (isDedicated || CTI_IsHostedServer) then {true} else {false};
CTI_IsClient = if (CTI_IsHostedServer || !isDedicated) then {true} else {false};
CTI_IsHeadless = if !(hasInterface || isDedicated) then {true} else {false};

CTI_TEAMSTACK_EAST=0;
CTI_TEAMSTACK_WEST=0;


if (CTI_Log_Level >= CTI_Log_Information) then { //--- Information
	["INFORMATION", "FILE: init.sqf", format["Environment is Multiplayer? [%1]", isMultiplayer]] call CTI_CO_FNC_Log;
	["INFORMATION", "FILE: init.sqf", format["Current Actor is: Hosted Server [%1]? Dedicated [%2]? Client [%3]? Headless [%4]?", CTI_IsHostedServer, isDedicated, CTI_IsClient, CTI_IsHeadless]] call CTI_CO_FNC_Log
};



//--- Hide first to prevent spoils
if (CTI_IsClient && isMultiplayer) then {
	0 spawn {
		waitUntil {!(isNull player)};

		while {side player == civilian} do
		{
		 		player enableSimulation true;
		 		player allowDamage true;
				player setCaptive false;
				player setDammage 1;
		    12452 cutText ["Respawning wounded client...(if blocked there press ESC> RESPAWN, go back in the lobby and rejoin)", "BLACK FADED", 50000];
		    waitUntil {alive player};
				sleep 1;
		};
	};
};

//--- In MP, we get the parameters.
if (isMultiplayer) then {call Compile preprocessFileLineNumbers "Common\Init\Init_Parameters.sqf"};

//--- Server JIP/DC Handler
if (isMultiplayer && CTI_IsServer) then {
	CTI_SE_FNC_OnPlayerConnected = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnPlayerConnected.sqf";
	CTI_SE_FNC_OnPlayerDisconnected = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnPlayerDisconnected.sqf";
	_null=["CTI_Join", "onPlayerConnected", {[_uid, _name, _id] spawn CTI_SE_FNC_OnPlayerConnected}] call BIS_fnc_addStackedEventHandler;
	_null = ["CTI_Left", "onPlayerDisconnected", {[_uid, _name, _id] spawn CTI_SE_FNC_OnPlayerDisconnected}] call BIS_fnc_addStackedEventHandler;
};

//--- JIP Part is over
CTI_Init_JIP = true;

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: init.sqf", "Running common initialization"] call CTI_CO_FNC_Log };

//--- Common Part execution
call compile preprocessFileLineNumbers "Common\Init\Init_CommonConstants.sqf";
call compile preprocessFileLineNumbers "Common\Init\Init_Common.sqf";
CTI_InitTowns = false;
//--- Towns init
execVM "Common\Init\Init_Locations.sqf";



if (missionNamespace getVariable "CTI_EW_ANET" == 1) then {
0 execVM "Addons\Strat_mode\AdvNet\AN_Init.sqf";
};


//--- Common Part is over
CTI_Init_Common = true;

//--- Server execution
if (CTI_IsServer) then {
	// load player saved informations
	CTI_PLAYER_VARIABLES=[];
	if (missionNamespace getvariable "CTI_PERSISTANT" == 1) then {
		if (profileNamespace getvariable ["CTI_SAVE_ENABLED",false]) then {
			_players= profileNamespace getVariable ["CTI_SAVE_PLAYERS",[]];
			{ diag_log format [" :: SAVE ::Loading player %1 ",(_x select 1 )];missionNamespace setVariable [_x select 0,_x select 1];CTI_PLAYER_VARIABLES pushBack (_x select 0); true} count _players;
		};
	};
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: init.sqf", "Running server initialization"] call CTI_CO_FNC_Log	};
	execVM "Server\Init\Init_Server.sqf";
};

//--- Pure client execution
if (CTI_IsClient && !CTI_IsHeadless) then {
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: init.sqf", "Running client initialization"] call CTI_CO_FNC_Log	};

	//waitUntil {!(isNull player)};

	execVM "Client\Init\Init_Client.sqf";
};

//--- Headless client execution
if (CTI_IsHeadless) then {
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: init.sqf", "Running headless client initialization"] call CTI_CO_FNC_Log };

	//execVM "Client\Init\Init_Client_Headless.sqf";
};

//--- Set the group ID

waitUntil {CTI_Init_Client || CTI_Init_Server};
0 execVM "Addons\Strat_mode\init.sqf";
waitUntil {CTI_Init_Strat};
0 execVM "changelog.sqf";

addMissionEventHandler ["Loaded",{execVM "Client\Init\Init_Client.sqf";execVM "Addons\strat_mode\init.sqf";}];
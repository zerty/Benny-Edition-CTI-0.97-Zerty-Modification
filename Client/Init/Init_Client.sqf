#define DIK_TAB             0x0F
#define DIK_U               0x16
#define DIK_TILDE             0x29


NET_LOG=false;

CTI_P_SideJoined = side player;

CTI_P_SideID = CTI_P_SideJoined call CTI_CO_FNC_GetSideID;
CTI_P_SideLogic = CTI_P_SideJoined call CTI_CO_FNC_GetSideLogic;

player setPos ([getMarkerPos format["CTI_%1Respawn", CTI_P_SideJoined], 3, 15] call CTI_CO_FNC_GetRandomPosition); //--- Preplace

CTI_CL_FNC_AddMissionActions = compileFinal preprocessFile "Client\Functions\Client_AddMissionActions.sqf";
CTI_CL_FNC_ChangePlayerFunds = compileFinal preprocessFile "Client\Functions\Client_ChangePlayerFunds.sqf";
CTI_CL_FNC_DisplayMessage = compileFinal preprocessFile "Client\Functions\Client_DisplayMessage.sqf";
CTI_CL_FNC_GetAIDigit = compileFinal preprocessFile "Client\Functions\Client_GetAIDigit.sqf";
CTI_CL_FNC_GetAIOrderLabel = compileFinal preprocessFile "Client\Functions\Client_GetAIOrderLabel.sqf";
CTI_CL_FNC_GetIncomes = compileFinal preprocessFile "Client\Functions\Client_GetIncomes.sqf";
CTI_CL_FNC_GetOrderLabel = compileFinal preprocessFile "Client\Functions\Client_GetOrderLabel.sqf";
CTI_CL_FNC_GetPlayerFunds = compileFinal preprocessFile "Client\Functions\Client_GetPlayerFunds.sqf";
CTI_CL_FNC_GetPlayerIncome = compileFinal preprocessFile "Client\Functions\Client_GetPlayerIncome.sqf";
CTI_CL_FNC_GetMissionTime = compileFinal preprocessFile "Client\Functions\Client_GetMissionTime.sqf";
CTI_CL_FNC_HasAIOrderChanged = compileFinal preprocessFile "Client\Functions\Client_HasAIOrderChanged.sqf";
CTI_CL_FNC_HookVehicle = compileFinal preprocessFile "Client\Functions\Client_HookVehicle.sqf";
CTI_CL_FNC_IsPlayerCommander = compileFinal preprocessFile "Client\Functions\Client_IsPlayerCommander.sqf";
CTI_CL_FNC_InitializeStructure = compileFinal preprocessFile "Client\Functions\Client_InitializeStructure.sqf";
CTI_CL_FNC_JoinRequestAnswer = compileFinal preprocessFile "Client\Functions\Client_JoinRequestAnswer.sqf";
CTI_CL_FNC_PlacingBuilding = compileFinal preprocessFile "Client\Functions\Client_PlacingBuilding.sqf";
CTI_CL_FNC_PlacingDefense = compileFinal preprocessFile "Client\Functions\Client_PlacingDefense.sqf";
CTI_CL_FNC_OnExplosivePlaced = compileFinal preprocessFile "Client\Functions\Client_OnExplosivePlaced.sqf";
CTI_CL_FNC_OnHQDestroyed = compileFinal preprocessFile "Client\Functions\Client_OnHQDestroyed.sqf";
CTI_CL_FNC_OnFriendlyStructureDestroyed = compileFinal preprocessFile "Client\Functions\Client_OnFriendlyStructureDestroyed.sqf";
CTI_CL_FNC_OnJailed = compileFinal preprocessFile "Client\Functions\Client_OnJailed.sqf";
CTI_CL_FNC_OnMissionEnding = compileFinal preprocessFile "Client\Functions\Client_OnMissionEnding.sqf";
CTI_CL_FNC_OnPlayerFired = compileFinal preprocessFile "Client\Functions\Client_OnPlayerFired.sqf";
CTI_CL_FNC_OnPlayerKilled = compileFinal preprocessFile "Client\Functions\Client_OnPlayerKilled.sqf";
CTI_CL_FNC_OnPurchaseDelegationReceived = compileFinal preprocessFile "Client\Functions\Client_OnPurchaseDelegationReceived.sqf";
CTI_CL_FNC_OnPurchaseOrderReceived = compileFinal preprocessFile "Client\Functions\Client_OnPurchaseOrderReceived.sqf";
CTI_CL_FNC_OnStructureConstructed = compileFinal preprocessFile "Client\Functions\Client_OnStructureConstructed.sqf";
CTI_CL_FNC_OnTownCaptured = compileFinal preprocessFile "Client\Functions\Client_OnTownCaptured.sqf";
CTI_CL_FNC_PurchaseUnit = compileFinal preprocessFile "Client\Functions\Client_PurchaseUnit.sqf";
CTI_CL_FNC_RemoveRuins = compileFinal preprocessFile "Client\Functions\Client_RemoveRuins.sqf";




call compile preprocessFileLineNumbers "Client\Functions\FSM\Functions_FSM_UpdateClientAI.sqf";
call compile preprocessFileLineNumbers "Client\Functions\FSM\Functions_FSM_UpdateOrders.sqf";

CTI_P_SideColor = switch (CTI_P_SideJoined) do { case west: {CTI_WEST_COLOR}; case east: {CTI_EAST_COLOR}; case resistance: {CTI_RESISTANCE_COLOR}; default {"ColorBlack"} };
CTI_P_MarkerPrefix = switch (CTI_P_SideJoined) do { case west: {"b_"}; case east: {"o_"}; case resistance: {"n_"}; default {""} };
CTI_P_ChatID = [CTI_P_SideJoined,"HQ"];
CTI_P_MarkerIterator = 0;
CTI_P_PurchaseRequests = [];
CTI_P_TeamsRequests = [];
CTI_P_TeamsRequests_FOB = 0;
CTI_P_TeamsRequests_FOB_Dismantle = 0;
CTI_P_TeamsRequests_Last = -5000;
CTI_P_PreBuilding = false;
CTI_P_LastDefenseBuilt = objNull;
CTI_P_LastStructurePreBuilt = objNull;
CTI_P_Respawning = false;
CTI_P_LastRespawnTime= -2000;
CTI_P_LastDeathTime= -2000;
CTI_P_CurrentTasks = [];
CTI_P_CanJoin = false;
CTI_P_Jailed = false;
CTI_P_LastTeamkill = time;
CTI_P_LastFireMission = -1200;
CTI_P_HookVehicle = objNull;
CTI_P_LastRootMenu = "";
CTI_P_LastRepairTime = -600;
CTI_P_WallsAutoAlign = true;
CTI_P_DefensesAutoManning = false;
CTI_P_RapidDefence_Actions=[];
CTI_P_RapidDefence=-1;
CTI_P_Coloration_Money = "#BAFF81";
CTI_P_Locks=[];
CTI_P_Interaction=false;
CTI_DIALOGS=["cti_dialog_ui_interractions","cti_dialog_ui_tabletmain","cti_dialog_ui_buildmenu","cti_dialog_ui_videosettingsmenu","cti_dialog_ui_transferresourcesmenu","cti_dialog_ui_servicemenu","cti_dialog_ui_purchasemenu","cti_dialog_ui_upgrademenu","cti_dialog_ui_workersmenu","cti_dialog_ui_defensemenu","cti_dialog_ui_requestmenu","cti_dialog_ui_onlinehelpmenu","cti_dialog_ui_gear","cti_dialog_ui_satcam","cti_dialog_ui_unitscam","cti_dialog_ui_teamsmenu","cti_dialog_ui_mapcommandmenu","cti_dialog_ui_aimicromenu","cti_dialog_ui_artillerymenu","cti_dialog_ui_aircraftloadoutmenu"];
CTI_TABLET_DIALOG="cti_dialog_ui_tabletmain";

//--- Artillery Computer is only enabled on demand
enableEngineArtillery true;
if ((missionNamespace getVariable "CTI_ARTILLERY_SETUP") != -1) then {enableEngineArtillery false};

if (isMultiplayer) then {
	//--- Can I join?
		missionNamespace setVariable ["CTI_PVF_Client_JoinRequestAnswer", {_this spawn CTI_CL_FNC_JoinRequestAnswer}]; //--- Early PVF, do not spoil the game with the others.

		_last_req = -100;
		while {!CTI_P_CanJoin} do {
			if (time - _last_req > 15) then {_last_req = time; ["SERVER", "Request_Join", [player, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend};
			sleep 1;
		};

	12452 cutText ["Receiving mission intel... If you are getting an error press ESC and respawn and then reconnect.", "BLACK IN", 5];

	if (CTI_P_Jailed) then {
		hintSilent "The ride never ends!";
		0 spawn CTI_CL_FNC_OnJailed;
	};


};



//--- Initialize the client PV
call compile preprocessFile "Client\Init\Init_PublicVariables.sqf";

//--- Call the UI Functions
call compile preprocessFile "Client\Functions\UI\Functions_UI_AIMicromanagementMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_ArtilleryMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_GearMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_KeyHandlers.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_MapCommanding.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_PurchaseMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_RequestMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_RespawnMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_SatelliteCamera.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_ServiceMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_UnitsCamera.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_UpgradeMenu.sqf";

if (CTI_P_SideJoined == west) then {(west) call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_West.sqf"};
if (CTI_P_SideJoined == east) then {(east) call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_East.sqf"};





CTI_InitClient = true;

//--- Wait for a proper overall init (disabled slot?)
//waitUntil {!isNil {(group player) getVariable "cti_funds"} || (CTI_P_SideJoined == resistance)} ;

player addEventHandler ["killed", {_this spawn CTI_CL_FNC_OnPlayerKilled}];
if !(CTI_IsServer) then {[player, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR", CTI_P_SideJoined]] call CTI_CO_FNC_EquipUnit}; //--- Equip pure clients

if (isNil {profileNamespace getVariable "CTI_PERSISTENT_HINTS"}) then { profileNamespace setVariable ["CTI_PERSISTENT_HINTS", true]; saveProfileNamespace };

//--- Marker init thread
0 spawn {
	if (CTI_P_SideJoined == resistance) exitWith {false};
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_teams"}};

	execFSM "Client\FSM\update_netunits_team.fsm";
};


//--- HQ / Base markers thread
0 spawn {

	waitUntil {!isNil 'CTI_Init_CommanderClient'};
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_structures"} && !isNil {CTI_P_SideLogic getVariable "cti_hq"}};
	//--- Initialize the structures (JIP or prefab) along with HQ.
	execVM "Client\Init\Init_JIP.sqf";
	execFSM "Client\FSM\update_actions.fsm";
};

//--- Commander thread
0 spawn {
	//if (CTI_P_SideJoined == resistance) exitWith {call CTI_CL_FNC_AddMissionActions; CTI_Init_CommanderClient = true; false};
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_commander"} && !isNil {CTI_P_SideLogic getVariable "cti_hq"} && !isNil {CTI_P_SideLogic getVariable "cti_salvagers"}};

	_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;

	CTI_Init_CommanderClient = true;

	/*if !(call CTI_CL_FNC_IsPlayerCommander ||(side player == resistance))  then {
		//--- Execute the client orders context
		execFSM "Client\FSM\update_orders.fsm";
	};*/

	call CTI_CL_FNC_AddMissionActions;

	//if (alive _hq) then {
		//--- Pure clients
		if (CTI_IsClient && !CTI_IsServer) then {
			_hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CL_FNC_OnHQDestroyed", CTI_P_SideID]];

			if (CTI_BASE_NOOBPROTECTION == 1) then {
				_hq addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage", CTI_P_SideID]]; //--- You want that on public
			};
		};
	//};
};

//--- Gear templates (persitent)
if !(CTI_P_SideJoined == resistance) then {if (isNil {profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined]}) then {call CTI_UI_Gear_InitializeProfileTemplates};
// profileNamespace setVariable [format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined], nil];
// saveProfileNamespace;
if !(isNil {profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined]}) then {execVM "Client\Init\Init_Persistent_Gear.sqf"};};

//--- Graphics/video thread (persistent)
0 spawn {
	//--- View Distance
	_distance = profileNamespace getVariable "CTI_PERSISTENT_VIEW_DISTANCE";
	_distance_max = missionNamespace getVariable "CTI_GRAPHICS_VD_MAX";

	if (isNil "_distance") then { _distance = viewDistance };
	if (typeName _distance != "SCALAR") then { _distance = viewDistance };
	if (_distance < 1) then { _distance = 500 };
	if (_distance > _distance_max) then { _distance = _distance_max };
	setViewDistance _distance;

	//--- Object Distance (scales to View Distance)
	_distance = profileNamespace getVariable "CTI_PERSISTENT_OBJECT_DISTANCE";
	if (isNil "_distance") then { _distance = viewDistance };
	if (_distance < 1) then { _distance = 500 };
	if (_distance > viewDistance) then { _distance = viewDistance };
	setObjectViewDistance _distance;

	//--- Shadows Distance.
	_distance = profileNamespace getVariable "CTI_PERSISTENT_SHADOWS_DISTANCE";
	if !(isNil "_distance") then {
		if (typeName _distance == "SCALAR") then {
			if (_distance < 50) then { _distance = 50 };
			if (_distance > 200) then { _distance = 200 };
			setShadowDistance _distance;
		};
	};

	//--- Terrain Grid
	_grid = profileNamespace getVariable "CTI_PERSISTENT_TG";
	_grid_max = missionNamespace getVariable "CTI_GRAPHICS_TG_MAX";

	if (isNil "_grid") then { _grid = 25 };
	if (typeName _grid != "SCALAR") then {
		_grid = 0;
	} else {
		if (_grid < 0) then { _grid = 0 };
	};
	if (_grid > _grid_max) then { _grid = _grid_max };
	setTerrainGrid _grid;


};

TABLET_KEY_DOWN={
	_return=false;
	disableSerialization;

	if (! (_this select 2) && ! (_this select 3) && ! (_this select 4) &&(_this select 1) in ([(profilenamespace getvariable ['CTI_TABLET_KEY',41])]+(actionKeys "User5"))  && !visibleMap && !CTI_P_PreBuilding &&!CTI_P_Repairing && isNull (uiNamespace getVariable ['cti_dialog_ui_interractions',objNull]) && isNull (uiNamespace getVariable ['cti_dialog_ui_defensemenu',objnull]) && isNull (uiNamespace getVariable ['cti_dialog_ui_purchasemenu',objnull]) && isnull (uiNamespace getVariable ["cti_dialog_ui_tabletmain",objnull]) && (isnull (findDisplay 60490))) then {
			uiNamespace setVariable ["INT_TARG", call TABLET_GET_TARGET];
			createdialog "CTI_RscInteraction";
			_return=true;
	};
	_return
};
TABLET_KEY_UP={
	_return=false;
	disableSerialization;
	if (! (_this select 2) && ! (_this select 3) && ! (_this select 4) && (_this select 1) in [(profilenamespace getvariable ['CTI_TABLET_KEY',41])]  && !isNil {uiNamespace getVariable 'cti_dialog_ui_interractions'}&& isNil {uiNamespace getVariable 'cti_dialog_ui_purchasemenu'} && isNil {uiNamespace getVariable 'cti_dialog_ui_buildmenu'} && isNil {uiNamespace getVariable 'cti_dialog_ui_defensemenu'}&& isNil {uiNamespace getVariable 'cti_dialog_ui_gear'}&& isNil {uiNamespace getVariable 'cti_dialog_ui_aircraftloadoutmenu'} && isnil {uiNamespace getVariable "cti_dialog_ui_tabletmain"} && (isnull (findDisplay 60490)) ) then {
		closeDialog 0;
	};
	_return
};

TABLET_GET_TARGET={
	private ["_target"];
	_target=objnull;
	if (cursortarget iskindof "CAManBase" && ([player,cursortarget] call BIS_fnc_distance2D) <3 ) exitWith {cursortarget};
	if (cursortarget == (CTI_P_SideLogic getvariable "cti_hq") && ([player,cursortarget] call BIS_fnc_distance2D) <10 && (isnull attachedTo (CTI_P_SideLogic getvariable "cti_hq") ) ) exitWith {cursortarget};
	if (vehicle player != player) exitWith {vehicle player};
	_target = lineintersectsobjs [(eyepos player),(atltoasl screentoworld [0.5,0.5]),objnull,objnull,false,16];
	if (count _target == 0 && !(cursortarget iskindof "CAManBase") && ( [player,cursortarget] call BIS_fnc_distance2D) <8) exitWith {cursortarget};
	if ((count _target) == 0) exitWith {player};
	if (( [player,(_target select 0)] call BIS_fnc_distance2D) > 8) exitWith {player};
	_target select 0;
};

0 spawn {
	disableSerialization;
	_maindisplay=findDisplay 46;
	while {isNull _maindisplay} do {
		_maindisplay=findDisplay 46;
		sleep 0.1;
	};
	_maindisplay  displayAddEventHandler ["KeyDown", TABLET_KEY_DOWN];
	_maindisplay  displayAddEventHandler ["KeyUp", TABLET_KEY_UP];
};


if (/*profileNamespace getVariable "CTI_PERSISTENT_HINTS"*/true) then {
	0 spawn {
		sleep 2;
		waitUntil {(!isNull (findDisplay 46)) && (["PlayerHasGroup",[player] ] call BIS_fnc_dynamicGroups) && isnull (findDisplay 60490) };
		createdialog "CTI_RscTabletOnlineHelpMenu";
	};
};

0 spawn
{
	while {!CTI_GameOver} do
	{
		if (animationState player == "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon" || animationState player == "helper_switchtocarryrfl" || animationState player == "AcinPknlMstpSrasWrflDnon") then
		{
			if (! isNull (player getvariable ["REV_DRAGGING",objnull])) then{player switchMove "AcinPknlMstpSrasWrflDnon";}	else{player switchMove "amovpknlmstpsraswrfldnon";};
		};
		sleep 3;
	};
};

if (CTI_BASE_NOOBPROTECTION == 1) then {player addEventHandler ["fired", {_this spawn CTI_CL_FNC_OnPlayerFired}]}; //--- Trust me, you want that

//trophy system
if (missionNamespace getVariable "CTI_TROPHY_APS" == 1) then {
	player addEventHandler["Fired","_this call TR_HANDLER;"];
};

if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {player enableFatigue false} else  {player enableFatigue true}; //--- Disable the unit's fatigue
["SERVER", "Request_NoobLogger", [player,0]] call CTI_CO_FNC_NetSend;
0 execVM "Addons\MapMarkersTitling.sqf";
0 execFSM "Addons\Strat_mode\FSM\dynamic_group.fsm";

CTI_Init_Client = true;


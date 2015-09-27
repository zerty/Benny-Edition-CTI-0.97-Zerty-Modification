/*
  # HEADER #
	Script: 		Client\Functions\Client_AddMissionActions.sqf
	Alias:			CTI_CL_FNC_AddMissionActions
	Description:	Add the contextual actions from the mission to the player
					Note that this filed is called at player init and upon respawn
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    None

  # RETURNED VALUE #
	None

  # SYNTAX #
	call CTI_CL_FNC_AddMissionActions

  # EXAMPLE #
    call CTI_CL_FNC_AddMissionActions
*/
(vehicle player) setVariable ["CTI_UID",getPlayerUID player,true];

player setcaptive false;
if (! isNil "HUD_PBar_stop" ) then {0 call HUD_PBar_stop};

//player addaction ["<t color='#86F078'>Online Help</t>",'createdialog "CTI_RscTabletOnlineHelpMenu";', [], -99];
//titleCut["","BLACK IN",1];

player addEventHandler ["InventoryOpened",{
		if !(simulationEnabled (_this select 1)) then {
			(_this select 1) enableSimulation true;
			false
		};
	}
];


if (missionNamespace getVariable "CTI_SM_RADAR" == 1) then {
	player addEventHandler ["WeaponAssembled",{["SERVER", "Server_UAV_FUEL",(_this select 1)] call CTI_CO_FNC_NetSend;["SERVER", "Server_ARTR_handle",(_this select 1)] call CTI_CO_FNC_NetSend;["SERVER", "Request_HandleAction", ["empty", [(_this select 1)]]] call CTI_CO_FNC_NetSend;}];
};

if (CTI_SM_FAR == 1) then {
	0 spawn {
		waitUntil {!isNil "REV_OBJ_INIT"};
		player call REV_OBJ_INIT;
	};
};

CTI_P_Repairing = false;


player setVariable ["CTI_UID",getPlayerUID player, true];

/*
  # HEADER #
	Script: 		Client\Functions\Client_OnPlayerKilled.sqf
	Alias:			CTI_CL_FNC_OnPlayerKilled
	Description:	Triggered from the "Killed" EH whenever the player dies
					Note this function shall be called by an Event Handler (EH) but can be called manually
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Object]: The killed unit
    1	[Object]: The killer

  # RETURNED VALUE #
	None

  # SYNTAX #
	[KILLED, KILLER] spawn CTI_CL_FNC_OnPlayerKilled

  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_AddMissionActions
	Common Function: CTI_CO_FNC_OnUnitKilled

  # EXAMPLE #
	player addEventHandler ["killed", {_this spawn CTI_CL_FNC_OnPlayerKilled}];
	  -> This function be triggered everytime the player dies
*/

private ["_killed", "_killer"];

_killed = _this select 0;
_killer = _this select 1;

_killed connectTerminalToUAV objNull;

CTI_DeathPosition = getPos _killed;
CTI_P_LastDeathTime=time;

/*
if !(isNil "CTI_DeathCamera") then {
	CTI_DeathCamera cameraEffect ["TERMINATE", "BACK"];
	camDestroy CTI_DeathCamera;
};*/


//--- Close dialogs if needed (check 2 times).
if (dialog) then {closeDialog 0};
if (dialog) then {closeDialog 0};

CTI_P_Respawning = true;

//--- Clear the previous
for '_i' from 0 to 10 do { player removeAction _i };

titleCut["","BLACK OUT",1];

if !(CTI_P_Jailed && _killed ==_killer ) then {[_killed, _killer, CTI_P_SideID] spawn CTI_CO_FNC_OnUnitKilled};


waitUntil {alive player};
hideobject _killed;

if (CTI_P_Jailed) exitWith {
	600 spawn CTI_CL_FNC_OnJailed
};

CTI_DeathTimer = time + (missionNamespace getVariable "CTI_RESPAWN_TIMER");

call CTI_CL_FNC_AddMissionActions;


//--- Make sure that player is always the leader (of his group).
if (! (isPlayer (leader(group player))) && !(CTI_P_SideJoined == resistance)) then {(group player) selectLeader player};

if !( missionNamespace getVariable ["TUTO_COMPLETE",false]) then {
	titleCut["","BLACK IN",1];
	12452 cutText [localize "STR_Begin_Tutorial", "BLACK IN", 5];
	0 call TUTORIAL_RUN;
} else {
	createDialog "CTI_RscRespawnMenu";
};
/*
titleCut["","BLACK IN",1];

CTI_DeathCamera = "camera" camCreate CTI_DeathPosition;
// CTI_DeathCamera camSetDir 0;
CTI_DeathCamera camSetFov 0.7;
CTI_DeathCamera cameraEffect["Internal","TOP"];

CTI_DeathCamera camSetTarget CTI_DeathPosition;
CTI_DeathCamera camSetRelPos [0,1,3];
CTI_DeathCamera camCommit 0;

waitUntil {camCommitted CTI_DeathCamera};

CTI_DeathCamera camSetRelPos [1,1,20];
CTI_DeathCamera camCommit (missionNamespace getVariable "CTI_RESPAWN_TIMER")+2;
*/

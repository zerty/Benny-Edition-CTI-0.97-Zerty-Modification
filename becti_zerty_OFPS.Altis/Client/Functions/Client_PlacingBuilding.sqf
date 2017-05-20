/*
  # HEADER #
	Script: 		Client\Functions\Client_PlacingBuilding.sqf
	Alias:			CTI_CL_FNC_PlacingBuilding
	Description:	Prepare the placement of a structure before the construction
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[String]: The structure variable name
    1	[Object]: The center (construction center)
    2	[Number]: The construction radius

  # RETURNED VALUE #
	None

  # SYNTAX #
	[STRUCTURE VARIABLE, CENTER, RADIUS] spawn CTI_CL_FNC_PlacingBuilding

  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_ChangePlayerFunds
	Client Function: CTI_CL_FNC_GetPlayerFunds
	Common Function: CTI_CO_FNC_GetDirTo
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    [_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_PlacingBuilding;
*/

_variable = _this select 0;
_center = _this select 1;
_center_distance = _this select 2;

if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {
hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br /><t align='justify'>Is this your first time in the <t color='#74bbf2'>Construction Preview Mode</t>?<br /><br />
You may chose to <t color='#9CF863'>Place</t> or <t color='#F86363'>Cancel</t> the structure from your action menu.<br /><br />
The blue arrow shows where the units which may be purchased from that structure will spawn at.<br /><br />
Some of those Key Binding may help you during the placement:<br /><br />
- Rotate (<t color='#7bef15'>+1</t>): <t align='right'><t color='#f4cb38'>User1</t></t><br />
- Rotate (<t color='#7bef15'>+5</t>): <t align='right'><t color='#f4cb38'>Ctrl</t> + <t color='#f4cb38'>User1</t></t><br />
- Rotate (<t color='#7bef15'>+45</t>): <t align='right'><t color='#f4cb38'>Shift</t> + <t color='#f4cb38'>User1</t></t><br />
- Distance (<t color='#7bef15'>+1</t>): <t align='right'><t color='#f4cb38'>Alt</t> + <t color='#f4cb38'>User1</t></t><br /><br />
- Rotate (<t color='#ef5315'>-1</t>): <t align='right'><t color='#f4cb38'>User2</t></t><br />
- Rotate (<t color='#ef5315'>-5</t>): <t align='right'><t color='#f4cb38'>Ctrl</t> + <t color='#f4cb38'>User2</t></t><br />
- Rotate (<t color='#ef5315'>-45</t>): <t align='right'><t color='#f4cb38'>Shift</t> + <t color='#f4cb38'>User2</t></t><br />
- Distance (<t color='#ef5315'>-1</t>): <t align='right'><t color='#f4cb38'>Alt</t> + <t color='#f4cb38'>User2</t></t><br /><br />
- Reset to Default: <t align='right'><t color='#f4cb38'>User3</t></t><br /><br />
Note that those Keys are not binded by default, you may chose to bind them by going in the game <t color='#bd9df2'>Options</t> (not the mission!) and selecting <t color='#bd9df2'>Controls</t>.<br /><br />
Those Keys may be found after selecting <t color='#bd9df2'>Custom Controls</t> from the 'Show' filter.<br /><br />
</t>";
};

CTI_VAR_StructureCanceled = false;
CTI_P_PreBuilding = true;
CTI_P_PreBuilding_SafePlace = false;

CTI_P_KeyRotate = 0;
CTI_P_KeyDistance = 0;
CTI_P_KeyDistance_Min = -10;
CTI_P_KeyDistance_Max = 20;

_deh = (findDisplay 46) displayAddEventHandler ["KeyDown", "nullReturn = _this spawn CTI_UI_KeyHandler_BuildMenu"];

_var = missionNamespace getVariable _variable;
_local = ((_var select 1) select 0) createVehicleLocal getPos player;
_direction_structure = (_var select 4) select 0;
_distance_structure = (_var select 4) select 1;
_last_collision_update = -600;

_action = player addAction ["<t color='#9CF863'>Place Structure</t>", "Client\Actions\Action_BuildingPlace.sqf","", 96, false, true, "", "CTI_P_PreBuilding_SafePlace"];
_action2 = player addAction ["<t color='#F86363'>Cancel Structure</t>", "Client\Actions\Action_BuildingPlace_Cancel.sqf"];

_pos = [];
_dir = 0;

_helper = "Sign_Arrow_Large_Blue_F" createVehicleLocal getPos player;

while {!CTI_VAR_StructurePlaced && !CTI_VAR_StructureCanceled} do {
	_pos = player modelToWorld [0, _distance_structure + CTI_P_KeyDistance + 5, 0];

	if (time - _last_collision_update > 1.5) then {_last_collision_update = time;{_local disableCollisionWith _x} forEach (player nearObjects 150)};
	CTI_P_PreBuilding_SafePlace = if (_pos distance ([_pos, CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures] call CTI_CO_FNC_GetClosestEntity) >20 && _pos distance ( [_pos, ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic) getVariable "cti_structures_wip"] call CTI_CO_FNC_GetClosestEntity) >20 && !surfaceIsWater _pos && !(lineIntersects [ATLtoASL (player modelToWorld (player selectionPosition "pilot")),ATLtoASL (_local modelToWorld (_local selectionPosition "pilot")), player, _local])) then {true} else {false};
	if (_center distance player > _center_distance || !alive _center) exitWith { CTI_VAR_StructureCanceled = true };

	_dir = ([_local, player] call CTI_CO_FNC_GetDirTo) + _direction_structure + CTI_P_KeyRotate;
	_pos set [2, 0];

	_local setPos _pos;
	_local setDir _dir;

	_helper_pos = _local modelToWorld [(sin (360 -_direction_structure) * _distance_structure), (cos (360 -_direction_structure) * _distance_structure), 0];
	_helper_pos set [2, 0];
	_helper setPos _helper_pos;
	_helper setDir _dir;

	sleep .01;
};
hintsilent "";
player removeAction _action;
player removeAction _action2;

CTI_P_PreBuilding = false;

detach _helper;
deleteVehicle _helper;
deleteVehicle _local;

(findDisplay 46) displayRemoveEventHandler ["KeyDown", _deh];

//--- First check if the surface is water based
if (surfaceIsWater _pos) exitWith {hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The structure may not be placed here."};

//--- Check the distance 2D between our position and the potential areas
_in_area = false;
{if ([_pos select 0, _pos select 1] distance [_x select 0, _x select 1] <= CTI_BASE_AREA_RANGE) exitWith {_in_area = true}} forEach (CTI_P_SideLogic getVariable "cti_structures_areas");

//--- Maybe we have no area in range?
if (!(_in_area) && ! CTI_VAR_StructureCanceled) then {
	//--- If we have none, then have we reached our limit?
	if (count (CTI_P_SideLogic getVariable "cti_structures_areas") < CTI_BASE_AREA_MAX) then {
		//--- We create a new area if we still have room for areas and of course, we allow the construction
		CTI_P_SideLogic setVariable ["cti_structures_areas", (CTI_P_SideLogic getVariable "cti_structures_areas") + [[_pos select 0, _pos select 1]], true];
	} else {
		CTI_VAR_StructureCanceled = true;
		hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The base area limit has been reached.";
	};
};

//todo: structure 'build' mode expires > check areas for other structures + buildings (if 0 then remove)

//--- If there's no problems then we place it.
if !(CTI_VAR_StructureCanceled) then {
	if ((call CTI_CL_FNC_GetPlayerFunds) >= (_var select 2)) then {
		-(_var select 2) call CTI_CL_FNC_ChangePlayerFunds;
		["SERVER", "Request_Building", [_variable, CTI_P_SideJoined, [_pos select 0, _pos select 1], _dir, player]] call CTI_CO_FNC_NetSend;
	} else {
		hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to place that structure.";
	};
};

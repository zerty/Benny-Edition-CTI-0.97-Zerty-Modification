/*
  # HEADER #
	Script: 		Server\Functions\Server_BuildDefense.sqf
	Alias:			CTI_SE_FNC_BuildDefense
	Description:	Construct a defense at a given position
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	14-10-2013

  # PARAMETERS #
    0	[String]: The defense variable name
    1	[Side]: The Side which requested it
    2	[Array]: The position of the defense
    3	[Number]: The direction of the defense
    4	[Boolean]: Determine if an alignment is needed for walls
    5	{Optionnal} [Boolean]: Determine if the defense shall be manned or not

  # RETURNED VALUE #
	[Object]: The constructed defense

  # SYNTAX #
	[DEFENSE VARIABLE, SIDE, POSITION, DIRECTION, AUTOALIGN, MANNED] call CTI_SE_FNC_BuildDefense

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_HandleStaticDefenses
	Server Function: funcCalcAlignPosDir

  # EXAMPLE #
    _defense = [_variable, CTI_P_SideJoined, [_pos select 0, _pos select 1], _dir, CTI_P_WallsAutoAlign, CTI_P_DefensesAutoManning] call CTI_SE_FNC_BuildDefense;
*/

private ["_autoalign", "_defense", "_direction", "_direction_structure", "_fob", "_limit", "_logic", "_manned", "_origin", "_position", "_ruins", "_side", "_stronger", "_var", "_varname"];

_varname = _this select 0;
_var = missionNamespace getVariable _varname;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_origin = _this select 4;
_autoalign = _this select 5;
_manned = if (count _this > 6) then {_this select 6} else {false};

_logic = (_side) call CTI_CO_FNC_GetSideLogic;

//--- Is it a fob?
_fob = false;
_limit = false;
{if (_x select 0 == "FOB") exitWith {_fob = true}} forEach (_var select 5);
if (_fob) then {if (count(_logic getVariable "cti_fobs") >= CTI_BASE_FOB_MAX) then {_limit = true}};
if (_limit) exitWith {};

_position set [2, 0];
if (_fob) then {
	_position=[_position, 15] call CTI_CO_FNC_GetEmptyPosition;
};

_defense = (_var select 1) createVehicle _position;
_logic setVariable ["cti_defences",((_logic getVariable "cti_defences")+ [_defense] - [objNull]),true];
[["CLIENT", _side], "Client_HandleDefense", _defense] call CTI_CO_FNC_NetSend;


_direction_structure = (_var select 4) select 0;

if (_defense isKindOf "Building") then {
	if (_autoalign) then {
		private ["_autoSupport", "_correction", "_offsetZ", "_width"];
		_autoSupport = [];
		{if (_x select 0 == "CanAutoAlign") exitWith {_autoSupport = _x}} forEach (_var select 5);

		if (count _autoSupport > 0) then {
			_width = _autoSupport select 1;
			_offsetZ = _autoSupport select 2; //todo
			_correction = [_defense, _position, _direction, _width, _offsetZ, _direction_structure] call funcCalcAlignPosDir;
			_position = _correction select 0;
			_direction = _correction select 1;
		};
	};
};

if (_fob) then {
	[["CLIENT", _side], "Client_OnSpecialConstructed", [_defense, "FOB"]] call CTI_CO_FNC_NetSend;
	_logic setVariable ["cti_fobs", (_logic getVariable "cti_fobs") + [_defense], true];

};
_defense setVariable ["cti_save",[_varname,[_position,_direction],_manned],false];
_defense setDir _direction;
_defense setPos _position;
if (_defense emptyPositions "gunner" < 1 && !_fob) then { //--- Soft defense
	_defense setDir _direction;
	// _defense setVectorUp [0,0,0];
	if !(isNull _origin) then {[["CLIENT", _origin], "Client_ReceiveDefense", _defense] call CTI_CO_FNC_NetSend};
};

//--- Make the defense stronger?
_stronger = -1;
{if (_x select 0 == "DMG_Reduce") exitWith {_stronger = _x select 1}} forEach (_var select 5);
if (_stronger != -1) then {_defense addEventHandler ["handleDamage", format["getDammage (_this select 0)+(_this select 2)/%1",_stronger]]};

//--- Check if the defense has a ruin model attached (we don't wana have a cemetery of wrecks)
_ruins = "";
{if (_x select 0 == "RuinOnDestroyed") exitWith {_ruins = _x select 1}} forEach (_var select 5);

_defense addEventHandler ["killed", format["[_this select 0, _this select 1, %1, '%2', '%3'] spawn CTI_SE_FNC_OnDefenseDestroyed", _side call CTI_CO_FNC_GetSideID, _ruins, _varname]];

if (_defense emptyPositions "gunner" > 0) then { //--- Hard defense
	//todo: determine if the defense is "auto" or not via config simulation
	[_defense, CTI_BASE_DEFENSES_EMPTY_TIMEOUT] spawn CTI_SE_FNC_HandleEmptyVehicle; //--- Track the defense lifespan

	//--- The defense is eligible for auto manning
	if (_manned && CTI_BASE_DEFENSES_AUTO_LIMIT > 0) then {_defense setVariable ["cti_aman_enabled", true]};



};

// _defense addEventHandler ["killed", {}];

	// _defense addEVentHandler ["hit", {player sidechat format["%1",getDammage (_this select 0)];}];
// _defense setDammage 1;
if (_defense isKindOf "B_supplyCrate_F") then {
	clearBackpackCargoGlobal _defense;
	clearItemCargoGlobal _defense;
	clearMagazineCargoGlobal _defense;
	clearWeaponCargoGlobal _defense;
};
if (missionNamespace getVariable "CTI_TROPHY_APS" == 1) then {
	_defense addEventHandler["Fired","_this call TR_HANDLER;"];
};

//artillery radar revamp
if (missionNamespace getVariable "CTI_SM_RADAR" == 1) then {
	_defense addEventHandler["Fired","_this call ARTR_HANDLER;"];
};


if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [[_defense],true];};

_defense

/*
  # HEADER #
	Script: 		Server\Functions\Server_OnTownCaptured.sqf
	Alias:			CTI_SE_FNC_OnTownCaptured
	Description:	Triggered when town is captured by a given side
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	23-09-2013

  # PARAMETERS #
    0	[Object]: The Town
    1	[Side]: The side which captured the town

  # RETURNED VALUE #
	None

  # SYNTAX #
	[TOWN, SIDE] call CTI_SE_FNC_OnTownCaptured

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayPush
	Common Function: CTI_CO_FNC_ChangeFunds
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_AddScore

  # EXAMPLE #
    [Town0, West] call CTI_SE_FNC_OnTownCaptured
	  -> Town0 is now captured by West
*/



private ["_award_teams", "_currentSideID", "_last_capture", "_newSide", "_newSideID", "_town"];

_town = _this select 0;
_newSide = _this select 1;

_cap_capture=1;
_cap_teambalance=0.9;
_cap_teamplay=0.5;

_newSideID = (_newSide) call CTI_CO_FNC_GetSideID;
_currentSideID = _town getVariable "cti_town_sideID";

_town setVariable ["cti_town_sideID", _newSideID, true];
_town setVariable ["cti_town_lastSideID", _currentSideID, true];

_town setVariable ["CTI_Net", _newSideID, true];

_town setFlagTexture ( _newSide call CTI_CO_FNC_GetSideFlag);


["CLIENT", "Client_OnTownCaptured", [_town, _newSideID, _currentSideID]] call CTI_CO_FNC_NetSend;


//if (_newSide != resistance && ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED" == 3)|| _newSide== west && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED" == 1) || _newSide== east && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED" == 2))) then { //--- Award the AI
	_award_teams = [];
	{
		if (({alive _x && (_x distance _town) <= CTI_MARKERS_TOWN_AREA_RANGE} count (units _x))>0) then {_award_teams set [count _award_teams, _x]};
		true
	} count ((_newSide call CTI_CO_FNC_GetSideLogic) getVariable "cti_teams");

	/*{
		if !(isNil '_x') then {
			if !(isPlayer leader _x) then {
				{if (_x distance _town < CTI_MARKERS_TOWN_AREA_RANGE && alive _x) exitWith {[_award_teams, group _x] call CTI_CO_FNC_ArrayPush}} forEach units _x;
			};
		};
	} forEach ((_newSide call CTI_CO_FNC_GetSideLogic) getVariable "cti_teams");
	*/
	if !(((_newSide) call CTI_CO_FNC_GetSideCommander) in _award_teams) then {_award_teams set [count _award_teams,((_newSide) call CTI_CO_FNC_GetSideCommander)]};
	if (count _award_teams > 0) then {
		_last_capture = _town getVariable format["cti_town_lastcap_%1", _newSide];
		_value = (_town getVariable "cti_town_value") *CTI_TOWNS_CAPTURE_RATIO;
		_player_east=({!isnil {_x getVariable "cti_uid"}||isPlayer leader _x} count ((east) call CTI_CO_FNC_GetSideGroups));//1
		_player_west=({!isnil {_x getVariable "cti_uid"}||isPlayer leader _x} count ((west) call CTI_CO_FNC_GetSideGroups));//0
		_med_players=(_player_west  + _player_east)/2;//0.5
		_players={!isnil {_x getVariable "cti_uid"}||isPlayer leader _x} count ((_newSide) call CTI_CO_FNC_GetSideGroups);
		if (_med_players == 0) then {_med_players =1};
		if (_players == 0) then {_players =1};
		_groups={side _x == _newSide} count _award_teams;
		_pl_groups={side _x == _newSide && (!isnil {_x getVariable "cti_uid"}||isPlayer leader _x)} count _award_teams;
		if !(isNil '_last_capture') then {
			if (time - _last_capture <= CTI_TOWNS_CAPTURE_BOUNTY_DELAY) then { _value = round(_value / 4) };
		};

		_score = round(_value / CTI_SCORE_TOWN_VALUE_PERPOINT);
		{
			if (_score > 0) then {[leader _x, _score] spawn CTI_SE_FNC_AddScore};
			//[_x, _newSide, _value] call CTI_CO_FNC_ChangeFunds;
		} forEach _award_teams;
		_base_value=_cap_capture*_value;
		_tb_value=_cap_teambalance*(1- (_players / _med_players ))*_value;
		_tp_value=_cap_teamplay*(1-((_pl_groups)/_players))*_value;
		_total_value=floor(_base_value+_tb_value+_tp_value);
		diag_log format [":: CAPTURE :: %1 captured %2 reward %3",_newSide, (_town getVariable "cti_town_name"),[_total_value,_base_value,_tb_value,_tp_value]];
		if !(((_newSide) call CTI_CO_FNC_GetSideCommander) in _award_teams) then {_award_teams set [count _award_teams,((_newSide) call CTI_CO_FNC_GetSideCommander)]};
		{
			[["CLIENT", leader _x], "Client_OnMessageReceived", ["town_award",[_total_value, (_town getVariable "cti_town_name"),_base_value,_tb_value,_tp_value]],true] call CTI_CO_FNC_NetSend;
			[_x, _newSide, _total_value] call CTI_CO_FNC_ChangeFunds;
		} count _award_teams;
	};



	_town setVariable [format["cti_town_lastcap_%1", _newSide], time];


//};

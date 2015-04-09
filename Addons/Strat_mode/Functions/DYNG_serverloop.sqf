waitUntil {(["IsInitialized"] call BIS_fnc_dynamicGroups)};
diag_log ":: DYNG :: Starting servre watchdog";
while {!CTI_Gameover} do {
	{
		if (isNil {(_x select 3) getVariable "cti_order"}) then {
			[_x select 3, _x select 6,count (_x select 5)] call CTI_SE_FNC_InitializeGroup;
		}else {
			_g = _x select 3;
			_ppl=_g getVariable ["last_known_players",[]];
			_pl= (_x select 5);
			//==================
			//Money handle
			//==================
			/*if (count _pl < count _ppl) then { // someone has left
				diag_log format [" :: DYNG :: removing money for %1 : %2 => %3",_g , (_g getVariable "cti_funds"), floor ((_g getVariable "cti_funds")-((_g getVariable "cti_funds")/(count _ppl))) ];
				_g setVariable ["cti_funds", floor ((_g getVariable "cti_funds")-((_g getVariable "cti_funds")/(count _pl))),true];
				_g setVariable ["last_known_players",_pl,true];
			};*/
			if (count _pl > count _ppl) then { // someone has joined
				_delta=_pl-_ppl;
				{
					_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _x];
					if (!isNil "_get") then {
						diag_log format [" :: DYNG :: Add money for %1 : %2 => %3",_g , (_g getVariable "cti_funds"), floor ((_g getVariable "cti_funds")+(_get select 2))];
						_g setVariable ["cti_funds",floor ((_g getVariable "cti_funds")+(_get select 2)),true];
					};
					true
				}count _delta;
				_g setVariable ["last_known_players",_pl,true];
			};
			//if (count _pl == count _ppl) then { // Save money only for leader
			{
				if (_x == (getPlayerUID leader _g)) then {
					_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _x];
					if (!isNil "_get") then {
						_get set [2,floor ((_g getVariable "cti_funds")/count(_pl))];
						missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _x],_get];
						//diag_log format [" :: DYNG :: saving money for %1 : %2 => %3", _get select 0 , _get select 2, _get ];
					};
				};
				true
			}count _pl;
			//};


			//==================
			//Updateing group name
			//==================
			_name =_x select 1;
			if !((groupID _g) == _name) then {_g setGroupId [_name]};
			if !((_g getVariable ["cti_alias",""]) == _name) then {_g setVariable ["cti_alias", _name,true]};

		};
		true
	}count ("GetAllGroups" call BIS_fnc_dynamicGroups);

	// group cleanup since BIS has fucked it
	{if ((count(units _x) == 0) && local _x && ! ( groupID _x == "Defense Team") && ! ( groupID _x == "Default Team")) then {deleteGroup _x} ;true }count allgroups;
	sleep 1;
};
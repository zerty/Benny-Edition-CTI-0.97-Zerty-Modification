waitUntil {(["IsInitialized"] call BIS_fnc_dynamicGroups)};
diag_log ":: DYNG :: Starting server watchdog";
while {!CTI_Gameover} do {
	{
		if (isNil {(_x) getVariable "cti_order"}) then {
			[_x, side _x,_x getvariable "bis_dg_cre"] call CTI_SE_FNC_InitializeGroup;
		}else {
			/*_ppl=_g getVariable ["last_known_players",[]];
			_pl=[];
			{} forEach (units group);
			//==================
			//Money handle
			//==================
			if (count _pl < count _ppl) then { // someone has left
				_delta=_ppl-_pl;
				{
					_to_remove=((missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side _g])) min ((_g getVariable "cti_funds")/(count _ppl));
					_new_funds=(floor (_g getVariable "cti_funds") - _to_remove) max (0);
					_g setVariable ["cti_funds",_new_funds,true];
					diag_log format [" :: DYNG :: Removing money for %1 : %2 => %3",_g , (_g getVariable "cti_funds"), _new_funds];
					true
				}count _delta;
				_g setVariable ["last_known_players",_pl,true];
			};
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
			};*/
			_last_leader=_x getvariable ["last_leader",objNull];

			if (isplayer (leader _x)) then { //group is behaving normaly
				_g=_x;


				if !(leader _g == _last_leader) then { // change of leadership settup the leader money or default
					_last_leader= leader _g;
					_x setVariable ["last_leader",leader _x,false];
					_uid_leader=getPlayerUID (_last_leader);
					_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid_leader];
					if (isNil "_get") then {
						_x setVariable ["cti_funds",(missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side _x]) ,true];
					} else {
						if ((_get select 2) <= 0) then {
							_x setVariable ["cti_funds",(missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side _x]) ,true];
						} else {
							_x setVariable ["cti_funds", (_get select 2) ,true];
						};
					};
				};

				// registerring the money of leader

				{
					if (isplayer _x) then {
						_uid=getPlayerUID (_x);
						_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid];
						if (!(isNil "_get") && alive _x )then {
							if (_x == leader _g) then {
								_get set [2,floor (_g getVariable "cti_funds")];
								missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _x],_get];
							} else {
								if ((_get select 2 ) > (missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side _g])) then
								{
									_g setVariable ["cti_funds", (_g getvariable "cti_funds")+ (_get select 2),true ]; // automatic tranfer of money
								};
								_get set [2,0];
								missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _x],_get];
							};
						};
					};
					/*if (_x == (getPlayerUID leader _g)) then {
						if (!isNil "_get") then {
							_get set [2,floor (_g getVariable "cti_funds")];
							missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _x],_get];
							//diag_log format [" :: DYNG :: saving money for %1 : %2 => %3", _get select 0 , _get select 2, _get ];
						};
					}else {
						if (!isNil "_get") then {
							_get set [2,(missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1", side _g])];
							missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _x],_get];
							//diag_log format [" :: DYNG :: saving money for %1 : %2 => %3", _get select 0 , _get select 2, _get ];
						};
					};*/
					true
				}count units _x;
			};


			//==================
			//Updateing group name
			//==================
			//_name =_x select 1;
			//if !((groupID _g) == _name) then {_g setGroupIdGlobal [_name]};
			if !((_x getVariable ["cti_alias",""]) == (groupID _x) ) then {_x setVariable ["cti_alias", (groupID _x),true]};

		};
		true
	}count ("GetAllGroups" call BIS_fnc_dynamicGroups);

	// group cleanup since BIS has fucked it
	//{if ((count(units _x) == 0) && local _x && ! ( groupID _x == "Defense Team") && ! ( groupID _x == "Default Team")) then {deleteGroup _x} ;true }count allgroups;
	sleep 2;
};
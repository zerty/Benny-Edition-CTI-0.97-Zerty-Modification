waitUntil {(["IsInitialized"] call BIS_fnc_dynamicGroups)};
diag_log ":: DYNG :: Starting server watchdog";
while {!CTI_Gameover} do {
	{
		if (isNil {(_x) getVariable "cti_order"}) then {
			[_x, side _x,_x getvariable "bis_dg_cre"] call CTI_SE_FNC_InitializeGroup;
		}else {

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

					true
				}count units _x;
			};


			if !((_x getVariable ["cti_alias",""]) == (groupID _x) ) then {_x setVariable ["cti_alias", (groupID _x),true]};

		};
		true
	}count ("GetAllGroups" call BIS_fnc_dynamicGroups);


	sleep 2;
};
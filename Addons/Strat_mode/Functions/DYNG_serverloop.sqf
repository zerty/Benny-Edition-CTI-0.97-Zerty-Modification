waitUntil {(["IsInitialized"] call BIS_fnc_dynamicGroups)};
while {!CTI_Gameover} do {
	{
		if (isNil {(_x select 3) getVariable "cti_order"}) then {
			[_x select 3, _x select 6,count (_x select 5)] call CTI_SE_FNC_InitializeGroup;
		}else {
			_g = _x select 3;
			_nbp= count (_x select 5);
			_ppl=_g getvariable ["last_player_count",0];
			if (_nbp < _ppl) then { // someone has left
				diag_log format [" :: DYNG :: removing money for %1 : %2 => %3",_g , (_g getVariable "cti_funds"), floor ((_g getVariable "cti_funds")-((_g getVariable "cti_funds")/_ppl)) ];
				_g setVariable ["cti_funds",floor ((_g getVariable "cti_funds")-((_g getVariable "cti_funds")/_ppl)),true];
				_g setvariable ["last_player_count",_nbp];
			}else {
				{
					_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _x];
					if (!isNil "_get") then {
						_get set [2,floor ((_g getVariable "cti_funds")/_nbp)];
						missionNamespace setVariable [format["CTI_SERVER_CLIENT_%1", _x],_get];
						diag_log format [" :: DYNG :: saving money for %1 : %2 => %3", _get select 0 , _get select 2, _get ];
					};
					true
				}count (_x select 5);
			};
		};
		true
	}count ("GetAllGroups" call BIS_fnc_dynamicGroups);
	sleep 1;
};
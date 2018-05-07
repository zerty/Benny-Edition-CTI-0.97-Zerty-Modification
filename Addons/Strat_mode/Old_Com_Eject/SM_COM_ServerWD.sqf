_side=_this;
_side_logic=(_this) call CTI_CO_FNC_GetSideLogic;
diag_log format [":: COM %1 :: Starting watchdog",_side];

while {!CTI_GameOver} do {

	_pl_count = {isplayer leader _x} count ((_side) call CTI_CO_FNC_GetSideGroups);
	_votes=count (_side_logic getvariable ["CTI_COM_VOTES",[]]);
	_ratio= if !(_pl_count == 0) then {(_votes/_pl_count)} else {0};
	if ((_pl_count == 1) && (_votes >= 1)) then {_ratio = 0};
	
	if (_ratio >= CTI_VOTE_RATIO  || (count units (_side_logic getvariable "cti_commander")) == 0) then {
		_side_logic setvariable ["CTI_COM_VOTES",[],true];
		_curent_com_gr=_side_logic getvariable  "cti_commander";
		_curent_com_pl=[];
		{if (isplayer _x) then {_curent_com_pl pushBack _x};true}count (units _curent_com_gr);
		if (!isNull _curent_com_gr) then {
			if (count _curent_com_pl > 0 ) then {
				_uids=[];
				{_uids pushBack (getPlayerUID _x);true } count _curent_com_pl;
				_side_logic setvariable ["CTI_COM_BLACKLIST",(_side_logic getvariable ["CTI_COM_BLACKLIST",[]])+_uids,true];
				[_side_logic, _uids] spawn {
					sleep 600;
					(_this select 0 ) setvariable ["CTI_COM_BLACKLIST",((_this select 0) getvariable ["CTI_COM_BLACKLIST",[]])-(_this select 1),true];
				};
			};
			[_side,true] call CTI_COM_UNSET_SERVER;
		};
		_side_logic setvariable ["CTI_COM_VOTES",[],true];
	};
	//diag_log format [":: COM %1 :: %2 votes %3 ratio",_side,_votes,(_votes/_pl_count)];

	sleep 2;
};
diag_log format [":: COM %1 :: END watchdog",_side];
/*
best recup /s 7.3 % so approx 14 s for full regen / 7s for half regen
best case ok
what i want for worst case:
13s for half regen 26 for full
so 3.8% /s

*/
#define FULL_REGEN_MAX_TIME 28
waitUntil {alive player};
while {!CTI_GameOver} do
{

		_previous_fat= getFatigue player;
		while {alive player } do {
			_current_fat=getFatigue player;
			if ((_previous_fat - _current_fat) >= -0.0001  && _current_fat >0) then {
				//_rv=(_previous_fat - _current_fat);
				_current_fat = _previous_fat - ((_previous_fat - _current_fat) max (1/FULL_REGEN_MAX_TIME));
				_current_fat =  (_current_fat min 1) max 0;
				player setFatigue _current_fat;
				//hintSilent format ["%1 :: %2(%3) :: %4(%5)", _previous_fat, _current_fat,getFatigue player,_next_offset,_rv];
			};
			_previous_fat=getFatigue player;
			sleep 1;
		};
};

//[H]Tom - Town Mines - - - - - -
#define MIN_FPS 20

private ["_town"];

_town = _this select 0;
_sideID = _town getVariable "cti_town_sideID";
_side = switch (_sideID) do {
				case 0: {west};
				case 1: {east};
				case 2: {resistance};
			};
_mines = [];

if (diag_fps > MIN_FPS && (_town getVariable "cti_town_value") > 149) then {
_random = selectRandom [0,0,0,0,2 + round (random 3),3 + round (random 4)];

for "_i" from 0 to (_random - 1) do {
	_minepos = [_town, 20, 120, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	_apers = selectRandom ["APERSMine","APERSBoundingMine"];
	_mine = createMine [_apers, _minepos, [], 0];
	_mines = _mines + [_mine];
};

if (count _mines > 0) then {
	{_side revealMine _x; true} count _mines;
	};
};

_town setVariable ["cti_town_mines",(_mines),true];
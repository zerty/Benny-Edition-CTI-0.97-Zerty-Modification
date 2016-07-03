///////////////////////////////////////////////////////////
//                =ATM= Airdrop       	 				    //
//         		 =ATM=Pokertour        		       		    //
//				version : 4.0							        //
//				date : 16/09/2013						   //
//                   visit us : atmarma.fr                 //
/////////////////////////////////////////////////////////

private ["_position","_cut","_dialog","_s_alt","_s_alt_text","_sound"];

waitUntil { !isNull player };
[] execVM "Addons\ATM_airdrop\functions.sqf";

_funds = [group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
if (_funds < 500) exitWith {
	hintsilent localize "STR_HALO_No_Funds";
	sleep 1;
	hintsilent ""
};

CTI_Selecting_Halo=true;
_position = GetPos player;
_z = _position select 2;
Altitude = CTI_HALO_ALTITUDE;


hint parseText localize "STR_HALO_Info";

openMap true;
ATM_Jump_mapclick = false;
onMapSingleClick 'ATM_Jump_clickpos = _pos; _ct =[ATM_Jump_clickpos, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestFriendlyTown; if (ATM_Jump_clickpos distance  _ct < CTI_MARKERS_TOWN_AREA_RANGE*CTI_HALO_RATIO) then { ATM_Jump_mapclick = true; onMapSingleClick ""; true;}';

//onMapSingleClick 'ATM_Jump_clickpos = _pos; ATM_Jump_mapclick = true; onMapSingleClick ""; true;';

waitUntil {ATM_Jump_mapclick or !(visiblemap)};
CTI_Selecting_Halo=false;
if (!visibleMap) exitwith {
	systemChat localize "STR_HALO_Cancel";
	hintsilent "";

	breakOut "main";
};
[group player, CTI_P_SideJoined, - 500] call CTI_CO_FNC_ChangeFunds;
_pos = ATM_Jump_clickpos;

ATM_Jump_mapclick = if(true) then{
	call compile format ['
		mkr_halo = createMarkerLocal ["mkr_halo", ATM_Jump_Clickpos];
		mkr_halo setMarkerTypeLocal "hd_dot";
		mkr_halo setMarkerColorLocal "ColorGreen";
		mkr_halo setMarkerTextLocal "Jump";
	'];
};


_target = player;
_loadout=[_target] call Getloadout;

_posJump = getMarkerPos "mkr_halo";
_x = _posJump select 0;
_y = _posJump select 1;
_z = _posJump select 2;
_target setPos [_x,_y,_z+Altitude];

openMap false;


removeBackpack _target;
sleep 0.5;
_target addBackpack "B_Parachute";
if ((getPos _target select 2) >= 8000) then{
	removeHeadgear _target;
	_target addHeadgear "H_CrewHelmetHeli_B";
	sleep 0.5;
};



_height = getPos _target select 2;
_sound = "Vent";
while {(getPos _target select 2) > 2} do {
	if(isTouchingGround _target and player == vehicle player) then{
	}
	else{
	playSound _sound;
	sleep 2;
	};
};

hint parseText localize "STR_HALO_Load";


deletevehicle (_target getvariable "lgtarray"); _target setvariable ["lgtarray",nil,true];


0=[_target,_loadout] call Setloadout;
if(!alive _target) then {
	_cut = nearestObjects [player, ["Steerable_Parachute_F"], 15];
	{
		deletevehicle _x;
	} foreach _cut;
	sleep 5;
	0=[_target,_loadout] call Setloadout;
};
deleteMarker "mkr_halo";
hint parseText localize "STR_HALO_Gear_Load";
sleep 3;
if (alive _target) then {CTI_HALO_LASTTIME=time;};
hintsilent "";
///////////////////////////////////////////////////////////
//                =ATM= Airdrop       	 				    //
//         		 =ATM=Pokertour        		       		    //
//				version : 4.0							        //
//				date : 16/09/2013						   //
//                   visit us : atmarma.fr                 //
/////////////////////////////////////////////////////////
/*
fnc_alt_onsliderchange =
{
	private["_dialog","_text","_value"];
	disableSerialization;
	
	_dialog = findDisplay 2900;
	_text = _dialog displayCtrl 2902;
	_value = _this select 0;
	
	Altitude = round(_value);
	_text ctrlSetText format["%1", round(_value)];
};

pkChangeKey = {
		_index = lbCurSel 2903;
		switch _index do {
			case 0 : {
				//Fr Keyboard
			};
			case 1 : {
				Keys = 16; //A
			};
			case 2 : {
				Keys = 48; //B
			};
			case 3 : {
				Keys = 46; //C
			};
			case 4 : {
				Keys = 32; //D
			};
			case 5 : {
				Keys = 18; //E
			};
			case 6 : {
				Keys = 33; //F
			};
			case 7 : {
				Keys = 34; //G
			};
			case 8 : {
				Keys = 35; //H
			};
			case 9 : {
				Keys = 23; //I
			};
			case 10 : {
				Keys = 36; //J
			};
			case 11 : {
				Keys = 37; //K
			};
			case 12 : {
				Keys = 38; //L
			};
			case 13 : {
				Keys = 39; //M
			};
			case 14 : {
				Keys = 49; //N
			};
			case 15 : {
				Keys = 24; //O
			};
			case 16 : {
				Keys = 25; //P
			};
			case 17 : {
				Keys = 30; //Q
			};
			case 18 : {
				Keys = 19; //R
			};
			case 19 : {
				Keys = 31; //S
			};
			case 20 : {
				Keys = 20; //T
			};
			case 21 : {
				Keys = 22; //U
			};
			case 22 : {
				Keys = 47; //V
			};
			case 33 : {
				Keys = 44; //W
			};
			case 24 : {
				Keys = 45; //X
			};
			case 25 : {
				Keys = 21; //Y
			};
			case 26 : {
				Keys = 17; //Z
			};
			case 27 : {
				//US Keyboard
			};
			case 28 : {
				Keys = 30; //A
			};
			case 29 : {
				Keys = 48; //B
			};
			case 30 : {
				Keys = 46; //C
			};
			case 31 : {
				Keys = 32; //D
			};
			case 32 : {
				Keys = 18; //E
			};
			case 33 : {
				Keys = 33; //F
			};
			case 34 : {
				Keys = 34; //G
			};
			case 35 : {
				Keys = 35; //H
			};
			case 36 : {
				Keys = 23; //I
			};
			case 37 : {
				Keys = 36; //J
			};
			case 38 : {
				Keys = 37; //K
			};
			case 39 : {
				Keys = 38; //L
			};
			case 40 : {
				Keys = 50; //M
			};
			case 41 : {
				Keys = 49; //N
			};
			case 42 : {
				Keys = 24; //O
			};
			case 43 : {
				Keys = 25; //P
			};
			case 44 : {
				Keys = 16; //Q
			};
			case 45 : {
				Keys = 19; //R
			};
			case 46 : {
				Keys = 31; //S
			};
			case 47 : {
				Keys = 20; //T
			};
			case 48 : {
				Keys = 22; //U
			};
			case 49 : {
				Keys = 47; //V
			};
			case 50 : {
				Keys = 17; //W
			};
			case 51 : {
				Keys = 45; //X
			};
			case 52 : {
				Keys = 21; //Y
			};
			case 53 : {
				Keys = 44; //Z
			};
		};
	};

dokeyDown={
     private ["_r","_key_delay"] ;
     _key_delay  = 0.3;
	 _cutawaysound = "Para";
	player setvariable ["key",false];
   _r = false ; 
     
   if (player getvariable["key",true] and (_this select 1)  == Keys) exitwith {player setvariable["key",false]; [_key_delay] spawn {sleep (_this select 0);player setvariable["key",true]; }; _r};
     if ((_this select 1)  == Keys) then {
       if  (player != vehicle player and player getvariable ["cutaway",true]) then  {
		playSound _cutawaysound;
		_cut = nearestObjects [player, ["Steerable_Parachute_F"], 5];
	   {
			deletevehicle _x;
	   } foreach _cut;
	player addBackpack "B_Parachute";
    player setvariable["key",true];  
    player setvariable ["cutaway",false];
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", Cut_Rope];
   };
    _r=true;
      };
     _r;
} ;*/

Getloadout={
_gear = [];
	_headgear = headgear player;
	_back_pack = backpack player;
	_back_pack_items = getItemCargo (unitBackpack player);
	_back_pack_weap = getWeaponCargo (unitBackpack player);
	_back_pack_maga = getMagazineCargo (unitBackpack player);
	
	_gear =
	[
		_headgear,
		_back_pack,
		_back_pack_items,
		_back_pack_weap,
		_back_pack_maga
	];
	_gear
};

Setloadout={
_unit = _this select 0;
	_gear = _this select 1;
	removeheadgear _unit;
	removeBackPack _unit;
	_unit addBackpack "B_AssaultPack_blk"; 
	removeBackPack _unit;
	if ((_gear select 1) != "") then {_unit addBackPack (_gear select 1);clearAllItemsFromBackpack _unit;};
	if ((_gear select 0) != "") then {_unit addHeadgear (_gear select 0);};
	if (count ((_gear select 3) select 0) > 0) then 
	{
		for "_i" from 0 to (count ((_gear select 3) select 0) - 1) do
		{
			(unitBackpack _unit) addweaponCargoGlobal [((_gear select 3) select 0) select _i,((_gear select 3) select 1) select _i];
		};			
	};
	if (count ((_gear select 4) select 0) > 0) then
	{
		for "_i" from 0 to (count ((_gear select 4) select 0) - 1) do
		{
			(unitBackpack _unit) addMagazineCargoGlobal [((_gear select 4) select 0) select _i,((_gear select 4) select 1) select _i];
		};
	};
	if (count ((_gear select 2) select 0) > 0) then
	{
		for "_i" from 0 to (count ((_gear select 2) select 0) - 1) do
		{
			(unitBackpack _unit) addItemCargoGlobal [((_gear select 2) select 0) select _i,((_gear select 2) select 1) select _i];
		};
	};
};
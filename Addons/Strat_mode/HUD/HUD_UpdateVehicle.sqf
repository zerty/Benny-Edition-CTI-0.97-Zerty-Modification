#define HUD_IDC 1500000

private ["_hud","_veh","_up_trt","_text","_col2","_col3","_co","_d","_c","_g"];
_hud=_this;
disableSerialization;
_veh=(_hud displayCtrl(HUD_IDC+2));
if !(profileNamespace getVariable ["HUD_Normal",true]) exitWith {_veh ctrlShow false;};

_up_trt=if (!( count ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades) == 0)) then {((CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TRT} else {0};

if (vehicle	player == player  ) then{
	_veh ctrlShow	false;
} else {
	_veh ctrlShow	true;
	_text="<t align='right'><t size='1'><t color='#00ff00'>";
	_text=_text + getText(configFile >> "CfgVehicles" >> (typeOf (vehicle player)) >> "displayName");
	_text=_text+"</t></t><br /><t size='0.7'>";
	if (vehicle player isKindOf "parachutebase" || vehicle player isKindOf "staticweapon") then {
	_text=_text+format	["<t color='#00ff00'><img image='A3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa'/> %1 </t>", ceil ((1 - getDammage (vehicle player))*100)];
	} else {
	_avgdamage = ((getAllHitPointsDamage (vehicle player)) select 2) call BIS_fnc_arithmeticMean;
	_text=_text+format	["<t color='#00ff00'><img image='A3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa'/> %1 </t>", ceil ((1 - (_avgdamage))*100)];
	};
	if ((vehicle player) isKindOf "tank" || (vehicle player) isKindOf "Wheeled_APC_F") then {
		_col2=if ((time - ((vehicle player) getVariable ["TROPHY_time_l",time])) > (300/(1+_up_trt)) )then { "#00ff00" } else {"#ff0000"};
		_col3=if ((time - ((vehicle player) getVariable ["TROPHY_time_r",time])) > (300/(1+_up_trt)) )then { "#00ff00" } else {"#ff0000"};
		_text=_text+format	[localize "STR_TROPHY_Ammo", (vehicle player) getVariable ["TROPHY_ammo_l",0],(vehicle player) getVariable ["TROPHY_ammo_r",0],_col2,_col3];
	};
	_text=_text+"<br />";
	if (missionNamespace getVariable "CTI_EW_ANET" == 1 && ! isNil {(vehicle player) getVariable "CTI_Net"}) then {
		_co="";
		if (((vehicle player) getVariable ["AN_iNet",-11]) == (vehicle player) getVariable ["CTI_Net",-10]) then {_co=format ["<t color='#00ff00'>%1</t>",(((vehicle player) getVariable "CTI_Net") call CTI_CO_FNC_GetSideFromID)]} else {_co=format ["<t color='#ffff00'>%1</t>",(((vehicle player) getVariable "CTI_Net") call CTI_CO_FNC_GetSideFromID)]};
		if (((vehicle player) getVariable "CTI_Net"< 0) ) then {_co = localize "STR_CTI_Net"};
		if (((vehicle player) getVariable ["AN_Hacked",0])>0) then {_co=_co+format[localize "STR_Hacked",floor ((vehicle player) getVariable ["AN_Hacked",0]) ];};
	_text=_text+format [localize "STR_Net_UpVeh",_co];
	};
	_d=driver	(vehicle	player);
	if (!isNull	_d && isPlayer	_d) then {_text=_text + 	format	["%1<img image='Rsc\Pictures\i_driver.paa'/><br />",name _d];};
	_c=commander (vehicle	player);
	if (!isNull	_c && isPlayer	_c) then {_text=_text + 	format	["%1<img image='Rsc\Pictures\i_commander.paa'/><br />",name _c];};
	_g=gunner (vehicle	player);
	if (!isNull	_g && isPlayer	_g) then {_text=_text + 	format	["%1<img image='Rsc\Pictures\i_gunner.paa'/><br />",name _g];};
	{
			if (isplayer _x && !(commander (vehicle	player) == _x || driver	(vehicle player) ==_x || gunner (vehicle player) ==_x )) then {
				_text=_text + 	format	["%1<img image='Rsc\Pictures\i_turrets.paa'/><br />",name _x];
			};
	} forEach crew (vehicle	player);
	_text=_text+"</t></t>";
	if !(HUD_Normal) then {_t=""};
	_veh ctrlSetStructuredText	parseText	 _text;
};
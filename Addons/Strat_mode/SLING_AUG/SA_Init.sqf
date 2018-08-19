SA_ACTION_PACK=compile preprocessfilelinenumbers "Addons\Strat_mode\SLING_AUG\SA_Action_pack.sqf";
SA_PACK=compile preprocessfilelinenumbers "Addons\Strat_mode\SLING_AUG\SA_pack.sqf";
SA_PACKLOOP=compile preprocessfilelinenumbers "Addons\Strat_mode\SLING_AUG\SA_PackLoop.sqf";
SA_UNPACK=compile preprocessfilelinenumbers "Addons\Strat_mode\SLING_AUG\SA_unpack.sqf";
SA_TOATTACH=compile preprocessfilelinenumbers "Addons\Strat_mode\SLING_AUG\SA_toAttach.sqf";
SA_TODROP=compile preprocessfilelinenumbers "Addons\Strat_mode\SLING_AUG\SA_toDrop.sqf";
SA_DROP=compile preprocessfilelinenumbers "Addons\Strat_mode\SLING_AUG\SA_Drop.sqf";

with missionnamespace do {
	CTI_PVF_CLIENT_SA_PROTECT_HQ={
		diag_log  format [":: HQ :: Handling death of hq %1 for player side",_this select 0];
		(_this select 0) addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CL_FNC_OnHQDestroyed", (_this select 1)]];
		if (CTI_BASE_NOOBPROTECTION == 1) then {
			_sideid= ((_this select 1) call CTI_CO_FNC_GetSideID);
			(_this select 0) addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage", _sideid]]; //--- You want that on public
		};
	};
};

if CTI_isServer then {
	with missionnamespace do {
		CTI_PVF_SERVER_SA_SIMU={
			_target = _this select 0;
			_status= _this select 1;
			_target enableSimulationGlobal _status;
		};
		CTI_PVF_SERVER_SA_LOOP={
			_this spawn SA_PACKLOOP;
		};
		CTI_PVF_SERVER_SA_PROTECT_HQ={
			diag_log  format [":: HQ :: Handling death of hq %1 for side %2",_this select 0,_this select 1];
			_sideid= ((_this select 1) call CTI_CO_FNC_GetSideID);
			(_this select 0) addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideid]];
			if (CTI_BASE_NOOBPROTECTION == 1) then {
				(_this select 0) addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage",  _sideid]]; //--- You want that on public
			};
		};
	};
};
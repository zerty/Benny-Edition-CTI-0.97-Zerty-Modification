private ["_action","_target"];
_action = _this select 0;
_target=uiNamespace getVariable ['INT_TARG',objnull];

_base_x=SafeZoneX + SafeZoneW*0.5;
_base_y=SafeZoneY+safezoneH*0.50;
_base_w=safezoneH * 0.04;
_base_h=safezoneH * 0.04;
_offset=-4.5;
_h_offset=-1;
_max_ctrl=40;



switch (_action) do {
	case "onLoad": {
		if (_target iskindof "Man") then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510103)) ctrlsettext (format ["%1", name _target])} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510103)) ctrlsettext (getText (configFile >> "CfgVehicles" >> typeof _target >> "displayname"))};

		for "_i" from 0 to _max_ctrl /* step +1 */ do {
			switch (_i) do {
			    case 1: {// CTI_Icon_tablet // ok
			    	((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
		    		_offset=_offset+1;
			    };
			    case 2: { // CTI_Icon_GROUP
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
					_offset=_offset+1;

			    };
			    case 3: { // CTI_Icon_units
					if (!CTI_P_PreBuilding &&(Client_AN_Connected && (CTI_Base_BarracksInRange || CTI_Base_LightInRange || CTI_Base_HeavyInRange || CTI_Base_AirInRange || CTI_Base_AmmoInRange || CTI_Base_RepairInRange || CTI_Base_NavalInRange )) ||  CTI_Town_InRange) then {

						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
					} else {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.2];
					};
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
		    		_offset=_offset+1;
			    };
			   	case 4: { // CTI_Icon_inventory
					_possible=call CTI_UI_Gear_LoadAvailableUnits;
					if (alive _target && count _possible >0) then  {

						if (_target in _possible) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];} else {
							if (count _possible > 0) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.5];};
						};
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.2];
			    		//((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    	((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    	_offset=-4.5;
			    	_h_offset=_h_offset+1;

			    };

			    case 5: { // CTI_Icon_Net // ok
					if ( alive player && (missionNamespace getVariable "CTI_EW_ANET" == 1)) then  {
						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
				    	if (((player) getVariable 'CTI_Net')==CTI_P_SideID) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];};

			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    	_offset=_offset+1;
			    };
			    case 6: { // CTI_Icon_earp
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
					if (soundVolume <1) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];};
					_offset=_offset+1;
			    };
			    case 7: { // CTI_Icon_fact
					if ((CTI_P_SideLogic getVariable "cti_commander") == group player && (leader group player) == player && !CTI_P_PreBuilding && CTI_Base_HQInRange) then {

						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];

		    			_base_x+(_offset*_base_w)
					} else {
						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.2];
							//((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
					};
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
					_offset=_offset+1;
			    };
			    case 8: { // CTI_Icon_halo
					if (vehicle player == player && !CTI_P_PreBuilding && CTI_Base_HaloInRange && [CTI_P_SideJoined, CTI_UPGRADE_HALO, 1] call CTI_CO_FNC_HasUpgrade && ( (missionNamespace getVariable 'CTI_SM_HALO')==1)) then {

						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
						//((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
		    			_base_x+(_offset*_base_w)
					} else {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.2];
					};
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
					_total_h_offset=_h_offset;
					_h_offset=0;
					_offset=0;
			    };


			    case 9: {// CTI_Icon_Lock // ok

			    	if (! isnull _target &&( (getplayeruid player) in (_target getVariable ["v_keys",["",grpnull]]) || (group player) in (_target getVariable ["v_keys",["",grpnull]]) && alive _target)) then  {
			    		if (locked _target >0 ) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];};

			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };

			    case 10: { // CTI_Icon_Net // ok
					if ( alive _target && (missionNamespace getVariable "CTI_EW_ANET" == 1) && ( _target iskindof "Car" || _target iskindof "Tank" || _target iskindof "Truck" || _target iskindof "Air"|| _target iskindof "Ship") && !(_target isKindOf "I_G_Offroad_01_F")) then  {
						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
						if (locked _target >0 ) Then {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
						} else{
				    		if (((_target) getVariable 'CTI_Net')==CTI_P_SideID) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];};
				    	};
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 11: { // CTI_Icon_Def // ok
			    	if (vehicle player == player && alive _target) then {
			    		_ok=false;
			    		if (_target == ((CTI_P_sidejoined) call CTI_CO_FNC_GetSideHQ)) then {_ok=true};
			    		if (_target in (CTI_P_SideLogic getVariable ["cti_structures",[]]) ) then {
			    			if ((((missionNamespace getVariable [format ["CTI_%1_%2", CTI_P_SideJoined, typeOf _target],[[""]]]) select 0) select 0  == CTI_REPAIR )) then {_ok=true}
			    		};
			    		if (_target in (CTI_P_SideLogic getVariable ["cti_service",[]]) ) then {
			    			if ((missionNamespace getVariable [format ["%1", typeOf _target],["","","","","","","",""]]) select 7 == "service-repairtruck") then {_ok=true}
			    		};
			    		//if (_target == ((CTI_P_sidejoined) call CTI_CO_FNC_GetSideHQ) || (missionNamespace getVariable [format ["%1", typeOf _target],["","","","","","","",""]]) select 7 == "service-repairtruck"  || ((missionNamespace getVariable [format ["CTI_%1_%2", CTI_P_SideJoined, typeOf _target],[[""]]]) select 0) select 0  == CTI_REPAIR )) then  {
						if (_ok) then {
				    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
				    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
				    		_offset=_offset+1;
				    	} else {
				    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];

				   		};
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 12: { // CTI_Icon_Rep //ok

			    	if (vehicle player == player &&( _target iskindof "Car" || _target iskindof "Tank" || _target iskindof "Air"|| _target iskindof "Ship" || _target iskindof "Wheeled_APC_F"|| _target iskindof "Truck_F") && alive _target) then  {


		    			if  ((({_x == "Toolkit"} count (backpackItems player)) +({_x == "Toolkit"} count (vestItems player))) >0) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1]; } else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];};
		    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
		    			_offset=_offset+1;

			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 13: { // CTI_Icon_fl //ok
					_hqs=[];
					{_hqs set [count _hqs, _x call CTI_CO_FNC_GetSideHQ];true} count [east,west];
					if (vehicle player == player &&( _target iskindof "Car" || _target iskindof "Tank" || _target iskindof "Air"|| _target iskindof "Ship" || _target iskindof "Wheeled_APC_F"|| _target iskindof "Truck_F") && alive _target && !( getplayeruid player in (_target getVariable ["v_keys",[]])) && !(_target getVariable ["cti_occupant",civilian] == CTI_P_SideJoined)&& !(_target in _hqs)) then  {
			    		if ((({_x == "Toolkit"} count (backpackItems player)) +({_x == "Toolkit"} count (vestItems player))) >0) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1]; } else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];};
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 14: { // CTI_Icon_rev //ok
			    	if (_target iskindof "Man" && _target getVariable ['REV_UNC',false] && !( player getVariable ['REV_UNC',true])  && isNull (player getVariable ['REV_DRAGGING',objNull])&& (side group player)==(side group _target)) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 15: { // CTI_Icon_drag //ok
					if (false) then {
			    	//if ((_target iskindof "Man" && _target getVariable ['REV_UNC',false]&&!(_target getVariable ['REV_DRAGGED',true])/*|| _target iskindof "StaticWeapon"|| _target iskindof "ReammoBox_F" */)&& isNull (player getVariable ['REV_DRAGGING',objNull]) || !isNull (player getVariable ['REV_DRAGGING',objNull])) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 16: { // CTI_Icon_fpk //ok
			    	if (vehicle player != player &&(_target getVariable ['CTI_Net',-10]) >= 0 && !( _target getVariable ['CTI_Net',-11] == CTI_P_SideID) && (speed _target) <1 && (speed _target) >-1 && ((CTI_P_SideLogic getVariable 'cti_upgrades') select CTI_UPGRADE_EXPI) > 0 && ! AN_E_INTRU ) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 17: { // CTI_Icon_intru
			    	if (vehicle player != player &&(_target getVariable ['CTI_Net',-10]) >= 0 && !(_target getVariable ['CTI_Net',-11] == CTI_P_SideID)  && ((CTI_P_SideLogic getVariable 'cti_upgrades') select CTI_UPGRADE_EXPI) > 0 && (_target getVariable ['CTI_Net',-10]) == (_target getVariable ['AN_inet',-11])&& (_target getVariable ['AN_Hacked',0])>0 && !(_target getVariable ['AN_Hack_started',false])) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 18: { // CTI_Icon_load //ok
			    	if (vehicle player != player && driver vehicle player ==player && _target iskindof "I_G_Offroad_01_F" && speed _target <1 && speed _target >-1 && alive _target &&  ! STATIC_TRY) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 19: { // CTI_Icon_fact // ok
			    	if (_target in (CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures) && alive _target && !isnil {missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, typeOf _target]}) then  {
			    		_var=missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, typeOf _target];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510103)) ctrlsettext (format ["%1", ((_var select 0) select 2)]);
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 20: { // CTI_Icon_Del //OK?
			    	if ((_target in (CTI_P_SideLogic getVariable ["cti_defences", []]) || _target in (CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures) || _target in (CTI_P_SideLogic getVariable ["cti_workers", []])) && alive _target &&(0  call CTI_CL_FNC_IsPlayerCommander)) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 21: { // CTI_Icon_rephq
			    	if ((missionNamespace getVariable "CTI_BASE_HQ_REPAIR") > 0 && (missionNamespace getVariable [format ["%1", typeOf _target],["","","","","","","",""]]) select 7 == "service-repairtruck" &&  !alive(CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ) ) then  {
			    		if ((CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ) distance _target <= CTI_BASE_HQ_REPAIR_RANGE && (0 call CTI_CL_FNC_GetPlayerFunds) >= CTI_BASE_HQ_REPAIR_PRICE) then {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		}else {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
			    		};
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 22: { // CTI_Icon_push //ok
			    	if (vehicle player != player && driver vehicle player ==player && (_target iskindof "Plane" || _target iskindof "Ship") && speed _target <1 && speed _target >-1 && alive _target ) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 23: { // CTI_Icon_pull //OK
			    	if (vehicle player != player && driver vehicle player ==player && (_target iskindof "Plane" || _target iskindof "Ship") && speed _target <1 && speed _target >-1 && alive _target ) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 24: { // CTI_Icon_pack
			    	_hqs=[];
					//{_hqs set [count _hqs, _x call CTI_CO_FNC_GetSideHQ];true} count [east,west];
			    	if (vehicle player == player && (_target iskindof "Tank" || _target iskindof "Wheeled_APC_F" || _target iskindof "Truck_F" || (typeof _target) in ["Land_Pod_Heli_Transport_04_box_F","B_Slingload_01_Cargo_F"])&& alive _target && !(_target in _hqs)) then  {
			    		if ((count (crew _target) == 0) && abs (speed _target) <1 && locked _target <2 ) then {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		} else {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
			    		};

			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 25: { // CTI_Icon_attach
			    	if (vehicle player != player && driver vehicle player ==player && (typeof _target) == "O_Heli_Transport_04_F"  ) then  {
			    		if (isNull (getSlingLoad _target) || !((typeof (getSlingLoad _target)) in ["Land_Pod_Heli_Transport_04_fuel_F","Land_Pod_Heli_Transport_04_ammo_F","Land_Pod_Heli_Transport_04_bench_F","Land_Pod_Heli_Transport_04_box_F","Land_Pod_Heli_Transport_04_repair_F","Land_Pod_Heli_Transport_04_medevac_F"])) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		};
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 26: { // CTI_Icon_PARAdrop

			    	if (vehicle player != player && driver vehicle player ==player && (_target iskindof "Helicopter") ) then  {

			    		if ((isNull  (getSlingLoad _target) && count (attachedObjects _target) ==0)) then {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
			    		} else {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		};

			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 27: { // CTI_Icon_build
			    	if (vehicle player == player && _target in (CTI_P_SideLogic getVariable ["cti_structures_wip",[]])&& (missionNamespace getVariable "CTI_BASEBUILDING") > 0) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 28: { // CTI_Icon_srep
			    	if (vehicle player == player && _target in (CTI_P_SideLogic getVariable ["cti_structures",[]])&&( getDammage _target >0 ||  _target getVariable ["cti_altdmg",-1] >0) && (missionNamespace getVariable "CTI_BASEBUILDING") > 0) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 29: { // CTI_Icon_al
			    	if (alive _target  && _target iskindof "Air" ) then  {
			    		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			    		_ammo_depots = [CTI_AMMO, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;
			    		_available_ammo_depots = [_target, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
			    		_available_ammo_trucks = [_target, CTI_SPECIAL_AMMOTRUCK, CTI_SERVICE_AMMO_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
			    		if (!(_target getVariable ["CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY",true]) && count (_available_ammo_depots + _available_ammo_trucks) >0 && local _target ) then {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		} else {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
			    		};

			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 30: {// CTI_Icon_Com
			    	if (! isnull _target && alive _target && (_target == (CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ) || _target in (CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures)) ) then  {
			    		if (isNull (CTI_P_SideJoined  call CTI_CO_FNC_GetSideCommander )&& !( (getplayeruid player) in (CTI_P_SideLogic getVariable ["CTI_COM_BLACKLIST",[] ]))) then {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
			    		} else {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
			    		};

			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 31: {// CTI_Icon_Pilot

			    	if (! isnull _target && alive _target && vehicle player == player &&(_target isKindOf "B_Heli_Transport_03_base_F" || _target isKindOf "Heli_Transport_04_base_F" )) then  {
			    		if (!((304400  in (getdlcs 1)) || (288520  in (getdlcs 1)))&& locked _target < 2 && isNull (driver _target))  then {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		} else {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
			    		};

			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };

			};
		};
		//if (_offset == 0) exitwith {false};
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510100)) ctrlSetPosition [_base_x- _base_w*4.70,_base_y- _base_h*0.20-SafeZoneH * 0.04,0,_base_h*1.4 +SafeZoneH * 0.04];
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510101)) ctrlSetPosition [_base_x- _base_w*0.10,_base_y- _base_h*(0.10+_h_offset),0,_base_h*1.2 ];
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510100)) ctrlcommit 0;
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510101)) ctrlcommit 0;
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510100)) ctrlSetPosition [_base_x- _base_w*4.7,_base_y- _base_h*0.2-SafeZoneH * 0.04,((_offset+0.4+4.7)*_base_w) max (SafeZoneW*0.15+_base_w*4.70 ),_base_h*1.4+SafeZoneH * 0.04 ];
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510101)) ctrlSetPosition [_base_x- _base_w*0.1,_base_y- _base_h*0.1,((_offset+0.2)*_base_w) max (SafeZoneW*0.15- _base_w*0.2),_base_h*1.2 ];
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510103)) ctrlSetPosition [_base_x,_base_y- _base_h*0.20-SafeZoneH * 0.03,SafeZoneW*0.15,SafeZoneH * 0.03];
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510100)) ctrlcommit 0.1;
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510101)) ctrlcommit 0.1;
		for "_i" from 1 to _max_ctrl /* step +1 */ do {
			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlcommit 0;
		};
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510103)) ctrlcommit 0;
	};
	case "OnLock": {
		if (locked _target >0 ) then {_target lock 0;} else {_target lock 2};
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'
	};
	case "OnNet": {
		if (locked _target >0) exitwith {false};
		if ((_target getVariable ['CTI_Net',-1])!= -1) Then {
			_target setVariable ['CTI_Net',-1,true];
			_target setVariable ['AN_iNet',CTI_P_SideID,true];
		} else {
			_target setVariable ['CTI_Net',CTI_P_SideID,true];
			["SERVER","Server_Run_Net",[_target,CTI_P_SideID]] call CTI_CO_FNC_NetSend;
		};
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'
	};
	case "OnNetp": {
		if ((player getVariable ['CTI_Net',-1])!= -1) Then {
			player setVariable ['CTI_Net',-1,true];
			player setVariable ['AN_iNet',CTI_P_SideID,true];
		} else {
			player setVariable ['CTI_Net',CTI_P_SideID,true];
			//["SERVER","Server_Run_Net",[_target,CTI_P_SideID]] call CTI_CO_FNC_NetSend;
		};
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'
	};
	case "OnDef": {
		uiNamespace setVariable ['cti_dialog_ui_defensemenu',objnull];
		closedialog 0;
		[_target] execVM  "Client\Actions\Action_DefenseMenu.sqf";
	};
	case "OnRepair": {
		closedialog 0;
		[_target,player] spawn SM_repair_vehicle;
	};
	case "OnForce": {
		closedialog 0;
		[_target,player] spawn SM_Force_entry;
	};
	case "OnRev": {
		closedialog 0;
		[_target,player] spawn REV_ACT_REV;
	};
	case "OnDrag": {
		closedialog 0;
		if (isNull (player getVariable ['REV_DRAGGING',objNull])) then {
			if ( _target iskindof "Man") then {[_target,player] spawn REV_ACT_DRAG;};
		} else {
			if (_target iskindof "Man") then {[player] spawn REV_ACT_REL;};
		};
	};
	case "OnFact": {
		closedialog 0;
		uiNamespace setVariable ['cti_dialog_ui_purchasemenu',objnull];
		[_target] execVM "Client\Actions\Action_UseNearestFactory.sqf";
	};
	case "OnDel": {
		if (_target in (CTI_P_SideLogic getVariable ["cti_defences", []])) Then {
			deletevehicle _target;
		};
		if (_target in (CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures) || _target in (CTI_P_SideLogic getVariable ["cti_workers", []]) ) Then {
				_target setVariable ["cti_sell", true, true];
				_target setDammage 1;
		};
		closedialog 0;
	};
	case "OnFpk": {
		[_target,player] spawn AN_E_Intrusion_Start;
		AN_E_INTRU=true;
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';
	};
	case "OnIntru": {
		(_target) setVariable ['AN_Hack_started',true,true];
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';
	};
	case "OnLoad": {
		CTI_P_ChatID commandChat  'ST LOAD :: Trying to load a static, please wait' ;
		STATIC_TRY=true;
		['SERVER','Request_load',[_target,player]]call CTI_CO_FNC_NetSend;
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';
	};
	case "OnPull": {
		if (speed _target <2 && speed _target >-2) then{	[_target,player] execVM "Client\Actions\Action_TaxiReverse.sqf"};
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';
	};
	case "OnPush": {
		if (speed _target <2 && speed _target >-2) then{[_target,player] execVM "Client\Actions\Action_Push.sqf"};
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';
	};
	case "OnRepHQ": {
		CTI_P_LastRepairTime = time;
		[_target,player] execVM "Client\Actions\Action_RepairHQ.sqf";
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';
	};
	case "OnFact": {
		closedialog 0;
		//uiNamespace setVariable ['cti_dialog_ui_purchasemenu',objnull];
		[_target] execVM "Client\Actions\Action_UseNearestFactory.sqf";
	};
	case "OnUnits": {
		closedialog 0;
		//uiNamespace setVariable ['cti_dialog_ui_purchasemenu',objnull];
		[_target] execVM "Client\Actions\Action_UseNearestFactory.sqf";
	};
	case "OnPara": {
		closedialog 0;
		(_target) spawn SA_TODROP;
	};
	case "OnAtt": {
		closedialog 0;
		(_target) spawn SA_TOATTACH;
	};
	case "OnPack": {
		closedialog 0;
		CTI_P_Repairing = true ;
		[player,_target] spawn SA_ACTION_PACK;
	};
	case "OnGear": {
		_possible=call CTI_UI_Gear_LoadAvailableUnits;
		if ((count _possible) == 0) exitWith{false};
		closedialog 0;
		disableserialization;
		uiNamespace setVariable ['GEAR_TARG',_target];
		createDialog "CTI_RscGearMenu";
	};
	case "OnBuild": {
		closedialog 0;
		[player,_target] spawn SM_ACTION_BUILD;
	};
	case "OnSRep": {
		closedialog 0;
		[player,_target] spawn SM_ACTION_REPAIR;
	};
	case "OnAircraftCust": {
		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		_ammo_depots = [CTI_AMMO, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;
		_available_ammo_depots = [_target, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
		_available_ammo_trucks = [_target, CTI_SPECIAL_AMMOTRUCK, CTI_SERVICE_AMMO_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
		if (!(_target getVariable ["CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY",true]) && count (_available_ammo_depots + _available_ammo_trucks) >0 && local _target ) then {
			uiNamespace setVariable ['HAL_TARG',_target];
			closedialog 0;
			createDialog "CTI_RscTabletAircraftLoadoutMenu";
		};
	};
	case "OnCom": {
		if (isNull (CTI_P_SideJoined  call CTI_CO_FNC_GetSideCommander )&& !( (getplayeruid player) in (CTI_P_SideLogic getVariable ["CTI_COM_BLACKLIST",[]] ))) then {
			closedialog 0;
			0 call CTI_COM_SET_CLIENT;
		};
	};
	case "OnTablet": {
		closedialog 0;
		createdialog "CTI_RscTablet_main";
	};

	case "OnBFact": {
		if !((CTI_P_SideLogic getVariable "cti_commander") == group player&& (leader group player) == player  && !CTI_P_PreBuilding && CTI_Base_HQInRange) exitwith {false};
		closedialog 0;
		createDialog "CTI_RscBuildMenu_Tablet";
	};
	case "OnPilot": {
		closedialog 0;
		if  (isNull (driver _target)) then {player moveInDriver _target} else {0 spawn { hint "There is already a pilot";sleep 3;hintSilent "";}};
	};
	case "OnHalo": {
		if !(vehicle player == player && !CTI_P_PreBuilding && CTI_Base_HaloInRange && [CTI_P_SideJoined, CTI_UPGRADE_HALO, 1] call CTI_CO_FNC_HasUpgrade && ( (missionNamespace getVariable 'CTI_SM_HALO')==1)) exitwith {false};
		closedialog 0;
		0 execvm "Addons\ATM_airdrop\atm_airdrop.sqf"
	};
	case "OnEarp": {
		if (soundVolume <1) Then {
			0.5 fadeSound 1;
		} else {
			0.5 fadeSound 0.25;
		};
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf';
	};
	case "OnGroup": {
		closedialog 0;
		createDialog  "RscDisplayDynamicGroups";
	};

};
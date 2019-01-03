private ["_action","_target"];
_action = _this select 0;
_target=uiNamespace getVariable ['INT_TARG',objnull];
if !(cameraOn == player || cameraOn == vehicle player) then {_target = cameraOn;};

_base_x=SafeZoneX + SafeZoneW*0.5;
_base_y=SafeZoneY+safezoneH*0.50;
_base_w=safezoneH * 0.04;
_base_h=safezoneH * 0.04;
_offset=-5;
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
			    case 2: { // CTI_Icon_units
					if (!CTI_P_PreBuilding &&(Client_AN_Connected && (CTI_Base_BarracksInRange || CTI_Base_LightInRange || CTI_Base_HeavyInRange || CTI_Base_AirInRange || CTI_Base_AmmoInRange || CTI_Base_RepairInRange || CTI_Base_NavalInRange )) ||  CTI_Town_InRange) then {

						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
					} else {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.2];
					};
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
		    		_offset=_offset+1;
			    };
			   	case 3: {
					if (CTI_Base_GearInRange) then {
						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.2];
			    	};
			    	((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    	_offset=_offset+1;


			    };
			    case 4: { // CTI_Icon_fact
					if (vehicle player == player &&(CTI_P_SideLogic getVariable "cti_commander") == group player && (leader group player) == player && !CTI_P_PreBuilding && CTI_Base_HQInRange) then {

						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];

		    			_base_x+(_offset*_base_w)
					} else {
						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.2];
							//((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
					};
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
					_offset=_offset+1;
			    };
			    case 5: { // CTI_Icon_halo
					if (vehicle player == player && !CTI_P_PreBuilding && CTI_Base_HaloInRange && [CTI_P_SideJoined, CTI_UPGRADE_HALO, 1] call CTI_CO_FNC_HasUpgrade && ( (missionNamespace getVariable 'CTI_SM_HALO')==1) && !(player getvariable ["REV_UNC",false])) then {

						if (time - CTI_HALO_LASTTIME >= CTI_HALO_COOLDOWN) then {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Icon_Halo";
						}else{
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,0.3];
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip format [localize "STR_Tooltip_HALO_Jump",floor((CTI_HALO_COOLDOWN-(time - CTI_HALO_LASTTIME))/60)];
						};

					} else {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,0.2];
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Tooltip_HALO_Jump_NA";
					};
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
					_offset=-5;
			    	_h_offset=_h_offset+1;

			    };
				case 6: { // CTI_Icon_GROUP
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,0,1];
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
					_offset=_offset+1;

			    };
			    case 7: { // CTI_Icon_Net // ok
					if ( alive player && (missionNamespace getVariable "CTI_EW_ANET" == 1)) then  {
						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
				    	if (((player) getVariable 'CTI_Net')==CTI_P_SideID) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];};

			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    	_offset=_offset+1;
			    };
			    case 8: { // CTI_thud
					if (profileNamespace getVariable ["HUD_Tactical",true]) then {
						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];
			    	};
			    	((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    	_offset=_offset+1;

			    };


			    case 9: { // CTI_Icon_earp
					((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
					if (soundVolume <1) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];};
					_total_h_offset=_h_offset;
					_h_offset=0;
					_offset=0;
			    };



			    case 10: {// CTI_Icon_Lock // ok

			    	if (! isnull _target && alive _target &&( (getplayeruid player) in (_target getVariable ["v_keys",["",grpnull]]) || (group player) in (_target getVariable ["v_keys",["",grpnull]]) || ((CTI_P_SideLogic getVariable "cti_commander") == (group player) && (_target getvariable ["cti_occupant",civilian]) == CTI_P_sidejoined)) ) then  {
			    		if (locked _target >0 ) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];};

			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };

			    case 11: { // CTI_Icon_Net // ok
					if ( alive _target && (missionNamespace getVariable "CTI_EW_ANET" == 1) && ( _target iskindof "Car" || _target iskindof "Tank" || _target iskindof "Truck" || _target iskindof "Air"|| _target iskindof "Ship") && !(_target isKindOf "UAV_01_base_F" || _target isKindOf "UAV_06_base_F")) then  {
						((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
						if (locked _target >0 ) Then {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Network_Lock";
						} else{
				    		if (((_target) getVariable 'CTI_Net')==CTI_P_SideID) then {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,1,0,1];} else {((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];};
				    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Icon_Net";
				    	};
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 12: { // CTI_Icon_Def // ok
			    	if (vehicle player == player && alive _target) then {
			    		_ok=false;
			    		_reptrucknear = [player, CTI_SPECIAL_REPAIRTRUCK, 20] call CTI_CO_FNC_GetNearestSpecialVehicles;
						if (count _reptrucknear > 0) then {_ok=true};
						_hq = (CTI_P_sidejoined) call CTI_CO_FNC_GetSideHQ;
						if ((player distance2D _hq) < 20 && alive _hq) then {_ok=true};
						_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			    		_rep_depots = [CTI_REPAIR, _structures] call CTI_CO_FNC_GetSideStructuresByType;
			    		_available_rep_depots = [player, _rep_depots, 20] call CTI_UI_Service_GetBaseDepots;
						if (count _available_rep_depots > 0) then {_ok=true};
						/*
			    		if (_target == ((CTI_P_sidejoined) call CTI_CO_FNC_GetSideHQ)) then {_ok=true};
			    		if (_target in (CTI_P_SideLogic getVariable ["cti_structures",[]]) ) then {
			    			if ((((missionNamespace getVariable [format ["CTI_%1_%2", CTI_P_SideJoined, typeOf _target],[[""]]]) select 0) select 0  == CTI_REPAIR )) then {_ok=true;};
			    		};
			    		if (_target in ((CTI_WEST getvariable ["cti_service", []]) + (CTI_EAST getvariable ["cti_service", []])) ) then {
			    			if ((missionNamespace getVariable [format ["%1", typeOf _target],["","","","","","","",""]]) select 7 == "service-repairtruck") then {_ok=true;};
			    		};
			    		*/
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
				case 13: { // CTI_Icon_Rep //ok
					_hps = 0;
					if ((_target iskindof "Car" || _target iskindof "Tank" || _target iskindof "Air"|| _target iskindof "Ship" || _target iskindof "Wheeled_APC_F" || _target iskindof "Truck_F") && !(_target iskindof "parachutebase" || _target iskindof "UAV_01_base_F")) then {
					_hps = {_x != 0} count (getAllHitPointsDamage _target select 2);
					};
			    	if (vehicle player == player && _hps > 0 && (_target iskindof "Car" || _target iskindof "Tank" || _target iskindof "Air"|| _target iskindof "Ship" || _target iskindof "Wheeled_APC_F"|| _target iskindof "Truck_F") && alive _target) then  {


		    			if ((({_x == "Toolkit"} count (backpackItems player)) + ({_x == "Toolkit"} count (vestItems player)) + ({_x == "Toolkit"} count (itemCargo _target))) >0) then {
		    				((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
		    				((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Icon_Rep";
		    				 } else {
		    				 ((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
		    				 ((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Repair_No_Toolkit";
		    				};
		    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
		    			_offset=_offset+1;

			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 14: { // CTI_Icon_fl //ok
					_hqs=[];
					{_hqs set [count _hqs, _x call CTI_CO_FNC_GetSideHQ];true} count [east,west];
					if (vehicle player == player && (_target iskindof "Car" || _target iskindof "Ship" || _target iskindof "Wheeled_APC_F" || _target iskindof "Truck_F") && alive _target && !( getplayeruid player in (_target getVariable ["v_keys",[]])) && !(_target getVariable ["cti_occupant",civilian] == CTI_P_SideJoined)&& !(_target in _hqs || _target isKindOf "UAV_01_base_F" || _target isKindOf "UAV_06_base_F")) then {
						if ((({_x == "Toolkit"} count (backpackItems player)) +({_x == "Toolkit"} count (vestItems player))) >0) then {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Icon_FL";
			    		} else {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Force_Lock_No_ToolKit";
			    		};
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
						if (vehicle player == player && (_target iskindof "Tank" || _target iskindof "Air") && !(_target isKindOf "UAV_01_base_F" || _target isKindOf "UAV_06_base_F") && alive _target && !( getplayeruid player in (_target getVariable ["v_keys",[]])) && !(_target getVariable ["cti_occupant",civilian] == CTI_P_SideJoined)&& !(_target in _hqs)) then {
						_rt = 0;
						_reptruck = [_target, CTI_SPECIAL_REPAIRTRUCK, 50] call CTI_CO_FNC_GetNearestSpecialVehicles;
						if (count _reptruck > 0) then {_rt = 1;};
							if ((({_x == "Toolkit"} count (backpackItems player)) +({_x == "Toolkit"} count (vestItems player))) >0 && _rt == 1) then {
								((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
								((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Icon_FL";
							} else {
								((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
								((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Force_Lock_No_ToolKit_No_RepTruck";
							};
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
							_offset=_offset+1;
							} else {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
						};
					};
				};
				case 15: { // CTI_Icon_rev //ok
			    	if (_target iskindof "Man" && _target getVariable ['REV_UNC',false] && !( player getVariable ['REV_UNC',true])  && isNull (player getVariable ['REV_DRAGGING',objNull])&& (side group player)==(side group _target)) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 16: { // CTI_Icon_drag //ok
					if (false) then {
			    	//if ((_target iskindof "Man" && _target getVariable ['REV_UNC',false]&&!(_target getVariable ['REV_DRAGGED',true])/*|| _target iskindof "StaticWeapon"|| _target iskindof "ReammoBox_F" */)&& isNull (player getVariable ['REV_DRAGGING',objNull]) || !isNull (player getVariable ['REV_DRAGGING',objNull])) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 17: { // CTI_Icon_fpk //ok
			    	if (vehicle player != player &&(_target getVariable ['CTI_Net',-10]) >= 0 && !( _target getVariable ['CTI_Net',-11] == CTI_P_SideID) && (speed _target) <1 && (speed _target) >-1 && ((CTI_P_SideLogic getVariable 'cti_upgrades') select CTI_UPGRADE_EXPI) > 0 && ! AN_E_INTRU ) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 18: { // CTI_Icon_intru
			    	if (vehicle player != player &&(_target getVariable ['CTI_Net',-10]) >= 0 && !(_target getVariable ['CTI_Net',-11] == CTI_P_SideID)  && ((CTI_P_SideLogic getVariable 'cti_upgrades') select CTI_UPGRADE_EXPI) > 0 && (_target getVariable ['CTI_Net',-10]) == (_target getVariable ['AN_inet',-11])&& (_target getVariable ['AN_Hacked',0])>0 && !(_target getVariable ['AN_Hack_started',false])) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 19: { // CTI_Icon_load //ok
			    	if (vehicle player != player && driver vehicle player ==player && (_target iskindof "I_G_Offroad_01_F" || _target iskindOf "B_G_Van_02_vehicle_F" || _target iskindOf "O_G_Van_02_vehicle_F") && speed _target <1 && speed _target >-1 && alive _target &&  ! STATIC_TRY) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 20: { // CTI_Icon_fact // ok
			    	if (_target in (CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures) && !((_target getVariable ["cti_structure_type",""]) in ["",CTI_RADAR,CTI_CONTROLCENTER] )&& alive _target && !isnil {missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, typeOf _target]}) then  {
			    		_var=missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, typeOf _target];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510103)) ctrlsettext (format ["%1", ((_var select 0) select 2)]);
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 21: { // CTI_Icon_Del //OK?
			    	if ((_target in (CTI_P_SideLogic getVariable ["cti_defences", []]) || _target in (CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures) || _target in (CTI_P_SideLogic getVariable ["cti_workers", []])) && alive _target &&(0  call CTI_CL_FNC_IsPlayerCommander)) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 22: { // CTI_Icon_rephq
			    	if ((missionNamespace getVariable "CTI_BASE_HQ_REPAIR") > 0 && (missionNamespace getVariable [format ["%1", typeOf _target],["","","","","","","",""]]) select 7 == "service-repairtruck" &&  !alive(CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ) ) then  {
			    		if ((CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ) distance _target <= CTI_BASE_HQ_REPAIR_RANGE && (0 call CTI_CL_FNC_GetPlayerFunds) >= CTI_BASE_HQ_REPAIR_PRICE && !(missionNamespace getVariable [format["CTI_HQ_Repair_Lock_%1", CTI_P_SideJoined], false])) then {
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
			    case 23: { // CTI_Icon_push //ok
			    	if (!(_target iskindof "Man" || _target iskindof "Static" || _target isKindOf "UAV_01_base_F" || _target isKindOf "UAV_06_base_F") && local _target && simulationEnabled _target && speed _target <1 && speed _target >-1 && alive _target && locked _target < 2 && typeOf _target != "") then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 24: { // CTI_Icon_pull //OK
			    	if (!(_target iskindof "Man" || _target iskindof "Static" || _target isKindOf "UAV_01_base_F" || _target isKindOf "UAV_06_base_F") && local _target && simulationEnabled _target && speed _target <1 && speed _target >-1 && alive _target && locked _target < 2 && typeOf _target != "") then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 25: { // CTI_Icon_pack
			    	_hqs=[];
					//{_hqs set [count _hqs, _x call CTI_CO_FNC_GetSideHQ];true} count [east,west];
			    	if (vehicle player == player && (_target iskindof "Tank" || _target iskindof "Wheeled_APC_F" || _target iskindof "Truck_F" || (typeof _target) in ["Land_Pod_Heli_Transport_04_box_F","B_Slingload_01_Cargo_F"])&& alive _target && !(_target in _hqs)) then  {
			    		if (({alive _x} count (crew _target) == 0) && abs (speed _target) <1 && locked _target <2 ) then {
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
			    case 26: { // CTI_Icon_attach
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
			    case 27: { // CTI_Icon_PARAdrop

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
			    case 28: { // CTI_Icon_build
			    	if (vehicle player == player && _target in (CTI_P_SideLogic getVariable ["cti_structures_wip",[]])&& (missionNamespace getVariable "CTI_BASEBUILDING") > 0) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 29: { // CTI_Icon_srep
			    	if (vehicle player == player && _target in (CTI_P_SideLogic getVariable ["cti_structures",[]])&&( getDammage _target >0 ||  _target getVariable ["cti_altdmg",-1] >0) && (missionNamespace getVariable "CTI_BASEBUILDING") > 0) then  {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			    case 30: { // CTI_Icon_al
			    	if (alive _target  && _target iskindof "Air" && !(_target iskindOf "parachutebase" || _target isKindOf "UAV_01_base_F" || _target isKindOf "UAV_06_base_F")) then {
			    		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			    		_ammo_depots = [CTI_AMMO, _structures] call CTI_CO_FNC_GetSideStructuresByType;
			    		_available_ammo_depots = [_target, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
			    		if (!(_target getVariable ["CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY",true]) && count (_available_ammo_depots) >0 && local _target && locked _target < 2) then {
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
				case 31: {// CTI_Icon_Com
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
			    case 32: {// CTI_Icon_Pilot

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
			    case 33: {// CTI_Icon_Exit Tutorial

			    	if (_target isKindOf "Land_Wreck_Heli_Attack_01_F") then {
			    		if ((CTI_P_SideLogic getVariable ["CTI_LOAD_COMPLETED",false])) then {
			    				((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,1,1];
			    			} else {
			    				((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.2,0.2,0.2,1];
			    			};
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			   case 34: {// Mobile gear access

			    	if ( CTI_SPECIAL_AMMOTRUCK in (_target getVariable ["cti_spec",[]]) || CTI_SPECIAL_GEAR in (_target getVariable ["cti_spec",[]]) || (CTI_SPECIAL_MEDICALVEHICLE in (_target getVariable ["cti_spec",[]])&& ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_REST >=CTI_GAMEPLAY_REARM_MED )) then {
			    		if ((time-(_target getvariable ["CTI_last_purchase_time",-10000])) >= CTI_GEAR_MOBILE_COOLOFF || (_target getvariable ["CTI_last_purchase_time",-10000])<0 ) then{
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0,0,1,1];
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip localize "STR_Icon_MobileG";
			    		} else {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [0.3,0.3,0.3,1];
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTooltip format [localize "STR_MGA_sec", ceil(CTI_GEAR_MOBILE_COOLOFF-(time-(_target getvariable ["CTI_last_purchase_time",-10000])))];
			    		};

			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
			   case 35: {// Dismount defense

			    	if (vehicle player == player && (_target in (CTI_WEST getVariable ["cti_defences", []]) +(CTI_EAST getVariable ["cti_defences", []]))&& (missionNamespace getVariable "CTI_BASEBUILDING") > 0) then  {
			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,0,0,1];

			    			((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];

			    		_offset=_offset+1;
			    	} else {
			    		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
			    	};
			    };
				case 36: {// Eject Cargo [H]Tom
			    	if (alive _target && vehicle player != player && driver _target == player && (_target isKindOf "Car" || _target isKindOf "Ship" || _target isKindOf "Air" || _target isKindOf "Tank") && locked _target < 2 && speed _target < 5 && speed _target > -5 && (getPos _target select 2) < 2) then {
						_crew = crew _target;
						_driver = [driver _target];
						_gunner = [gunner _target];
						_commander = [commander _target];
						_alivecargo = {alive _x} count (_crew - (_driver + _gunner + _commander));
			    		if (count (_crew - (_driver + _gunner + _commander)) > 0 && local _target && _alivecargo != 0) then {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetTextColor [1,1,1,1];
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+_h_offset*_base_h,_base_w,_base_h];
							_offset=_offset+1;
						} else {
							((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (511000+_i)) ctrlSetPosition [_base_x+(_offset*_base_w),_base_y+5,_base_w,_base_h];
						};
					};
				};
				case 37: {// CamoNet [H]Tom
					_possible = 0;
					if (_target isKindOf "Wheeled_APC_F" || _target isKindOf "Tank") then {
						_orig = [_target] call bis_fnc_getVehicleCustomization select 1;
						_camohull = "showCamonetHull";
						_camoturret = "showCamonetTurret";
						if  (_camohull in _orig || _camoturret in _orig) then {_possible = 1;};
					};
			    	if (alive _target && (_target isKindOf "Wheeled_APC_F" || _target isKindOf "Tank") && locked _target < 2 && speed _target < 2 && speed _target > -2 && _possible == 1) then {
			    		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			    		_rep_depots = [CTI_REPAIR, _structures] call CTI_CO_FNC_GetSideStructuresByType;
			    		_available_rep_depots = [_target, _rep_depots, CTI_SERVICE_REPAIR_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
						_available_rep_trucks = [_target, CTI_SPECIAL_REPAIRTRUCK, CTI_SERVICE_REPAIR_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
						_funds = [group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
						_money = 0;
						if (_funds >= 500) then {_money = 1;};
			    		if (count (_available_rep_depots + _available_rep_trucks) > 0 && local _target && _money == 1) then {
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
				case 38: {// SlatCage [H]Tom
					_cage = 0;
					if (_target isKindOf "Wheeled_APC_F" || _target isKindOf "Tank") then {
						_orig = [_target] call bis_fnc_getVehicleCustomization select 1;
						if ("showSLATHull" in _orig || "showSLATTurret" in _orig || "HideHull" in _orig || "HideTurret" in _orig) then {_cage = 1;};
					};
			    	if (alive _target && (_target isKindOf "Wheeled_APC_F" || _target isKindOf "Tank") && locked _target < 2 && _cage == 1 && speed _target < 2 && speed _target > -2) then {
			    		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			    		_rep_depots = [CTI_REPAIR, _structures] call CTI_CO_FNC_GetSideStructuresByType;
			    		_available_rep_depots = [_target, _rep_depots, CTI_SERVICE_REPAIR_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
						_available_rep_trucks = [_target, CTI_SPECIAL_REPAIRTRUCK, CTI_SERVICE_REPAIR_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
						_funds = [group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
						_money = 0;
						if (_funds >= 1500) then {_money = 1;};
			    		if (count (_available_rep_depots + _available_rep_trucks) > 0 && local _target && _money == 1) then {
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
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510100)) ctrlSetPosition [_base_x- _base_w*5.20,_base_y- _base_h*0.20-SafeZoneH * 0.04,0,_base_h*1.4 +SafeZoneH * 0.04];
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510101)) ctrlSetPosition [_base_x- _base_w*0.10,_base_y- _base_h*(0.10+_h_offset),0,_base_h*1.2 ];
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510100)) ctrlcommit 0;
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510101)) ctrlcommit 0;
		((uiNamespace getVariable "cti_dialog_ui_interractions") displayCtrl (510100)) ctrlSetPosition [_base_x- _base_w*5.2,_base_y- _base_h*0.2-SafeZoneH * 0.04,((_offset+0.4+5.2)*_base_w) max (SafeZoneW*0.15+_base_w*5.2 ),_base_h*1.4+SafeZoneH * 0.04 ];
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
		if (locked _target >0&& !(_target isKindOf "Heli_light_03_base_F")) exitwith {false}; // migth fix the hellcat problem
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
			player setVariable ["AN_iNet",-1,true];
			player setVariable ["AN_Parrents",[],false];
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
		if (!(_target isKindOf "Tank" || _target isKindOf "Air")) then {
			[_target,player] spawn SM_Force_entry;
		} else {
			_available_rep_trucks = [_target, CTI_SPECIAL_REPAIRTRUCK, 50] call CTI_CO_FNC_GetNearestSpecialVehicles;
			if ((count _available_rep_trucks) > 0) then {
				[_target,player] spawn SM_Force_entry;
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You need a <t color='#ccffaf'>ToolKit</t> and a <t color='#ccffaf'>Repair truck</t> (closer than <t color='#beafff'>50m</t>) to perform this action.";
			};
		};
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
	/*case "OnFact": {
		closedialog 0;
		//uiNamespace setVariable ['cti_dialog_ui_purchasemenu',objnull];
		[_target] execVM "Client\Actions\Action_UseNearestFactory.sqf";
	};*/
	case "OnUnits": {
		closedialog 0;
		//uiNamespace setVariable ['cti_dialog_ui_purchasemenu',objnull];
		if (!CTI_P_PreBuilding &&(Client_AN_Connected && (CTI_Base_BarracksInRange || CTI_Base_LightInRange || CTI_Base_HeavyInRange || CTI_Base_AirInRange || CTI_Base_AmmoInRange || CTI_Base_RepairInRange || CTI_Base_NavalInRange )) ||  CTI_Town_InRange) then {
			[_target] execVM "Client\Actions\Action_UseNearestFactory.sqf";
		};
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
		//uiNamespace setVariable ['GEAR_TARG',_target];
		uiNamespace setVariable ['GEAR_TARG_F',false];
		createDialog "CTI_RscGearMenu";
	};
	case "OnGearM": {
		if ((time-(_target getvariable ["CTI_last_purchase_time",-10000])) < CTI_GEAR_MOBILE_COOLOFF) exitWith {false};
		closedialog 0;
		disableserialization;
		uiNamespace setVariable ['GEAR_TARG',_target];
		uiNamespace setVariable ['GEAR_TARG_F',true];
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
	case "OnDisDef": {
		closedialog 0;
		[player,_target] spawn SM_ACTION_DISMANTLE;
	};
	case "OnAircraftCust": {
		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		_ammo_depots = [CTI_AMMO, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;
		_available_ammo_depots = [_target, _ammo_depots, CTI_SERVICE_AMMO_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
		_available_ammo_trucks = [_target, CTI_SPECIAL_AMMOTRUCK, CTI_SERVICE_AMMO_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
		if (!(_target getVariable ["CTI_AC_AIRCRAFT_LOADOUT_IS_BUSY",true]) && count (_available_ammo_depots + _available_ammo_trucks) >0 && local _target && locked _target < 2) then {
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
		if !(vehicle player == player &&(CTI_P_SideLogic getVariable "cti_commander") == group player&& (leader group player) == player  && !CTI_P_PreBuilding && CTI_Base_HQInRange) exitwith {false};
		closedialog 0;
		createDialog "CTI_RscBuildMenu_Tablet";
	};
	case "OnPilot": {
		closedialog 0;
		if  (isNull (driver _target)) then {player moveInDriver _target} else {0 spawn { hint "There is already a pilot";sleep 3;hintSilent "";}};
	};
	case "OnHalo": {
		if !(vehicle player == player && !CTI_P_PreBuilding && CTI_Base_HaloInRange && [CTI_P_SideJoined, CTI_UPGRADE_HALO, 1] call CTI_CO_FNC_HasUpgrade && ( (missionNamespace getVariable 'CTI_SM_HALO')==1 && !(player getvariable ["REV_UNC",false])) && (time - CTI_HALO_LASTTIME >= CTI_HALO_COOLDOWN)) exitwith {false};
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
	case "OnThud": {
		profileNamespace setVariable ["HUD_Tactical", !((profileNamespace getVariable ["HUD_Tactical",true]))];
		saveProfileNamespace;
		['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'
	};
	case "OnExitT": {
		if (CTI_P_SideLogic getVariable ["CTI_LOAD_COMPLETED",false]) then {
			TUTO_COMPLETE=true;
			} else {hintsilent "Wait for loading to complete";0 spawn {sleep 2 ; hintsilent "";};};
		//profileNamespace setVariable ["TUTO_COMPLETE", true];
		//saveProfileNamespace;
	};
	case "EjectCargo": {
		_crew = crew _target;
		_driver = [driver _target];
		_gunner = [gunner _target];
		_commander = [commander _target];
		if (count (_crew - (_driver + _gunner + _commander)) > 0 && local _target) then {
			doGetOut (_crew - (_driver + _gunner + _commander));
		};
	};
	case "OnCamo": {
		_funds = [group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
		if (_funds < 500) exitWith {
		hintsilent localize "STR_HALO_No_Funds";
		};
		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		_rep_depots = [CTI_REPAIR, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;
		_available_rep_depots = [_target, _rep_depots, CTI_SERVICE_REPAIR_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
		_available_rep_trucks = [_target, CTI_SPECIAL_REPAIRTRUCK, CTI_SERVICE_REPAIR_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
		if (count (_available_rep_depots + _available_rep_trucks) > 0 && local _target) then {

			_orig = [_target] call bis_fnc_getVehicleCustomization select 1;
			_camohull = "showCamonetHull";
			_camoturret = "showCamonetTurret";

			if (_camohull in _orig) then {
				_camohullpos = _orig find _camohull;
				_vposch = _camohullpos +1;
				_vch = _orig select _vposch;
				if (_vch == 0) then {_orig set [_vposch, 1];} else {_orig set [_vposch, 0];};
			};
			if (_camoturret in _orig) then {
				_camoturretpos = _orig find _camoturret;
				_vposct = _camoturretpos +1;
				_vct = _orig select _vposct;
				if (_vct == 0) then {_orig set [_vposct, 1];} else {_orig set [_vposct, 0];};
			};

			[_target, nil, _orig] call BIS_fnc_initVehicle;
			[group player, CTI_P_SideJoined, - 500] call CTI_CO_FNC_ChangeFunds;
		};
	};
	case "OnSlatCage": {
		_funds = [group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
		if (_funds < 1500) exitWith {
		hintsilent localize "STR_HALO_No_Funds";
		};
		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
		_rep_depots = [CTI_REPAIR, _structures, player] call CTI_CO_FNC_GetSideStructuresByType;
		_available_rep_depots = [_target, _rep_depots, CTI_SERVICE_REPAIR_DEPOT_RANGE] call CTI_UI_Service_GetBaseDepots;
		_available_rep_trucks = [_target, CTI_SPECIAL_REPAIRTRUCK, CTI_SERVICE_REPAIR_TRUCK_RANGE] call CTI_CO_FNC_GetNearestSpecialVehicles;
		if (count (_available_rep_depots + _available_rep_trucks) > 0 && local _target) then {

			_orig = [_target] call bis_fnc_getVehicleCustomization select 1;
			_slath = "showSLATHull";
			_slatt = "showSLATTurret";
			_hideh = "HideHull";
			_hidet = "HideTurret";

			if (_slath in _orig) then {
				_slathpos = _orig find _slath;
				_shvpos = _slathpos +1;
				_vsh = _orig select _shvpos;
				if (_vsh == 0) then {_orig set [_shvpos, 1];} else {_orig set [_shvpos, 0];};
			};
			if (_slatt in _orig) then {
				_slattpos = _orig find _slatt;
				_stvpos = _slattpos +1;
				_vst = _orig select _stvpos;
				if (_vst == 0) then {_orig set [_stvpos, 1];} else {_orig set [_stvpos, 0];};
			};
			if (_hideh in _orig) then {
				_hidehpos = _orig find _hideh;
				_hhvpos = _hidehpos +1;
				_vhh = _orig select _hhvpos;
				if (_vhh == 1) then {_orig set [_hhvpos, 0];} else {_orig set [_hhvpos, 1];};
			};
			if (_hidet in _orig) then {
				_hidetpos = _orig find _hidet;
				_htvpos = _hidetpos +1;
				_vht = _orig select _htvpos;
				if (_vht == 1) then {_orig set [_htvpos, 0];} else {_orig set [_htvpos, 1];};
			};

			[_target, nil, _orig] call BIS_fnc_initVehicle;
			[group player, CTI_P_SideJoined, - 1500] call CTI_CO_FNC_ChangeFunds;
		};
	};
};
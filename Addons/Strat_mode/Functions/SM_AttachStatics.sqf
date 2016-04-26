STATICS_MG = ["I_HMG_01_high_F","I_GMG_01_high_F","O_HMG_01_high_F","O_GMG_01_high_F","B_HMG_01_high_F","B_GMG_01_high_F"];
STATICS_LMG = ["I_HMG_01_F","I_GMG_01_F","O_HMG_01_F","O_GMG_01_F","B_HMG_01_F","B_GMG_01_F"];
STATICS_L = ["I_static_AA_F","I_static_AT_F","O_static_AA_F","O_static_AT_F","B_static_AA_F","B_static_AT_F"];
STATICS_M = ["ReammoBox_F"];
STATICS_ALL=STATICS_MG + STATICS_LMG  + STATICS_L+STATICS_M;

STATIC_TRY=false;

Attach_Static={
  _veh=_this select 0;
  _pl=_this select 1;
  [_veh,_pl] call CTI_PVF_Request_Locality;
  waitUntil {(owner _veh) == (owner _pl)};
  _NO = nearestObjects [[(_veh modelToWorld [0,-3,0]) select 0,(_veh modelToWorld [0,-3,0]) select 1,0],STATICS_ALL,3];
  if (count _NO == 0) exitWith {_pl spawn {[["CLIENT",_this],"Fail_load",[]] call CTI_CO_FNC_NetSend}};
  if !(isNull attachedto (_NO select 0)) exitWith {_pl spawn {[["CLIENT",_this],"Fail_load",[]] call CTI_CO_FNC_NetSend}};
  [(_NO select 0),_pl] call CTI_PVF_Request_Locality;
  waitUntil {(owner (_NO select 0)) == (owner _pl )};
  _turn=0;
  if(typeOf (_NO select 0) in STATICS_L) then {(_NO select 0) attachto [_veh,[0,-1.5,0.25]];_turn=180;};
  if(typeOf (_NO select 0) in STATICS_LMG) then {(_NO select 0) attachto [_veh,[-0.1,-2,0.5]];_turn=180;_veh animate ["HideDoor3", 1];};
  if(typeOf (_NO select 0) in STATICS_MG ) then {(_NO select 0)attachto [_veh,[0.25,-2,1]];};
  if((_NO select 0) isKindOf (STATICS_M select 0)) then {(_NO select 0) attachto [_veh,[0,-1.5,-0.5]];_turn=90;};
  _veh setvariable ['attachment',(_NO select 0)];
  [["CLIENT",_pl],"Reply_load",[_veh,(_NO select 0),true,_turn]]call CTI_CO_FNC_NetSend;
};

Dettach_Static={
  _veh = _this select 0;
  _pl=_this select 1;
  if (isNil {_veh getvariable "attachment"}) exitwith {false};
  _attached=_veh getvariable "attachment";
  detach _attached;
  _attached setpos [(_veh modelToWorld [0,-5,0]) select 0,(_veh modelToWorld [0,-5,0]) select 1,0];
  _attached removeEventHandler ["GetOut", 0];
  _veh setvariable ['attachment',nil];
  [["CLIENT",_pl],"Reply_load",[_veh,_attached,false]]call CTI_CO_FNC_NetSend;
};


/*Action_Statics={
_veh= _this select 0;
_veh  addAction ["<t color='#006400'>Load / Unload Static / Crate</t>", "CTI_P_ChatID commandChat  'ST LOAD :: Trying to load a static, please wait' ;STATIC_TRY=true;['SERVER','Request_load',_this]call CTI_CO_FNC_NetSend;", [], 1000, false, true, "", "driver (vehicle (player) ) == player && speed _target <1 && speed _target >-1 && (vehicle _this) == _target && alive _target &&  ! STATIC_TRY"];

};*/

with missionNamespace do {
  CTI_PVF_Request_load={
    if (isNil {(_this select 0 ) getvariable 'attachment'}) then {
      _this call Attach_Static;
    } else {
      _this call Dettach_Static;
    };
  };
  CTI_PVF_Reply_load={
    if (_this select 2) then {
      CTI_P_ChatID commandChat format [localize "STR_ST_Load",typeof (_this select 1),_this select 0];
      (_this select 1) setdir (_this select 3);
      (_this select 1)  addEventHandler ["GetOut", {(_this select 2) attachto [(_this select 0),[-3,-1,-0.65]]; detach (_this select 2);}];
      (_this select 0) lock false;
      {if !(driver (_this select 0) == _x) then {unassignVehicle _this}; true}  count (crew(_this select 0));
      (_this select 0) lockCargo true;
      (_this select 0) lockCargo [0,false];
      STATIC_TRY=false;
    } else {
      CTI_P_ChatID commandChat format [localize "STR_ST_Unload",typeof(_this select 1),_this select 0];
      (_this select 0) lockCargo false;
      STATIC_TRY=false;
    };
    if !(isNil {uiNamespace getVariable 'cti_dialog_ui_interractions'}) then { ['onLoad'] call compile preprocessFileLineNumbers 'Addons\Strat_mode\Tablet\Events_UI_Interact.sqf'};
  };
  CTI_PVF_Fail_load={
    CTI_P_ChatID commandChat  localize "STR_ST_NotFound";
    STATIC_TRY=false;
  };
};


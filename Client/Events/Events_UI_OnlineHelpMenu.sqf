#define DIK_TAB             0x0F
#define DIK_TILDE             0x29
#define DIK_Y               0x15

private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		{((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160001) lbAdd _x} forEach [
		localize "STR_Welcome_Screen",
		localize "STR_Int_menu",
		localize "STR_Basics",
		localize "STR_Map",
		localize "STR_Strategic_Mode",
		localize "STR_Base_Protect",
		localize "STR_Player_Eco",
		localize "STR_Base_Struct",
		localize "STR_Special_Veh",
		localize "STR_Com",
		localize "STR_Adv_network",
		localize "STR_Tact_Hud",
		localize "STR_Trophy_Sys",
		localize "STR_Rem_Control",
		localize "STR_Cred"
		];
		((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160001) lbSetCurSel 0;
    for "_i" from 2 to 200 /* step +1 */ do {
      if (keyName _i != """") then {

        ((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160003) lbAdd format["%1", keyName  _i];
        ((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160003) lbSetValue [(_i-2), _i];
        //if (_percent_resources == (_i*10)) then {((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140006) lbSetCurSel _u};
        if (_i == (profilenamespace getvariable ['CTI_TABLET_KEY',41])) then {((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160003) lbSetCurSel _i};
      };
    };
	};
  case "onKeyLBSelChanged" : {
      _changeTo = _this select 1;
     // hintsilent parsetext format ["%1",keyImage (_changeTo+2 )];
      profileNamespace setVariable ["CTI_TABLET_KEY", (_changeto+2)];
      saveProfileNamespace;
      ['onHelpLBSelChanged', 0] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_OnlineHelpMenu.sqf'
  };
	case "onHelpLBSelChanged": {
		_changeTo = _this select 1;

_helps = [format [localize "STR_Welcome_msg",keyImage(profilenamespace getvariable ['CTI_TABLET_KEY',41])],
format [localize "STR_Interaction_Menu",keyImage(profilenamespace getvariable ['CTI_TABLET_KEY',41])],
localize "STR_The_Basics",
localize "STR_The_Map",

format [localize "STR_The_Strategic_Mode",(missionNamespace getVariable "CTI_SM_STRATEGIC_NB")],
localize "STR_Base_Protection",
localize "STR_Player_Economy",
localize "STR_Base_Structures",
localize "STR_Special_Vehicles",
localize "STR_Commander",
localize "STR_Advance_Network",
localize "STR_Tactical_HUD",
localize "STR_Trophy_system",
localize "STR_Remote_Control",
localize "STR_Current_Credits"

];
		((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160002) ctrlSetStructuredText parseText (_helps select _changeTo);
	};
};
#define HUD_IDC 1500000

private ["_hud","_basic","_pro","_town","_pb","_t","_co","_running","_ttext","_sl","_marker","_icon","_air_c","_art_c"];
_hud=_this;

disableSerialization;
_basic=(_hud displayCtrl(HUD_IDC+1));
_pro=(_hud displayCtrl(HUD_IDC+3));
if (!(profileNamespace getVariable ["HUD_Normal",true]) ||visiblemap) exitWith {_basic ctrlShow false;};
_basic ctrlShow true;
// capture
_town=((player) call CTI_CO_FNC_GetClosestTown);
if ( player distance _town < CTI_MARKERS_TOWN_AREA_RANGE) then {
	_pro ctrlShow true;
	_pb=((_town getVariable "cti_town_capture")) / CTI_TOWNS_CAPTURE_VALUE_CEIL ;
	if ((_town getVariable ["cti_town_occupation_active",true]) || (_town getVariable ["cti_town_resistance_active",true])) then
	{
		_pro ctrlSetTextColor [1,1,0,1];
	} else {
		_pro ctrlSetTextColor [1,1,1,1];
	};
	_pro progressSetPosition  _pb ;
} else {
	_pro ctrlShow false;
};
//-------INFO -------
if (CTI_P_SideJoined == resistance) exitWith {};
_t="<t size='0.75' align='right'>";
if (missionNamespace getVariable "CTI_EW_ANET" == 1 && ! isNil {( player) getVariable "CTI_Net"} && ! isNil {( player) getVariable "AN_iNet"}) then {
		_co="";
		if (((player) getVariable "AN_iNet") == (player) getVariable "CTI_Net") then {_co=format ["<t color='#00ff00'>%1</t>",(((player) getVariable "CTI_Net") call CTI_CO_FNC_GetSideFromID)]} else {_co=format ["<t color='#ffff00'>%1</t>",(((player) getVariable "CTI_Net") call CTI_CO_FNC_GetSideFromID)]};
		if ((( player) getVariable "CTI_Net"< 0) ) then {_co = localize "STR_CTI_Net"};
	_t=_t+format ["<t size='1'><img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa'/></t> %1 || ",_co];
	};
_t= _t+format	["%1 <t color='#00ff00'>$</t> || ",[group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds] ;
_t=_t+format	["%1 <t color='#ff0000'><img image='A3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa'/></t> || ",ceil( (1- getDammage	player)*100)] ;
_t=_t+format	["%1 <t color='#0000ff'><img image='\A3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa'/></t><br />",ceil( (1- getfatigue	player)*100)] ;
_com_name="";
if (isNull (CTI_P_SideLogic getVariable ["cti_commander",grpnull])) then {
	if (!isnil {CTI_P_SideLogic getVariable ["cti_ai_commander_group", grpNull]}) then {
		if !(isNull (CTI_P_SideLogic getVariable ["cti_ai_commander_group", grpNull])) then {_com_name= format ["%1 (AI)", name leader (CTI_P_SideLogic getVariable ["cti_ai_commander_group", grpNull])]};
	};
} else {
	_com_name=name (leader  (CTI_P_SideLogic getVariable ["cti_commander",grpnull]));
};

if (_com_name == "") then {_com_name = "NONE"};
_t=_t+ (format [localize "STR_Current_Com",_com_name ]);



_running = CTI_P_SideLogic getVariable "cti_upgrade";
_ttext = localize "STR_No_Upgrade_Running";
	if (_running > -1) then {
		_ttext = format [localize "STR_Upgrade_Left", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select _running) select 0,CTI_P_SideLogic getVariable "cti_upgrade_lt"];
	};
_t=_t+ (format ["<t color='#F5D363'>%1 </t><br />",_ttext ]);
_sl=CTI_P_SideJoined call  CTI_CO_FNC_GetSideLogic;
{
	_marker = format ["cti_town_marker_%1", _x];

	_icon = switch (getMarkerColor _marker) do
	{
	    case 	"ColorGreen":{ "<t color='#00ff00' size='0.75'><img image='A3\ui_f\data\map\Markers\Military\flag_ca.paa'/></t>" };
	    case 	"ColorBlue":{ "<t color='#0000ff' size='0.75'><img image='A3\ui_f\data\map\Markers\Military\flag_ca.paa'/></t>" };
	    case 	"ColorRed":{ "<t color='#ff0000' size='0.75'><img image='A3\ui_f\data\map\Markers\Military\flag_ca.paa'/></t>" };
	    default { "<t color='#00ff00' size='0.75'><img image='A3\ui_f\data\map\Markers\Military\flag_ca.paa'/></t>"  };
	};
	_t = _t + format ["%2 %1 ",(_x getVariable "cti_town_name"),_icon	]
} count (_sl getVariable ["CTI_ACTIVE",[]]);
_t=_t+"<br />";
if ( (missionNamespace getVariable 'CTI_SM_RADAR')==1 && (count ([CTI_RADAR, ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures)] call CTI_CO_FNC_GetSideStructuresByType) > 0 )) then {
	//_t=_t+"<t underline='true'> Radars:</t><br />";
	_air_c="color='#ffff00'";
	_art_c="color='#ffff00'";
	if (([CTI_P_SideJoined, CTI_UPGRADE_AIRR, 1] call CTI_CO_FNC_HasUpgrade)) then {_air_c="color='#00ff00'";};
	if (([CTI_P_SideJoined, CTI_UPGRADE_ARTR, 1] call CTI_CO_FNC_HasUpgrade)) then {_art_c="color='#00ff00'";};
	if ( SM_Radar_Detected ) then {_air_c="color='#ff0000'";};
	if (count ARTR_MARKERS >0) then {_art_c="color='#ff0000'";};
	_t=_t+"<t size='1.2'><t "+_air_c+"><img image='a3\air_f_gamma\Plane_Fighter_03\Data\UI\map_plane_fighter_03_ca.paa'/></t><t "+_art_c+"><img image='\a3\ui_f\data\gui\cfg\CommunicationMenu\artillery_ca.paa'/></t></t><br />";
	//_t=_t+"<t size='1.75'><t "+_air_c+"><img image='a3\air_f_gamma\Plane_Fighter_03\Data\UI\map_plane_fighter_03_ca.paa'/></t></t><br />";
};
_t=_t+"</t>";
if !(HUD_Normal) then {_t=""};
_basic ctrlSetStructuredText	parseText	 _t;
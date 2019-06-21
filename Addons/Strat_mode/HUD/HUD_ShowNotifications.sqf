#define HUD_IDC 1500000

_hud=_this select 0;
_text="";
_copy=[];
_last_notif="";
_new_not="";
_last_shown=-1000;

if (isNil "_hud" || _hud == displayNull) exitWith {false};
{
	if (count _x < 4) then {_x pushBack time;};
	//if (time < _x select 1) then {_copy pushBack _x} ;
	_copy pushBack _x;
	true;
} count HUD_NOTIFICATIONS;

HUD_NOTIFICATIONS= _copy;
if (count HUD_NOTIFICATIONS >17) then {
	reverse HUD_NOTIFICATIONS;
	HUD_NOTIFICATIONS resize 17;
	reverse HUD_NOTIFICATIONS;
};

_reverse = + HUD_NOTIFICATIONS;
reverse _reverse;
_new_not=_reverse select 0 select 0;


disableSerialization;

if (time- (_reverse select 0 select 3) < 7 || !isNil {uiNamespace getVariable ['cti_dialog_ui_interractions', nil]}) then {

	(_hud displayCtrl (HUD_IDC+7)) ctrlShow true;
	{

		//_text=_text +		 format ["<t size='0.8' color='#%1%2'> (+) ",if (((_x select 1) - time)>3) then {"ff"} else {(99 min ((floor (((_x select 1) - time)*100/4)) max 10))},_x select 2]+		  (_x select 0) +		  "</t><br/>";
		_text=_text +format ["<t size='0.8' color='#ff%1'>(+) %2</t><br/>",_x select 2,(_x select 0)];
	true
	} count _reverse;
} else {
	(_hud displayCtrl (HUD_IDC+7)) ctrlShow false;
};


_cont=(_hud displayCtrl (HUD_IDC+8));
_cont ctrlSetStructuredText (parseText _text);


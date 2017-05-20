_last_funds = -1;
_last_townheld = -1;
_last_award_pool = -1;
_last_resources_pool = -1;
_last_income = -1;

//_town_count = count CTI_Towns;
_town_count=0;
{
	_town_count = _town_count + (_x getVariable "cti_town_value");
} forEach CTI_Towns;

_last_infocheck = -100;

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_optionsmenu"}) exitWith {}; //--- Menu is closed.

	if (time - _last_infocheck > 1) then {
		_uptime = call CTI_CL_FNC_GetMissionTime;
//		((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130005) ctrlSetStructuredText (parseText format["Mission Time: <t color='#d4ceff'>%1 Day(s) %2:%3:%4</t>", _uptime select 0,_uptime select 1,_uptime select 2, _uptime select 3]);
		((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130005) ctrlSetStructuredText (parseText format["Mission Time: <t color='#d4ceff'>%1 Day(s) %2:%3:%4, maxtime : %5 hours</t>", _uptime select 0,_uptime select 1,_uptime select 2, _uptime select 3,missionNamespace getVariable "CTI_MAX_MISSION_TIME"]);
		_last_infocheck = time;
		if !(side group player == resistance) then {
				_funds = call CTI_CL_FNC_GetPlayerFunds;
				_held=0;
				{_held=_held+ (_x getVariable "cti_town_value"); } ForEach ((CTI_P_SideJoined) call CTI_CO_FNC_GetFriendlyTowns);
				_award_pool = CTI_P_SideLogic getVariable "cti_pool_award";
				_resources_pool = CTI_P_SideLogic getVariable "cti_pool_resources";
				_income = call CTI_CL_FNC_GetPlayerIncome;

				if (_funds != _last_funds) then {
					((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130001) ctrlSetStructuredText (parseText format["<t>Resources: <t color='%1'>$%2</t></t>", CTI_P_Coloration_Money, _funds]);
					_last_funds = _funds;
				};
				if (_resources_pool != _last_resources_pool || _award_pool != _last_award_pool) then {
					((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130002) ctrlSetStructuredText (parseText format["<t>Pools (Players/Award): %1%3 / %2%3</t>", round(_resources_pool*100), round(_award_pool*100), "%"]);
					_last_resources_pool = _resources_pool;
					_last_award_pool = _award_pool;
				};
				if (_income != _last_income) then {
					_side_income = (CTI_P_SideJoined) call CTI_CO_FNC_GetTownsResources;
		//			((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130003) ctrlSetStructuredText (parseText format["<t>Income (Me/Side): <t color='%1'>$%2</t>/<t color='%1'>$%3</t></t>", CTI_P_Coloration_Money, _income, round _side_income]);
					((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130003) ctrlSetStructuredText (parseText format["<t>Income (Me/Side): <t color='%1'>$%2</t>/<t color='%1'>$%3</t> every %4 seconds.</t>", CTI_P_Coloration_Money, _income, round (_side_income), missionNamespace getVariable "CTI_ECONOMY_INCOME_CYCLE" ]);
					_last_income = _income;
				};
				if (_held != _last_townheld) then {
					((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130004) ctrlSetStructuredText (parseText format["<t>Towns Held Value: <t color='#66baff'>%1 $</t>/ %2 $</t><t color='#ff9900'> :: Victory : %3 $</t>", _held, _town_count,floor (_town_count * 0.75)]);
					_last_townheld = _held;
				};};
	};

	sleep .1;
};
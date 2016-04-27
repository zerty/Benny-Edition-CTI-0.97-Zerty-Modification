SM_Last_dis=0;
SM_TO_dis=0;

SM_Ask_Priority={

	hint parseText format [localize "STR_TownPriority",(SM_Ask_Town getVariable "cti_town_name")];

	openMap true;
	SM_mapclick = false;
	onMapSingleClick ' temp_Ask_Town= (_pos) call CTI_CO_FNC_GetClosestTown;SM_mapclick = true; onMapSingleClick ""; true;';



		waitUntil {SM_mapclick or !(visiblemap)};
		if (!visibleMap) exitwith {
				systemChat "Priority Target Cancelled";
			hintsilent "";
			breakOut "main";
		};
		_sl =(CTI_P_SideJoined)  call CTI_CO_FNC_GetSideLogic;
		[["CLIENT",CTI_P_SideJoined],"SM_message",format [localize "STR_NextPriorityTown",(temp_Ask_Town getVariable "cti_town_name")],true] call CTI_CO_FNC_NetSend ;

		openMap false;
		hint parseText format [localize "STR_NextPriorityTown_1",(temp_Ask_Town getVariable "cti_town_name")];
		_sl setVariable ["CTI_PRIORITY",temp_Ask_Town,true];
		if (temp_Ask_Town == (_sl getVariable "CTI_PREVENT")) then {_sl setVariable ["CTI_PREVENT",objNull,true];};

};
SM_Disactivate_Town={
		hint parseText localize "STR_Disactivate_Town";

	openMap true;
	SM_mapclick = false;
	onMapSingleClick ' temp_Ask_Town= (_pos) call CTI_CO_FNC_GetClosestTown;SM_mapclick = true; onMapSingleClick ""; true;';


		_sl =(CTI_P_SideJoined)  call CTI_CO_FNC_GetSideLogic;
		waitUntil {SM_mapclick or !(visiblemap)};
		if (!visibleMap) exitwith {
				systemChat "Town disactivating Cancelled";
			hintsilent "";
			breakOut "main";
		};
		_sl setVariable ["CTI_PREVENT",temp_Ask_Town,true];
		if (temp_Ask_Town == (_sl getVariable "CTI_PRIORITY")) then {_sl setVariable ["CTI_PRIORITY",objNull,true];};

		openMap false;
		[["CLIENT",CTI_P_SideJoined],"SM_message",format [localize "STR_DisactivateTown",(temp_Ask_Town getVariable "cti_town_name")],true] call CTI_CO_FNC_NetSend ;
		SM_Last_dis=time;
};

/*
Hint & Tips

obj setvariable ["BTC_cannot_lift",1,true]; // Make an object not liftable
obj setVariable ["BTC_cannot_drag",1,true]; // Make an object not draggable
obj setVariable ["BTC_cannot_load",1,true]; // Make an object not loadable
BTC_lift_min_h   = 7;  // Min height required to lift an object
BTC_lift_max_h   = 12; // Max height required to lift an object
BTC_lift_radius  = 2;  // You have to stay in this radius to lift an object
BTC_lift_pilot   = []; // Leave empty if all soldiers can use choppers to lift. If only pilot can -> BTC_lift_pilot = ["US_Soldier_Pilot_EP1","USMC_Soldier_Pilot", ...etc etc];

BTC_Get_liftable_array =
{
	_chopper = _this select 0;
	_array   = [];
	switch (typeOf _chopper) do
	{
		case "MH6J_EP1" : {_array = ["Motorcycle","ReammoBox"];}; // Modify the array to change liftable objects by the chopper ex -> _array = ["Motorcycle","ReammoBox","Wheeled_APC", ... etc etc];
		// To add a new chopper class: copy the previous line:
		// case "MH6J_EP1" : {_array = ["Motorcycle","ReammoBox"];};
		// modify the class in the "" -> "Mi17_Ins"
		// case "Mi17_Ins" : {_array = ["Motorcycle","ReammoBox"];};
		// modify the _array as u want like above
	};
	_array
};
*/
private ["_pack"];
_pack = _this;

while {!isNull _pack} do {
	if (!( alive _pack) && !isNull( _pack getvariable ["SA_PACKED",objnull])) then {
		deletevehicle (_pack getvariable ["SA_PACKED",objnull]);
	};
	sleep 10;
};
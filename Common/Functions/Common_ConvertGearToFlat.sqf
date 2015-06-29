/*
  # HEADER #
	Script: 		Common\Functions\Common_ConvertGearToFlat.sqf
	Alias:			CTI_CO_FNC_ConvertGearToFlat
	Description:	Convert a CTI gear variable into a flat array.
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013

  # PARAMETERS #
    0	[Array]: A CTI gear variable

  # RETURNED VALUE #
	[Array]: The flattened array

  # SYNTAX #
	(Array) call CTI_CO_FNC_ConvertGearToFlat

  # DEPENDENCIES #


  # EXAMPLE #
	_gear = [
		[["arifle_mxc_f",["","acc_pointer_ir","optic_Aco"],["30rnd_65x39_caseless_mag"]],["launch_nlaw_f",[],["nlaw_f"]],["",[],[]]],
		[["u_b_combatuniform_mcam",[]],["v_platecarrier1_rgr",[]],["b_assaultpack_mcamo",["firstaidkit","nlaw_f","nlaw_f"]]],
		["h_helmetb",""],
		[["nvgoggles","binocular"],["itemmap","itemgps","itemradio","itemcompass","itemwatch"]]
	];

	(_gear) call CTI_CO_FNC_ConvertGearToFlat;
	  -> ["arifle_mxc_f","acc_pointer_ir","optic_Aco","30rnd_65x39_caseless_mag","launch_nlaw_f","nlaw_f","u_b_combatuniform_mcam",...,"h_helmetb","nvgoggles",...]
*/

private ["_classnames", "_gear"];
_gear = _this;

_classnames = [];
{
	if (_x select 0 != "") then { _classnames pushBack (_x select 0) };
	{ if (_x != "") then { _classnames pushBack _x } } forEach (_x select 1);
	if (count(_x select 2) > 0) then { _classnames pushBack ((_x select 2) select 0) };
} forEach (_gear select 0);

{
	if (_x select 0 != "") then { _classnames pushBack (_x select 0) };
	{ if (_x != "") then { _classnames pushBack _x } } forEach (_x select 1);
} forEach (_gear select 1);

{
	if (_x != "") then { _classnames pushBack _x };
} forEach (_gear select 2);

{
	{if (_x != "") then { _classnames pushBack _x }} forEach _x;
} forEach (_gear select 3);

_classnames
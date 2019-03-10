/*
    unit: Object - Object the event handler is assigned to.
    selectionName: String - Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
    damage: Number - Resulting level of damage for the selection.
    source: Object - The source unit that caused the damage.
    projectile: String - Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.)
*/
#define upper_bound 1.25
#define  lower_bound 0.85

_unit=_this select 0;
_new_damage=_this select 2;
_source=_this select 3;
_unc=_unit getvariable ["REV_UNC",false];
if (alive _unit && _new_damage < upper_bound && _new_damage > lower_bound && ! _unc &&  (  ((getPosATL _unit) select 2) < 5 || ((getPosASl _unit) select 2) < 0 ) ) then {
	_new_damage = 0;
	[_unit,_source] spawn REV_UNC;
};

_new_damage


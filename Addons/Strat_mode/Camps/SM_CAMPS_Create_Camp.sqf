// spawn a given camp
// input [Config, position,rot]
// output [objects, building positions]

_camp=_this select 0;
_position=_this select 1;
_rot=_this select 2;
_object=[];
_b_positions=[];

_camp_objects="true" configClasses _camp;
{
	_o_class=getText  (_x >> "vehicle");
	_o_offset=getArray (_x >>"position");
	_o_dir=getNumber (_x >>"dir")-_rot;
	_o_offset=[(_o_offset select 0) * cos _rot -  (_o_offset select 1)  * sin _rot,(_o_offset select 0) * sin _rot +  (_o_offset select 1)  * cos _rot,(_o_offset select 2)];
	_o_pos=_position vectoradd _o_offset;

	_o=createvehicle  [_o_class, _o_pos, [], 0, "CAN_COLLIDE"];
	_o setdir (_o_dir);
	_o enablesimulationglobal false;
	_object set [count _object,_o];
	//need to select more precisely what position can be used for static Launcher AI
	_b_positions = _b_positions + ([_o,100] call BIS_fnc_buildingPositions);

} forEach _camp_objects;
[_object,_b_positions]
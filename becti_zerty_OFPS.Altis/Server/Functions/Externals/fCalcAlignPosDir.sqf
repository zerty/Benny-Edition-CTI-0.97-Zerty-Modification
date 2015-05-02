private ["_direction_object", "_dirNearest", "_dirStruct", "_mtwa", "_mtwb", "_objectNearest", "_offsetZ", "_posNearest", "_posStruct", "_struct", "_width"];

_struct = _this select 0;
_posStruct = _this select 1;
_dirStruct = _this select 2;
_width = _this select 3;
_offsetZ = _this select 4;
_direction_object = _this select 5;

_sort = nearestObjects [_struct, [typeOf _struct], 25];
_remove = _sort - [_struct];

//Nearest wall.
_objectNearest = if (count _remove > 0) then {_remove select 0} else {objNull};
_defense_direction = 0;

if ( !(isNull _objectNearest) && ((_objectNearest distance _posStruct) < 2*_width) ) then
{
	_posNearest = getPos _objectNearest;
	_dirNearest = (getDir _objectNearest + 360 - _defense_direction) % 360;
	_vectorNearToNew = [(_posStruct select 0) - (_posNearest select 0), (_posStruct select 1) - (_posNearest select 1)];
	_dirSminusN = (((_dirStruct + 360) - _dirNearest) % 360);
	
	if (_dirSminusN < 0) then { _dirSminusN = 360 - abs _dirSminusN }; //--- Correct the negative offset
	
	_dirOffset = [0, 45, 90, -45, 0, 45, -90, -45, 0] select ((_dirSminusN - 0)/45);
	_dirStruct = (_dirNearest + _dirOffset + 360) % 360;

	_vectorDirNearest = [sin _dirNearest, cos _dirNearest, 0];
	_vectorDirStruct = [sin _dirStruct, cos _dirStruct, 0];

	_infront = (0 < [_vectorDirNearest, _vectorNearToNew] call funcVectorDot);
	_vectorDirNearest = [_vectorDirNearest, [0,0,1]] call funcVectorCross;
	_toright = (0 < [_vectorDirNearest, _vectorNearToNew] call funcVectorDot);

	_vectorDirNearest = [_vectorDirNearest, _width/2] call funcVectorScale;

	_vectorDirStruct = [_vectorDirStruct, [0,0,1]] call funcVectorCross;
	_vectorDirStruct = [_vectorDirStruct, _width/2] call funcVectorScale;

	if (_toright) then { _posStruct = [_posNearest, _vectorDirNearest] call funcVectorAdd } else { _posStruct = [_posNearest, _vectorDirNearest] call funcVectorSub };

	if ( _toright &&  _infront) then { if (_dirOffset>0) then { _posStruct = [_posStruct, _vectorDirStruct] call funcVectorSub } else { _posStruct = [_posStruct, _vectorDirStruct] call funcVectorAdd } };
	if (!_toright &&  _infront) then { if (_dirOffset>=0) then { _posStruct = [_posStruct, _vectorDirStruct] call funcVectorSub } else { _posStruct = [_posStruct, _vectorDirStruct] call funcVectorAdd } };
	if ( _toright && !_infront) then { if (_dirOffset<0) then { _posStruct = [_posStruct, _vectorDirStruct] call funcVectorSub } else { _posStruct = [_posStruct, _vectorDirStruct] call funcVectorAdd } };
	if (!_toright && !_infront) then { if (_dirOffset<=0) then { _posStruct = [_posStruct, _vectorDirStruct] call funcVectorSub } else { _posStruct = [_posStruct, _vectorDirStruct] call funcVectorAdd } };

	_posStruct set [2, (_this select 1) select 2]
};

[_posStruct, _dirStruct]
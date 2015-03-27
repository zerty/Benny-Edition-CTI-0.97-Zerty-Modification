CTI_UI_UnitsCamera_GetPitchFromDirectionVector = {
	private ["_dx", "_dy", "_dz", "_pitch", "_vector3"];
	_vector3 = _this;
	
	_dx = _vector3 select 0;
	_dy = _vector3 select 2;
	_dz = _vector3 select 1;
	// _yaw = _dx atan2 -_dz;
	_pitch = _dy atan2 sqrt((_dx * _dx) + (_dz * _dz));
	
	_pitch
};
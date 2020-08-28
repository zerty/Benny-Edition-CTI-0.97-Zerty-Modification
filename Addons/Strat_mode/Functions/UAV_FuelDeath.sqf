//Destroys the vehicle if out of fuel (used for Drones)

private ["_uav"];

_uav=_this;

while {!CTI_GameOver && alive _uav && _uav isKindOf "Air"} do {
	if (local _uav) then {
		if (fuel _uav <0.05) then {_uav setDammage 1};
	};
	sleep 60;
};

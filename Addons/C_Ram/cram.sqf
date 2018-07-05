if(!isServer)exitWith{};

private["_chance","_rand","_cram"];

_cram = _this select 0;
_gatID = _this select 1;
_incoming = [];
_scanDis = FSG_CRAMRANGE;
_engageRange = FSG_ENGAGERANGE;
_radarOffset = FSG_RADAROFFSET;

sleep 1;
while{alive _cram}do{
  sleep 1;
  if(FSG_USE_MAINRADAR && alive FSG_MAINRADAR_NAME)then{
    _incoming = +FSG_INCOMING;
  }else{	
    if(FSG_USE_CRAMRADAR)then{
      _incoming = _cram nearObjects ["MissileBase",_scanDis];
      _incoming = _incoming + (_cram nearObjects ["RocketBase",_scanDis]);
      _incoming = _incoming + (_cram nearObjects ["ShellBase",_scanDis]);
      if(FSG_DEBUG)then{FSG_INCOMING = +_incoming;hint format["Incoming: %1 \n Using CRAM Radar \n CRAMs Online: %2 \n SAMs Online: %3",(count _incoming),FSG_CRAMCOUNT,FSG_SAMCOUNT]};
    }else{
      _incoming = [];
      if(FSG_DEBUG)then{FSG_INCOMING = +_incoming;hint format["Incoming: %1 \n Using CRAM Radar \n CRAMs Online: %2 \n SAMs Online: %3",(count _incoming),FSG_CRAMCOUNT,FSG_SAMCOUNT]};
    };
  };

  if(count _incoming > _gatID)then{
    _cram disableAI "TARGET";
    _cram disableAI "AUTOTARGET";
    sleep 0.2;
    _incomingRound = _incoming select _gatID;
    _fromTarget = _incomingRound getDir _cram;
    _targetDir = direction _incomingRound;
    if(_targetDir < _fromTarget + (_radarOffset/2) && _targetDir > _fromTarget - (_radarOffset/2) && ((getPos _incomingRound) select 2) > 30 && alive _incomingRound)then{
      _cram addMagazine FSG_MAG_OVERRIDE;
      _cram addWeapon FSG_WEP_OVERRIDE;
      _cram doWatch _incomingRound;
      sleep 0.2;
      _chance = 100;
	  _watchIdle = (getPos _cram);
	  _watchIdle set [2, (_watchIdle select 2) + 100];
      _cram doWatch _watchIdle;
      while{alive _incomingRound && ((getPos _incomingRound) select 2) > 50 && _chance > 0 && _cram distance _incomingRound < _engageRange}do{
        _target = "Land_HelipadEmpty_F" createVehicle [0,0,0]; //Very bad but i have no idea how to do this otherwise, let me know
        _leadPrediction = (((_cram distance _incomingRound) / 4032) * (speed _incomingRound)) / (_cram distance _incomingRound);
        _zeroing = ((_cram distance _incomingRound) / 100) * 8;
        _target attachTo [_incomingRound,[0,_leadPrediction,_zeroing]];
        _cram doWatch _target;
        if(alive _target && alive _incomingRound)then{
          _cram fire FSG_WEP_OVERRIDE;
        };
        //_cram fire (currentWeapon _cram);
        sleep 0.01;
        deleteVehicle _target;
        if(_cram distance _incomingRound < _engageRange && alive _incomingRound && _cram distance _incomingRound > 40)then{
          _rand = random[0,1,2];
          _chance = _chance - _rand;
        };
      };
      if(alive _incomingRound && _incomingRound distance _cram < _engageRange && _cram distance _incomingRound > 40)then{
        sleep 1;
        _exp = "helicopterexplosmall" createVehicle getPos _incomingRound;
        deleteVehicle _incomingRound;
      };
    };
    _cram enableAI "TARGET";
    _cram enableAI "AUTOTARGET";
  };
  Sleep FSG_SLEEPCYCLE;
};
FSG_CRAMCOUNT = FSG_CRAMCOUNT - 1;
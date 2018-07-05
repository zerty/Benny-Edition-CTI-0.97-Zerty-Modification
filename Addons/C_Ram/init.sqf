if(!isServer)exitWith{};
//EDIT THESE

FSG_CRAM_ENABLED = FALSE;
FSG_DEBUG = FALSE;
FSG_CRAM_GATLING_CN = "B_AAA_System_01_F"; //Classname of Gatling type CRAMs (def. Praetorian)
FSG_CRAM_SAM_CN = "B_SAM_System_02_F"; //Classname of Missile type CRAMs (def. Mk21 Centurion)

FSG_USE_WEPOVERRIDE = TRUE; //Use weapon override
FSG_WEP_OVERRIDE = "Gatling_30mm_Plane_CAS_01_F"; //Weapon override for Gatling weapons (def. 30mm CAS)
FSG_MAG_OVERRIDE = "1000Rnd_Gatling_30mm_Plane_CAS_01_F"; //Magazine override for Gatling weapons (def. 30mm CAS red tracer)

FSG_USE_MAINRADAR = FALSE; //Use a single radar for all CRAMs (Reduces lag by quite alot)
FSG_MAINRADAR_NAME = objNull; //Use objNull if not using. (Otherwise place radar on map and name it something)
FSG_USE_CRAMRADAR = TRUE; //Use CRAMs own radar if Main not in use/destroyed
FSG_INCOMING = []; //Main array to store incoming rounds (Main Radars)

FSG_MAINRADAR_SCANDIS = 3000; //Main radar range
FSG_CRAMRANGE = 2000; //CRAM Radar Range
FSG_ENGAGERANGE = 1700; //CRAM Engage Range
FSG_RADAROFFSET = 50; //Incoming must be pointing towards cram in this range to be shot down

FSG_SLEEPCYCLE = 1; //Sleep control for almost everything (Increase if heavy lag)

FSG_CRAMINDEX = 0;
FSG_CRAMCOUNT = 0;
FSG_SAMCOUNT = 0; //Counts how many Crams/Sams are online
FSG_TARGETCOUNT = 0;


/*
if(FSG_USE_MAINRADAR)then{
  _null=[FSG_MAINRADAR_NAME]spawn{
    private["_radar","_scanDis","_incoming"];
    _radar = _this select 0;
    _scanDis = FSG_MAINRADAR_SCANDIS;
    while{alive _radar}do{
      _incoming = _radar nearObjects ["MissileBase",_scanDis];
      _incoming = _incoming + (_radar nearObjects ["RocketBase",_scanDis]);
      _incoming = _incoming + (_radar nearObjects ["ShellBase",_scanDis]);
      FSG_INCOMING = +_incoming;
      if(FSG_DEBUG)then{hint format["Incoming: %1 \n Using Main Radar \n CRAMs Online: %2 \n SAMs Online: %3",(count FSG_INCOMING),FSG_CRAMCOUNT,FSG_SAMCOUNT]}; //Show incoming (all crams)
      Sleep FSG_SLEEPCYCLE;
    };
  };
};

{
  if(_x isKindOf FSG_CRAM_GATLING_CN)then{
    if((side _x) == West)then{
      private["_gatID"];
      _gatID = FSG_CRAMCOUNT;
      FSG_CRAMCOUNT = FSG_CRAMCOUNT + 1;
      _null = [_x,_gatID] execVM "scripts\cram\cram.sqf";
    };
  };
} forEach vehicles;

{
  if(_x isKindOf FSG_CRAM_SAM_CN)then{
    if((side _x) == West)then{
      private["_gatID"];
      _gatID = FSG_CRAMCOUNT + FSG_SAMCOUNT;
      FSG_SAMCOUNT = FSG_SAMCOUNT + 1;
      _null = [_x,_gatID] execVM "scripts\cram\sam.sqf";
    };
  };
} forEach vehicles;*/
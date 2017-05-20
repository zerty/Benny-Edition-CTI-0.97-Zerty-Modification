//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	loadUGV 1.2.0																					//
//	Author: Cleverle																						//
//	Version date: 28.06.2014																				//
//																											//
//	USE: In vehicles "INITIALIZATION" field type: "0 = [this] execVM "loadUGV.sqf";"					    //
//																											//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

_main = _this select 0;

// Check if main_obj is supported
Supported_UGV = ["B_UGV_01_F", "O_UGV_01_F", "I_UGV_01_F"];

// Init supported boxes
One_Boxes = ["Box_NATO_Wps_F", "Box_East_Wps_F", "Box_IND_Wps_F", "Box_East_Wps_F", "Box_East_AmmoVeh_F", "Box_NATO_Wps_F", "Box_Nato_AmmoVeh_F"];  

One_Pos = [0.45,-0.03,-0.8];
One_z_Offset = 0.35;
One_maxBoxes = 2;

One_third_Boxes = ["Box_NATO_Ammo_F", "Box_East_Ammo_F", "Box_IND_Ammo_F", "Box_NATO_AmmoOrd_F", "Box_East_AmmoOrd_F", "Box_IND_AmmoOrd_F", "Box_NATO_Grenades_F", "Box_East_Grenades_F", "Box_IND_Grenades_F", "Box_NATO_Support_F", "Box_East_Support_F", "Box_IND_Support_F"];
One_third_Pos = [0.82,-0.08,-0.7];
One_third_x_Offset = -0.44;
One_third_maxBoxes = 3;

Launcher_Boxes = ["Box_NATO_WpsLaunch_F", "Box_East_WpsLaunch_F", "Box_IND_WpsLaunch_F"];
Launcher_Pos = [0.3,0.14,-0.65];
Launcher_y_Offset = -0.34;
Launcher_maxBoxes = 2;

Special_Boxes = ["Box_NATO_WpsSpecial_F", "Box_East_WpsSpecial_F", "Box_IND_WpsSpecial_F", "B_supplyCrate_F", "O_supplyCrate_F"];
Special_Pos = [.45,-.5,-0.03];  //ss83 original #'s [0.3, 0, -0.65] the new #'s are for the supply box
Special_Offset = 0;
Special_maxBoxes = 1;

All_Boxes = One_Boxes + One_third_Boxes + Launcher_Boxes + Special_Boxes;

if !(typeOf _main in Supported_UGV) exitwith {
    player globalChat format ["loadUGV: Object ""%1"" is not supported.", typeOf _main];
};
// Init main variables
_main setVariable ["loadedBoxes",[],true];
_main setVariable ["vicinityBoxes",[],true];
_main setVariable ["boxtype","none",true];

// Functions
doLoad = {
    // [vehicle, box, pos, offset, maxBoxes, actionID]
    private["_v", "_box", "_pos", "_offset", "_maxBoxes", "_actionID"];
    _v = _this select 0;
    _box = _this select 1;
    _pos = _this select 2;
    _offset = _this select 3;
    _maxBoxes = _this select 4;
    _actionID = _this select 5;
    
    _loadedBoxCount = count (_v getVariable "loadedBoxes");
    
    if(_loadedBoxCount == _maxBoxes) then {
        player globalChat format["Maximum of %1 boxes reached.", _maxBoxes];
    }
    else {
        _v setVariable["loadedBoxes", (_v getVariable "loadedBoxes") + [_box], true];
        _v setVariable["vicinityBoxes", (_v getVariable "vicinityBoxes") - [_box], true];
        _box setVariable["status", "loaded", true];
        _box removeAction _actionID;
        
        if(typeOf _box in One_Boxes) then {
            _v setVariable["boxtype", "one",true];        
            if(_loadedBoxCount == 0) then {
                _box attachTo [_v, _pos];                
            }
            else {
                _box attachTo [_v, [_pos select 0, _pos select 1, (_pos select 2) + _offset]];
            };
        };
        if(typeOf _box in One_third_Boxes) then {
            _v setVariable["boxtype", "onethird",true];
            if(_loadedBoxCount == 0) then {
                _box attachTo [_v, _pos];
            };
            if(_loadedBoxCount == 1) then {
                _box attachTo [_v, [(_pos select 0) + _offset, _pos select 1, _pos select 2]];
            };
            if(_loadedBoxCount == 2) then {
                _box attachTo [_v, [(_pos select 0) + (2 * _offset), _pos select 1, _pos select 2]];
            };  
        };
        if(typeOf _box in Launcher_Boxes) then {
            _v setVariable["boxtype", "launcher",true];
            if(_loadedBoxCount == 0) then {
                _box attachTo [_v, _pos];
                _box setVectorUp[0.22,0,1];
            };
            if(_loadedBoxCount == 1) then {
                _box attachTo [_v, [_pos select 0, (_pos select 1) + _offset, _pos select 2]];
                _box setVectorUp[0.22,0,1];
            };
        };
        if(typeOf _box in Special_Boxes) then {
            _v setVariable["boxtype", "special",true];
            if(_loadedBoxCount == 0) then {
                _box attachTo [_v, _pos];
                _box setVectorUp[0.19,0,1];
            };
            if(_loadedBoxCount == 1) then {
                _box attachTo [_v, [_pos select 0, (_pos select 1) + _offset, _pos select 2]];
                _box setVectorUp[0.19,0,1];
            };
        };
    };

};

doUnload = {
    // [vehicle, box, actionID]
    private["_v", "_box", "_actionID", "_loadedBoxCount", "_pos"];
    _v = _this select 0;
    _box = _this select 1;
    _actionID = _this select 2;
    
    _loadedBoxCount = count (_v getVariable "loadedBoxes");
    if(_loadedBoxCount == 1) then {
        _v setVariable ["boxtype", "none", true];
    };
    
    _box setVariable ["actionID", _actionID, true];
    
    _pos = [];
    switch(_loadedBoxCount) do {
        case 1: { _pos = _v modelToWorld [-2,0,0]; };
        case 2: { _pos = _v modelToWorld [-2,1,0]; };
        case 3: { _pos = _v modelToWorld [-2,2,0]; };
    };
    
    detach _box;
    _box setPos _pos;
    [_box, 0] call bis_fnc_setheight;
    
    _v removeAction _actionID;
    
    _box setVariable["status", "nostatus", true];
    _v setVariable["loadedBoxes", (_v getVariable "loadedBoxes") - [_box], true];
};

// Script
while{true} do {
    _vicinity = nearestObjects[_main, [], 5];
    
    // Put boxes in special array
    {
        if(typeOf _x in All_Boxes && !(_x in (_main getVariable "vicinityBoxes")) && !(_x in (_main getVariable "loadedBoxes"))) then {
            _main setVariable["vicinityBoxes", (_main getVariable "vicinityBoxes") + [_x], true];
            _x setVariable["status", "vicinity", true];
        };
    } foreach _vicinity;
           
    {   
        // Remove boxes from special array if not in vicinity any more
        if(!(_x in _vicinity)) then {
            _main setVariable["vicinityBoxes", (_main getVariable "vicinityBoxes") - [_x], true];
            _x removeAction (_x getVariable "actionID");
        };

        // Add actions to vicinity boxes
        if((_x getVariable "status") != "vicinity_hasAction") then {
            if(typeOf _x in One_Boxes) then {
                _actionID = _x addAction["Load box in UGV", {
                    if((_this select 3 select 0 getVariable "boxtype") == "onethird"  || (_this select 3 select 0 getVariable "boxtype") == "launcher" || (_this select 3 select 0 getVariable "boxtype") == "special") then {
                        player globalChat "Can't put different types of boxes in.";
                    } else {
                        [_this select 3 select 0, _this select 3 select 1, One_Pos, One_z_Offset, One_maxBoxes, _this select 2] call doLoad;
                    };
                },[_main, _x],1.5,true,true,"","_this distance _target < 3.75"];
                _x setVariable["actionID", _actionID, true];
                _x setVariable["status", "vicinity_hasAction", true];              
            };
            if(typeOf _x in One_third_Boxes) then {
                _actionID = _x addAction["Load box in UGV", {
                    if((_this select 3 select 0 getVariable "boxtype") == "one" || (_this select 3 select 0 getVariable "boxtype") == "launcher" || (_this select 3 select 0 getVariable "boxtype") == "special") then {
                        player globalChat "Can't put different types of boxes in.";
                    } else {
                        [_this select 3 select 0, _this select 3 select 1, One_third_Pos, One_third_x_Offset, One_third_maxBoxes, _this select 2] call doLoad;
                    };
                },[_main, _x],1.5,true,true,"","_this distance _target < 3.75"];
                _x setVariable["actionID", _actionID, true];
                _x setVariable["status", "vicinity_hasAction", true];  
            };
            if(typeOf _x in Launcher_Boxes) then {
                _actionID = _x addAction["Load box in UGV", {
                    if((_this select 3 select 0 getVariable "boxtype") == "one" || (_this select 3 select 0 getVariable "boxtype") == "onethird" || (_this select 3 select 0 getVariable "boxtype") == "special") then {
                        player globalChat "Can't put different types of boxes in.";
                    } else {
                        [_this select 3 select 0, _this select 3 select 1, Launcher_Pos, Launcher_y_Offset, Launcher_maxBoxes, _this select 2] call doLoad;
                    };
                },[_main, _x],1.5,true,true,"","_this distance _target < 3.75"];
                _x setVariable["actionID", _actionID, true];
                _x setVariable["status", "vicinity_hasAction", true];  
            };
            if(typeOf _x in Special_Boxes) then {
                _actionID = _x addAction["Load box in UGV", {
                    if((_this select 3 select 0 getVariable "boxtype") == "one" || (_this select 3 select 0 getVariable "boxtype") == "onethird" || (_this select 3 select 0 getVariable "boxtype") == "launcher") then {
                        player globalChat "Can't put different types of boxes in.";
                    } else {
                        [_this select 3 select 0, _this select 3 select 1, Special_Pos, Special_Offset, Special_maxBoxes, _this select 2] call doLoad;
                    };
                },[_main, _x],1.5,true,true,"","_this distance _target < 3.75"];
                _x setVariable["actionID", _actionID, true];
                _x setVariable["status", "vicinity_hasAction", true]; 
            }
        };
    } foreach (_main getVariable "vicinityBoxes");
        
    // Add actions to UGV for loaded boxes
    if(count (_main getVariable "loadedBoxes") == 3) then {
        _box1 = (_main getVariable ["loadedBoxes",nil]) select 0;
        _box2 = (_main getVariable ["loadedBoxes",nil]) select 1;
        _box3 = (_main getVariable ["loadedBoxes",nil]) select 2;
        
        _main removeAction (_box1 getVariable "actionID");
        _main removeAction (_box2 getVariable "actionID");
        _box1 setVariable ["status", "loaded", true];
        _box2 setVariable ["status", "loaded", true];
        if(_box3 getVariable "status" != "loaded_hasAction") then {
            _main addAction ["Unload box from UGV", {
                [_this select 3 select 0, _this select 3 select 1, _this select 2] call doUnload;                
            }, [_main, _box3],1.5,true,true,"","_this distance _target < 5"];
            _box3 setVariable["status", "loaded_hasAction", true];
        };
        
    };
    if(count (_main getVariable "loadedBoxes") == 2) then {    
        _box1 = (_main getVariable ["loadedBoxes",nil]) select 0;
        _box2 = (_main getVariable ["loadedBoxes",nil]) select 1;
            
        _main removeAction (_box1 getVariable "actionID");
        _box1 setVariable ["status", "loaded", true];
        if(_box2 getVariable "status" != "loaded_hasAction") then {
            _actionID = _main addAction ["Unload box from UGV", {
                [_this select 3 select 0, _this select 3 select 1, _this select 2] call doUnload;                
            }, [_main, _box2],1.5,true,true,"","_this distance _target < 5"];
            _box2 setVariable["actionID", _actionID, true];
            _box2 setVariable["status", "loaded_hasAction", true];
        };
    };
    if(count (_main getVariable "loadedBoxes") == 1) then {
        _box1 = (_main getVariable ["loadedBoxes",nil]) select 0;
        if(_box1 getVariable "status" != "loaded_hasAction") then {
            _actionID = _main addAction ["Unload box from UGV", {
                [_this select 3 select 0, _this select 3 select 1, _this select 2] call doUnload;     
            }, [_main, _box1],1.5,true,true,"","_this distance _target < 5"]; 
            _box1 setVariable["actionID", _actionID, true];
            _box1 setVariable["status", "loaded_hasAction", true];
        };
    };
    
    sleep 2;
};
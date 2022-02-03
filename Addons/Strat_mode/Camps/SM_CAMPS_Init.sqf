#DEFINE NUMCAMPS 4


SM__CAMPS_CREATE_CAMP=compileFinal preprocessFileLineNumbers "Addons\Strat_mode\Camps\SM_CAMPS_Create_Camp.sqf";



GUER_GROUPS_PATROL=[
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")
	];
GUER_GROUPS_DEFEND=[
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AT"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AA"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),
	(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")
	];




///
///  SERVER SIDE
///

CTI_SM_CAMPS=[];

//Wait map initialisation
waitUntil {CTI_EAST getVariable ["CTI_LOAD_COMPLETED",false]};

// Create Camps

for "_i" from 0 to NUMCAMPS step 1 do
{
	_pos=[0,0,0];
	_gl=objNull;
	_townstodef=[];
	// Find Position

	// Create game logic
	CTI_SM_CAMPS pushBack(_gl);

	// Select towns to defend

	// select Type of Camp
	_outposts = "true" configClasses (configfile >> "CfgGroups" >> "Empty" >> "Military" >> "Outposts");
	_type = (_possible select floor random (count _possible ));

	// Create Camps building
	_buildings=[_type, _pos,random(360)] call SM__CAMPS_CREATE_CAMP;
	// register variable
	_gl setVariable ["CTI_SM_CAMP_TYPE", _type, false];
	_gl setVariable ["CTI_SM_CAMP_buildings", _buildings select 0, false];
	_gl setVariable ["CTI_SM_CAMP_Spositions", _buildings select 1, false];

};



// setup commander and groups


// Create Camps Statics

// Launch Camp Loop


///
///  Client Side SIDE
///

// Nothing client is blind to camp behavior
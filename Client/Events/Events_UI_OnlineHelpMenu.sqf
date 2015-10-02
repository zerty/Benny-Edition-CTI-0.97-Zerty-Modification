#define DIK_TAB             0x0F
#define DIK_TILDE             0x29
#define DIK_Y               0x15

private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		{((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160001) lbAdd _x} forEach ["Welcome Screen","Interraction menu", "The Basics", "The Map","Strategic Mode","Base Protection", "Player Economy", "Base Structures", "Special Vehicles", "Commander","Advance network","Tactical Hud","Trophy System","Remote Control","Credits"];
		((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160001) lbSetCurSel 0;
    for "_i" from 2 to 200 /* step +1 */ do {
      if (keyName _i != """") then {

        ((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160003) lbAdd format["%1", keyName  _i];
        ((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160003) lbSetValue [(_i-2), _i];
        //if (_percent_resources == (_i*10)) then {((uiNamespace getVariable "cti_dialog_ui_transferresourcesmenu") displayCtrl 140006) lbSetCurSel _u};
        if (_i == (profilenamespace getvariable ['CTI_TABLET_KEY',41])) then {((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160003) lbSetCurSel _i};
      };
    };
	};
  case "onKeyLBSelChanged" : {
      _changeTo = _this select 1;
     // hintsilent parsetext format ["%1",keyImage (_changeTo+2 )];
      profileNamespace setVariable ["CTI_TABLET_KEY", (_changeto+2)];
      saveProfileNamespace;
      ['onHelpLBSelChanged', 0] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_OnlineHelpMenu.sqf'
  };
	case "onHelpLBSelChanged": {
		_changeTo = _this select 1;

_helps = [format ["<t size='1.4' color='#2394ef'>Welcome in BECTI - Zerty mod</t><br /><br />
<t size='1.4' color='#FF3333'>Interactions / Buying Gear and units</t><br />
You can open the interraction menu regarding the object you are facing, if you are close enougth by pressing the <t color='#2394ef'>%1 key</t>; this key can be configured with the combo box on top of the online help menu (the current one).<br /><br />
<t size='1.2' color='#e8bd12'>The Mission</t><br />
This Mission is based on the original CTI Benny Edition mission (obviously by Benny) and then modified by Zerty. More informations on zerty's mod. and a download link to the mission file can be found on the website http://www.jammywarfare.eu . The full credits can be found in this menu; the changelog can be found in the map menu.<br /><br />
<t size='1.2' color='#e8bd12'>Objective</t><br />
The goal of a CTI mission is to take most the towns of the map or destroy enemy facilities and MHQ. The more towns your team controls the more money you will earn. A commander is in charge of building factories, unlocking the upgrades and setting the team strategies.<br /><br />
<t size='1.2' color='#e8bd12'>Money</t><br />
You will earn money by taking towns and killing enemies. You will also get paid for your efforts every minute, depending how many town your team owns.<br /><br /><br />

<t color='#e8bd12'>You can disable this screen by disabling hints in the video options.</t>
",keyImage(profilenamespace getvariable ['CTI_TABLET_KEY',41])],
format ["<t size='1.4' color='#2394ef'>Interraction Menu</t><br /><br />
The Interaction menu is the interface replacing the old action menu.<br /><br />
It can be oppened facing most objects and by pressing the <t color='#2394ef'>%1 key</t>, this key can be configured with the combo box on top of the online help menu (the current one).<br /><br />
An<t color='#e8bd12'> additionnal key</t> can be configured through the user action in the Arma 3 configuration as <t color='#e8bd12'>User action 5</t>.<br /><br />
This menu will differ if you are inside a vehicle or outside and also on what kind of object you are looking at.",keyImage(profilenamespace getvariable ['CTI_TABLET_KEY',41])],
"<t size='1.4' color='#2394ef'>The Basics</t><br /><br />
Each side's teams are led by a <t color='#e8bd12'>Team Leader</t> which will respawn after it's death (you are a Team Leader). Your character's location can be seen on the map if you are connected to the network. You position will be shown with one of the icons below, along with your group name and player name.<br /><br />
<t align='center'><img image='\A3\ui_f\data\map\Markers\NATO\b_inf.paa' size='2'/> <img image='\A3\ui_f\data\map\Markers\NATO\o_inf.paa' size='2'/></t><br /><br />
Each player team has it's own <t color='#e8bd12'>Income</t>, the income can be viewed by accessing the <t color='#eaff96'>Options Menu</t>. The income can be increased by controlling <t color='#e8bd12'>Towns</t> and by earning non-combat points.<br /><br />
<t color='#e8bd12'>Towns</t> will generate a different income value depending on their size. The bigger the town the bigger the bounty (and the difficulty!). Note that an <t color='#e8bd12'>Occupied Towns</t> will generate more income.<br /><br />
<t color='#e8bd12'>Towns</t> are also defended by resistance at the start of the game so as you try to capture them, they will try to defend and recapture it!<br />
",
"<t size='1.4' color='#2394ef'>The Map</t><br /><br />
The <t color='#e8bd12'>Map</t> contains all of the information that you need. First of all, you need to be aware of the colors<br /><br />
- <t color='#e8bd12'>West</t> is identified by the <t color='#eaff96'>Blue</t> color.<br />
- <t color='#e8bd12'>East</t> is identified by the <t color='#eaff96'>Red</t> color.<br />
- <t color='#e8bd12'>Resistance</t> (or unknowns) is identified by the <t color='#eaff96'>Green</t> color.<br /><br />
The <t color='#e8bd12'>Towns</t> are identified by a Flag marker as follow (a circle may appear around it which signify that the town is occupied):<br /><br />
<t align='center'><img image='\A3\ui_f\data\map\Markers\Military\flag_ca.paa' size='2'/></t><br /><br />
While the <t color='#e8bd12'>MHQ</t> is identified by a specific marker labeled 'HQ' the <t color='#e8bd12'>Base Structures</t> are identified by an installation marker as follow:<br /><br />
<t align='center'><img image='\A3\ui_f\data\map\Markers\NATO\b_installation.paa' size='2'/> <img image='\A3\ui_f\data\map\Markers\NATO\o_installation.paa' size='2'/></t><br /><br />
Additionally, vehicles and infantry may appear with a different icon on the map depending on their nature (<t color='#eaff96'>Infantry</t>, <t color='#eaff96'>Mechanized</t>, <t color='#eaff96'>Armored</t>, <t color='#eaff96'>Air</t>...). Smaller yellow markers may appear on the map, to represent the subordinate infantry of your side (your own AI will appear orange along with their squad number).
",

format ["<t size='1.4' color='#2394ef'>The Strategic Mode</t><br /><br />
The <t color='#e8bd12'>strategic mode</t> is a dynamic behavior that regulate both the localisation of the action and the number of AI present in the mission.<br />
It is represented as the <t color='#e8bd12'>black lines between towns.</t><br /><br />
THe bahavior follows those<t color='#e8bd12'>rules:</t> <br />
  -  You can capture any town as your first town.<br />
  -  A town can be captured only if active.<br />
  -  You can only have %1 town actives at a time.<br />
  -  A town can be activated if available.<br />
  -  A town is available if you have no town or if you own one town connected to it.<br />
  -  No towns are available if you already have %1 towns actives.<br />
",(missionNamespace getVariable "CTI_SM_STRATEGIC_NB")],
"
<t size='1.4' color='#2394ef'>Base Protection</t><br /><br />
The base protection system is <t color='#e8bd12'>the system preventing destruction of factories</t> inside the base.<br /><br />
If active, the base area is linked to the three closest towns (links will be shown).<br /><br />
<t color='#e8bd12'>The base is protected if and only if all of the three towns are owned by the side of the base.</t><br /><br />
The enemies base areas and their links to the towns will be shown to your side if a friendly unit was once inside the corresponding area.
",
"<t size='1.4' color='#2394ef'>Player Economy</t><br /><br />
Aside from the Commander, there are multiple <t color='#e8bd12'>Teams</t> (labeled as <t color='#eaff96'>Alpha</t>, <t color='#eaff96'>Bravo</t>, <t color='#eaff96'>Charlie</t>...) which may be controlled by either the AI (if enabled) or a player. Without an order from the Commander, those units will run toward the closest hostile town.<br /><br />
A Team Leader receives a percentage of the total resource income earned. Assuming the value is set on <t color='#f455aa'>30 percent</t> for the <t color='#e8bd12'>Player Pool</t> and that there are <t color='#f455aa'>3 Team Leaders</t> on your side (excluding the Commander) then each of those units will receive <t color='#f455aa'>10 percent</t> of the pool resources (30 / 3).<br /><br />
Team Leaders may also earn resource from the <t color='#e8bd12'>Award Pool</t>. This pool awards the Team Leaders based on their combative and non combative score. Assuming that the Award Pool is set on <t color='#f455aa'>10 percent</t> and that there is <t color='#f455aa'>2 Team Leaders</t> with a score of <t color='#f455aa'>75</t> and <t color='#f455aa'>25</t> then the first one will receive <t color='#f455aa'>75 percent</t> of the pool resources.<br /><br />
The <t color='#e8bd12'>Player Pool</t> and the <t color='#e8bd12'>Award Pool</t> percentage may be viewed from the <t color='#eaff96'>Options Menu</t>. The <t color='#e8bd12'>Commander</t> may raise or lower them from within the <t color='#eaff96'>Transfer Resources Menu</t>.
",
"<t size='1.4' color='#2394ef'>Base Structures</t><br /><br />
The <t color='#e8bd12'>Base Structures</t> can be used for different purposes. As soon as the player is in range of a structure he may decide to purchase additional units or vehicles from them. You may choose to buy a vehicle manned or empty (you may also buy a vehicle without a driver, gunner, commander or turrets).<br /><br />
A <t color='#eaff96'>Control Center</t> will increase the purchase range of the different factories and add new commanding features to the Commander.<br /><br />
You may also choose to change or reload your gear at the nearest <t color='#eaff96'>Barracks</t>.
",
"<t size='1.4' color='#2394ef'>Special Vehicles</t><br /><br />
- Players may log on the <t color='#e8bd12'>MHQ</t> Satellite link to use the <t color='#eaff96'>Team Camera</t>. This mode allows you to overwatch the current Team Leaders or your side.<br /><br />
- <t color='#e8bd12'>Ammo Trucks</t> are used to resupply the ammunition of the nearby vehicles. They may also rearm nearby stationary weapons if needed.<br /><br />
- <t color='#e8bd12'>Repair Trucks</t> can be used to repair the nearby damaged <t color='#eaff96'>Vehicles</t> or <t color='#eaff96'>Base Structures</t>. Players may also construct <t color='#eaff96'>Defensive Structures</t> from them. A driver is needed to repair <t color='#eaff96'>Base Structures</t>.<br /><br />
- <t color='#e8bd12'>Salvagers</t> are used to salvage destroyed vehicles thus reclaiming a certain part of the original wreck's value. If a player is the driver during the salvaging of a wreck then he will receive <t color='#f455aa'>50 percent</t> of it's value and earn some points while the rest is divided among the side's teams. <t color='#e8bd12'>Independent AI Salvagers</t> may be purchased by the Commander from the <t color='#eaff96'>Repair Depot</t>.<br /><br />
",
"<t size='1.4' color='#2394ef'>Commander</t><br /><br />
First step for player to begin duty as a Commander is to go to MHQ and in it's menu use option 'Take Command'. Then if most of players vote for new commander, player will be granted commander role. <br /><br />
The <t color='#e8bd12'>Commander</t> is reponsible for <t color='#eaff96'>Constructing Bases</t> and <t color='#eaff96'>Managing</t> the side's teams. He may also diminish or increase the <t color='#eaff96'>Player Pool</t> and the <t color='#eaff96'>Award Pool</t>.<br /><br />
The responsabilities that falls on the Commander are heavier than a regular player. It is recommended to practice this role in SinglePlayer if you're not used to it (your team may be very angry at you otherwise).<br /><br />
Your very first duty as Commander is to find a suitable <t color='#eaff96'>Base Location</t>, the perfect area should be flat, easily defensible and not too far away from the battlefield.<br /><br />
Your second duty as Commander is to <t color='#eaff96'>Construct the Base</t>. <t color='#eaff96'>Barracks</t> and <t color='#eaff96'>Control Center</t> are a good choice for a start. Once you've decided on the location, you can open the <t color='#eaff96'>Build Menu</t> and place the desired structures. Those structures will appear as 'ruins' at first as they must be built up. Don't forget to hire <t color='#eaff96'>Workers</t> to construct the structures (Keep in mind that you're on a low budget at first!). You can also build structures on Your own using menu option 'Build' for ruins, while beeing close to ruins.<br /><br />
From now on, the strategy is entirely up to you. You may create a <t color='#eaff96'>Light Vehicle Factory</t> for your side so that they may move faster to the battlefield or save up for a <t color='#eaff96'>Heavy Vehicle Factory</t> in order to perform an heavy attack. <t color='#eaff96'>Defenses</t> are very important in your base as enemy players may close in at any time!<br /><br />
Commander can also set orders to Team Leaders, ie. to capture selected town, or go to some spot on map. This is true for both AI units and Player owned. It can be done in 'Map Commanding' part of Laptop Menu.
Don't forget that a good Commander shall balance the needs of the base and the needs of his team.
",

"<t size='1.4' color='#2394ef'>Advance Network</t><br /><br />

The <t color='#e8bd12'>network</t> is the way for you to communicate with the rest of your team <br />
Being connected to the network allows: <br />
 - To get the positions of friendly units on the map <br />
 - To be able to purchase units from the factories <br />
 - To see what upgrades are available or running<br />
 - To be able to see friendly Connected units on the hud.<br />
 - To be able to share target to other units using Tac Hud.<br />
 - To be able to receive target from the network. <br />
<br />
<t color='#e8bd12'>Be aware that your network can be hacked by the opposing forces.</t>
<br /><br />
The network is a tree meshing network (look on wikipedia).
The reconfiguration process tries to lower network units power consumption by connecting to the closest connected unit.
The <t color='#e8bd12'>backbone</t> of the network is constituted of <t color='#e8bd12'>the HQ, CCs, Towns And Vehicles</t>.
As infantry you are able to connect to either of those elements <br />
The following are the effective <t color='#e8bd12'>ranges</t> of connection depending on types <br />
  - Infantry:  100m + 200m * (Upgrade Level)<br />
  - Vehicle: 1000m + 1000m * (Upgrade Level) <br />
  - Town : 5 km<br />
  - CCs : Unlimited<br />
  - HQ : Unlimited<br /><br />
",

"<t size='1.4' color='#2394ef'>Tactical HUD</t><br /><br />
Tactical Hud is available if you are equiped with tactical glasses and if the upgrade is done by your side. <br /> <br />
This HUD functionnalities are: <br />
 - Target highligths <br />
 - Automatic Target Sharing between player groups <br />
  Shared Targets are marked with a dot above it  <br />
  (If connected to field mesh network) <br />
 - Town highligths with status <br />
 - Friendly units highligth (if connected)<br />
  <br />
The target are first local to the player, then as soon as the player is connected to the advance network, the target is registered across all network, alowing everyone to see it on the hud and on map.
",
"<t size='1.4' color='#2394ef'>Trophy system</t><br /><br />
The Trophy system is a real world <t color='#e8bd12'>Active Protection System (APS) </t> made by Rafael. It protect your heavy vehicle of soft targets (missiles and rockets).<br /><br />
<t color='#e8bd12'>Without upgrades</t>, all MBTs and APCs starts with two ammos (one of each side), a 60 seconds cooldown and a 50% effectiveness. <br />
<br /><t color='#e8bd12'>Two blind spots are present:</t> one on the front between -20° and 20° and another on the back between 160 and 200 °.<br />
<br />With the <t color='#e8bd12'>ammunition upgrade</t>, all side vehicles are getting two more ammunition each level (1 on each side).<br />
<br />The <t color='#e8bd12'>Cooldown and effectiveness upgrade</t> increases working probability by 15% each level and reduces the cooldown time (60s /(1+level))<br /><br />
You can find the current <t color='#e8bd12'>status</t> of your trophy system in the <t color='#e8bd12'>vehicle hud.</t>",
"<t size='1.4' color='#2394ef'>Remote Control</t><br /><br />
Since the AI in ArmA III can be realy frustrating while driving, the ability of <t color='#e8bd12'>remote controling the drivers and pilots</t> have been introduced.<br/>
You can initiate the remote controling using the <t color='#e8bd12'>action menu of the unit</t>. (F1-10 Keys and then the 6 key). <br />
In order to be able to remote control, the following conditions must be all met <br />
- The unit and player must be alive<br />
- No gunner must be present in the vehicle<br />
- The unit must be driver/ pilot of the vehicle<br />
- The vehicle must be unlocked (BIS related)<br />
- The player cannot be in the same vehicle<br />
<br />
Be aware that it migth disconnect you from your current uav.
",
"<t size='1.4' color='#2394ef'>Current Credits</t><br /><br />
- <t color='#e8bd12'>Benny</t> for the mission<br />
- <t color='#e8bd12'>Bl1p, Fluit</t> for random AI skill<br />
- <t color='#e8bd12'>=ATM=Pokertour</t> for ATM airdrop<br />
- <t color='#e8bd12'>Prodavec</t> for Map Markers titling<br />
- <t color='#e8bd12'>^HS^</t> for writting the diary help <br />
- <t color='#e8bd12'>Farooq</t> for his original idea of a revive script <br />
- <t color='#e8bd12'>Sari</t> for updating the sanitize scripts <br />
- <t color='#e8bd12'>John681611</t> for his original idea of offroad aug.<br />
- <t color='#e8bd12'>Henroth</t> for his Aircraft loadout customisation framework.<br /><br />

<t color='#e8bd12'>And of course, everyone who gave feedback and bug reports.</t><br />"

];
		((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160002) ctrlSetStructuredText parseText (_helps select _changeTo);
	};
};
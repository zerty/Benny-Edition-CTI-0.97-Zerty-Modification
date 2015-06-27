
player createDiarySubject ["TS", "TeamSpeak"];
player createDiaryRecord ["TS",["JMW","ts.jammywarfare.eu"]];


player createDiarySubject ["CL", "Change Log"];
player createDiaryRecord ["CL",["* 1.1.8",
"  - FEATURE: Air radar (range 5Km at least 40m heigth)<br />
  - FEATURE: Gear to vehicles<br />
  - FEATURE: HC slot<br />
  - FEATURE: More items in defence menu<br />
  - FEATURE: Stratis version<br />
  - PARAM : Town Mortars<br />
  - PARAM : Base Protections<br />
  - FIX: Param strategic mode only disactivate strat mode not all features<br />
  - FIX: Cannot steal HQ anymore :) <br />
  - FIX: AI mortar less precise<br />
  - FIX: Commander money exploit  <br />
  - FIX: Lag in Respawn menu (hopefully)<br />
  - CODE: Init cleanup<br />
"]];
player createDiaryRecord ["CL",["* 1.1.8.1",
"  - FIX: Mortars Not despawning<br />
  - FIX: Air Radar Init and JIP
"]];
player createDiaryRecord ["CL",["* 1.1.9",
"  - FEATURE: Farooq's Revive <br />
  - FEATURE: More items in defence menu<br />
  - FEATURE: Artillery radar<br />
  - FEATURE: NVs and Thermal limitation (innactive by default)<br />
  - PARAM : Farooq's Revive active<br />
  - PARAM : Farooq's Revive mode<br />
  - PARAM : Town capture award multiplyer<br />
  - PARAM : Teamswap protection<br />
  - PARAM : NVs and Thermal limitation<br />
  - FIX: Structure placing tweaks to prevent clusterfucks<br />
         of buildings (30m radius)<br />
         So build defences first and then factories<br />
  - FIX: WeaponGroundContainers Cleanup (4 minutes timeout)<br />
  - FIX: Occupation can take back a town even if innactive<br />
  - FIX: Money exploit with teamkills<br />
  - FIX: Selling buildings<br />
  - FIX: Non despawning vehicle in resistance towns<br />
  - FIX: ScrollBars in dialogs (partially, some errors left)<br />
  - FIX: Rearm now gives the rigth number of magazines<br />
  - FIX: Reduced despawning time of town offroads.<br />
  - FIX: Disactivating MRLS for balance.<br />
  - HOTFIX: Removed hook capacities of SDVs to prevent abuse<br />
            (it will be reintroduced later).<br />
"]];
player createDiaryRecord ["CL",["* 1.1.9.1","
  - CHANGE: Crates at towns are now random <br />
  - FIX: Parachute are now not detected by the Air radar <br />
  - FIX: Halo jumping is now working as expected (rigth position) <br />
  - FIX: PFV error when client and/or server is lagging <br />
  - CODE: Partially Rewriten the strategic mode <br />
          Some changes of behavior are to be expected.<br />
  - HOTFIX: Removed AI delegation (pb with town groups) <br />
"]];
player createDiaryRecord ["CL",["* 1.1.9.2","
  - FEATURE: Basic HUD <br />
  - FIX: Activation when no town occupation <br />
  - FIX: Town disactivation preventing reactivation <br />
  - FIX: Capture with AI without force spawning <br />
  - CODE: Arty radar rewrite (less client lags) <br />
"]];

player createDiaryRecord ["CL",["* 1.1.9.3","
  - FEATURE: Tactical HUD with tactical glasses and upgrade<br />
  - FEATURE: More Upgrades <br /><br />
  - FIX: Terrain intercept radar contact <br />
  - FIX: Radar Spam <br />
  - FIX: Arty radar not working <br />
  - FIX: Lowered radar hitpoints <br />
  - FIX: Air contacs are revealed to player <br /><br />
  - FIX: Placing fob inside buildings or other stuff <br />
  - FIX: FOB protected by base protections <br />
  - FIX: Canceling building creating base <br /><br />
  - FIX: Disactivation of the respawn button <br />
  - FIX: 30s Suicide TimeOut <br />
  - FIX: No more respawning in a town being captured <br /><br />
  - FIX: Tweak Gear/Upgrades/startup <br />
  - FIX: No more respawning in a town being captured <br />
  - FIX: Repair action stacking <br />
  - FIX: Priority target disactivation <br />
  - FIX: 60s timeout on town disactivation action <br />
  - FIX: Tweak on Town vehicles spawning <br /><br />
  - CODE: Upgrades rewriten <br />
"]];

player createDiaryRecord ["CL",["* 1.2.0.0","
  - FEATURE: Adaptative player groupsize <br />
  - FEATURE: Advance mesh networking <br />
  - FEATURE: 3P pov limitation <br />
  - FEATURE: Guerrilla uniforms in equipment <br />
  - FEATURE: More H barrier element in defence menu <br />
  - FEATURE: Basic resistance patrols<br />
  - FEATURE: Serverside unit cleanup<br />
  - FEATURE: Zeus Interface for Logged Admin <br />
  - FEATURE: Some Stuff :) <br /> <br />
  - PARAM: Advance mesh networking <br />
  - PARAM: 3P limitation <br />
  - PARAM: Resistance patrols <br /> <br />
  - FIX: Ajusted construction timeout <br />
  - FIX: eject crew of hooked vehicles <br />
  - FIX: Revive available at 0-25% health <br />
  - FIX: Removed Suicide Timeout  <br />
  - FIX: player goes unconscious if hp below 25% <br />
  - FIX: Artillery Radar (maybe need more tests)<br />
  - FIX: Centralised Tact Hud targets per side on server <br />
  - FIX: Augmented time for town capture 1.5 min<br /> <br />
  - CHANGE: Commander slots at the end of the list<br />
  - CHANGE: Target sharing can only be done if connected <br />
  - CHANGE: Map updates only if connected <br />
  - CHANGE: Factory accessible only if connected <br />
  - CHANGE: Friendly units update on map if player and unit connected <br />
  - CHANGE: player name shows only if connected <br />
  - CHANGE: Weather script changed for randomWeather2<br /><br />
  - CODE: Changed Tact Hud targets rendering method (drawIcon3D) <br />
  - CODE: Changed Map rendering (drawIcon, drawLine) <br />
"]];

player createDiaryRecord ["CL",["* 1.2.1.0","
  - FEATURE: Offroads can load statics /crates <br />
  - FEATURE: Trophy APS on tanks and APCs +2 Upgrades<br />
  - FEATURE: New upgrade for the respawn truck<br />
  - FEATURE: Commander can delete defences<br />
  - FEATURE: Quadbikes can be bougth on fobs<br />
  - FEATURE: Equipement menu access on respawn trucks<br />
  - FEATURE: AAF technologies can be upgrades to access AAF vehicles<br />
  - PARAM: Tactical Hud Targets sensivity <br /><br />
  - FIX: Getting award for crashing Chopper/plane<br />
  - FIX: Not getting award for UAV kills <br />
  - FIX: Disapearing AI when AI teams enabled<br />
  - FIX: Script error in cleanup<br />
  - FIX: Some logic errors in the networking <br />
  - FIX: Town occupations are disconnected by default <br />
  - FIX: Guerrilla vehicles are disconnected by default <br />
  - FIX: Stopping Networking procedures on disconnected vehicles <br /><br />
  - CHANGE: Player access to defense menu near HQ// repair depot <br />
  - CHANGE: Moved the APCs to basic heavy factory <br />
  - CHANGE: Lowered the price of Respawn trucks <br />
  - CHANGE: 30k bounty on side HQs <br />
  - CHANGE: 5k bounty on Commanders <br />
  - CHANGE: HALO jump now costs 500$ per jumps <br />
  - CHANGE: Changed blufor chopper prices <br />
  - CHANGE: 7 second timeount before starting field repairs <br />
  - CHANGE: Misile range limit is disactivated by default (replaced by APS) <br /><br />
  - CODE: Moved activation and hud variable to side logics <br />
  - CODE: Changed repairing and forcelocking a bit <br /> <br /> <br />

Next version:
  - Blackhole routing <br />
  - Network intrusion <br />
  - Scrambler (maybe) <br />
  - Revamp of the fob system
"]];

player createDiaryRecord ["CL",["* 1.2.1.1","
  - FEATURE: Network intrusion exploit (Network 3)<br />
  - FIX: Bad spawning pos for town Helos<br />
  - FIX: Patrol spawning in active towns<br />
  - FIX: No Trophy EH on static defences<br />
  - FIX: Defence removing not JIP compatiple<br />
  - FIX: Town Mortars JIP<br />
  - FIX: Duplicates in OPFOR AF<br />
  - FIX: Show units in forced disconnection mode<br />
  - FIX: Com Disactivation blocked activation <br />
  - FIX: Repair progress bar <br />
  - FIX: Message on failed attachement on offroads <br />
  - FIX: Exit attached static EH <br /><br />
  - CHANGE: Logged Admin action to connect to Zeus (no message)  <br />
  - CHANGE: Hud targets are shown on map  <br />
  - CHANGE: Reduced base detection range  <br />
  - CODE: TacHud target removal Serverside <br />
"]];

player createDiaryRecord ["CL",["* 1.2.1.2","
  - PARAM: Town CAS on town value <br />
  - PARAM: Trophy APS <br />
  - FIX: Concurency between structure removal inducing game lock <br />
  - FIX: Error on structure handler<br />
  - FIX: Jail<br />
  - FIX: town occupation not able to recap if no enemy present<br />
  - FIX: Concurency between threads working on the tachud targets inducing flickering<br />
  - FIX: while in hacked net, map elements not showing in hud<br />
  - FIX: while in hacked net, towns not showing<br />
  - FIX: Error in patrol cleaning<br />
  - FIX: Sometime hud not showing <br />
  - FIX: Intrusion action not showing in MP <br />
  - FIX: Reduced number of patrols <br />
  - FIX: Town spawning while occupation is still active <br />
  - CODE: Town CAS is independant from Mortars <br />
"]];

player createDiaryRecord ["CL",["* 1.2.1.3","
  - FEATURE: None, still fixin' and tweakin'<br />
  - FIX: Showing enemy names when shared target <br />
  - FIX: Disabled Fatique for AIs<br />
  - FIX: Revive while in statics<br />
  - FIX: Jailing while in vehicle/statics<br />
  - FIX: Worker stack and removal (WIP)<br />
  - FIX: Selling buildings<br />
  - CHANGE: black and camo variants <br />
  - CHANGE: Flag on flagpole with current occupation color <br />
  - CHANGE: Fatigue recuperation for players less hardcore (max 26s for full, ignore loadout)<br />
  - CHANGE: Town CAS plane is now the CAS variant <br />
  - CHANGE: Some hud changes and Fatigue indicator (inspired from ^HS^) <br />
  - CODE: Full rewrite of the strat mode <br />
  - CODE: Trying to reduce town lag linked to the total number of vehicles <br />
  - CODE: Trying to reduce Capture lag linked to the total number of vehicles <br />
"]];

player createDiaryRecord ["CL",["* 1.2.1.4","
  - FEATURE: Drivers/Pilots remote control (read the help topic on map)<br />
  - FEATURE: Fast building Actions<br />
  - FEATURE: MLRS is back for blufor<br />
  - FIX: No despawning time for special vehicles<br />
  - FIX: Hud not showing towns correctly<br />
  - FIX: Task creation script updated<br />
  - FIX: Disapearing vehicles and HQ when player disconnects<br />
  - FIX: Building offsets for some defenses<br />
  - FIX: Award not given to players if last hit is explosion <br />
  - FIX: Asynchronism allowing resistance/occupation respawn<br />
  - FIX: Strat mode behavior placed on a 10s cycle to prevent glitches<br />
  - FIX: No more concrete ramp to prevent abuse with them<br />
  - FIX: Template not loading with Uavterminal in gps slot<br />
  - FIX: Defense menu action attached to HQ<br />
  - FIX: Defense menu action attached to Repair factories<br />
  - FIX: Patrols rushing capture and leaving (End of trolling patrols)<br />
  - FIX: Using defences to blow up HQ<br />
  - CHANGE: Need to be connected to get radar contacts <br />
  - CHANGE: SDVs can hook wreaks only <br />
  - CHANGE: Procedural map init using the CTI_CENTER marker<br />
            (Editors :it can be also used to restrict the playground!)<br />
  - CODE - CHANGE: Network intrusion <br />
  - CODE: Privates, Privates everywhere<br />
  - CODE: Full rewrite of base protection<br />
  - CODE: Full rewrite of Artillery radar<br />
  - CODE: Full rewrite of Air radar<br />
  - CODE: Town occupation group computing <br />
  - CODE: Cleanup in the strat mode init<br />
  - CODE: Infantry network procedures moved on clients <br />
"]];

player createDiaryRecord ["CL",["* 1.3.0.0","
Designated as 'Operation Unfuck the Action Menu and WTF to do with choppers' <br /><br />

  - FEATURE: Henroth Aircraft loadout customisation<br />
  - FEATURE: New interraction Menu (tilde key)<br />
  - FEATURE: New Tablet Menu (U keys)<br />
  - FEATURE: New Choppers and pod Modules <br />
  - FEATURE: Dynamic Commanding (take com at HQ or CC)<br />
  - FEATURE: Possibility to leave Com seat IG<br />
  - FEATURE: Possibility vote eject the commander<br />
  - FEATURE: Ability to pack unpack heavy vehicle for sling load <br />
  - FEATURE: Ability to pack HQ for sling load <br />
  - FEATURE: Ability to attach slingload to taru <br />
  - FEATURE: Ability to drop slingload/attachement using parachute (if above 30m) <br />
  - FEATURE: Laser Targets shown in hud/map (if  both  unit and player connected)<br />
  - FEATURE: Player are able to build/repair the base buildings (and get paid) <br /><br /><br />


  - PARAM: Enable/Disable workers (AI Com will still use them)<br />
  - PARAM: Gear access on Ammo trucks/pod<br />
  - PARAM: Gear access on Medical trucks/pod<br />
  - PARAM: Ability to buy at town flags<br />
  - PARAM: AI teams can be activated per side<br />
  - PARAM: Weather acceleration is now working with TimeMultiplier and randomWeather2<br />
  - PARAM: Adaptative groupsize for player can be disabled<br />
  - PARAM: TacHud targeting report can be disable using its sensitivity<br />
  - PARAM: Henroth Aircraft Loadout customisation (v1.3)<br /><br /><br />


  - CHANGE: if AI teams are enabled, an AI will take command if not taken by a player<br />
  - CHANGE: Respawn timer computed with last death time and respawn distance<br />
  - CHANGE: Gear button moved on action menu (depends on target)<br />
  - CHANGE: Have acess to gear of vehicles if unlocked<br />
  - CHANGE: Always have access to gear if connected<br />
  - CHANGE: New watchdog for structure cleanup preventing stuck game<br />
  - CHANGE: rewriting part of online help<br />
  - CHANGE: Using online help as welcome screen<br />
  - CHANGE: All dialog modified<br />
  - CHANGE: Refuel removed from Repair Trucks<br />
  - CHANGE: Removed death camera<br />
  - CHANGE: UGVs are back<br />
  - CHANGE: UAVs - UGVs are getting removed if not connected (1h-10m) <br />
  - CHANGE: AI team leader starting gear<br />
  - CHANGE: Town Capture award computed with teambalance and teamplay<br />
  - CHANGE: commanding view always disabled<br />
  - CHANGE: Capture area marked on map<br />
  - CHANGE: player gear can be set as permanant <br />
  - CHANGE: Vehicule ownership is now persistant over JIP <br />
  - CHANGE: FOB are removed, please use the mobile varients <br />
  - CHANGE: Commander town activation action in the tablet menu <br />
  - CHANGE: Commanderallways get the money for capping <br />
  - CHANGE: Benny's hook Code Disabled<br /><br /><br />


  - FIX: No remote control if gunner present in the vehicle<br />
  - FIX: Town mortar less agressive <br />
  - FIX: Patrols getting removed while capping <br />
  - FIX: More probability of good weather <br />
  - FIX: AI can cap towns <br />
  - FIX: AI team orders should work with strat mode <br />
  - FIX: Missing current magazines on respawn <br />
  - FIX: Hud not showing if the strategic mode is disabled <br />
  - FIX: BAse area not showing if base protection disabled<br />
  - FIX: cti_netmarker global variable useless and removed <br />
  - FIX: Disapearing occupation and resistance on disactivation <br /><br /><br />


  - CODE: heavy artillery radar moved back on server <br/>
  - CODE: Full rewrite of the revive system <br/>
  - CODE: 3P restriction moved to onEachFrame EH stack <br/>
  - CODE: Optimisations for non strategic mode<br/>

"]];

player createDiaryRecord ["CL",["* 1.3.0.1","
  - HOTFIX: Fixed HQ wreak removed if once packed<br />
  - HOTFIX: Can take command on any factory<br />
"]];

player createDiaryRecord ["CL",["* 1.3.0.2","
  - FEATURE: 5 Headless Client slots <br />
  - FEATURE: Base protection Soft mode (DMG reduced)<br />
  - FEATURE: Random startup with min number of towns(if set) <br /><br />

  - PARAM: HC Mode<br />
  - PARAM: Min Number of towns<br />
  - PARAM: Max number of active towns<br />
  - PARAM: Base protection mode<br /><br />

  - CHANGE: ejected com is only backlisted for 10 minutes<br />
  - CHANGE: AI skill lowered<br />
  - CHANGE: player factory repair ratio lowered<br />
  - CHANGE: Procedural Min Town startup<br />
  - CHANGE: Number of patrols computed <br />
  - CHANGE:Non strategic mode uses the activation process<br />
  - CHANGE: Some UI modifications <br />
  - CHANGE: Medium chopper can sling load conteners/taru module <br /><br />

  - FIX: SP: Team leaders not able to activate<br />
  - FIX: SP: AI Com behavior midgame<br />
  - FIX: SP: Loading game<br />
  - FIX: instant fog changes<br />
  - FIX: Artilery radar marker not disapearing<br />
  - FIX: HQ Locality watchdog added<br />
  - FIX: HQ eventhandlers<br />
  - FIX: error when using -autoinit<br />
  - FIX: Stopping building when complete<br />
  - FIX: Combined repair/build with player and truck<br />
  - FIX: Repair action behavior<br />
  - FIX: Factory resiliance lowered <br />
"]];

player createDiaryRecord ["CL",["* 1.3.0.3","

  - CHANGE: FOB can be reactivated using distance parameter<br />
  - CHANGE: Reactivation of commander view using param<br /><br />


  - FIX: Artilery radar marker not disapearing<br />
  - FIX: Error on mission end<br />
  - FIX: Locality error on hq wreak handle<br />
  - FIX: Interraction menu on defences<br />
  - FIX: Equipment on FOBs <br />
  - FIX: Requip last purchase mode <br />
  - FIX: Laser designator batteries reequip <br />
  - FIX: Gear loosing on respawn <br />
"]];

player createDiaryRecord ["CL",["* 1.3.0.4","
  - CHANGE: separated vehicles from groups in towns<br />
  - CHANGE: Augmented the fuel consuption of small UAV<br /><br />
  - FIX: noobish AI<br />
  - FIX: Medium choppers not able to lift<br />
  - FIX: Interraction menu when hq is in a building<br />
"]];

player createDiaryRecord ["CL",["* 1.3.0.5","
  - FEATURE : Agressive PhysX Caching system <br /><br />

  - Change: Limiting number of spawn groups to 6<br /><br />

  - FIX: Unflip and caching system<br />
  - FIX: Reammo stacking on air<br />
  - FIX: Ammo containers allowing retrisction bypass<br />
  - FIX: Town AI behavior<br />
  - FIX: Default weigth for modules<br />
"]];

player createDiaryRecord ["CL",["* 1.3.0.6 [TestVersion]","
  - Feature: Towns are now considered as factories (Townshop)<br />

  - PARAM: Town Shop Price Ratio<br />
  - PARAM: Caching system<br />
  - PARAM: Darter range limitation<br />
  - PARAM: Darter fuel limitation<br /><br />

  - CHANGE: Heavy artillery research time <br />
  - CHANGE: Darter Range Limitation <br />
  - CHANGE: Tac hud do not mark infentry anymore. <br />


  - Fix: AI icons for UAV/UGV purchase <br />
  - Fix: Black Icons <br />
  - Fix: toolkit can be used from vest <br />
  - Fix: Cannot detach HQ pod from taru <br />
  - Fix: Air and artillery radar for assembled weapons or UAVs <br />
"]];

player createDiaryRecord ["CL",["* 1.3.1.0","
  - Feature: Group system from BiS <br />
  - Feature: Marksman new items <br />
  - Feature: Teamstack protection <br />
  - Feature: Weak server persistency <br />
  - Feature: Respawn on team leaders <br /><br />

  - PARAM: FFAR upgrade limitation <br />
  - PARAM: Buy limitation with players groups<br />
  - PARAM: server persistency<br />
  - PARAM: infantry on tac hud<br /><br />

  - CHANGE: Gear upgrades refactored <br />
  - CHANGE: vehicle prices and upgrades refactored<br />

  - Fix : Hud showing without tac glasses <br />
  - Fix : Upgrade forcing through param making Upg Dialog bug <br />
  - Fix : Gear menu for bipods <br /><br />
"]];


player createDiaryRecord ["CL",["* 1.3.1.1","
6b594ba - zerty : Persitancy cleenup on mission end happening sooner <br />
97f56f9 - zerty : Fix buying to group <br />
0d5972e - zerty : SDV has repair hability <br />
0a0b990 - zerty : Regenerate hq on destruction while packed <br />
0a62bd6 - zerty : Parameter to disable rain <br />
fd055c8 - zerty : removing fatigue for AI leaders <br />
4b66aaf - zerty : Protecting wheels  from bad AI/player drivers <br />
c2588d8 - zerty : Removing some logging <br />
3c34ef8 - zerty : Some more zeus modules <br />
d3a190e - zerty : AI Teams capture and town activation <br />
265ede6 - zerty : THud icon in the interraction Menu <br />
d7f5e53 - zerty : Fix missing battery for CSAT <br />
3997cbc - zerty : Prevent push pull on static objects <br />
d948196 - zerty : Allowing push pull on all unlocked vehicles <br />
be08709 - zerty : Tring to limit lag in interraction menu <br />
a1e4cac - zerty : Fixing AI teams first part <br />
5b9de90 - zerty : Price change on the titans <br />
95119da - zerty : Fix for free gear in vehicles <br />
5aa9d69 - zerty : Fix for salvagers #54 luggage66#17 <br />
c6a8646 - zerty : Change in plane price, loggin fix <br />
2f46f0f - zerty : Small error in ART radar <br />
5358a25 - zerty : Longer rearm for heavy arty <br />
6704468 - zerty : Fixed manning vehicle with extra turrets (RHS) <br />
15efc70 - zerty : Additionnal brackets <br />
d385cc8 - zerty : Small error <br />
8ce2b47 - zerty : Longer rearm for Air, Increased service costs <br />
5c51bb9 - zerty : Trying to fix Marker/script leak from Art radar <br />
67d9893 - zerty : Changing object for mobile gear #45 <br />
f42e26e - zerty : Trying to add additionnal checks for #49 <br />
86f8e4c - zerty : Fix for #48 <br />
2112f66 - zerty : Fix for #47 <br />
f217ca3 - Zerty : Merge pull request #50 from luggage66/zerty <br />
4a527c6 - Donald Mull Jr : Fixed missing action menu items <br />
49743d6 - zerty : Small var problem with construction handle <br />
0e9084a - zerty : Small error on uav fuel limitation <br />
2643b6a - zerty : Small error on assembling handle <br />
40f1b04 - zerty : FSM for Dyn groups, removal of Player tasks <br />
dbb2570 - zerty : Fix for quick rearm #44 <br />
2508a48 - zerty : Renewing HQ handles on repair, client side #42 <br />
d1e816a - zerty : Disabling totally uav fuel limitation with parameter <br />
91a3ba7 - zerty : Revert 'BiS revive system '<br />
3cf1c83 - zerty : Fix for #40 <br />
28638b9 - zerty : BiS revive system <br />
67d0d66 - zerty : keep template if respawn on leader <br />
728ea68 - zerty : Somehing is fucked with uav fuel <br />
b42f3c3 - zerty : Offset fail <br />
ed74bde - zerty : Earplug and group in interraction menu <br />
286e08e - zerty : I am a noob <br />
fdb0b4d - zerty : putting tac glasses in lower <br />
"]];
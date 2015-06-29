/*
  # HEADER #
	Script: 		Client\Functions\Client_OnPurchaseDelegationReceived.sqf
	Alias:			CTI_CL_FNC_OnPurchaseDelegationReceived
	Description:	Triggered when the commander or another leading unit buy an entity to another one (delegation)
					Note this function is called automatically upon a delegated purchase by the "Client_OnPurchaseDelegationReceived" PVF
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[Number]: The purchase seed
    1	[String]: The classname
    2	[Group]: The unit which made the purchase order
    3	[Array]: The vehicle special info (lock, crew)
    4	[Object]: The factory

  # RETURNED VALUE #
	None

  # SYNTAX #
	[SEED, CLASSNAME, BUYER, INFORMATION, FACTORY] call CTI_CL_FNC_OnPurchaseDelegationReceived

  # DEPENDENCIES #


  # EXAMPLE #
	[_seed, _classname, group player, _veh_infos, _factory] call CTI_CL_FNC_OnPurchaseDelegationReceived
*/

_req_seed = _this select 0;
_req_classname = _this select 1;
_req_buyer = _this select 2;
_req_vehinfos = _this select 3;
_factory = _this select 4;

CTI_P_PurchaseRequests pushBack [_req_seed, _req_classname, _req_vehinfos, _factory, group player, false];
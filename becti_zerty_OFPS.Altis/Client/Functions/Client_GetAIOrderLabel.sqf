/*
  # HEADER #
	Script: 		Client\Functions\Client_GetAIOrderLabel.sqf
	Alias:			CTI_CL_FNC_GetAIOrderLabel
	Description:	Return the current order assigned from the Micro AI UI
					Note the orders are defined in:
					 - Common\Init\Init_CommonConstants.sqf: "ORDERS (PLAYER AI)"
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Integer]: The given order
	
  # RETURNED VALUE #
	[String]: The order label
	
  # SYNTAX #
	(AI MICRO ORDER) call CTI_CL_FNC_GetAIOrderLabel
	
  # EXAMPLE #
    (CTI_ORDER_CLIENT_TAKETOWNS) call CTI_CL_FNC_GetAIOrderLabel 
	  -> Will return "Take Towns"
*/

private ["_order"];

_order = _this;

switch (true) do {
	case (_order == CTI_ORDER_CLIENT_NONE): {"None"};
	case (_order == CTI_ORDER_CLIENT_TAKETOWNS): {"Take Towns"};
	case (_order in [CTI_ORDER_CLIENT_TAKETOWN, CTI_ORDER_CLIENT_TAKETOWN_AUTO]): {"Take Town"};
	case (_order == CTI_ORDER_CLIENT_TAKEHOLDTOWNS): {"Take Hold Towns"};
	case (_order in [CTI_ORDER_CLIENT_TAKEHOLDTOWN, CTI_ORDER_CLIENT_TAKEHOLDTOWN_AUTO]): {"Take Hold Town"};
	case (_order == CTI_ORDER_CLIENT_HOLDTOWNSBASES): {"Hold Towns/Base"};
	case (_order == CTI_ORDER_CLIENT_HOLDTOWNSBASE): {"Hold Town/Base"};
	case (_order == CTI_ORDER_CLIENT_SAD): {"Search and Destroy"};
	case (_order == CTI_ORDER_CLIENT_MOVE): {"Move"}; 
	case (_order == CTI_ORDER_CLIENT_PATROL): {"Patrol"}; 
	default {"Unknown"}
}
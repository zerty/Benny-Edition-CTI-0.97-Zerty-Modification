/*
  # HEADER #
	Script: 		Client\Functions\Client_GetOrderLabel.sqf
	Alias:			CTI_CL_FNC_GetOrderLabel
	Description:	Return an AI group current order's label
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013
	
  # PARAMETERS #
    0	[Integer]: The given order
	
  # RETURNED VALUE #
	[String]: The order label
	
  # SYNTAX #
	(AI ORDER) call CTI_CL_FNC_GetOrderLabel
	
  # EXAMPLE #
    (CTI_ORDER_TAKETOWNS) call CTI_CL_FNC_GetOrderLabel 
	  -> Will return "Take Towns"
*/

private ["_order"];

_order = _this;

switch (true) do {
	case (_order == CTI_ORDER_TAKETOWNS): {"Take Towns"};
	case (_order in [CTI_ORDER_TAKETOWN, CTI_ORDER_TAKETOWN_AUTO]): {"Take Town"};
	case (_order == CTI_ORDER_TAKEHOLDTOWNS): {"Take Hold Towns"};
	case (_order in [CTI_ORDER_TAKEHOLDTOWN, CTI_ORDER_TAKEHOLDTOWN_AUTO]): {"Take Hold Town"};
	case (_order == CTI_ORDER_HOLDTOWNSBASES): {"Hold Towns/Base"};
	case (_order == CTI_ORDER_HOLDTOWNSBASE): {"Hold Town/Base"};
	case (_order == CTI_ORDER_SAD): {"Search and Destroy"};
	case (_order == CTI_ORDER_MOVE): {"Move"}; 
	case (_order == CTI_ORDER_EMBARKCOMMANDVEH): {"Get In"}; 
	case (_order == CTI_ORDER_DISEMBARKCOMMANDVEH): {"Get Out"}; 
	case (_order == CTI_ORDER_EMBARKCARGOVEH): {"Get In (Cargo)"}; 
	case (_order == CTI_ORDER_DISEMBARKCARGOVEH): {"Get Out (Cargo)"}; 
	default {"Unknown"}
}
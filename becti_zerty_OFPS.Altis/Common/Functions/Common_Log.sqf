/*
  # HEADER #
	Script: 		Common\Functions\Common_Log.sqf
	Alias:			CTI_CO_FNC_Log
	Description:	Log an event into the RPT
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[String]: The nature of the event
    1	[String]: The origin of the event (the script/function)
    2	[String]: The content/message
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[TITLE, SOURCE, MESSAGE] call CTI_CO_FNC_Log
	
  # EXAMPLE #
   ["DEBUG", "Common\Functions\Common_Log.sqf", "McFly can't fly"] call CTI_CO_FNC_Log
*/

private ["_log_content", "_log_from", "_log_type"];

_log_type = _this select 0;
_log_from = _this select 1;
_log_content = _this select 2;

diag_log format["[CTI (%1)] [frameno:%2 | ticktime:%3 | fps:%4] [%5] %6", _log_type, diag_frameno, diag_tickTime, diag_fps, _log_from, _log_content]
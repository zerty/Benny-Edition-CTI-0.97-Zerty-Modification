
private ["_pos","_offset","_marker"];








  _enemy = switch (CTI_P_SideJoined) do
  {
  	case west: {east };
  	case east: {west };
    default {east};
  };

  _size=[0.7,0.7];
  _pos2=getMarkerPos "CTI_HELP";
  _offset2=CTI_MARKERS_TOWN_AREA_RANGE*2;


  _marker = createMarkerLocal ["cti_help_1", _pos2];
  _marker setMarkerShapeLocal "ELLIPSE";
  _marker setMarkerBrushLocal "SolidBorder";
  _marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE];
  _marker setMarkerColorLocal "ColorWhite";
  _marker setMarkerAlphaLocal 0.7;
  _pos2=[(_pos2 select 0),(_pos2 select 1),(_pos2 select 2)+_offset2/3];

  _marker = createMarkerLocal ["cti_help_10", _pos2];
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerSizeLocal [1,1];
  _marker setMarkerColorLocal "ColorWhite";
  _marker setMarkerAlphaLocal 0.7;
  _marker setMarkerTextLocal "Town available for capture (no IA spawned)";
  _pos2=[(_pos2 select 0),(_pos2 select 1)-_offset2,(_pos2 select 2)-_offset2/3];

  _marker = createMarkerLocal ["cti_help_2", _pos2];
  _marker setMarkerShapeLocal "ELLIPSE";
  _marker setMarkerBrushLocal "SolidBorder";
  _marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE];
  _marker setMarkerColorLocal "ColorGreen";
  _marker setMarkerAlphaLocal 0.7;

  _pos2=[(_pos2 select 0),(_pos2 select 1),(_pos2 select 2)+_offset2/3];

  	_marker = createMarkerLocal ["cti_help_20", _pos2];
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerSizeLocal [1,1];
  _marker setMarkerColorLocal "ColorGreen";
  _marker setMarkerAlphaLocal 0.7;
  _marker setMarkerTextLocal "Town Activated by your side - IA Present ";
  _pos2=[(_pos2 select 0),(_pos2 select 1)-_offset2,(_pos2 select 2)-_offset2/3];

  _marker = createMarkerLocal ["cti_help_3", _pos2];
  _marker setMarkerShapeLocal "ELLIPSE";
  _marker setMarkerBrushLocal "SolidBorder";
  _marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE];
  _marker setMarkerColorLocal  ( (CTI_P_SideJoined) call CTI_CO_FNC_GetSideColoration);
  _marker setMarkerAlphaLocal 0.7;

  _pos2=[(_pos2 select 0),(_pos2 select 1),(_pos2 select 2)+_offset2/3];

  	_marker = createMarkerLocal ["cti_help_30", _pos2];
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerSizeLocal [1,1];
  _marker setMarkerColorLocal ( (CTI_P_SideJoined) call CTI_CO_FNC_GetSideColoration);
  _marker setMarkerAlphaLocal 0.7;
  _marker setMarkerTextLocal "Town activated for your side (100% income)";
  _pos2=[(_pos2 select 0),(_pos2 select 1)-_offset2,(_pos2 select 2)-_offset2/3];


  _marker = createMarkerLocal ["cti_help_4", _pos2];
  _marker setMarkerShapeLocal "ELLIPSE";
  _marker setMarkerBrushLocal "Border";
  _marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE];
  _marker setMarkerColorLocal  "ColorYellow";
  _marker setMarkerAlphaLocal 0.7;

  _pos2=[(_pos2 select 0),(_pos2 select 1),(_pos2 select 2)+_offset2/3];

  	_marker = createMarkerLocal ["cti_help_40", _pos2];
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerSizeLocal [1,1];
  _marker setMarkerColorLocal  "ColorYellow";
  _marker setMarkerAlphaLocal 0.7;
  _marker setMarkerTextLocal "HALO Jump zones";
  _pos2=[(_pos2 select 0),(_pos2 select 1)-_offset2,(_pos2 select 2)-_offset2/3];

  _marker = createMarkerLocal ["cti_help_5", _pos2];
  _marker setMarkerShapeLocal "ELLIPSE";
  _marker setMarkerBrushLocal "SolidBorder";
  _marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE];
  _marker setMarkerColorLocal  "ColorBrown";
  _marker setMarkerAlphaLocal 0.7;

  _pos2=[(_pos2 select 0),(_pos2 select 1),(_pos2 select 2)+_offset2/3];

  	_marker = createMarkerLocal ["cti_help_50", _pos2];
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerSizeLocal [1,1];
  _marker setMarkerColorLocal  "ColorBrown";
  _marker setMarkerAlphaLocal 0.7;
  _marker setMarkerTextLocal "Base Areas of your side";

  _pos2=[(_pos2 select 0),(_pos2 select 1)-_offset2,(_pos2 select 2)-_offset2/3];
  _marker = createMarkerLocal ["cti_help_6", _pos2];
  _marker setMarkerShapeLocal "ELLIPSE";
  _marker setMarkerBrushLocal "SolidBorder";
  _marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE];
  _marker setMarkerColorLocal  ( (_enemy) call CTI_CO_FNC_GetSideColoration);
  _marker setMarkerAlphaLocal 0.7;

  _pos2=[(_pos2 select 0),(_pos2 select 1),(_pos2 select 2)+_offset2/3];

  	_marker = createMarkerLocal ["cti_help_60", _pos2];
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerSizeLocal [1,1];
  _marker setMarkerColorLocal  ( (_enemy) call CTI_CO_FNC_GetSideColoration);
  _marker setMarkerAlphaLocal 0.7;
  _marker setMarkerTextLocal "Enemy Base Areas";
  _pos2=[(_pos2 select 0),(_pos2 select 1)-_offset2,(_pos2 select 2)-_offset2/3];



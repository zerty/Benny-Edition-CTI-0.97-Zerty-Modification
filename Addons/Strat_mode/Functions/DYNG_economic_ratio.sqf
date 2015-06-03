_side=_this;

_ratio=1;
_min_ratio=0.1;
_delta_min_decay=1;
_delta_max_decay=5;
_west_count=0;
_east_count=0;
{_west_count=_west_count + count(_x select 5);true }count (["GetAllGroupsOfSide",[west]]call BIS_fnc_dynamicGroups);
{_east_count=_east_count + count(_x select 5);true }count (["GetAllGroupsOfSide",[east]]call BIS_fnc_dynamicGroups);

_delta=switch (_side) do {
    case west: {
    	(_west_count-_east_count)
    };
    case east: {
    	-(_west_count-_east_count)
    };
    default {
     	0
    };
};
_ratio=switch (true) do {

    case ((_delta > _delta_min_decay) && (_delta < _delta_max_decay)) : {
    	/* STATEMENT */
    };
    case (_delta >=  _delta_max_decay) : {
    	_min_ratio
    };

    default {
     	1
    };
};



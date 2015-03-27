class CfgNotifications {
	class CTI_TaskAssigned {
		title = "TASK ASSIGNED";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa";
		description = "%1";
		priority = 5;
		sound = "taskAssigned";
	};
	class CTI_TaskSucceeded: CTI_TaskAssigned {
		title = "TASK COMPLETED";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
		priority = 6;
		color[] = {0.7,1.0,0.3,1.0};
		sound = "taskSucceeded";
	};
	class CTI_TaskUpdated: CTI_TaskAssigned {
		title = "TASK UPDATED";
		priority = 4;
		sound = "taskUpdated";
	};
	class CTI_TaskFailed: CTI_TaskAssigned {
		title = "TASK FAILED";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
		priority = 6;
		color[] = {1.0,0.3,0.2,1.0};
		sound = "taskFailed";
	};
	class CTI_TaskCanceled: CTI_TaskAssigned {
		title = "TASK CANCELED";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_ca.paa";
		priority = 6;
		color[] = {0.7,0.7,0.7,1.0};
		sound = "taskCanceled";
	};
	class CTI_TaskCreated: CTI_TaskAssigned {
		title = "TASK CREATED";
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa";
		priority = 5;
		sound = "taskCreated";
	};
};
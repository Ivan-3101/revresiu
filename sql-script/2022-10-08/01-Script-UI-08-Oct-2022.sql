UPDATE ui.menustructuredesc SET vcaction = 'RT Window', vccontroller = 'WindowManagement', vcmini = 'WM', vcmenuname = 'RT Window' WHERE imenuid = 547;

UPDATE ui.menustructuredesc SET vcaction = 'RT Observation', vccontroller = 'ObservationManagement', vcmini = 'OM', vcmenuname = 'RT Observation' WHERE imenuid = 554;

UPDATE ui.menustructuredesc SET vcaction = 'Class', vccontroller = 'ClassManagement', vcmini = 'CM', vcmenuname = 'Class' WHERE imenuid = 521;

UPDATE ui.menustructuredesc SET vcaction = 'Decision', vccontroller = 'DecisionLevelManagement', vcmini = 'DLM', vcmenuname = 'Decision' WHERE imenuid = 522;

UPDATE ui.menustructuredesc SET vcaction = 'Rules', vccontroller = 'RuleManagement', vcmini = 'RM', vcmenuname = 'Rules' WHERE imenuid = 528;

UPDATE ui.menustructuredesc SET vcaction = 'List', vccontroller = 'ListManagement', vcmini = 'LM', vcmenuname = 'List' WHERE imenuid = 499;



UPDATE ui.menustructuredesc SET isortorder = 5 WHERE imenuid = 554;
UPDATE ui.menustructuredesc SET isortorder = 3 WHERE imenuid = 499;
UPDATE ui.menustructuredesc SET isortorder = 6 WHERE imenuid = 561;
UPDATE ui.menustructuredesc SET isortorder = 4 WHERE imenuid = 547;
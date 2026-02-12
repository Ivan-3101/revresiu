-- Parent Menu: AI & ML
INSERT INTO ui.menustructuredesc (
    imenuid, bcollapse, isortorder, vcmenuname, vcaction, vccontroller, vcstate, istatus, vcicon
) VALUES (
    604, true, 6, 'AI & ML', 'AI & ML', 'AI & ML', 'aiMlCollapse', 1, 'tim-icons icon-globe-2'
);

-- Level 1: ML Models (child of AI & ML)
INSERT INTO ui.menustructuredesc (
    imenuid, bcollapse, isortorder, vcmenuname, vcmini, vcpath, vcaction, vccontroller, vclayout, iparentmenu, istatus
) VALUES
(605, false, 0, 'ML Models', 'MM', '/ai-ml/ml-models', 'ML Models', 'ML Models', '/user', 604, 1),

-- Level 2: ML Model actions
(606, false, 0, 'Add Model', 'AM', '/ai-ml/ml-models/add-model', 'Add Model', 'Add Model', '/user', 605, 1),
(607, false, 1, 'Edit Model', 'EM', '/ai-ml/ml-models/edit-model', 'Edit Model', 'Edit Model', '/user', 605, 1),
(608, false, 2, 'Delete Model', 'DM', '/ai-ml/ml-models/delete-model', 'Delete Model', 'Delete Model', '/user', 605, 1),
(609, false, 3, 'Update Model', 'UM', '/ai-ml/ml-models/update-model', 'Update Model', 'Update Model', '/user', 605, 1),
(610, false, 4, 'View Model', 'VM', '/ai-ml/ml-models/view-model', 'View Model', 'View Model', '/user', 605, 1),
(611, false, 5, 'Approve Add Model', 'AAM', '/ai-ml/ml-models/approve-add-model', 'Approve Add Model', 'Approve Add Model', '/user', 605, 1),
(612, false, 6, 'Approve Edit Model', 'AEM', '/ai-ml/ml-models/approve-edit-model', 'Approve Edit Model', 'Approve Edit Model', '/user', 605, 1),
(613, false, 7, 'Approve Delete Model', 'ADM', '/ai-ml/ml-models/approve-delete-model', 'Approve Delete Model', 'Approve Delete Model', '/user', 605, 1);

-- Level 1: AI Agents (child of AI & ML)
INSERT INTO ui.menustructuredesc (
    imenuid, bcollapse, isortorder, vcmenuname, vcmini, vcpath, vcaction, vccontroller, vclayout, iparentmenu, istatus
) VALUES
(614, false, 1, 'AI Agents', 'AA', '/ai-ml/ai-agents', 'AI Agents', 'AI Agents', '/user', 604, 1),

-- Level 2: Agent actions
(615, false, 0, 'Add Agent', 'AA', '/ai-ml/ai-agents/add-agent', 'Add Agent', 'Add Agent', '/user', 614, 1),
(616, false, 1, 'View Agent', 'VA', '/ai-ml/ai-agents/view-agent', 'View Agent', 'View Agent', '/user', 614, 1),
(617, false, 2, 'Edit Agent', 'EA', '/ai-ml/ai-agents/edit-agent', 'Edit Agent', 'Edit Agent', '/user', 614, 1),
(618, false, 3, 'Delete Agent', 'DA', '/ai-ml/ai-agents/delete-agent', 'Delete Agent', 'Delete Agent', '/user', 614, 1),
(619, false, 4, 'Approve Add Agent', 'AAA', '/ai-ml/ai-agents/approve-add-agent', 'Approve Add Agent', 'Approve Add Agent', '/user', 614, 1),
(620, false, 5, 'Approve Edit Agent', 'AEA', '/ai-ml/ai-agents/approve-edit-agent', 'Approve Edit Agent', 'Approve Edit Agent', '/user', 614, 1),
(621, false, 6, 'Approve Delete Agent', 'ADA', '/ai-ml/ai-agents/approve-delete-agent', 'Approve Delete Agent', 'Approve Delete Agent', '/user', 614, 1);

-- Level 1: Chats (child of AI & ML)
INSERT INTO ui.menustructuredesc (
    imenuid, bcollapse, isortorder, vcmenuname, vcmini, vcpath, vcaction, vccontroller, vclayout, iparentmenu, istatus
) VALUES
(622, false, 2, 'Chats', 'CH', '/ai-ml/chats', 'Chats', 'Chats', '/user', 604, 1);

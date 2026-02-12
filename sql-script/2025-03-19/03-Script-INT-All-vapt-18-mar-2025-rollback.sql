-- Delete menu items for Decision Levels and Workflow
DELETE FROM ui.menustructuredesc WHERE imenuid IN (583, 584, 597, 598) AND iparentmenu = 522;

-- Delete menu items for Historic Profile Management (Custom Aggregation)
DELETE FROM ui.menustructuredesc WHERE imenuid IN (585, 586, 587, 588) AND iparentmenu = 561;

-- Delete menu items for Email Scheduler
DELETE FROM ui.menustructuredesc WHERE imenuid IN (589, 590, 591, 592) AND iparentmenu = 576;

-- Delete menu items for Observation Management
DELETE FROM ui.menustructuredesc WHERE imenuid = 600 AND iparentmenu = 554;

-- Delete menu items for Metadata Master Management
DELETE FROM ui.menustructuredesc WHERE imenuid IN (593, 594, 595, 596) AND iparentmenu = 561;


UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= true, bpublish = true::boolean, bdelete = true::boolean, badd = true::boolean WHERE
imenuid = 501 and itenantid in(7,6,20,24) and iroleid=5;
UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= true, bpublish = true::boolean, bdelete = true::boolean, badd = true::boolean WHERE
imenuid = 482 and itenantid in(7,6,20,24) and iroleid=5;


UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= true, bpublish = true::boolean, bdelete = true::boolean, badd = true::boolean WHERE
imenuid in (501,482) and itenantid in(5) and iroleid=5;

UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= true, bpublish = true::boolean, bdelete = true::boolean, badd = true::boolean WHERE
imenuid in (501,482) and itenantid in(9,19) and iroleid=5;

UPDATE ui.rolemenuaccessmap SET
bview = true::boolean, bedit= true, bpublish = true::boolean, bdelete = true::boolean, badd = true::boolean WHERE
imenuid = 482 and itenantid in(16, 17,21 ,22,23, 8) and iroleid=5;

UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= true, bpublish = true::boolean, bdelete = true::boolean, badd = true::boolean WHERE
imenuid = 482 and itenantid in(16, 17,21 ,22,23,9,19, 8) and iroleid in (7,6, 8,9);

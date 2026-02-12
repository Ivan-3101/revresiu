INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'583'::integer, true::boolean, '1'::integer, 'AddDecision'::character varying, 'AddDecision'::character varying, '/user'::character varying, 'Add Decision'::character varying, 'AD'::character varying, '/masters/decision-levels-and-workflow/add-decision'::character varying, '522'::integer, '1'::integer)
 returning imenuid;																			
																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'585'::integer, true::boolean, '1'::integer, 'AddCustomAggregation'::character varying, 'AddCustomAggregation'::character varying, '/user'::character varying, 'Add Custom Aggregation'::character varying, 'ACA'::character varying, '/masters/historic-profile-management/add-custom-aggregation'::character varying, '561'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'586'::integer, true::boolean, '1'::integer, 'DeleteCustomAggregation'::character varying, 'DeleteCustomAggregation'::character varying, '/user'::character varying, 'Delete Custom Aggregation'::character varying, 'DCA'::character varying, '/masters/historic-profile-management/delete-custom-aggregation'::character varying, '561'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'587'::integer, true::boolean, '1'::integer, 'ApproveCustomAggregation'::character varying, 'ApproveCustomAggregation'::character varying, '/user'::character varying, 'Approve Custom Aggregation'::character varying, 'ACA'::character varying, '/masters/historic-profile-management/approve-custom-aggregation'::character varying, '561'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'588'::integer, true::boolean, '1'::integer, 'ViewCustomAggregation'::character varying, 'ViewCustomAggregation'::character varying, '/user'::character varying, 'View Custom Aggregation'::character varying, 'VCA'::character varying, '/masters/historic-profile-management/view-custom-aggregation'::character varying, '561'::integer, '1'::integer)
 returning imenuid;																			
																			
																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'589'::integer, true::boolean, '1'::integer, 'AddEmailSchedular'::character varying, 'AddEmailSchedular'::character varying, '/user'::character varying, 'Add Email Schedular'::character varying, 'AES'::character varying, '/add-email-scheduler'::character varying, '576'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'590'::integer, true::boolean, '1'::integer, 'ViewEmailSchedular'::character varying, 'ViewEmailSchedular'::character varying, '/user'::character varying, 'View Email Schedular'::character varying, 'VES'::character varying, '/view-email-scheduler'::character varying, '576'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'591'::integer, true::boolean, '1'::integer, 'EditEmailSchedular'::character varying, 'EditEmailSchedular'::character varying, '/user'::character varying, 'Edit Email Schedular'::character varying, 'EES'::character varying, '/edit-email-scheduler'::character varying, '576'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'592'::integer, true::boolean, '1'::integer, 'DeleteEmailSchedular'::character varying, 'DeleteEmailSchedular'::character varying, '/user'::character varying, 'Delete Email Schedular'::character varying, 'DES'::character varying, '/delete-email-scheduler'::character varying, '576'::integer, '1'::integer)
 returning imenuid;																			
																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'584'::integer, true::boolean, '1'::integer, 'ApproveDecision'::character varying, 'ApproveDecision'::character varying, '/user'::character varying, 'Approve Decision'::character varying, 'AD'::character varying, '/masters/decision-levels-and-workflow/approve-add-decision'::character varying, '522'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'597'::integer, true::boolean, '1'::integer, 'ApproveEditDecision'::character varying, 'ApproveEditDecision'::character varying, '/user'::character varying, 'Approve Edit Decision'::character varying, 'AED'::character varying, '/masters/decision-levels-and-workflow/approve-edit-decision'::character varying, '522'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'598'::integer, true::boolean, '1'::integer, 'ApproveDeleteDecision'::character varying, 'ApproveDeleteDecision'::character varying, '/user'::character varying, 'Approve Delete Decision'::character varying, 'ADD'::character varying, '/masters/decision-levels-and-workflow/approve-delete-decision'::character varying, '522'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'600'::integer, true::boolean, '1'::integer, 'ApproveEditObservation'::character varying, 'ApproveEditObservation'::character varying, '/user'::character varying, 'Approve Edit Observation'::character varying, 'AE0'::character varying, '/masters/observation-management/approve-edit-observation'::character varying, '554'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'593'::integer, true::boolean, '1'::integer, 'AddMetadataMaster'::character varying, 'AddMetadataMaster'::character varying, '/user'::character varying, 'Add metadata master'::character varying, 'AMM'::character varying, '/masters/metadata-master-management/add-metadata-master'::character varying, '561'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'594'::integer, true::boolean, '1'::integer, 'ViewMetadataMaster'::character varying, 'ViewMetadataMaster'::character varying, '/user'::character varying, 'View metadata master'::character varying, 'VMM'::character varying, '/masters/metadata-master-management/view-metadata-master'::character varying, '561'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'595'::integer, true::boolean, '1'::integer, 'DeleteMetadataMaster'::character varying, 'DeleteMetadataMaster'::character varying, '/user'::character varying, 'Delete metadata master'::character varying, 'DMM'::character varying, '/masters/metadata-master-management/delete-metadata-master'::character varying, '561'::integer, '1'::integer)
 returning imenuid;																			
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'596'::integer, true::boolean, '1'::integer, 'ApproveMetadataMaster'::character varying, 'ApproveMetadataMaster'::character varying, '/user'::character varying, 'Approve metadata master'::character varying, 'AMM'::character varying, '/masters/metadata-master-management/approve-metadata-master'::character varying, '561'::integer, '1'::integer)
 returning imenuid;																			

---vapt
--42c
UPDATE ui.rolemenuaccessmap SET
bview = true::boolean, bpublish = false::boolean, bdelete = false::boolean, badd = false::boolean WHERE
imenuid = 482 AND iroleid=5 and itenantid = 6;

UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= false,  bpublish = false::boolean, bdelete = false::boolean, badd = false::boolean WHERE
imenuid = 501 AND iroleid=5 and itenantid = 6;

UPDATE ui.rolemenuaccessmap SET
bview = true::boolean, bpublish = false::boolean, bdelete = false::boolean, badd = false::boolean WHERE
imenuid = 482 AND iroleid=5 and itenantid = 7;

UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= false, bpublish = false::boolean, bdelete = false::boolean, badd = false::boolean WHERE
imenuid = 501 AND iroleid=5 and itenantid = 7;

UPDATE ui.rolemenuaccessmap SET
bview = true::boolean, bpublish = false::boolean, bdelete = false::boolean, badd = false::boolean WHERE
imenuid = 482 AND iroleid=5 and itenantid = 20;

UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= false, bpublish = false::boolean, bdelete = false::boolean, badd = false::boolean WHERE
imenuid = 501 AND iroleid=5 and itenantid = 20;

UPDATE ui.rolemenuaccessmap SET
bview = true::boolean, bpublish = false::boolean, bdelete = false::boolean, badd = false::boolean WHERE
imenuid = 482 AND iroleid=5 and itenantid = 24;

UPDATE ui.rolemenuaccessmap SET
bview = false::boolean, bedit= false, bpublish = false::boolean, bdelete = false::boolean, badd = false::boolean WHERE
imenuid = 501 AND iroleid=5 and itenantid = 24;

--epifi
UPDATE ui.rolemenuaccessmap SET
bpublish = false::boolean, bedit = false::boolean, bdelete = false::boolean, badd = false::boolean, bview=false WHERE
imenuid = 482 AND iroleid=5 and itenantid = 5;

UPDATE ui.rolemenuaccessmap SET
bpublish = false::boolean, bedit = false::boolean, bdelete = false::boolean, badd = false::boolean, bview=false  WHERE
imenuid = 501 AND iroleid=5 and itenantid = 5;

--yb
UPDATE ui.rolemenuaccessmap SET
bapprove=false, bpublish = false::boolean, bedit = false::boolean, bdelete = false::boolean, badd = false::boolean, bview=false WHERE
imenuid in ( 501, 482) AND iroleid in (7,6, 8,9)  and itenantid in (16, 17,21 ,22,23,9,19, 8);

UPDATE ui.rolemenuaccessmap SET
bview= true , bedit=true , bpublish = true::boolean WHERE
imenuid in (482) AND iroleid in (5)  and itenantid in(19);

UPDATE ui.rolemenuaccessmap SET
bapprove=false, bpublish = false::boolean, bedit = false::boolean, bdelete = false::boolean, badd = false::boolean, bview=false WHERE
imenuid in (501) AND iroleid in (5)  and itenantid in(16, 17,21 ,22,23,9,19, 8);


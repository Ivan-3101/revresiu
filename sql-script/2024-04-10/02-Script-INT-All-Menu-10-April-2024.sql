INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'580'::integer, false::boolean, '3'::integer, 'UAMReports'::character varying, 'UAMReports'::character varying, '/user'::character varying, 'UAM Reports'::character varying, 'UR'::character varying, '/admin/uam-reports'::character varying, '482'::integer, '1'::integer)
 returning imenuid;
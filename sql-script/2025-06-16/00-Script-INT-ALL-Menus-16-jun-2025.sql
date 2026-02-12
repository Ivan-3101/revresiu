----------all
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'601'::integer, false::boolean, '1'::integer, 'PartyDashboardDL'::character varying, 'PartyDashboardDL'::character varying, '/user'::character varying, 'Party Dashboard - DL'::character varying, 'PDO'::character varying, '/analytics/party-dashboard-dl'::character varying, '478'::integer, '1'::integer)
 returning imenuid;

 
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'603'::integer, false::boolean, '2'::integer, 'TransactionProfileDL'::character varying, 'TransactionProfileDL'::character varying, '/user'::character varying, 'Transaction Profile - DL'::character varying, 'TP'::character varying, '/analytics/transaction-profile-dashboard-dl'::character varying, '478'::integer, '1'::integer)
 returning imenuid;


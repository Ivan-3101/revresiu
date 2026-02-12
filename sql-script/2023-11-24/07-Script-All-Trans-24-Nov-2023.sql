UPDATE ui.dashboardquery SET
vcfilterparametersjson = '{"DateRange" : null, "simid":null, "runid" : null, "dscore":null, "simscore": null, "limit":null }'::text, vcdashboardquery = 'SELECT * from sim.analyze_sim(:runid, :simid, :StartDate, :EndDate,  :dscore, :simscore, :limit);'::text WHERE
idashboardqueryid = 70;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'135'::integer, 'dscore'::character varying, 'String'::character varying, '70'::integer)
 returning idashboardparameterid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'136'::integer, 'simscore'::character varying, 'String'::character varying, '70'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'137'::integer, 'limit'::character varying, 'Integer'::character varying, '70'::integer)
 returning idashboardparameterid;
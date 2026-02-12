INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (26, false, NULL, 'SELECT  adm3, icityid, true FROM masters.cities;');

UPDATE ui.dashboardquery SET vcfilterparametersjson='{"Date" : null, "LocationAddress" : null}', vcdashboardquery='select adm3 as "District",b.* from profiles.sp_getdatalocation_c(:Date, :LocationAddress)b, masters.cities where cities.icityid= b."location.ilocationid"' WHERE idashboardqueryid=10;

INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (17, 'LocationAddress', 4, 1, 'Select', NULL, 26, 'Location Address');

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (22, 'LocationAddress', 'Integer', 10);
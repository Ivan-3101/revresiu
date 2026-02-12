alter table if exists ui.dashboard
       add column imenustructuredesc integer;

alter table if exists ui.dashboardquery
       add column imenustructuredesc integer;

alter table if exists ui.dashboardresultset
       add column imenustructuredesc integer;

alter table if exists ui.dashboard
       add constraint FK27ij33v98onpg9c2rbiaa02sq
       foreign key (imenustructuredesc)
       references ui.menustructuredesc;

alter table if exists ui.dashboardquery
       add constraint FKtp0477ne8ih81ighf91p0ob2k
       foreign key (imenustructuredesc)
       references ui.menustructuredesc;

alter table if exists ui.dashboardresultset
       add constraint FKoecyu0g05cgp3vlxbvhfgyp5j
       foreign key (imenustructuredesc)
       references ui.menustructuredesc;

UPDATE ui.dashboard SET
imenustructuredesc = '510'::integer WHERE
idashboardid = 21;


UPDATE ui.dashboard SET
imenustructuredesc = '510'::integer WHERE
idashboardid = 17;

UPDATE ui.dashboard SET
imenustructuredesc = '510'::integer WHERE
idashboardid = 16;


UPDATE ui.dashboard SET
imenustructuredesc = '510'::integer WHERE
idashboardid = 13;


UPDATE ui.dashboard SET
imenustructuredesc = '510'::integer WHERE
idashboardid = 12;


UPDATE ui.dashboard SET
imenustructuredesc = '510'::integer WHERE
idashboardid = 11;


UPDATE ui.dashboard SET
imenustructuredesc = '536'::integer WHERE
idashboardid = 23;

UPDATE ui.dashboard SET
imenustructuredesc = '536'::integer WHERE
idashboardid = 22;


UPDATE ui.dashboard SET
imenustructuredesc = '536'::integer WHERE
idashboardid = 20;


UPDATE ui.dashboard SET
imenustructuredesc = '536'::integer WHERE
idashboardid = 19;

UPDATE ui.dashboard SET
imenustructuredesc = '536'::integer WHERE
idashboardid = 18;


UPDATE ui.dashboardresultset
SET imenustructuredesc =(select imenustructuredesc from ui.dashboard where idashboardid= dashboardresultset.idashboardid) ;

UPDATE ui.dashboardresultset SET
imenustructuredesc = '574'::integer WHERE
idashboardresultsetid = 32;

UPDATE ui.dashboardresultset SET
imenustructuredesc = '509'::integer WHERE
idashboardresultsetid = 31;

UPDATE ui.dashboardresultset SET
imenustructuredesc = '507'::integer WHERE
idashboardresultsetid = 25;

UPDATE ui.dashboardresultset SET
imenustructuredesc = '508'::integer WHERE
idashboardresultsetid = 22;

UPDATE ui.dashboardquery
SET imenustructuredesc =(select imenustructuredesc from ui.dashboardresultset where
						 idashboardqueryid = dashboardquery.idashboardqueryid) ;

UPDATE ui.dashboardquery SET
imenustructuredesc = '507'::integer WHERE
idashboardqueryid = 56;


UPDATE ui.dashboardquery SET
imenustructuredesc = '509'::integer WHERE
idashboardqueryid = 68;

UPDATE ui.dashboardquery SET
imenustructuredesc = '510'::integer WHERE
idashboardqueryid = 74;


UPDATE ui.dashboardresultset SET
imenustructuredesc = '508'::integer WHERE
idashboardresultsetid = 31;


UPDATE ui.dashboardresultset SET
imenustructuredesc = '494'::integer WHERE
idashboardresultsetid = 22;
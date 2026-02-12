UPDATE ui.dashboardquery
SET vcdashboardquery='select vcrulename as "Rule", dtdate as "Time Stamp", sumday as "Day-Sum", sumweek as "Week-Sum", summonth as "Month-Sum" from(
SELECT a.iruleid,r.vcrulename, a.dtdate,
       sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
       AS sumday,
  sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
       AS sumweek,
  sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 30 PRECEDING AND CURRENT ROW)
       AS summonth
       FROM (
select x.iruleid,dtcreateddate as dtdate,sum(CASE WHEN bpassed is null THEN 0 else case when bpassed then 0 else 1 end END) cntrule from
			 (
				select iruleid,dtcreateddate from masters.rules r,
              (SELECT cast(generate_series(min(dtcreateddatetime), max(dtcreateddatetime), ''1d'') as date) AS dtcreateddate
              FROM   transactions.livedecisiondetails) b
               ) x
           LEFT  JOIN
			 transactions.livedecisiondetails d ON dtcreateddate =cast(dtcreateddatetime as date) and x.iruleid=d.iruleid
group by x.iruleid,x.dtcreateddate  order by x.iruleid,dtcreateddate) a, masters.rules r
where r.iruleid=a.iruleid )b where dtdate=:Date'
WHERE idashboardqueryid=12;

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (16, false, NULL,
        'select dtTrxnTime as "Time" from transactions.vw_LiveTrans order by dtTrxnTime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (17, false, NULL, 'select tdate from profiles.vpa where bside=false order by tdate desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (18, false, NULL, 'select tdate from profiles.vpa where bside=true order by tdate desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (19, false, NULL, 'select tdate from profiles.location order by tdate desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (20, false, NULL, 'select tdate from profiles.mcc order by tdate desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (21, false, NULL,
        'select cast(dtcreateddatetime as date) from transactions.livedecisiondetails where bpassed=false order by dtcreateddatetime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (22, false, NULL,
        'select dtentrydatetime from transactions.live_clientipaddresses order by dtentrydatetime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (23, false, NULL,
        'select dtentrydatetime from transactions.live_clientkeystrokedynamics order by dtentrydatetime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery)
VALUES (24, false, NULL,
        'select dtentrydatetime from transactions.live_fingerprints order by dtentrydatetime desc limit 1');

UPDATE ui.dashboardquery SET vcfilterparametersjson='{"DateRange" : null}' WHERE idashboardqueryid=7;
UPDATE ui.dashboardquery SET vcfilterparametersjson='{"DateRange" : null}' WHERE idashboardqueryid=13;
UPDATE ui.dashboardquery SET vcfilterparametersjson='{"DateRange" : null}' WHERE idashboardqueryid=14;
UPDATE ui.dashboardquery SET vcfilterparametersjson='{"DateRange" : null}' WHERE idashboardqueryid=15;



ALTER TABLE ui.dashboardqueryparameters
    RENAME COLUMN iperspectiveparameterid TO idashboardparameterid;

UPDATE ui.dashboardqueryparameters
SET vcparametername='DateRange', vcparametertype='DateRange'
WHERE idashboardparameterid=6;

UPDATE ui.dashboardqueryparameters
SET vcparametername='DateRange', vcparametertype='DateRange'
WHERE idashboardparameterid=13;

UPDATE ui.dashboardqueryparameters
SET vcparametername='DateRange', vcparametertype='DateRange'
WHERE idashboardparameterid=15;

UPDATE ui.dashboardqueryparameters
SET vcparametername='DateRange', vcparametertype='DateRange'
WHERE idashboardparameterid=17;

DELETE
FROM ui.dashboardqueryparameters
WHERE idashboardparameterid = 7;

DELETE
FROM ui.dashboardqueryparameters
WHERE idashboardparameterid = 14;

DELETE
FROM ui.dashboardqueryparameters
WHERE idashboardparameterid = 16;

DELETE
FROM ui.dashboardqueryparameters
WHERE idashboardparameterid = 18;

ALTER TABLE ui.dashboardfilters
DROP
CONSTRAINT fk3suw71dnuk468jpwso0kxn8c9;

ALTER TABLE ui.dashboardfilters
DROP
COLUMN idashboardqueryid;

ALTER TABLE ui.dashboardfilters
    ADD COLUMN idashboardqueryidfordefaultvalue integer,
ADD CONSTRAINT fk4ms029lkxx6aabiyocd954e8c FOREIGN KEY (idashboardqueryidfordefaultvalue)
        REFERENCES ui.dashboardquery (idashboardqueryid) MATCH SIMPLE
        ON
UPDATE NO ACTION
ON
DELETE
NO ACTION,

ADD COLUMN idashboardqueryidforoptions integer,
ADD CONSTRAINT fkepk8cjfxyeeh7ra5b9nh5u4vd FOREIGN KEY (idashboardqueryidforoptions)
        REFERENCES ui.dashboardquery (idashboardqueryid) MATCH SIMPLE
        ON
UPDATE NO ACTION
ON
DELETE
NO ACTION;

UPDATE ui.dashboardfilters
SET vcdashboardfiltername='DateRange', vcdashboardfiltertype='DateRangePicker', idashboardqueryidfordefaultvalue=16
WHERE idashboardfilterid =1;

UPDATE ui.dashboardfilters
SET vcdashboardfiltername='DateRange', vcdashboardfiltertype='DateRangePicker', idashboardqueryidfordefaultvalue=22
WHERE idashboardfilterid =8;

UPDATE ui.dashboardfilters
SET vcdashboardfiltername='DateRange', vcdashboardfiltertype='DateRangePicker', idashboardqueryidfordefaultvalue=24
WHERE idashboardfilterid =10;

UPDATE ui.dashboardfilters
SET vcdashboardfiltername='DateRange', vcdashboardfiltertype='DateRangePicker', idashboardqueryidfordefaultvalue=23
WHERE idashboardfilterid =12;

UPDATE ui.dashboardfilters
SET idashboardqueryidfordefaultvalue=17
WHERE idashboardfilterid = 3;

UPDATE ui.dashboardfilters
SET idashboardqueryidfordefaultvalue=18
WHERE idashboardfilterid = 4;

UPDATE ui.dashboardfilters
SET idashboardqueryidfordefaultvalue=19
WHERE idashboardfilterid = 5;

UPDATE ui.dashboardfilters
SET idashboardqueryidfordefaultvalue=20
WHERE idashboardfilterid = 6;

UPDATE ui.dashboardfilters
SET idashboardqueryidfordefaultvalue=21
WHERE idashboardfilterid = 7;

DELETE
FROM ui.dashboardfilters
WHERE idashboardfilterid = 2;
DELETE
FROM ui.dashboardfilters
WHERE idashboardfilterid = 9;
DELETE
FROM ui.dashboardfilters
WHERE idashboardfilterid = 11;
DELETE
FROM ui.dashboardfilters
WHERE idashboardfilterid = 13;


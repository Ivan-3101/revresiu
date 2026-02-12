CREATE OR REPLACE FUNCTION profiles.fngetfilter(
	tablename character varying,
	bside boolean)
    RETURNS TABLE(name character varying, id integer, b boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN

        IF tablename = 'cust' THEN
            return query  select vcexternalcustid, icustomerid, true from masters.customers;
        END IF;
		IF tablename = 'cust' THEN
            return query  select vcexternalcustid, icustomerid, true from masters.customers;
        END IF;
    END;
$BODY$;



CREATE TABLE ui.dashboard (
    idashboardid integer NOT NULL,
    vcdashboardname character varying(255),
    bactive boolean,
    bdelete boolean
);

CREATE SEQUENCE ui.dashboard_idashboardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ONLY ui.dashboard ALTER COLUMN idashboardid SET DEFAULT nextval('ui.dashboard_idashboardid_seq'::regclass);


SELECT pg_catalog.setval('ui.dashboard_idashboardid_seq', 1, false);

ALTER TABLE ONLY ui.dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (idashboardid);

CREATE TABLE ui.dashboardfilters (
    idashboardfilterid integer NOT NULL,
    vcdashboardfiltername character varying(255),
    idashboardid integer,
    ifilterorder integer,
    idashboardqueryid integer
);

CREATE SEQUENCE ui.dashboardfilters_idashboardfilterid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ONLY ui.dashboardfilters ALTER COLUMN idashboardfilterid SET DEFAULT nextval('ui.dashboardfilters_idashboardfilterid_seq'::regclass);


ALTER TABLE ONLY ui.dashboardfilters
    ADD CONSTRAINT dashboardfilters_pkey PRIMARY KEY (idashboardfilterid);



ALTER TABLE ONLY ui.dashboardfilters
    ADD CONSTRAINT fksa64lowii6subos942fmvk1i FOREIGN KEY (idashboardid) REFERENCES ui.dashboard(idashboardid);



CREATE TABLE ui.dashboardquery (
    idashboardqueryid integer NOT NULL,
    bparametersrequired boolean,
    vcfilterparametersjson text,
    vcdashboardquery text
);

CREATE SEQUENCE ui.dashboardquery_idashboardqueryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ONLY ui.dashboardquery ALTER COLUMN idashboardqueryid SET DEFAULT nextval('ui.dashboardquery_idashboardqueryid_seq'::regclass);

ALTER TABLE ONLY ui.dashboardquery
    ADD CONSTRAINT dashboardquery_pkey PRIMARY KEY (idashboardqueryid);


ALTER TABLE ONLY ui.dashboardfilters
    ADD CONSTRAINT fk3suw71dnuk468jpwso0kxn8c9 FOREIGN KEY (idashboardqueryid) REFERENCES ui.dashboardquery(idashboardqueryid);


CREATE TABLE ui.dashboardqueryparameters (
    iperspectiveparameterid integer NOT NULL,
    vcparametername character varying(255),
    vcparametertype character varying(255),
    idashboardqueryid integer
);

CREATE SEQUENCE ui.dashboardqueryparameters_iperspectiveparameterid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ONLY ui.dashboardqueryparameters ALTER COLUMN iperspectiveparameterid SET DEFAULT nextval('ui.dashboardqueryparameters_iperspectiveparameterid_seq'::regclass);

ALTER TABLE ONLY ui.dashboardqueryparameters
    ADD CONSTRAINT dashboardqueryparameters_pkey PRIMARY KEY (iperspectiveparameterid);


ALTER TABLE ONLY ui.dashboardqueryparameters
    ADD CONSTRAINT fkmtuyi08ep7lacubjcq9hqnc4n FOREIGN KEY (idashboardqueryid) REFERENCES ui.dashboardquery(idashboardqueryid);



CREATE TABLE ui.dashboardresultset (
    idashboardresultsetid integer NOT NULL,
    vcdashboardresultsetlayout text,
    vcdashboardresultsetname character varying(255),
    idashboardid integer,
    vcdashboardresultsetcolumnjson text,
    iresultsetorder integer,
    idashboardqueryid integer
);


CREATE SEQUENCE ui.dashboardresultset_idashboardresultsetid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER TABLE ONLY ui.dashboardresultset ALTER COLUMN idashboardresultsetid SET DEFAULT nextval('ui.dashboardresultset_idashboardresultsetid_seq'::regclass);


ALTER TABLE ONLY ui.dashboardresultset
    ADD CONSTRAINT dashboardresultset_pkey PRIMARY KEY (idashboardresultsetid);



ALTER TABLE ONLY ui.dashboardresultset
    ADD CONSTRAINT fkgnbyyvgvbmksuj6u4160upqmh FOREIGN KEY (idashboardid) REFERENCES ui.dashboard(idashboardid);


ALTER TABLE ONLY ui.dashboardresultset
    ADD CONSTRAINT fkiqau23o4f4yu8cf9abf7m81v6 FOREIGN KEY (idashboardqueryid) REFERENCES ui.dashboardquery(idashboardqueryid);



-- INSERT in dashboard 

INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (1, 'Profile Dashboard', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (2, 'Live Trans', true, false);


-- INSERT in dashboardquery 

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (1, false, NULL, 'SELECT DISTINCT  REPLACE(REPLACE(SPLIT_PART(vcpath,''.'',1),''['',''''),'']'',''''), false  FROM profiles.metadata
');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (3, false, NULL, 'SELECT DISTINCT  REPLACE(REPLACE(SPLIT_PART(vcpath,''.'',1),''['',''''),'']'',''''), false  FROM profiles.metadata
');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (6, false, NULL, 'SELECT icustomerid,velocity ->> ''d05_txn_count'' as "d05_txn_count"
,velocity ->> ''d05_txn_value'' as "d05_txn_value"
,velocity ->> ''d28_txn_count'' as "d28_txn_count"
,velocity ->> ''d28_txn_value'' as "d28_txn_value" FROM profiles.cust where icustomerid=51');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (2, true, '{"Label1" : null}', 'SELECT DISTINCT bside, true from profiles.:Label1
');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (4, true, '{"Label1" : null , "Label2" : null}', 'SELECT * from profiles.fngetFilter(:Label1,:Label2)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (5, true, '{"Label1" : null , "Label3" : null}', 'SELECT icustomerid,velocity ->> ''d05_txn_count'' as "d05_txn_count"
,velocity ->> ''d05_txn_value'' as "d05_txn_value"
,velocity ->> ''d28_txn_count'' as "d28_txn_count"
,velocity ->> ''d28_txn_value'' as "d28_txn_value" FROM profiles.:Label1 where icustomerid=:Label3');

-- INSERT in dashboardqueryparameters 

INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (1, 'Label1', 'TableName', 2);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (2, 'Label1', 'String', 4);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (3, 'Label2', 'Boolean', 4);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (5, 'Label1', 'TableName', 5);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (4, 'Label3', 'Integer', 5);


-- INSERT in dashboardfilters 

INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid) VALUES (1, 'Label1', 1, 0, 1);
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid) VALUES (3, 'Label3', 2, 0, 3);
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid) VALUES (4, 'Label3', 1, 2, 4);
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid) VALUES (2, 'Label2', 1, 1, 2);


-- INSERT in dashboardresultset 

INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (2, '{
   "sizes":[
      1
   ],
   "detail":{
      "main":{
         "children":[
            {
               "type":"tab-area",
               "widgets":[
                  "PERSPECTIVE_GENERATED_ID_2"
               ],
               "currentIndex":0
            }
         ],
         "sizes":[
            1
         ]
      }
   },
   "viewers":{
      "PERSPECTIVE_GENERATED_ID_2":{
         "selectable":true,
         "plugin":"datagrid",
         "columns":[
            "id",
            "day 5 txn count",
            "day 5 txn value",
            "day 28 txn count",
            "day 28 txn value"
         ],
         "editable":false,
         "master":true,
         "name":"Live Transaction",
         "table":"livetransaction",
         "linked":false
      }
   }
}', 'livetransaction', 1, ' {
        "id":[],
        "day 5 txn count":[],
        "day 5 txn value":[],
        "day 28 txn count":[],
        "day 28 txn value":[]
    }', NULL, 6);
INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (1, '{
   "sizes":[
      1
   ],
   "detail":{
      "main":{
         "children":[
            {
               "type":"tab-area",
               "widgets":[
                  "PERSPECTIVE_GENERATED_ID_2"
               ],
               "currentIndex":0
            }
         ],
         "sizes":[
            1
         ]
      }
   },
   "viewers":{
      "PERSPECTIVE_GENERATED_ID_2":{
         "selectable":true,
         "plugin":"datagrid",
         "columns":[
            "id",
            "day 5 txn count",
            "day 5 txn value",
            "day 28 txn count",
            "day 28 txn value"
         ],
         "editable":false,
         "master":true,
         "name":"Live Transaction",
         "table":"livetransaction",
         "linked":false
      }
   }
}', 'livetransaction', 1, ' {
        "id":[],
        "day 5 txn count":[],
        "day 5 txn value":[],
        "day 28 txn count":[],
        "day 28 txn value":[]
    }', NULL, 5);




-- delete unused group


DELETE FROM ui.usergroupmapaudit 

WHERE igroupid  < 1020;

DELETE FROM ui.groupdesc 

WHERE igroupid  < 1020;


-- delete unused roles

DELETE FROM ui.rolemenuaccessmap 

WHERE iroleid   IN (2, 3, 4);

DELETE FROM ui.userrolemap 

WHERE iroleid   IN (2, 3, 4);

DELETE FROM ui.tempuserrolemapaudit 

WHERE iroleid   IN (2, 3, 4);

DELETE FROM ui.tempuserrolemap 

WHERE iroleid   IN (2, 3, 4);

DELETE FROM ui.userrolemapaudit 

WHERE user_permissions_iroleid   IN (2, 3, 4);

DELETE FROM ui.roledesc
	WHERE iroleid   IN (2, 3, 4);

UPDATE ui.groupdesc
	SET vcgroupid='riskanalyst', vcgroupname='Risk Analyst', vcgrouptype='WORKFLOW'
	WHERE igroupid=1020;
	
UPDATE ui.groupdesc
	SET vcgroupid='risksupervisor', vcgroupname='Risk Supervisor', vcgrouptype='WORKFLOW'
	WHERE igroupid=1021;

UPDATE ui.webuser
	SET vcusername='cadmin', vcfirstname='cadmin', vclastname='cadmin', vcemailid='cadmin@dronapay.com'
	WHERE iuserid=1;
	
UPDATE ui.webuser
	SET vcusername='madmin', vcfirstname='madmin', vclastname='madmin', vcemailid='madmin@dronapay.com'
	WHERE iuserid=2;




INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (510, false, NULL, NULL, 8, 'GenericDashboard', 'GenericDashboard', NULL, NULL, '/user', 'Generic Dashboard', 'GD', '/analytics/generic-dashboard', NULL, NULL, NULL, NULL, NULL, 478, 1);

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (590, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 510, 1);





CREATE TABLE profiles.cust (
    icustomerid bigint NOT NULL,
    longevity jsonb,
    frequency jsonb,
    velocity jsonb,
    engagement jsonb,
    geospatial jsonb,
    events jsonb,
    last_updated timestamp(6) without time zone,
    tdate date NOT NULL,
    bside boolean
);


CREATE TABLE profiles.cust_ip (
    icustomerid bigint NOT NULL,
    vcippart character varying(64) NOT NULL,
    velocity jsonb,
    tdate date NOT NULL
);



CREATE TABLE profiles.cust_payer (
    icustomerid bigint NOT NULL,
    vcpayer character varying(64) NOT NULL,
    velocity jsonb,
    tdate date NOT NULL
);


CREATE TABLE profiles.cust_user (
    icustomerid bigint NOT NULL,
    vcuser character varying(64) NOT NULL,
    velocity jsonb,
    tdate date NOT NULL
);


CREATE TABLE profiles.cust_userip (
    icustomerid bigint NOT NULL,
    vcuser character varying(64) NOT NULL,
    vcippart character varying(64) NOT NULL,
    velocity jsonb,
    tdate date NOT NULL
);


CREATE TABLE profiles.cust_userpayer (
    icustomerid bigint NOT NULL,
    vcuser character varying(64) NOT NULL,
    vcpayer character varying(64) NOT NULL,
    velocity jsonb,
    tdate date NOT NULL
);



ALTER TABLE ONLY profiles.cust_ip
    ADD CONSTRAINT "cust.ip_pkey" PRIMARY KEY (icustomerid, vcippart, tdate);



ALTER TABLE ONLY profiles.cust_payer
    ADD CONSTRAINT "cust.payer_pkey" PRIMARY KEY (icustomerid, vcpayer, tdate);



ALTER TABLE ONLY profiles.cust_user
    ADD CONSTRAINT "cust.user_pkey" PRIMARY KEY (icustomerid, vcuser, tdate);


ALTER TABLE ONLY profiles.cust_userip
    ADD CONSTRAINT "cust.userip_pkey" PRIMARY KEY (icustomerid, vcuser, vcippart, tdate);


ALTER TABLE ONLY profiles.cust_userpayer
    ADD CONSTRAINT "cust.userpayer_pkey" PRIMARY KEY (icustomerid, vcuser, vcpayer, tdate);


ALTER TABLE ONLY profiles.cust
    ADD CONSTRAINT cust_pkey PRIMARY KEY (icustomerid, tdate);






INSERT INTO profiles.cust VALUES (48, '{"Active day": 4464, "Onboarding Date": "01-03-2021", "FirstTransactionDate": "01-01-2010", "Last Transaction Date": "22-03-2022"}', NULL, '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 25, "d28_txn_value": 50000, "max_txn_value": 100000}', '{"Txncount": 10000000, "TotalValue": "50000000"}', NULL, NULL, NULL, '2022-03-22', true);
INSERT INTO profiles.cust VALUES (50, '{"Active day": 2256, "Onboarding Date": "01-05-2015", "FirstTransactionDate": "05-05-2015", "Last Transaction Date": "22-03-2022"}', NULL, '{"d05_txn_count": 10, "d05_txn_value": 10000, "d28_txn_count": 10, "d28_txn_value": 50000, "max_txn_value": 100000}', '{"Txncount": 10000000, "TotalValue": "50000000"}', NULL, NULL, NULL, '2022-03-22', true);
INSERT INTO profiles.cust VALUES (51, '{"Active day": 2256, "Onboarding Date": "01-03-2021", "FirstTransactionDate": "05-05-2015", "Last Transaction Date": "22-03-2022"}', NULL, '{"d05_txn_count": 7, "d05_txn_value": 10000, "d28_txn_count": 7, "d28_txn_value": 50000, "max_txn_value": 100000}', '{"Txncount": 10000000, "TotalValue": "50000000"}', NULL, NULL, NULL, '2022-03-22', true);
INSERT INTO profiles.cust VALUES (53, '{"Active day": 2256, "Onboarding Date": "01-05-2015", "FirstTransactionDate": "05-05-2015", "Last Transaction Date": "22-03-2022"}', NULL, '{"d05_txn_count": 10, "d05_txn_value": 10000, "d28_txn_count": 10, "d28_txn_value": 50000, "max_txn_value": 100000}', '{"Txncount": 10000000, "TotalValue": "50000000"}', NULL, NULL, NULL, '2022-03-22', true);
INSERT INTO profiles.cust VALUES (55, '{"Active day": 2256, "Onboarding Date": "01-05-2015", "FirstTransactionDate": "05-05-2015", "Last Transaction Date": "22-03-2022"}', NULL, '{"d05_txn_count": 10, "d05_txn_value": 10000, "d28_txn_count": 10, "d28_txn_value": 50000, "max_txn_value": 100000}', '{"Txncount": 10000000, "TotalValue": "50000000"}', NULL, NULL, NULL, '2022-03-22', true);
INSERT INTO profiles.cust VALUES (56, '{"Active day": 2256, "Onboarding Date": "01-05-2015", "FirstTransactionDate": "05-05-2015", "Last Transaction Date": "22-03-2022"}', NULL, '{"d05_txn_count": 7, "d05_txn_value": 10000, "d28_txn_count": 7, "d28_txn_value": 50000, "max_txn_value": 100000}', '{"Txncount": 10000000, "TotalValue": "50000000"}', NULL, NULL, NULL, '2022-03-22', true);


INSERT INTO profiles.cust_ip VALUES (48, '71.124.36.17', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (48, '142.168.14.34', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (48, '124.123.83.121', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (48, '151.123.76.123', '{"d05_txn_count": 6, "d05_txn_value": 5000, "d28_txn_count": 16, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (48, '151.121.76.124', '{"d05_txn_count": 5, "d05_txn_value": 15000, "d28_txn_count": 15, "d28_txn_value": 75000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (48, '151.123.86.125', '{"d05_txn_count": 5, "d05_txn_value": 15000, "d28_txn_count": 15, "d28_txn_value": 55000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (48, '151.123.76.126', '{"d05_txn_count": 6, "d05_txn_value": 15000, "d28_txn_count": 16, "d28_txn_value": 25000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (48, '151.123.76.127', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (51, '71.124.36.17', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (51, '142.168.14.34', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (51, '124.123.83.121', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (51, '151.123.76.123', '{"d05_txn_count": 6, "d05_txn_value": 5000, "d28_txn_count": 16, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (51, '151.121.76.124', '{"d05_txn_count": 5, "d05_txn_value": 15000, "d28_txn_count": 15, "d28_txn_value": 75000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (51, '151.123.86.125', '{"d05_txn_count": 5, "d05_txn_value": 15000, "d28_txn_count": 15, "d28_txn_value": 55000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (51, '151.123.76.126', '{"d05_txn_count": 6, "d05_txn_value": 15000, "d28_txn_count": 16, "d28_txn_value": 25000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (51, '151.123.76.127', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (53, '71.124.36.17', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (53, '142.168.14.34', '{"d05_txn_count": 6, "d05_txn_value": 10000, "d28_txn_count": 16, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (53, '124.123.83.121', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 5, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (53, '151.123.76.123', '{"d05_txn_count": 6, "d05_txn_value": 10000, "d28_txn_count": 16, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (53, '151.121.76.124', '{"d05_txn_count": 5, "d05_txn_value": 15000, "d28_txn_count": 15, "d28_txn_value": 25000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (53, '151.123.86.125', '{"d05_txn_count": 5, "d05_txn_value": 15000, "d28_txn_count": 15, "d28_txn_value": 55000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (53, '151.123.76.126', '{"d05_txn_count": 6, "d05_txn_value": 15000, "d28_txn_count": 16, "d28_txn_value": 25000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (53, '151.123.76.127', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (55, '71.124.36.17', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (55, '142.168.14.34', '{"d05_txn_count": 6, "d05_txn_value": 10000, "d28_txn_count": 16, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (55, '124.123.83.121', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 5, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (55, '151.123.76.123', '{"d05_txn_count": 6, "d05_txn_value": 10000, "d28_txn_count": 16, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (55, '151.121.76.124', '{"d05_txn_count": 5, "d05_txn_value": 15000, "d28_txn_count": 15, "d28_txn_value": 25000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (55, '151.123.86.125', '{"d05_txn_count": 5, "d05_txn_value": 15000, "d28_txn_count": 15, "d28_txn_value": 55000}', '2022-03-22');
INSERT INTO profiles.cust_ip VALUES (55, '151.123.76.126', '{"d05_txn_count": 6, "d05_txn_value": 15000, "d28_txn_count": 16, "d28_txn_value": 25000}', '2022-03-22');


INSERT INTO profiles.cust_payer VALUES (48, '5.55544E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '5.12965E+15', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '9.99989E+15', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '1.23412E+15', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '4.56723E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '9.89877E+15', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '3.12168E+15', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '5.67857E+15', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '5.52957E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '5.55544E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '5.12965E+15', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '9.99989E+15', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '1.23412E+15', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '4.56723E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '9.89877E+15', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '3.12168E+15', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '5.67857E+15', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '5.52957E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '9.89812E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '3.45635E+15', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '9.99989E+15', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '1.23412E+15', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '4.56723E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '9.89877E+15', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '3.12168E+15', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '5.67857E+15', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '5.52957E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '5.55544E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '5.12965E+15', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '9.99989E+15', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '1.23412E+15', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '4.56723E+15', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '9.89877E+15', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '3.12168E+15', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '5555444433332220', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '5129650211113330', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '1234123412341230', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '4567234517892340', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '9898767654544340', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '3121676789892320', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '5678567856785670', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (48, '5529567812341230', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '5555444433332220', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '5129650211113330', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '1234123412341230', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '4567234517892340', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '9898767654544340', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '3121676789892320', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '5678567856785670', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (51, '5529567812341230', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '9898121245457870', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '3456345689891240', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '1234123412341230', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '4567234517892340', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '9898767654544340', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '3121676789892320', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (53, '5678567856785670', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '5529567812341230', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '5555444433332220', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '5129650211113330', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '1234123412341230', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '4567234517892340', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '9898767654544340', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_payer VALUES (55, '3121676789892320', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');



INSERT INTO profiles.cust_user VALUES (48, 'radhika@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (48, 'satish@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (48, 'pallavi@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (48, 'arpan@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (48, 'niraj@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (48, 'purva@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (48, 'darpan@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (48, 'sueba@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (50, 'radhika@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (50, 'satish@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (50, 'pallavi@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (50, 'arpan@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (50, 'niraj@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (50, 'purva@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (50, 'darpan@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (50, 'sueba@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (51, 'radhika@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (51, 'satish@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (51, 'pallavi@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (51, 'arpan@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (51, 'niraj@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (51, 'purva@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (51, 'darpan@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (51, 'sueba@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (53, 'radhika@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (53, 'satish@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (53, 'pallavi@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (53, 'arpan@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (53, 'niraj@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (53, 'purva@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (53, 'darpan@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (53, 'sueba@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (55, 'radhika@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (55, 'satish@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (55, 'pallavi@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (55, 'arpan@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (55, 'niraj@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (55, 'purva@gmail.com', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (55, 'darpan@hotmail.com', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_user VALUES (55, 'sueba@hotmail.com', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');




INSERT INTO profiles.cust_userip VALUES (48, 'radhika@gmail.com', '71.124.36.17', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (48, 'radhika@gmail.com', '142.168.14.34', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (48, 'pallavi@gmail.com', '71.124.36.17', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (48, 'arpan@gmail.com', '142.168.14.34', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (48, 'satish@gmail.com', '124.123.83.121', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (48, 'pallavi@gmail.com', '151.123.76.123', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (48, 'arpan@hotmail.com', '151.121.76.124', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (48, 'niraj@hotmail.com', '151.123.86.125', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (51, 'purva@gmail.com', '151.123.76.126', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (51, 'darpan@hotmail.com', '71.124.36.17', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (51, 'radhika@gmail.com', '142.168.14.34', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (51, 'satish@gmail.com', '124.123.83.121', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (51, 'pallavi@gmail.com', '151.123.76.123', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (51, 'arpan@hotmail.com', '151.121.76.124', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (51, 'niraj@hotmail.com', '151.123.86.125', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (51, 'sueba@hotmail.com', '151.123.76.126', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (53, 'purva@gmail.com', '151.123.76.127', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (53, 'darpan@hotmail.com', '71.124.36.17', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (53, 'radhika@gmail.com', '142.168.14.34', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (53, 'satish@gmail.com', '124.123.83.121', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (53, 'pallavi@gmail.com', '151.123.76.123', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (53, 'arpan@hotmail.com', '151.121.76.124', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (53, 'niraj@hotmail.com', '151.123.86.125', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userip VALUES (53, 'sueba@hotmail.com', '151.123.76.126', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');



INSERT INTO profiles.cust_userpayer VALUES (48, 'radhika@gmail.com', '5555444433332220', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (48, 'radhika@gmail.com', '5129650211113330', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (48, 'satish@gmail.com', '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (48, 'satish@gmail.com', '1234123412341230', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (48, 'satish@gmail.com', '4567234517892340', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (48, 'arpan@hotmail.com', '9898767654544340', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (48, 'arpan@hotmail.com', '3121676789892320', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (48, 'pallavi@gmail.com', '5678567856785670', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (48, 'pallavi@gmail.com', '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'radhika@gmail.com', '5555444433332220', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'radhika@gmail.com', '5129650211113330', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'satish@gmail.com', '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'satish@gmail.com', '1234123412341230', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'satish@gmail.com', '4567234517892340', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'arpan@hotmail.com', '9898767654544340', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'arpan@hotmail.com', '3121676789892320', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'pallavi@gmail.com', '5678567856785670', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (50, 'pallavi@gmail.com', '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'radhika@gmail.com', '5555444433332220', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'radhika@gmail.com', '5129650211113330', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'satish@gmail.com', '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'satish@gmail.com', '1234123412341230', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'satish@gmail.com', '4567234517892340', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'arpan@hotmail.com', '9898767654544340', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'arpan@hotmail.com', '3121676789892320', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'pallavi@gmail.com', '5678567856785670', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (51, 'pallavi@gmail.com', '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'radhika@gmail.com', '5555444433332220', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'radhika@gmail.com', '5129650211113330', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'satish@gmail.com', '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'satish@gmail.com', '1234123412341230', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'satish@gmail.com', '4567234517892340', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'arpan@hotmail.com', '9898767654544340', '{"d05_txn_count": 5, "d05_txn_value": 19000, "d28_txn_count": 15, "d28_txn_value": 80000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'arpan@hotmail.com', '3121676789892320', '{"d05_txn_count": 5, "d05_txn_value": 10000, "d28_txn_count": 15, "d28_txn_value": 20000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'pallavi@gmail.com', '5678567856785670', '{"d05_txn_count": 6, "d05_txn_value": 17000, "d28_txn_count": 16, "d28_txn_value": 27000}', '2022-03-22');
INSERT INTO profiles.cust_userpayer VALUES (53, 'pallavi@gmail.com', '9999888877776660', '{"d05_txn_count": 5, "d05_txn_value": 12000, "d28_txn_count": 5, "d28_txn_value": 50000}', '2022-03-22');



INSERT INTO profiles.metadata VALUES ('[cust].longevity.FirstTransactionDate', 'date', true, false, true, 'First transaction Date', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].longevity.LastTransactionDate', 'date', true, false, true, 'Last transaction Date', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].longevity.OnboardingDate', 'date', true, true, true, 'Onboarding Date', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].longevity.DaysInSystem', 'float', true, true, true, 'Days in system', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].longevity.LogDaysInSystem', 'float', true, true, true, 'Log Days in system', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].longevity.FirstIntTransactionDate', 'date', true, false, false, 'First International Transaction Date', NULL);
INSERT INTO profiles.metadata VALUES ('[cust.engagement.ActiveDay', 'float', true, false, false, 'Active Day', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].velocity.d05_txn_count', 'float', true, false, true, 'Transaction count of last 5 days of Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].velocity.d05_txn_value', 'float', true, false, true, 'Transaction value of last 5 days of Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].velocity.d28_txn_count', 'float', true, false, true, 'Transaction count of last 28 days of Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].velocity.d28_txn_value', 'float', true, false, true, 'Transaction value of last 28 days of Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust].velocity.max_txn_value', 'float', true, false, true, 'Maximum transaction value for Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_ip].velocity.d05_txn_count', 'float', true, false, true, 'Transaction count of last 5 days by same IP for Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_ip].velocity.d05_txn_value', 'float', true, false, true, 'Transaction value of last 5 days by same IP for Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_ip].velocity.d28_txn_count', 'float', true, false, true, 'Transaction count of last 28 days by same IP for Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_ip].velocity.d28_txn_value', 'float', true, false, true, 'Transaction value of last 28 days by same IP for Customer', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_user].velocity.d05_txn_count', 'float', true, false, true, 'Transaction count of last 5 days by same user', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_user].velocity.d05_txn_value', 'float', true, false, true, 'Transaction value of last 5 days by same user', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_user].velocity.d28_txn_count', 'float', true, false, true, 'Transaction count of last 28 days by same user', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_user].velocity.d28_txn_value', 'float', true, false, true, 'Transaction value of last 28 days by same user', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_payer].velocity.d05_txn_count', 'float', true, false, true, 'Transaction count of last 5 days by same payment address', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_payer].velocity.d05_txn_value', 'float', true, false, true, 'Transaction value of last 5 days by same payment address', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_payer].velocity.d28_txn_count', 'float', true, false, true, 'Transaction count of last 28 days by same payment address', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_payer].velocity.d28_txn_value', 'float', true, false, true, 'Transaction value of last 28 days by same payment address', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_payer].velocity.d05_txn_count', 'float', true, false, true, 'Transaction count of last 5 days by same same user with same IP', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_userip].velocity.d05_txn_value', 'float', true, false, true, 'Transaction value of last 5 days by same same user with same IP', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_userip].velocity.d28_txn_count', 'float', true, false, true, 'Transaction count of last 28 days by same same user with same IP', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_userip].velocity.d28_txn_value', 'float', true, false, true, 'Transaction value of last 28 days by same same user with same IP', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_userpayer].velocity.d05_txn_count', 'float', true, false, true, 'Transaction count of last 5 days by same user with same payment address', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_userpayer].velocity.d05_txn_value', 'float', true, false, true, 'Transaction value of last 5 days by same payment address', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_userpayer].velocity.d28_txn_count', 'float', true, false, true, 'Transaction count of last 28 days by same payment address', NULL);
INSERT INTO profiles.metadata VALUES ('[cust_userpayer].velocity.d28_txn_value', 'float', true, false, true, 'Transaction value of last 28 days by same payment address', NULL);



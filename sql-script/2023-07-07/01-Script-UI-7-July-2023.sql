CREATE TABLE IF NOT EXISTS ui.masterconfig
(
    iconfigid integer NOT NULL,
    bdelete boolean,
    configjson jsonb,
    configname character varying(255) COLLATE pg_catalog."default",
    createdtime timestamp(6) without time zone,
    updatedtime timestamp(6) without time zone,
    CONSTRAINT masterconfig_pkey PRIMARY KEY (iconfigid),
    CONSTRAINT uk_ac3j01vw7i4dje4fpqdnq0ak3 UNIQUE (configname)
);

CREATE TABLE IF NOT EXISTS ui.masterconfigcustom
(
    icustomid integer NOT NULL,
    bdelete boolean,
    configjson jsonb,
    createdtime timestamp(6) without time zone,
    updatedtime timestamp(6) without time zone,
    iparentid integer,
    CONSTRAINT masterconfigcustom_pkey PRIMARY KEY (icustomid),
    CONSTRAINT fkghyekba2pgkbsdrwnkacb7unr FOREIGN KEY (iparentid)
        REFERENCES ui.masterconfig (iconfigid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE SEQUENCE IF NOT EXISTS ui.reportmailconfig_reportid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.reportmailconfig
(
    reportid integer NOT NULL DEFAULT nextval('ui.reportmailconfig_reportid_seq'::regclass),
    bactive boolean,
    dashboardqueryparams jsonb,
    day integer,
    emaillist text COLLATE pg_catalog."default",
    emailparameters jsonb,
    frequency character varying(255) COLLATE pg_catalog."default",
    reportheaders jsonb,
    reporttime character varying(255) COLLATE pg_catalog."default",
    idashboardid integer,
    bdelete boolean,
    CONSTRAINT reportmailconfig_pkey PRIMARY KEY (reportid),
    CONSTRAINT fk96acj3uj557naq0303wnduk4h FOREIGN KEY (idashboardid)
        REFERENCES ui.dashboard (idashboardid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO ui.emailtemplate (id, body, subject, associateid) VALUES (10, '<style>
    table, th, td {
      border: 1px solid #000000;
      border-collapse: collapse;
    }
    </style>
    <table style="border: 1px solid #000000; border-collapse: collapse;">
    <tr style="border: 1px solid #000000; border-collapse: collapse;">
        <th th:each="header : ${headers}" th:text="${header}" style="border: 1px solid #000000; border-collapse: collapse;"></th>
    </tr>
    <tr th:each="row : ${rows}" style="border: 1px solid #000000; border-collapse: collapse;">
        <td th:each="cell : ${row}" th:text="${cell}" style="border: 1px solid #000000; border-collapse: collapse;"></td>
    </tr>
    </table>', 'Report Generated: [(${name})]', 'yb-report');
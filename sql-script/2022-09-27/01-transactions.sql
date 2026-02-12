-- Table: transactions.rule_performance

-- DROP TABLE IF EXISTS transactions.rule_performance;

CREATE TABLE IF NOT EXISTS transactions.rule_performance
(
    idecisionid integer,
    vcclassname character varying(99) COLLATE pg_catalog."default",
    iruleid integer,
    score integer,
    totaltxncount bigint,
    scoretxncount bigint,
    totaltxnvalue numeric(15,2),
    scoretxnvalue numeric(15,2),
    tdate date
)

TABLESPACE pg_default;

-- Index: idx_rule_perf_tdate

-- DROP INDEX IF EXISTS transactions.idx_rule_perf_tdate;

CREATE INDEX IF NOT EXISTS idx_rule_perf_tdate
    ON transactions.rule_performance USING btree
    (tdate ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: transactions.rule_triggered

-- DROP TABLE IF EXISTS transactions.rule_triggered;

CREATE TABLE IF NOT EXISTS transactions.rule_triggered
(
    ilivemessageid bigint NOT NULL,
    vcmsgid character varying(100) COLLATE pg_catalog."default",
    vcuniquetransid character varying(100) COLLATE pg_catalog."default",
    dttrxntime timestamp with time zone,
    ipayervpaid bigint,
    vcpayeraddr character varying(100) COLLATE pg_catalog."default",
    ipayeraccountid bigint,
    vcpayeraccountexternalid character varying(100) COLLATE pg_catalog."default",
    ipayercustomerid bigint,
    vcpayercustomerexternalid character varying(100) COLLATE pg_catalog."default",
    ipayermccid bigint,
    ipayeevpaid bigint,
    vcpayeeaddr character varying(100) COLLATE pg_catalog."default",
    ipayeeaccountid bigint,
    vcpayeeaccountexternalid character varying(100) COLLATE pg_catalog."default",
    ipayeecustomerid bigint,
    vcpayeecustomerexternalid character varying(100) COLLATE pg_catalog."default",
    ipayeemccid bigint,
    icurrencyid bigint,
    dobservationamount numeric(15,2),
    txn_score integer,
    vcclassname character varying(99) COLLATE pg_catalog."default",
    idecisionid integer,
    vcdecisionname character varying(20) COLLATE pg_catalog."default",
    vcrulename character varying(255) COLLATE pg_catalog."default",
    iruleid integer NOT NULL,
    rule_score integer,
    CONSTRAINT rule_triggered_pkey PRIMARY KEY (ilivemessageid, iruleid)
)

TABLESPACE pg_default;

-- Index: rt_dtrxntime_d

-- DROP INDEX IF EXISTS transactions.rt_dtrxntime_d;

CREATE INDEX IF NOT EXISTS rt_dtrxntime_d
    ON transactions.rule_triggered USING btree
    (dttrxntime ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: rt_livemessageid_d

-- DROP INDEX IF EXISTS transactions.rt_livemessageid_d;

CREATE INDEX IF NOT EXISTS rt_livemessageid_d
    ON transactions.rule_triggered USING btree
    (ilivemessageid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: rt_rule_score_d

-- DROP INDEX IF EXISTS transactions.rt_rule_score_d;

CREATE INDEX IF NOT EXISTS rt_rule_score_d
    ON transactions.rule_triggered USING btree
    (iruleid ASC NULLS LAST, rule_score ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: rt_ruleid_d

-- DROP INDEX IF EXISTS transactions.rt_ruleid_d;

CREATE INDEX IF NOT EXISTS rt_ruleid_d
    ON transactions.rule_triggered USING btree
    (iruleid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: rt_txn_score_d

-- DROP INDEX IF EXISTS transactions.rt_txn_score_d;

CREATE INDEX IF NOT EXISTS rt_txn_score_d
    ON transactions.rule_triggered USING btree
    (txn_score ASC NULLS LAST)
    TABLESPACE pg_default;

-- PROCEDURE: transactions.ruleperf(date)

-- DROP PROCEDURE IF EXISTS transactions.ruleperf(date);

CREATE OR REPLACE PROCEDURE transactions.ruleperf(
	cdate date DEFAULT CURRENT_DATE)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE MDATE DATE;
BEGIN
	SELECT COALESCE(MAX(tdate), '2022-01-01'::date) INTO MDATE FROM transactions.rule_performance;
	RAISE NOTICE '> %  -- < %', MDATE, CDATE;
-----------
	WITH 
	dd AS (
		SELECT 
			tdd.ilivemessageid,
			DATE_TRUNC('day'::text, tt.dttrxntime, 'Asia/Kolkata'::text) AS tdate,
			tt.dobservationamount,
			tt.vcclassname,
			(tt.observations->'observations'->'transactionclass'->'decisionID')::integer AS idecisionid,
			tdd.iruleid,
			tdd.dscore AS score
		FROM transactions.decisiondetails tdd
		JOIN transactions.trans tt ON tt.ilivemessageid = tdd.ilivemessageid
		WHERE (tdd.dttrxntime::date > MDATE AND tdd.dttrxntime::date < CDATE)
	),
	rulecount AS (
		SELECT 
			tdate,
			vcclassname,
			idecisionid,
			iruleid,
			COUNT(1) AS txncount,
			SUM(dobservationamount) AS txnvalue
		FROM dd
		GROUP BY
			tdate,
			vcclassname,
			idecisionid,
			iruleid
	),
	finalaggr AS (
		SELECT 
			tdate,
			vcclassname,
			idecisionid,
			iruleid,
			score,
			COUNT(1) AS txncount,
			SUM(dobservationamount) AS txnvalue
		FROM dd
		GROUP BY
			tdate,
			vcclassname,
			idecisionid,
			iruleid,
			score
	)
	INSERT INTO transactions.rule_performance(
		idecisionid, vcclassname, iruleid, score, totaltxncount, scoretxncount, totaltxnvalue, scoretxnvalue, tdate)
	SELECT 
		fa.idecisionid,
		fa.vcclassname,
		fa.iruleid,
		fa.score,
		rc.txncount,
		fa.txncount,
		rc.txnvalue,
		fa.txnvalue,
		fa.tdate
	FROM finalaggr fa
	LEFT JOIN rulecount rc
	ON 
		fa.tdate = rc.tdate AND 
		fa.vcclassname = rc.vcclassname AND 
		fa.idecisionid = rc.idecisionid AND 
		fa.iruleid = rc.iruleid
	ORDER BY fa.tdate, fa.idecisionid, fa.iruleid;
END;
$BODY$;


-- PROCEDURE: transactions.ruletrig(date)

-- DROP PROCEDURE IF EXISTS transactions.ruletrig(date);

CREATE OR REPLACE PROCEDURE transactions.ruletrig(
	cdate date DEFAULT CURRENT_DATE)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE MDATE DATE;
BEGIN
    SELECT COALESCE(MAX(dttrxntime), '2022-01-01'::date) INTO MDATE FROM transactions.rule_triggered;
    RAISE NOTICE '> %  -- < %', MDATE, CDATE;
-----------
    INSERT INTO transactions.rule_triggered(
        ilivemessageid, vcmsgid, vcuniquetransid, dttrxntime, ipayervpaid, vcpayeraddr, ipayeraccountid, vcpayeraccountexternalid, ipayercustomerid, vcpayercustomerexternalid, ipayermccid, ipayeevpaid, vcpayeeaddr, ipayeeaccountid, vcpayeeaccountexternalid, ipayeecustomerid, vcpayeecustomerexternalid, ipayeemccid, icurrencyid, dobservationamount, txn_score, vcclassname, idecisionid, vcdecisionname, vcrulename, iruleid, rule_score)
    SELECT 
        tdd.ilivemessageid,
        tt.vcmsgid,
        tt.vcuniquetransid,
        tt.dttrxntime,
        tt.ipayervpaid,
        tt.vcpayeraddr,
        tt.ipayeraccountid,
        tt.vcpayeraccountexternalid,
        tt.ipayercustomerid,
        tt.vcpayercustomerexternalid,
        tt.ipayermccid,
        tt.ipayeevpaid,
        tt.vcpayeeaddr,
        tt.ipayeeaccountid,
        tt.vcpayeeaccountexternalid,
        tt.ipayeecustomerid,
        tt.vcpayeecustomerexternalid,
        tt.ipayeemccid,
        tt.icurrencyid,
        tt.dobservationamount,
        tt.score as txn_score,
        tt.vcclassname,
        (tt.observations->'observations'->'transactionclass'->'decisionID')::integer AS idecisionid,
        tt.observations->'observations'->'decisionclass'->>'decisionName' AS vcdecisionname,
        r.vcrulename,
        tdd.iruleid,
        tdd.dscore::integer as rule_score
    FROM transactions.decisiondetails tdd
    LEFT JOIN masters.rules r ON r.iruleid = tdd.iruleid
    JOIN transactions.trans tt ON tt.ilivemessageid = tdd.ilivemessageid
    WHERE (tdd.dttrxntime >= MDATE AND tdd.dttrxntime < CDATE)
    AND tdd.dscore > 0.0
    ON CONFLICT (ilivemessageid, iruleid) DO NOTHING;
-----------
END;
$BODY$;

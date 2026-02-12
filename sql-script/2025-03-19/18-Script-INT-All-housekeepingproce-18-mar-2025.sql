CREATE OR REPLACE PROCEDURE analytics.update_batch_rule_triggered(
    IN cdate date DEFAULT CURRENT_DATE,
    IN itenantid_value integer DEFAULT 1)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    MAX_BDD_ID BIGINT;
    non_integer_dscore_count INT;
BEGIN
    -- Fetch the maximum bdd_id
    SELECT COALESCE(MAX(bdd_id), 0) INTO MAX_BDD_ID 
    FROM analytics.batch_rule_triggered 
    WHERE itenantid = itenantid_value;

    -- Temporary table for processing
    WITH tbt AS (
        SELECT 
            tbt.idecisionid, 
            ((jsonb_array_elements_text(tbt.result->'score'->'decisiondetails')::json->>'ruleid')::numeric)::int AS iruleid, 
            tbt.vcmsgid, tbt.dttrxntime,
            tbt.ivpaid, tbt.vcaddr,
            tbt.iaccountid, tbt.vcaccountexternalid,
            tbt.icustomerid, tbt.vccustomerexternalid,
            (jsonb_array_elements_text(tbt.result->'score'->'decisiondetails')::json->>'score') AS dscore,
            tbt.score AS txn_score,
            'BATCH' AS class_name, 
            tbt.btrans_pk, tbt.itenantid
        FROM analytics.batchtrans tbt
        WHERE tbt.btrans_pk > MAX_BDD_ID 
          AND tbt.dttrxntime::date < cdate 
          AND itenantid = itenantid_value
    ),
    tt AS (
        SELECT 
            tbt.idecisionid, tbt.iruleid, tbt.vcmsgid, tbt.dttrxntime,
            tbt.ivpaid, tbt.vcaddr, tbt.iaccountid, tbt.vcaccountexternalid,
            tbt.icustomerid, tbt.vccustomerexternalid,
            CASE 
                WHEN tbt.dscore ~ '^[0-9]+(\.[0-9]+)?$' THEN tbt.dscore::numeric::int
                ELSE 0
            END AS dscore, 
            tbt.txn_score, tbt.class_name,
            tbt.btrans_pk, tbt.itenantid,
            d.vcdecisionname, r.vcrulename
        FROM tbt 
        LEFT JOIN masters.rules r ON r.iruleid = tbt.iruleid AND r.itenantid = tbt.itenantid
        LEFT JOIN masters.decisions d ON d.idecisionid = r.idecisionid AND d.itenantid = r.itenantid
    )
    SELECT COUNT(*) INTO non_integer_dscore_count
    FROM tbt
    WHERE dscore !~ '^[0-9]+(\.[0-9]+)?$';

    -- Insert rows with valid dscore
    INSERT INTO analytics.batch_rule_triggered(
        idecisionid, iruleid, vcmsgid,
        dttrxntime,
        ivpaid, vcaddr, 
        iaccountid, vcaccountexternalid, 
        icustomerid, vccustomerexternalid,
        rule_score, txn_score,
        vcclassname, bdd_id, itenantid, vcdecisionname, vcrulename)
    SELECT 
        tt.idecisionid, tt.iruleid, tt.vcmsgid, tt.dttrxntime,
        tt.ivpaid, tt.vcaddr, tt.iaccountid, tt.vcaccountexternalid,
        tt.icustomerid, tt.vccustomerexternalid,
        tt.dscore, tt.txn_score, tt.class_name,
        tt.btrans_pk, tt.itenantid,
        tt.vcdecisionname, tt.vcrulename
    FROM tt 
    WHERE tt.dscore > 0;

    -- Optional: Log or handle the non-integer dscore count
    RAISE NOTICE 'Non-integer dscore count: %', non_integer_dscore_count;

END;
$BODY$;



CREATE OR REPLACE PROCEDURE analytics.update_rule_performance(
    IN cdate date DEFAULT CURRENT_DATE,
    IN itenantid_value integer DEFAULT 1)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    MDATE DATE;
    cnt_null_vcclassname INT := 0;
cnt_invalid_rule_score int := 0;
BEGIN
    SELECT COALESCE(MAX(tdate), '2022-01-01'::date) INTO MDATE 
    FROM analytics.rule_performance
    WHERE vcclassname != 'BATCH' AND itenantid = itenantid_value;
    RAISE NOTICE 'online rules > %  -- < %', MDATE, CDATE;

    WITH score_wise AS (
        WITH tt AS (
            SELECT tt.itenantid,
                DATE_TRUNC('day'::text, tt.dttrxntime, 'Asia/Kolkata'::text)::DATE AS tdate,
                tc.idecisionid, 
                tt.vcclassname,
                ((jsonb_array_elements_text(tt.result->'score'->'decisiondetails')::json->>'ruleid')::numeric)::int as iruleid,
                (jsonb_array_elements_text(tt.result->'score'->'decisiondetails')::json->>'score') as dscore,
                tt.dobservationamount AS dobservationamount,
                tt.risk_override,tt.ipayeraccountid,tt.ipayeeaccountid,tt.ipayervpaid,tt.ipayeevpaid,tt.dttrxntime,
                jsonb_array_elements_text(tt.result->'score'->'decisiondetails')::json->>'side' as vcremark
            FROM analytics.trans tt 
            LEFT JOIN masters.transactionclasses tc ON tt.vcclassname = tc.vcclassname AND tt.itenantid = tc.itenantid
            WHERE (tt.dttrxntime::date > MDATE AND tt.dttrxntime::date < CDATE) AND tt.itenantid = itenantid_value AND tt.vcclassname IS NOT NULL
        ),
        temp AS (
            SELECT
                tt.itenantid,
                tt.tdate,
                tt.idecisionid, 
                tt.vcclassname,
                tt.iruleid,
                CASE 
                    WHEN tt.dscore ~ '^[0-9]+(\.[0-9]+)?$'
                    THEN tt.dscore::numeric::int
                    ELSE 0
                END as dscore,
                1 as scoretxncount,
                tt.dobservationamount,
                CASE WHEN tt.risk_override > 0 THEN 1 ELSE 0 END AS risk_override,
                CASE WHEN tt.risk_override > 0 THEN tt.dobservationamount ELSE 0 END AS override_txnvalue,
                tt.vcremark,
                tt.ipayeraccountid,
                tt.ipayeeaccountid,
                tt.ipayervpaid,
                tt.ipayeevpaid
            FROM tt
        )
        SELECT temp.itenantid,
            temp.tdate,
            temp.idecisionid, 
            temp.vcclassname,
            temp.iruleid,
            temp.dscore,
            COUNT(1) as scoretxncount,
            SUM(temp.dobservationamount) AS scoretxnvalue,
            SUM(temp.risk_override) AS override_txncount,
            SUM(temp.override_txnvalue) AS override_txnvalue,
            ARRAY_AGG(temp.ipayeraccountid) FILTER(WHERE temp.vcremark SIMILAR TO '(Payer|Both)') payer_accs, 
            ARRAY_AGG(temp.ipayeeaccountid) FILTER(WHERE temp.vcremark SIMILAR TO '(Payee|Both)') payee_accs,
            ARRAY_AGG(temp.ipayervpaid) FILTER(WHERE temp.vcremark SIMILAR TO '(Payer|Both)') payer_vpas, 
            ARRAY_AGG(temp.ipayeevpaid) FILTER(WHERE temp.vcremark SIMILAR TO '(Payee|Both)') payee_vpas
        FROM temp 
        GROUP BY temp.itenantid,temp.tdate, temp.idecisionid, temp.vcclassname, temp.iruleid, temp.dscore
    ),
    rule_wise AS (
        SELECT tdate, idecisionid, vcclassname, iruleid, itenantid,
            sum(scoretxncount) as totaltxncount,
            sum(scoretxnvalue) as totaltxnvalue
        FROM score_wise
        GROUP BY tdate, idecisionid, vcclassname, iruleid, itenantid
    ),
    affected AS (
        SELECT tdate, idecisionid, vcclassname, iruleid, dscore, itenantid,
            (SELECT COUNT(DISTINCT e) FROM UNNEST(payer_accs || payee_accs) a(e)) AS accs_ctr,
            (SELECT COUNT(DISTINCT e) FROM UNNEST(payer_vpas || payee_vpas) a(e)) AS vpas_ctr
        FROM score_wise
    )
    INSERT INTO analytics.rule_performance(
        idecisionid, vcclassname, iruleid, score, 
        totaltxncount, scoretxncount, totaltxnvalue, scoretxnvalue, 
        override_txncount, override_txnvalue,
        tdate, accounts_affected, vpas_affected, itenantid)
    SELECT 
        CASE WHEN sw.idecisionid IS NULL THEN (SELECT idecisionid FROM ui.rules WHERE iruleid = sw.iruleid AND itenantid = sw.itenantid) ELSE sw.idecisionid END,
        sw.vcclassname, sw.iruleid, 
        sw.dscore as score, 
        rw.totaltxncount, sw.scoretxncount, rw.totaltxnvalue, sw.scoretxnvalue,
        sw.override_txncount, sw.override_txnvalue,
        sw.tdate, aa.accs_ctr, aa.vpas_ctr, sw.itenantid
    FROM score_wise sw
    LEFT JOIN rule_wise rw 
        ON sw.tdate = rw.tdate AND sw.idecisionid = rw.idecisionid AND sw.vcclassname = rw.vcclassname AND sw.iruleid = rw.iruleid AND sw.itenantid = rw.itenantid
    LEFT JOIN affected aa
        ON sw.tdate = aa.tdate AND sw.idecisionid = aa.idecisionid AND sw.vcclassname = aa.vcclassname AND sw.iruleid = aa.iruleid AND sw.dscore = aa.dscore AND sw.itenantid = aa.itenantid;

    -- Count records with vcclassname is null
    SELECT COUNT(*) INTO cnt_null_vcclassname 
    FROM analytics.trans tt 
    WHERE tt.dttrxntime::date > MDATE AND tt.dttrxntime::date < CDATE AND tt.itenantid = itenantid_value AND tt.vcclassname IS NULL;

    -- Log or use the count of records with vcclassname is null
    RAISE NOTICE 'Count of records with vcclassname is NULL: %', cnt_null_vcclassname;

    SELECT COUNT(*) INTO cnt_invalid_rule_score
    FROM trans
    WHERE rule_score !~ '^[0-9]+(\.[0-9]+)?$';

    RAISE NOTICE 'Count of records with invalid rule_score: %', cnt_invalid_rule_score;


    SELECT COALESCE(MAX(tdate), '2022-01-01'::date) INTO MDATE 
    FROM analytics.rule_performance
    WHERE vcclassname = 'BATCH' AND itenantid = itenantid_value;
    RAISE NOTICE 'batch rules > %  -- < %', MDATE, CDATE;

    WITH batch_score_wise AS (
        WITH tt AS (
            SELECT d.itenantid,
                DATE_TRUNC('day'::text, btt.dttrxntime, 'Asia/Kolkata'::text)::DATE AS tdate,
                btt.idecisionid, 
                ((jsonb_array_elements_text(btt.result->'score'->'decisiondetails')::json->>'ruleid')::numeric)::int as iruleid,
                (jsonb_array_elements_text(btt.result->'score'->'decisiondetails')::json->>'score') as dscore,
                1 AS scoretxncount,
                CASE WHEN btt.risk_override > 0 THEN 1 ELSE 0 END AS override_txncount,    
                btt.iaccountid accs,
                btt.ivpaid vpas
            FROM analytics.batchtrans btt 
            LEFT JOIN masters.decisions d ON (d.idecisionid = btt.idecisionid AND d.itenantid = btt.itenantid)
            WHERE (btt.dttrxntime::date > MDATE AND btt.dttrxntime::date < CDATE AND btt.itenantid = itenantid_value)
        ), 
        temp AS (
            SELECT tt.itenantid,
                tt.tdate,
                tt.idecisionid,
                tt.iruleid,
                CASE 
                    WHEN tt.dscore ~ '^[0-9]+(\.[0-9]+)?$'
                    THEN tt.dscore::numeric::int 
                    ELSE 0
                END as dscore,
                1 AS scoretxncount,
                tt.override_txncount AS override_txncount,
                tt.accs,
                tt.vpas
            FROM tt
        )
        SELECT temp.itenantid,
            temp.tdate,
            temp.idecisionid,
            temp.iruleid,
            temp.dscore,
            COUNT(temp.scoretxncount) AS scoretxncount,
            SUM(temp.override_txncount) AS override_txncount,
            ARRAY_AGG(temp.accs) accs,
            ARRAY_AGG(temp.vpas) vpas
        FROM temp
        GROUP BY temp.itenantid, temp.tdate, temp.idecisionid, temp.iruleid, dscore 
    ),
    batch_rule_wise AS (
        SELECT 
            tdate, 
            idecisionid, 
            iruleid,
            itenantid,
            SUM(scoretxncount) AS totaltxncount
        FROM batch_score_wise
        GROUP BY tdate, idecisionid, iruleid, itenantid
    ),
    batch_affected AS (
        SELECT tdate, idecisionid, iruleid, dscore, itenantid,
            (SELECT COUNT(DISTINCT e) FROM UNNEST(accs) a(e)) AS accs_ctr,
            (SELECT COUNT(DISTINCT e) FROM UNNEST(vpas) a(e)) AS vpas_ctr
        FROM batch_score_wise
    )
    INSERT INTO analytics.rule_performance(
        idecisionid, vcclassname, iruleid, score, 
        totaltxncount, scoretxncount, totaltxnvalue, scoretxnvalue, 
        override_txncount, override_txnvalue,        
        tdate, accounts_affected, vpas_affected, itenantid)
    SELECT 
        sw.idecisionid, 'BATCH', sw.iruleid, 
        sw.dscore as score, 
        rw.totaltxncount, sw.scoretxncount, 0, 0,
        sw.override_txncount, 0,
        sw.tdate, aa.accs_ctr, aa.vpas_ctr, sw.itenantid
    FROM batch_score_wise sw
    LEFT JOIN batch_rule_wise rw 
        ON sw.tdate = rw.tdate AND sw.idecisionid = rw.idecisionid AND sw.iruleid = rw.iruleid AND sw.itenantid = rw.itenantid
    LEFT JOIN batch_affected aa
        ON sw.tdate = aa.tdate AND sw.idecisionid = aa.idecisionid AND sw.iruleid = aa.iruleid AND sw.dscore = aa.dscore AND sw.itenantid = aa.itenantid;

END;
$BODY$;




CREATE OR REPLACE PROCEDURE analytics.update_rule_triggered(
    IN itenantid_value integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    MAX_DD_ID BIGINT;
    cnt_null_vcclassname INT := 0;
    cnt_invalid_rule_score INT := 0;
BEGIN
    -- Fetch the maximum ilivemessageid
    SELECT COALESCE(MAX(ilivemessageid), 0) INTO MAX_DD_ID 
    FROM analytics.rule_triggered 
    WHERE itenantid = itenantid_value;

    -- Temporary table for processing
    WITH trans AS (
        SELECT 
            tt.ilivemessageid, tt.vcmsgid, tt.vcuniquetransid, tt.dttrxntime,
            tt.ipayervpaid, tt.vcpayeraddr,
            tt.ipayeraccountid, tt.vcpayeraccountexternalid,
            tt.ipayercustomerid, tt.vcpayercustomerexternalid,
            tt.ipayermccid,
            tt.ipayeevpaid, tt.vcpayeeaddr,
            tt.ipayeeaccountid, tt.vcpayeeaccountexternalid,
            tt.ipayeecustomerid, tt.vcpayeecustomerexternalid,
            tt.ipayeemccid,
            tt.icurrencyid, tt.dobservationamount,
            tt.itenantid,
            tt.score AS txn_score, 
            tt.vcclassname,
            ((jsonb_array_elements_text(tt.result->'score'->'decisiondetails')::json->>'ruleid')::numeric)::int AS iruleid,
            (jsonb_array_elements_text(tt.result->'score'->'decisiondetails')::json->>'score') AS rule_score,
            jsonb_array_elements_text(tt.result->'score'->'decisiondetails')::json->>'side' AS vcremark
        FROM analytics.trans tt 
        WHERE tt.ilivemessageid > MAX_DD_ID 
          AND tt.itenantid = itenantid_value
    ), 
    tt AS (
        SELECT 
            trans.ilivemessageid, trans.vcmsgid, trans.vcuniquetransid, trans.dttrxntime,
            trans.ipayervpaid, trans.vcpayeraddr,
            trans.ipayeraccountid, trans.vcpayeraccountexternalid,
            trans.ipayercustomerid, trans.vcpayercustomerexternalid,
            trans.ipayermccid,
            trans.ipayeevpaid, trans.vcpayeeaddr,
            trans.ipayeeaccountid, trans.vcpayeeaccountexternalid,
            trans.ipayeecustomerid, trans.vcpayeecustomerexternalid,
            trans.ipayeemccid,
            trans.icurrencyid, trans.dobservationamount,
            trans.itenantid,
            trans.txn_score,
            trans.vcclassname, trans.iruleid, 
            CASE 
                WHEN trans.rule_score ~ '^[0-9]+(\.[0-9]+)?$'
                THEN trans.rule_score::numeric::int 
                ELSE 0
            END AS rule_score, 
            trans.vcremark,
            r.idecisionid, d.vcdecisionname, r.vcrulename 
        FROM trans 
        LEFT JOIN masters.rules r ON (r.iruleid = trans.iruleid AND r.itenantid = trans.itenantid)
        LEFT JOIN masters.decisions d ON (d.idecisionid = r.idecisionid AND d.itenantid = trans.itenantid)
    )
    -- Insert valid rows into the rule_triggered table
    INSERT INTO analytics.rule_triggered(
        ilivemessageid, vcmsgid, vcuniquetransid, dttrxntime, 
        ipayervpaid, vcpayeraddr, 
        ipayeraccountid, vcpayeraccountexternalid, 
        ipayercustomerid, vcpayercustomerexternalid, 
        ipayermccid, 
        ipayeevpaid, vcpayeeaddr, 
        ipayeeaccountid, vcpayeeaccountexternalid, 
        ipayeecustomerid, vcpayeecustomerexternalid, 
        ipayeemccid, 
        icurrencyid, dobservationamount, itenantid,
        txn_score, vcclassname, iruleid, rule_score, 
        vcremark, idecisionid, vcdecisionname, vcrulename)
    SELECT 
        tt.ilivemessageid, tt.vcmsgid, tt.vcuniquetransid, tt.dttrxntime,
        tt.ipayervpaid, tt.vcpayeraddr,
        tt.ipayeraccountid, tt.vcpayeraccountexternalid,
        tt.ipayercustomerid, tt.vcpayercustomerexternalid,
        tt.ipayermccid,
        tt.ipayeevpaid, tt.vcpayeeaddr,
        tt.ipayeeaccountid, tt.vcpayeeaccountexternalid,
        tt.ipayeecustomerid, tt.vcpayeecustomerexternalid,
        tt.ipayeemccid,
        tt.icurrencyid, tt.dobservationamount,
        tt.itenantid,
        tt.txn_score, 
        tt.vcclassname, tt.iruleid, 
        tt.rule_score, 
        tt.vcremark,
        tt.idecisionid, tt.vcdecisionname, tt.vcrulename
    FROM tt 
    WHERE tt.rule_score > 0;

    -- Count records with vcclassname IS NULL
    SELECT COUNT(*) INTO cnt_null_vcclassname 
    FROM analytics.trans tt 
    WHERE tt.ilivemessageid > MAX_DD_ID 
      AND tt.itenantid = itenantid_value 
      AND tt.vcclassname IS NULL;

    -- Count records with invalid rule_score
    SELECT COUNT(*) INTO cnt_invalid_rule_score
    FROM trans
    WHERE rule_score !~ '^[0-9]+(\.[0-9]+)?$';

    -- Log the counts
    RAISE NOTICE 'Count of records with vcclassname IS NULL: %', cnt_null_vcclassname;
    RAISE NOTICE 'Count of records with invalid rule_score: %', cnt_invalid_rule_score;

END;
$BODY$;


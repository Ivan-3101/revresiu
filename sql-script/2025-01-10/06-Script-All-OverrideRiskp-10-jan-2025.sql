-- PROCEDURE: analytics.override_risk(character varying[], smallint, jsonb, integer)

-- DROP PROCEDURE IF EXISTS analytics.override_risk(character varying[], smallint, jsonb, integer);

CREATE OR REPLACE PROCEDURE analytics.override_risk(
    IN reqids character varying[],
    IN override smallint,
    IN ctx jsonb,
    IN itenantid_value integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Update override_txncount in analytics.rule_performance
    UPDATE analytics.rule_performance
    SET override_txncount = 
        CASE
            WHEN override > 0 THEN trans.override_txncount
            ELSE rule_performance.override_txncount
        END
    FROM (
        SELECT 
            DATE_TRUNC('day', dttrxntime AT TIME ZONE 'Asia/Kolkata')::date AS tdate, vcclassname,
            (observations->'observations'->'transactionclass'->'decisionID')::integer AS idecisionid,
            ((jsonb_array_elements_text(result->'score'->'decisiondetails')::json->>'ruleid')::numeric)::int AS iruleid,
            ((jsonb_array_elements_text(result->'score'->'decisiondetails')::json->>'score')::numeric)::int AS dscore,
            COUNT(*) AS override_txncount -- Aggregation added
        FROM analytics.trans
        WHERE vcmsgid = ANY(reqids) AND itenantid = itenantid_value
        GROUP BY
            DATE_TRUNC('day', dttrxntime AT TIME ZONE 'Asia/Kolkata')::date,
            (observations->'observations'->'transactionclass'->'decisionID')::integer,
            ((jsonb_array_elements_text(result->'score'->'decisiondetails')::json->>'ruleid')::numeric)::int,
            ((jsonb_array_elements_text(result->'score'->'decisiondetails')::json->>'score')::numeric)::int,
            vcclassname,
	        itenantid
    ) trans
    WHERE rule_performance.tdate = trans.tdate 
        AND rule_performance.idecisionid = trans.idecisionid
      	AND rule_performance.vcclassname = trans.vcclassname       
        AND rule_performance.iruleid = trans.iruleid
        AND rule_performance.score = trans.dscore
        AND rule_performance.itenantid = itenantid_value;
    -- Update risk_override and risk_context in analytics.trans
    UPDATE analytics.trans
    SET
        risk_override = override,
        risk_context = ctx
    WHERE vcmsgid = ANY(reqids) AND itenantid = itenantid_value;

END
$BODY$;

ALTER PROCEDURE analytics.override_risk(character varying[], smallint, jsonb, integer)
    OWNER TO dronapay;

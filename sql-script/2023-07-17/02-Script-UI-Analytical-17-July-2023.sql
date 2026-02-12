-- FUNCTION: sim.analyze_sim(integer, character varying, timestamp without time zone, timestamp without time zone)

DROP FUNCTION IF EXISTS sim.analyze_sim(integer, character varying, timestamp without time zone, timestamp without time zone);

CREATE OR REPLACE FUNCTION sim.analyze_sim(
	rid integer,
	sid character varying,
	starttime timestamp without time zone,
	endtime timestamp without time zone)
    RETURNS TABLE("Unique ID" character varying, "Txn Date Time" timestamp with time zone, "Score" integer, "Remark" character varying, "Sim Score" integer, "Sim Remark" character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
sql_query text;
txcount integer;
BEGIN
	txcount = (select txncount from sim.runs where runid=rid and simid=sid);
	if txcount = 0 then
		raise exception 'This run returned no records for the date range selected. Please re run.';
	elseif txcount < 0 then
		raise exception 'Run in progress. Please check results in some time.';
	elseif txcount > 0 then
	sql_query:='SELECT vcmsgid as "Unique ID", dttrxntime as "Txn Date Time", dscore as "Score", vcremark as "Remark", sim_dscore as "Sim Score", sim_vcremark as "Sim Remark"
	FROM sim."%I" where dttrxntime  between $1  and $2';
	RETURN QUERY EXECUTE format(sql_query, sid||'_'||rid) using starttime, endtime;
	end if;
	
END
$BODY$;

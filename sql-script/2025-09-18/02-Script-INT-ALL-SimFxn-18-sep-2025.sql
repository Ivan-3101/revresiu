 DROP FUNCTION IF EXISTS sim.analyze_sim(bigint, character varying, timestamp without time zone, timestamp without time zone, character varying, character varying, bigint, integer);

 DROP FUNCTION IF EXISTS sim.analyze_sim(integer, character varying, timestamp without time zone, timestamp without time zone, character varying, character varying, integer, integer);


CREATE OR REPLACE FUNCTION sim.analyze_sim(
	rid bigint,
	sid character varying,
	starttime timestamp without time zone,
	endtime timestamp without time zone,
	dscorechar character varying,
	simscorechar character varying,
	limitint bigint,
	tenantid integer)
	RETURNS TABLE("Unique ID" text, "Txn Date Time" timestamp, "Score" integer, "Remark" text, "Sim Score" integer, "Sim Remark" text)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
sql_query text;
txcount integer;
BEGIN
	txcount = (select txncount from sim.runs where runid=rid and simid=sid and itenantid = tenantid );
	if txcount = 0 then
		raise exception 'This run returned no records for the date range selected. Please re run.';
	elseif txcount < 0 then
		raise exception 'Run in progress. Please check results in some time.';
	elseif txcount > 0 then
		if dscorechar = '=0' or dscorechar = '>0' or dscorechar = '>=0' then
		else
			raise exception 'Please select valid dscore';
		end if;

		if simscorechar = '=0' or simscorechar = '>0' or simscorechar = '>=0' then
		else
			raise exception 'Please select valid sim_score';
		end if;

		if limitint = 10000 or limitint = 25000 or limitint = 50000 then
		else
			raise exception 'Please select valid limit';
		end if;

	sql_query:='SELECT vcmsgid as "Unique ID", dttrxntime as "Txn Date Time", dscore as "Score", vcremark as "Remark", sim_dscore as "Sim Score", sim_vcremark as "Sim Remark"
	FROM sim.%I where dttrxntime  between $1  and $2 and dscore '||dscorechar||' and sim_dscore '||simscorechar||' order by dttrxntime desc  limit $3';
	RETURN QUERY EXECUTE format(sql_query, sid||'_'||rid) using starttime, endtime, limitint;
	end if;

END
$BODY$;


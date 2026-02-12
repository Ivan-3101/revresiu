DROP TYPE IF EXISTS transactions.decisiondetail;

CREATE TYPE transactions.decisiondetail AS
(
	score numeric,
	ruleno numeric,
	side text,
	rulename text
);



CREATE OR REPLACE FUNCTION transactions.getdecisiondetails(
	vcmsgidinput character varying)
    RETURNS TABLE("Score" numeric, "Order" numeric, "Remarks" text, "RuleName" text)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
tempresult text;
qtemp text;
BEGIN
tempresult = (select result  ->  'score' ->> 'decisiondetails' from transactions.trans l where vcmsgid=vcmsgidinput);
if(tempresult is not null)then
	qtemp:= 'select * from json_populate_recordset(null::transactions.decisiondetail, '''||tempresult||''')';
else
	qtemp:= 'select * from json_populate_recordset(null::transactions.decisiondetail, ''[]'')';
end if;
RETURN QUERY execute qtemp;
END
$BODY$;





CREATE OR REPLACE FUNCTION ui.ticketid(
	)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
  current_year integer;
  last_value integer;
BEGIN
  current_year =  (select EXTRACT(YEAR FROM  current_date)*1000000) ;
  last_value = (select nextval('ui.ticket_seq')) ;
  IF  last_value < current_year THEN
    EXECUTE  'ALTER SEQUENCE ui.ticket_seq RESTART WITH  '||current_year+1;
	return current_year;
  else
    return last_value;
  END IF;
END;
$BODY$;


ALTER TABLE IF EXISTS ui.ticketidgenerator
    ADD PRIMARY KEY (ticketid);
ALTER TABLE IF EXISTS ui.ticketidgenerator
    ALTER COLUMN ticketid SET DEFAULT  ui.ticketid();



SELECT setval('ui.ticket_seq', (SELECT (max(ticketid)+(EXTRACT(YEAR FROM  current_date)*1000000)+1)::integer  FROM ui.ticketidgenerator));

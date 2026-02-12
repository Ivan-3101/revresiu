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
    perform setval('ui.ticket_seq', current_year+1, true);
	return current_year;
  else
    return last_value;
  END IF;
END;
$BODY$;

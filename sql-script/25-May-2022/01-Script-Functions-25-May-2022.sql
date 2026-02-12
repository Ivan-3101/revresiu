CREATE OR REPLACE FUNCTION transactions.sp_getdatalivetrans_c(
	tdate timestamp without time zone,
	todate timestamp without time zone)
    RETURNS SETOF livetrans_c_type
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
keyname text;
	recindex profiles.index;
	rec profiles.metadata;
	cnt int;
   tablewithschema text;
   typename text;
   sql_query text;

BEGIN
	tablewithschema='transactions.livetrans';
	typename=tablewithschema||'_c_type';
	cnt=0;
	sql_query:='SELECT a.attname AS name, format_type(a.atttypid, a.atttypmod) AS type
FROM
    pg_class AS c
    JOIN pg_index AS i ON c.oid = i.indrelid AND i.indisprimary
    JOIN pg_attribute AS a ON c.oid = a.attrelid AND a.attnum = ANY(i.indkey)
WHERE c.oid = $1::regclass	';
	--raise notice '% ' ,sql_query  ;

for recindex in execute sql_query  USING tablewithschema
	loop
	--raise notice '%',rec;
	case cnt when 0 then
		keyname:=recindex.name||' ';
		cnt=1;
else
		keyname:=keyname||','||recindex.name||' ' ;
end case;
end loop;
	cnt=0;
   sql_query:='select distinct(split_part(vcpath,".",1)) from profiles.metadata where ( bui=true )and substring (vcpath, ''(?<=\[).+?(?=\])'')=$1'  ;
   --raise notice '% -', sql_query1;
   sql_query:='
with recursive flat (ilivemessageid, key, value) as (
select ilivemessageid, ''livetrans'',format(''{"ilivemessageid":%s}'',cast(ilivemessageid as text))::jsonb as value
	from transactions.livetrans where dttrxntime::Timestamp>='''||tdate||'''::Timestamp and dttrxntime::Timestamp<='''||todate||'''::Timestamp
	union
    select ilivemessageid ,  concat(''livetrans.'',key), value
    from transactions.livetrans,
    jsonb_each(observations) where dttrxntime::Timestamp>='''||tdate||'''::Timestamp and dttrxntime::Timestamp<='''||todate||'''::Timestamp
union
	select ilivemessageid,  concat(''livetrans.result.'',key), value
    from transactions.livetrans,
    jsonb_each(result) where dttrxntime::Timestamp>='''||tdate||'''::Timestamp and dttrxntime::Timestamp<='''||todate||'''::Timestamp
union
    select f.ilivemessageid, concat(f.key, ''.'', j.key), j.value
    from flat f,
    jsonb_each(f.value) j
    where jsonb_typeof(f.value) = ''object''
)

select * from json_populate_recordset(NULL::"livetrans_c_type",
	(
		select json_agg(data) from (

select jsonb_object_agg(case when vccolumnname is null then key else vccolumnname end, value) as data
from flat a left join profiles.metadata b
			on a.key=translate(b.vcpath, ''[,]'', '''') where jsonb_typeof(value) <> ''object''
group by ilivemessageid
) a)) ;';
--raise notice '%',sql_query;
RETURN QUERY EXECUTE sql_query;
END
$BODY$;

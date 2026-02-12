

CREATE TYPE profiles.index AS
    (
    name text,
    type text
    );

CREATE FUNCTION profiles.sp_createtype(mytable text) RETURNS SETOF profiles.metadata
    LANGUAGE plpgsql
    AS $_$
DECLARE
recindex profiles.index;
	rec profiles.metadata;
	cnt int;
   createtype  text;
   tablewithschema text;
   typename text;
   sql_query text;

BEGIN
	tablewithschema='profiles.'||mytable;
	typename=mytable||'_type';
	--raise notice '% ' ,typename;
	cnt=0;
  	createtype:='CREATE TYPE %I AS (';
	sql_query:='SELECT a.attname AS name, format_type(a.atttypid, a.atttypmod) AS type
FROM
    pg_class AS c
    JOIN pg_index AS i ON c.oid = i.indrelid AND i.indisprimary
    JOIN pg_attribute AS a ON c.oid = a.attrelid AND a.attnum = ANY(i.indkey)
WHERE c.oid = $1::regclass	';
	--raise notice '% ' ,sql_query  ;

for recindex in execute sql_query  USING tablewithschema
	loop
	raise notice '%',rec;
case cnt when 0 then
		createtype:=createtype||'"'||mytable||'.'||recindex.name||'" '||recindex.type ;
		cnt=1;
else
		createtype:=createtype||',"'||mytable||'.'||recindex.name||'" '||recindex.type ;
end case;
end loop;

   sql_query:='select * from profiles.metadata where ( bui=true )and substring (vcpath, ''(?<=\[).+?(?=\])'')=$1'  ;
   raise notice '% -', sql_query;
for rec in execute sql_query  USING Mytable
	loop

	createtype:=createtype||' ,"'||translate(rec.vcpath, '[,]', '')||'" '||'text ';
end loop;
	createtype:=createtype||')';
	raise notice '% ', createtype;
EXECUTE format('DROP TYPE IF EXISTS %I' , typename);
EXECUTE format(createtype , typename);
END
$_$;

select * from profiles.sp_createtype('cust');
select * from profiles.sp_createtype('mcc');
select * from profiles.sp_createtype('vpa');
select * from profiles.sp_createtype('location');
select * from transactions.sp_createtype('livetrans');

CREATE FUNCTION profiles.sp_getdatacust(mytable text, tdate date) RETURNS SETOF public.cust_type
    LANGUAGE plpgsql
    AS $_$
DECLARE
keyname text;
	recindex profiles.index;
	rec profiles.metadata;
	cnt int;
   tablewithschema text;
   typename text;
   sql_query text;

BEGIN
	tablewithschema='profiles.'||mytable;
	typename=tablewithschema||'_type';
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
   sql_query:='select distinct(split_part(vcpath,".",1)) from profiles.metadata where ( bml=true or bui=true or bscore=true )and substring (vcpath, ''(?<=\[).+?(?=\])'')=$1'  ;
   --raise notice '% -', sql_query1;
   sql_query:='with recursive flat (icustomerid,tdate, key, value) as (
	select icustomerid,tdate, ''cust'',format(''{"icustomerid":%s,"tdate":"%s"}'',cast(icustomerid as text),TO_CHAR(tdate,''yyyy-Mon-dd''))::jsonb as value
	from profiles.cust where tdate='''||tdate||'''
	union
    select icustomerid,tdate,  concat(''cust.longevity.'',key), value
    from profiles.cust,
    jsonb_each(longevity) where tdate='''||tdate||'''
union
	select icustomerid,tdate,  concat(''cust.velocity.'',key), value
    from profiles.cust,
    jsonb_each(velocity) where tdate='''||tdate||'''
union
	select icustomerid,tdate,  concat(''cust.frequency.'',key), value
    from profiles.cust,
    jsonb_each(frequency) where tdate='''||tdate||'''
union
	select icustomerid,tdate,  concat(''cust.engagement.'',key), value
    from profiles.cust,
    jsonb_each(engagement)	 where tdate='''||tdate||'''
union
    select f.icustomerid,tdate, concat(f.key, ''.'', j.key), j.value
    from flat f,
    jsonb_each(f.value) j
    where jsonb_typeof(f.value) = ''object''
)
select * from json_populate_recordset(NULL::"cust_type",
	(
		select json_agg(data) from (
select jsonb_object_agg(key, value) as data
from flat
where jsonb_typeof(value) <> ''object''
group by icustomerid,tdate
) a)) ;';

RETURN QUERY EXECUTE sql_query;
END
$_$;


CREATE FUNCTION profiles.sp_getdatalocation(tdate date) RETURNS SETOF public.location_type
    LANGUAGE plpgsql
    AS $_$
DECLARE
keyname text;
	recindex profiles.index;
	rec profiles.metadata;
	cnt int;
   tablewithschema text;
   typename text;
   sql_query text;

BEGIN
	tablewithschema='profiles.location';
	typename=tablewithschema||'_type';
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
   sql_query:='with recursive flat (ilocationid,vclocationlevel,tdate, key, value) as (
	select ilocationid,vclocationlevel,tdate, ''location'',format(''{"ilocationid":%s,"vclocationlevel":%s,"tdate":"%s"}'',cast(ilocationid as text),cast(vclocationlevel as text) ,TO_CHAR(tdate,''yyyy-Mon-dd''))::jsonb as value
	from profiles.location where tdate='''||tdate||'''
	union
    select ilocationid,vclocationlevel,tdate,  concat(''location.geospatial.'',key), value
    from profiles.location,
    jsonb_each(velocity)  where tdate='''||tdate||'''
union
	select ilocationid,vclocationlevel,tdate,  concat(''location.frequency.'',key), value
    from profiles.location,
    jsonb_each(frequency)  where tdate='''||tdate||'''
union
	select ilocationid,vclocationlevel,tdate,  concat(''location.engagement.'',key), value
    from profiles.location,
    jsonb_each(engagement)	 where tdate='''||tdate||'''
union
	select ilocationid,vclocationlevel,tdate,  concat(''location.events.'',key), value
    from profiles.location,
    jsonb_each(events)	 where tdate='''||tdate||'''
union
    select f.ilocationid,vclocationlevel,tdate, concat(f.key, ''.'', j.key), j.value
    from flat f,
    jsonb_each(f.value) j
    where jsonb_typeof(f.value) = ''object''
)
select * from json_populate_recordset(NULL::"location_type",
	(
		select json_agg(data) from (
select jsonb_object_agg(key, value) as data
from flat
where jsonb_typeof(value) <> ''object''
group by ilocationid,vclocationlevel,tdate
) a)) ;';
--raise notice '%',sql_query;
RETURN QUERY EXECUTE sql_query;
END
$_$;


CREATE FUNCTION profiles.sp_getdatamcc(tdate date) RETURNS SETOF public.mcc_type
    LANGUAGE plpgsql
    AS $_$
DECLARE
keyname text;
	recindex profiles.index;
	rec profiles.metadata;
	cnt int;
   tablewithschema text;
   typename text;
   sql_query text;

BEGIN
	tablewithschema='profiles.mcc';
	typename=tablewithschema||'_type';
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
   sql_query:='with recursive flat (imcc,tdate, key, value) as (
	select imcc,tdate, ''mcc'',format(''{"imcc":%s,"tdate":"%s"}'',cast(imcc as text),TO_CHAR(tdate,''yyyy-Mon-dd''))::jsonb as value
	from profiles.mcc where tdate='''||tdate||'''
	union
    select imcc,tdate,  concat(''mcc.geospatial.'',key), value
    from profiles.mcc,
    jsonb_each(geospatial)  where tdate='''||tdate||'''
union
	select imcc,tdate,  concat(''mcc.velocity.'',key), value
    from profiles.mcc,
    jsonb_each(velocity) where tdate='''||tdate||'''
union
	select imcc,tdate,  concat(''mcc.frequency.'',key), value
    from profiles.mcc,
    jsonb_each(frequency) where tdate='''||tdate||'''
union
	select imcc,tdate,  concat(''mcc.engagement.'',key), value
    from profiles.mcc,
    jsonb_each(engagement)	 where tdate='''||tdate||'''
union
	select imcc,tdate,  concat(''mcc.events.'',key), value
    from profiles.mcc,
    jsonb_each(events)	 where tdate='''||tdate||'''
union
    select f.imcc,tdate, concat(f.key, ''.'', j.key), j.value
    from flat f,
    jsonb_each(f.value) j
    where jsonb_typeof(f.value) = ''object''
)
select * from json_populate_recordset(NULL::"mcc_type",
	(
		select json_agg(data) from (
select jsonb_object_agg(key, value) as data
from flat
where jsonb_typeof(value) <> ''object''
group by imcc,tdate
) a)) ;';

RETURN QUERY EXECUTE sql_query;
END
$_$;


CREATE FUNCTION profiles.sp_getdatavpa(bside boolean, tdate date) RETURNS SETOF public.vpa_type
    LANGUAGE plpgsql
    AS $_$
DECLARE
keyname text;
	recindex profiles.index;
	rec profiles.metadata;
	cnt int;
   tablewithschema text;
   typename text;
   sql_query text;

BEGIN
	tablewithschema='profiles.vpa';
	typename=tablewithschema||'_type';
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
   sql_query:='with recursive flat (ivpaid,bside,tdate, key, value) as (
	select ivpaid,bside,tdate, ''vpa'',format(''{"ivpaid":%s,"bside":"%s","tdate":"%s"}'',cast(ivpaid as text),cast(bside as text),TO_CHAR(tdate,''yyyy-Mon-dd''))::jsonb as value
	from profiles.vpa where bside ='||bside||' and   tdate='''||tdate||'''
	union
    select ivpaid,bside,tdate,  concat(''vpa.longevity.'',key), value
    from profiles.vpa,
    jsonb_each(longevity) where bside ='||bside||' and   tdate='''||tdate||'''
union
	select ivpaid,bside,tdate,  concat(''vpa.velocity.'',key), value
    from profiles.vpa,
    jsonb_each(velocity)	where bside ='||bside||' and   tdate='''||tdate||'''
union
	select ivpaid,bside,tdate,  concat(''vpa.frequency.'',key), value
    from profiles.vpa,
    jsonb_each(frequency)	where bside ='||bside||' and   tdate='''||tdate||'''
union
	select ivpaid,bside,tdate,  concat(''vpa.engagement.'',key), value
    from profiles.vpa,
    jsonb_each(engagement)	where bside ='||bside||' and   tdate='''||tdate||'''
union
	select ivpaid,bside,tdate,  concat(''vpa.events.'',key), value
    from profiles.vpa,
    jsonb_each(events)		where bside ='||bside||' and   tdate='''||tdate||'''
union
    select f.ivpaid,bside,tdate, concat(f.key, ''.'', j.key), j.value
    from flat f,
    jsonb_each(f.value) j
    where jsonb_typeof(f.value) = ''object''
)
select * from json_populate_recordset(NULL::"vpa_type",
	(
		select json_agg(data) from (
select jsonb_object_agg(key, value) as data
from flat
where jsonb_typeof(value) <> ''object''
group by ivpaid,tdate
) a)) ;';

RETURN QUERY EXECUTE sql_query;
END
$_$;

CREATE FUNCTION transactions.sp_createtype(mytable text) RETURNS SETOF profiles.metadata
    LANGUAGE plpgsql
    AS $_$
DECLARE
recindex profiles.index;
	rec profiles.metadata;
	cnt int;
   createtype  text;
   tablewithschema text;
   typename text;
   sql_query text;

BEGIN
	tablewithschema='transactions.'||mytable;
	typename=mytable||'_type';
	--raise notice '% ' ,typename;
	cnt=0;
  	createtype:='CREATE TYPE %I AS (';
	sql_query:='SELECT a.attname AS name, format_type(a.atttypid, a.atttypmod) AS type
FROM
    pg_class AS c
    JOIN pg_index AS i ON c.oid = i.indrelid AND i.indisprimary
    JOIN pg_attribute AS a ON c.oid = a.attrelid AND a.attnum = ANY(i.indkey)
WHERE c.oid = $1::regclass	';
	--raise notice '% ' ,sql_query  ;

for recindex in execute sql_query  USING tablewithschema
	loop
	raise notice '%',rec;
case cnt when 0 then
		createtype:=createtype||'"'||mytable||'.'||recindex.name||'" '||recindex.type ;
		cnt=1;
else
		createtype:=createtype||',"'||mytable||'.'||recindex.name||'" '||recindex.type ;
end case;
end loop;

   sql_query:='select * from profiles.metadata where ( bui=true )and substring (vcpath, ''(?<=\[).+?(?=\])'')=$1'  ;
   raise notice '% -', sql_query;
for rec in execute sql_query  USING Mytable
	loop

	createtype:=createtype||' ,"'||translate(rec.vcpath, '[,]', '')||'" '||'text ';
end loop;
	createtype:=createtype||')';
	raise notice '% ', createtype;
EXECUTE format('DROP TYPE IF EXISTS %I' , typename);
EXECUTE format(createtype , typename);
END
$_$;


CREATE FUNCTION transactions.sp_getdatalivetrans(tdate timestamp without time zone, todate timestamp without time zone) RETURNS SETOF public.livetrans_type
    LANGUAGE plpgsql
    AS $_$
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
	typename=tablewithschema||'_type';
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
	select ilivemessageid,  concat(''livetrans.'',key), value
    from transactions.livetrans,
    jsonb_each(result) where dttrxntime::Timestamp>='''||tdate||'''::Timestamp and dttrxntime::Timestamp<='''||todate||'''::Timestamp
union
    select f.ilivemessageid, concat(f.key, ''.'', j.key), j.value
    from flat f,
    jsonb_each(f.value) j
    where jsonb_typeof(f.value) = ''object''
)

select * from json_populate_recordset(NULL::"livetrans_type",
	(
		select json_agg(data) from (
select jsonb_object_agg(key, value) as data
from flat
where jsonb_typeof(value) <> ''object''
group by ilivemessageid
) a)) ;';
--raise notice '%',sql_query;
RETURN QUERY EXECUTE sql_query;
END
$_$;




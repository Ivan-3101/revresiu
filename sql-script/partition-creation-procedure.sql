

CREATE OR REPLACE PROCEDURE masters.partition_for_tenants(
	IN _org integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    _tbl text;
    _sql text;
    tenant RECORD;
BEGIN
    FOR _tbl IN
        SELECT table_schema || '.' || table_name AS table
        FROM information_schema.tables
        WHERE  table_type = 'BASE TABLE'
        AND table_name NOT LIKE '%_1%' AND table_name NOT LIKE '%trans\_%'
        AND table_schema in ('ui', 'masters', 'analytics', 'profiles', 'sim', 'transactions')
        AND table_schema || '.' || table_name NOT IN
        ('ui.scorerequests','analytics.trans', 'ui.webuser','ui.webuseraudit','ui.webusermapping',
        'ui.webusermappingaudit', 'ui.activelogintokens','ui.activitylog','transactions.trans',
        'analytics.trans','ui.passwordhistory', 'analytics.batchtrans')
        AND table_name IN (
            SELECT relname
            FROM pg_class
            WHERE relkind = 'p'
        )
    LOOP
        FOR tenant IN
            SELECT itenantid FROM masters.tenants WHERE iorgid = _org ORDER BY itenantid
        LOOP
            _sql := 'CREATE TABLE IF NOT EXISTS ' || _tbl || '_' || tenant.itenantid ||
                     ' PARTITION OF ' || _tbl || ' FOR VALUES IN(' || tenant.itenantid || ');';

            RAISE NOTICE '%', _sql;
            EXECUTE _sql;
        END LOOP;
    END LOOP;

    -- Special handling for analytics.trans and analytics.batchtrans
    FOR tenant IN
        SELECT itenantid FROM masters.tenants WHERE iorgid = _org ORDER BY itenantid
    LOOP
        -- Partition for analytics.trans
        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS analytics.trans_%s PARTITION OF analytics.trans
             FOR VALUES IN (%s)
             PARTITION BY RANGE (dttrxntime)',
            tenant.itenantid, tenant.itenantid
        );

        -- Partition for analytics.batchtrans
        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS analytics.batchtrans_%s PARTITION OF analytics.batchtrans
             FOR VALUES IN (%s)
             PARTITION BY RANGE (dttrxntime)',
            tenant.itenantid, tenant.itenantid
        );
    END LOOP;
END
$BODY$;




CREATE OR REPLACE PROCEDURE masters.partition_for_orgs(
	IN _org integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    _tbl text;
    _sql text;
    -- org RECORD;
BEGIN

    FOR _tbl IN
        SELECT table_schema || '.' || table_name AS table
        FROM information_schema.tables
        WHERE  table_type = 'BASE TABLE'
        AND table_name NOT LIKE '%_1%'
		AND table_schema || '.' || table_name IN
        ('ui.webuser','ui.webuseraudit','ui.webusermapping',
        'ui.webusermappingaudit', 'ui.activelogintokens','ui.activitylog','ui.passwordhistory')
        AND table_name IN (
            SELECT relname
            FROM pg_class
            WHERE relkind = 'p'
        )
    LOOP


            _sql := 'CREATE TABLE IF NOT EXISTS ' || _tbl || '_' || _org || ' PARTITION OF ' || _tbl || ' FOR VALUES IN(' || _org || ');';

            -- Raise Notice
            RAISE NOTICE '%', _sql;

            -- Execute
            IF _sql IS NOT NULL THEN
                EXECUTE _sql;
            END IF;

    END LOOP;
END
$BODY$;





CREATE OR REPLACE PROCEDURE masters.add_monthly_partitions_to_trans()
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
   _sql text;
   tenant_tbl text;
   _label text;
   _from date;
   _to date;
   _start_dates date[] := ARRAY[
       DATE_TRUNC('month', CURRENT_DATE)::date,                      -- Current month start
       (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month')::date,  -- Next month start
       (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '2 month')::date  -- Next month start
   ];
BEGIN
   FOREACH _from IN ARRAY _start_dates
   LOOP
      _to := _from + INTERVAL '1 month'; -- End of month (exclusive)
      _label := TO_CHAR(_from, 'YYYYMM');

      -- Process analytics.trans partitions
      FOR tenant_tbl IN
         SELECT inhrelid::regclass::text
         FROM pg_inherits
         WHERE inhparent::regclass = 'analytics.trans'::regclass
      LOOP
         _sql := 'CREATE TABLE IF NOT EXISTS ' || tenant_tbl || '_' || _label ||
                 ' PARTITION OF ' || tenant_tbl ||
                 ' FOR VALUES FROM (''' || _from::text || ' 00:00:00+05:30'') TO (''' || _to::text || ' 00:00:00+05:30'');';

         RAISE NOTICE '%', _sql;
         EXECUTE _sql;
      END LOOP;

      -- Process analytics.batchtrans partitions
      FOR tenant_tbl IN
         SELECT inhrelid::regclass::text
         FROM pg_inherits
         WHERE inhparent::regclass = 'analytics.batchtrans'::regclass
      LOOP
         _sql := 'CREATE TABLE IF NOT EXISTS ' || tenant_tbl || '_' || _label ||
                 ' PARTITION OF ' || tenant_tbl ||
                 ' FOR VALUES FROM (''' || _from::text || ' 00:00:00+05:30'') TO (''' || _to::text || ' 00:00:00+05:30'');';

         RAISE NOTICE '%', _sql;
         EXECUTE _sql;
      END LOOP;

   END LOOP;
END
$BODY$;

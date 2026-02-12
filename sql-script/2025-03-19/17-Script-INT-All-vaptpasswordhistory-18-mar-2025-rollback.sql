DROP TABLE IF EXISTS ui.passwordhistory;

ALTER TABLE IF EXISTS ui.webuser
DROP COLUMN IF EXISTS dtlastpasswordemailsentat;

-- PROCEDURE: masters.partition_for_orgs(integer)

-- DROP PROCEDURE IF EXISTS masters.partition_for_orgs(integer);

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
        'ui.webusermappingaudit', 'ui.activelogintokens','ui.activitylog')
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


-- PROCEDURE: masters.partition_for_tenants(integer)

-- DROP PROCEDURE IF EXISTS masters.partition_for_tenants(integer);

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
		AND table_schema || '.' || table_name NOT IN 
        ('ui.scorerequests','analytics.trans', 'ui.webuser','ui.webuseraudit','ui.webusermapping',
        'ui.webusermappingaudit', 'ui.activelogintokens','ui.activitylog','transactions.trans', 'analytics.trans')
        AND table_name IN (
            SELECT relname
            FROM pg_class
            WHERE relkind = 'p'
        )
    LOOP
        FOR tenant IN
            SELECT itenantid FROM masters.tenants WHERE iorgid = _org ORDER BY itenantid
        LOOP
            _sql := 'CREATE TABLE IF NOT EXISTS ' || _tbl || '_' || tenant.itenantid || ' PARTITION OF ' || _tbl || ' FOR VALUES IN(' || tenant.itenantid || ');';
            
            -- Raise Notice
            RAISE NOTICE '%', _sql;
            
            -- Execute
                EXECUTE _sql;         
        END LOOP;
    END LOOP;
END 
$BODY$;

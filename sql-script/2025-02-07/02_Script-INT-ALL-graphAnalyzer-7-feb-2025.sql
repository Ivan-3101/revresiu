--49373

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{ 
  "analytics.trans":"SELECT X.* FROM  (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]'' AND bui = true and vcroot =''trans'' and itenantid=:tenantid)  AS X (\\"label\\", \\"value\\") where value != :SearchField"
}'::text WHERE
idashboardqueryid = 152;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT X.* FROM  (SELECT vccolumnname , vcpath FROM ui.metadata WHERE vcprefix = ''[{"Path": ""}]'' AND bui = true and vcroot =''trans'' and itenantid= :tenantid) AS X ("label", "value")
'::text WHERE
idashboardqueryid = 149;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "masters.customers": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]'' AND bui = true and vcroot =''customer'' and itenantid=:tenantid) AS X (\\"label\\", \\"value\\")",

    "masters.accounts": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]'' AND bui = true and vcroot =''account'' and itenantid=:tenantid) AS X (\\"label\\", \\"value\\")",

    "masters.vpa": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]'' AND bui = true and vcroot =''vpa'' and itenantid=:tenantid) AS X (\\"label\\", \\"value\\")"
}'::text WHERE
idashboardqueryid = 119;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
   "masters.customers": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]''  AND bui = true and vcroot =''customer'' and itenantid=:tenantid) AS X (\\"label\\", \\"value\\") WHERE X.value != :SearchField",

    "masters.accounts": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]''  AND bui = true and vcroot =''account'' and itenantid=:tenantid) AS X (\\"label\\", \\"value\\") WHERE X.value != :SearchField",

    "masters.vpa": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]''  AND bui = true and vcroot =''vpa'' and itenantid=:tenantid) AS X (\\"label\\", \\"value\\") WHERE X.value != :SearchField"
}
'::text WHERE
idashboardqueryid = 151;


UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT X.* FROM   (VALUES (''Transaction'', ''analytics.trans'')) AS X ("label", "value")'::text WHERE
idashboardqueryid = 147;



CREATE OR REPLACE FUNCTION masters.get_nodewithvcattribs(
    p_table_name text,
    column_names text[],
    common_value text,
    common_field text,
    tenant_id integer)
    RETURNS TABLE("searchValue" text, externalfield text, "displayValue" text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    query_text TEXT;
    where_condition TEXT;
    node_column TEXT;
    column_list TEXT;
BEGIN
    -- Determine the node column based on the table name
    IF p_table_name = 'masters.accounts' THEN
        node_column := 'vcexternalaccountid';
    ELSIF p_table_name = 'masters.vpa' THEN
        node_column := 'vcexternaladdressid';
    ELSIF p_table_name = 'masters.customers' THEN
        node_column := 'vcexternalcustid';
    ELSIF p_table_name = 'analytics.trans' THEN
        node_column := 'vcuniquetransid';
    ELSE
        RAISE EXCEPTION 'Invalid table name: %', p_table_name;
    END IF;

    -- Construct the WHERE condition for the provided columns
    where_condition := '(';
    FOR i IN 1..array_length(column_names, 1) LOOP
        IF i > 1 THEN
            where_condition := where_condition || ' OR ';
        END IF;
        where_condition := where_condition || column_names[i] || ' = ''' || common_value || '''';
    END LOOP;
    where_condition := where_condition || ') AND itenantid = ' || tenant_id;

    -- Build the column list for the SELECT query
    column_list := array_to_string(column_names, ', ');

    -- Construct the final query with quoted column aliases
    query_text := 
        'SELECT ''' || common_value || '''::TEXT AS "searchValue", ' || 
        node_column || '::TEXT AS "externalfield", ' ||
        common_field || '::TEXT AS "displayValue" ' ||
        'FROM ' || p_table_name || 
        ' WHERE ' || where_condition || 
        ' LIMIT 100';

    -- Debugging: Output the generated query for verification
    RAISE NOTICE 'Generated Query: %', query_text;

    -- Execute the dynamic query and return the result
    RETURN QUERY EXECUTE query_text;

END;
$BODY$;


---function
DROP FUNCTION IF EXISTS masters.get_nodewithvcattribs(TEXT, TEXT[], TEXT);

CREATE OR REPLACE FUNCTION masters.get_nodewithvcattribs(
	p_table_name text,
	column_names text[],
	common_value text,
	common_field text
	)
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
    ELSE
        RAISE EXCEPTION 'Invalid table name: %', p_table_name;
    END IF;

    -- Construct the WHERE condition for the provided columns
    where_condition := '';
    FOR i IN 1..array_length(column_names, 1) LOOP
        IF i > 1 THEN
            where_condition := where_condition || ' OR ';
        END IF;
        where_condition := where_condition || column_names[i] || ' = ''' || common_value || '''';
    END LOOP;

    -- Build the column list for the SELECT query
    column_list := array_to_string(column_names, ', ');

    -- Construct the final query with quoted column aliases
    query_text := 
        'SELECT ''' || common_value || '''::TEXT AS "searchValue", ' || 
        node_column || '::TEXT AS "externalfield", ' ||
        common_field || '::TEXT AS "displayValue" ' ||
        'FROM ' || p_table_name || 
        ' WHERE ' || where_condition;

    -- Debugging: Output the generated query for verification
    RAISE NOTICE 'Generated Query: %', query_text;

    -- Execute the dynamic query and return the result
    RETURN QUERY EXECUTE query_text;

END;
$BODY$;

ALTER FUNCTION masters.get_nodewithvcattribs(text, text[], text,text)
    OWNER TO dronapay;

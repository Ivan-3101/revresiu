INSERT INTO ui.menustructuredesc ( imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, iparentmenu, istatus ) VALUES ( 579, false, NULL, NULL, 4, 'GraphAnalyzer', 'GraphAnalyzer', NULL, NULL, '/user', 'Graph Analyzer', 'GA', '/analytics/graph-analyzer', NULL, Null, NULL, 478, 1 );


CREATE OR REPLACE FUNCTION masters.get_nodewithvcattribs(
	p_table_name text,
	column_names text[],
	common_value text)
    RETURNS SETOF record 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    query_text TEXT;
    result_row RECORD;
    where_condition TEXT;
    i INT;
    row_count INT := 0;
    node_column text;
    check_for_gstn boolean := false;
    other_columns TEXT[];
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

    -- Construct the WHERE condition for regular columns
    where_condition := '';
    FOR i IN 1..array_length(column_names, 1) LOOP
        IF i > 1 THEN
            where_condition := where_condition || ' OR ';
        END IF;
        where_condition := where_condition || column_names[i] || ' = ''' || common_value || '''';
    END LOOP;

    -- Check if 'gstn' column is present in column_names
    FOR i IN 1..array_length(column_names, 1) LOOP
        IF column_names[i] = 'gstn' THEN
            -- If 'gstn' column is present, construct WHERE condition to search within vcattribs->'yb_raw'
            where_condition := 'vcattribs->''yb_raw''->>''gstn'' = ''' || common_value || '''';
            check_for_gstn = 'true';
            ELSE
            -- If column name is not 'gstn', add it to other_columns array
            other_columns := array_append(other_columns, column_names[i]);
        END IF;
    END LOOP;

    IF check_for_gstn THEN
    -- Construct the SELECT query dynamically
    query_text := 'SELECT ' || node_column || ', ' || 'vcattribs->''yb_raw''->>''gstn''' || ',' || array_to_string(other_columns, ', ') || ' FROM ' || p_table_name || ' WHERE ' || where_condition;
    ELSE
    query_text := 'SELECT ' || node_column || ', ' || array_to_string(column_names, ', ') || ' FROM ' || p_table_name || ' WHERE ' || where_condition;
    END IF;

    -- Print out the generated query text for debugging
    RAISE NOTICE 'Generated Query: %', query_text;

    -- Execute the dynamic query and return the result
    FOR result_row IN EXECUTE query_text LOOP
        row_count := row_count + 1; -- Increment row counter
        RETURN NEXT result_row;
        -- Limit the number of rows returned per batch
        IF row_count % 1000 = 0 THEN
            RETURN;
        END IF;
    END LOOP;

    -- Return if no rows were found
    IF row_count = 0 THEN
        RAISE NOTICE 'No rows found for the given parameters.';
        RETURN;
    END IF;
END;
$BODY$;
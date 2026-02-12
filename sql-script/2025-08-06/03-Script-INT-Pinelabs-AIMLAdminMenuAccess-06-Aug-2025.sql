DO $$
DECLARE
    start_id INTEGER;
BEGIN
    SELECT COALESCE(MAX(irolemenumapid), 0) + 1 INTO start_id FROM ui.rolemenuaccessmap;

    -- Insert rows for each imenuid from 604 to 622
    FOR i IN 604..622 LOOP
        INSERT INTO ui.rolemenuaccessmap (
            irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid
        ) VALUES (
            start_id, true, true, true, true, true, true, true, i, 1, 10, 7
        );
        start_id := start_id + 1;
    END LOOP;
END $$;
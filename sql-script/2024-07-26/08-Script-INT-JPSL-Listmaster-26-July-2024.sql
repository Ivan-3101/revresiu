INSERT INTO ui.listmaster (ilistmasterid, ifordays, vcname, itenantid)
SELECT '3'::integer, '75'::integer, 'custom'::character varying, '14'::integer
WHERE NOT EXISTS (
    SELECT 1 FROM ui.listmaster 
    WHERE ilistmasterid = '3'::integer 
      AND itenantid = '14'::integer
);
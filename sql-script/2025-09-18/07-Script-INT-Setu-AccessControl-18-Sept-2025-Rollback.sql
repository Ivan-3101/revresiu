DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid IN (1, 10, 5)
    AND itenantid = 27
    AND iorgid = 12
    AND imenuid BETWEEN 604
    AND 622;
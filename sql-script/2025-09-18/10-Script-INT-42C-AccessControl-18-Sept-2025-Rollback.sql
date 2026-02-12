DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid IN (1, 10, 5)
    AND itenantid IN (6, 7, 20, 24)
    AND iorgid = 4
    AND imenuid BETWEEN 604
    AND 622;
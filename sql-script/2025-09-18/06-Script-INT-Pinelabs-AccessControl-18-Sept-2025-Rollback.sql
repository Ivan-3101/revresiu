DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid IN (1, 10, 5)
    AND itenantid = 10
    AND iorgid = 7
    AND imenuid BETWEEN 604
    AND 622;
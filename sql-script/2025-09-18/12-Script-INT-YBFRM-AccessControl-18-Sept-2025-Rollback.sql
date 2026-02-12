DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid IN (5, 10, 1)
    AND itenantid = 9
    AND iorgid = 6
    AND imenuid BETWEEN 604
    AND 622;
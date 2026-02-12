DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid IN (2, 1)
    AND itenantid = 25
    AND iorgid = 11
    AND imenuid BETWEEN 604
    AND 622;
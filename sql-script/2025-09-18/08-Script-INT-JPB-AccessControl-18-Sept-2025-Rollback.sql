DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid IN (2, 1)
    AND itenantid = 12
    AND iorgid = 9
    AND imenuid BETWEEN 604
    AND 622;
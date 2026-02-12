DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid IN (13, 14, 1, 16)
    AND itenantid = 14
    AND iorgid = 10
    AND imenuid BETWEEN 604
    AND 622;
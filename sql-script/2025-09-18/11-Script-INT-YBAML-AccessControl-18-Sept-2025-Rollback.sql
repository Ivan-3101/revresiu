DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid IN (5, 10)
    AND itenantid IN (8, 16, 17, 21, 22, 23)
    AND iorgid = 5
    AND imenuid BETWEEN 604
    AND 622;

DELETE FROM
    ui.rolemenuaccessmap
WHERE
    iroleid = 1
    AND itenantid IN (8, 16)
    AND iorgid = 5
    AND imenuid BETWEEN 604
    AND 622;
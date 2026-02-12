-- Delete mappings for Risk Admin (roleid 10)
DELETE FROM ui.rolemenuaccessmap 
WHERE itenantid = 27 
AND iroleid = 10 
AND imenuid IN (572, 480, 573, 574, 575);

-- Delete mappings for MIS (roleid 2)
DELETE FROM ui.rolemenuaccessmap 
WHERE itenantid = 27 
AND iroleid = 2 
AND imenuid IN (579, 479, 494, 536);

-- Delete mappings for Risk Analyst (roleid 5)
DELETE FROM ui.rolemenuaccessmap 
WHERE itenantid = 27 
AND iroleid = 5 
AND imenuid IN (572, 503, 480, 573, 574, 575, 577, 576, 581, 589, 590, 591, 592, 513, 518, 519, 520);


delete from ui.rolemenuaccessmap where imenuid=602 and itenantid in (27);
--update rulesaudit table: set  vcruledescription = vcrulename wherever vcruledescription is NULL or blank
UPDATE ui.rulesaudit SET vcruledescription = vcrulename
WHERE vcruledescription IS NULL OR TRIM(vcruledescription) = '';

--Alter column constraint
ALTER TABLE ui.rulesaudit
ALTER COLUMN vcrulename SET NOT NULL,
ALTER COLUMN vcruledescription SET NOT NULL;


--update rules table: set  vcruledescription = vcrulename wherever vcruledescription is NULL or blank
UPDATE ui.rules SET vcruledescription = vcrulename
WHERE vcruledescription IS NULL
   OR TRIM(vcruledescription) = '';

--Alter column constraint
ALTER TABLE ui.rules
ALTER COLUMN vcruledescription SET NOT NULL;
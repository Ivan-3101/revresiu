ALTER TABLE ui.webuser
ALTER COLUMN vcaddress TYPE character varying(100)
COLLATE pg_catalog."default";

ALTER TABLE ui.webuseraudit
ALTER COLUMN vcaddress TYPE character varying(100)
COLLATE pg_catalog."default";

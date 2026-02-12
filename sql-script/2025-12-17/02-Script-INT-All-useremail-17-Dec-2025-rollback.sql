ALTER TABLE ui.webuseraudit
    ALTER COLUMN vcemailid TYPE character varying(35) COLLATE pg_catalog."default";

ALTER TABLE ui.webuser
    ALTER COLUMN vcemailid TYPE character varying(35) COLLATE pg_catalog."default";
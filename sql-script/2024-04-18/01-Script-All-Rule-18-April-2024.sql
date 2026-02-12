ALTER TABLE ui.rules
    ALTER COLUMN vcruleorder TYPE character varying(1000);

ALTER TABLE ui.rulesaudit
    ALTER COLUMN vcruleorder TYPE character varying(1000);

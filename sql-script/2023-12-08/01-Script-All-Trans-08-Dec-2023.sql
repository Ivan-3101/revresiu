ALTER TABLE IF EXISTS ui.dashboard
    ADD COLUMN itenantid integer;

ALTER TABLE IF EXISTS ui.dashboard
    ADD CONSTRAINT fkfk67or610kb80haurhqvumjpe FOREIGN KEY (itenantid)
    REFERENCES ui.tenants (itenantid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS ui.dashboard
    ADD COLUMN bdynamic boolean;

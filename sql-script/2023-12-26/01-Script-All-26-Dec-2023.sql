ALTER TABLE ui.reportmailconfig ADD COLUMN itenantid integer;
ALTER TABLE ui.reportmailconfig ADD COLUMN iuserid integer;
ALTER TABLE IF EXISTS ui.reportmailconfig
    ADD CONSTRAINT tenant_fk FOREIGN KEY (itenantid)
    REFERENCES ui.tenants (itenantid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS ui.reportmailconfig
    ADD CONSTRAINT webuser_fk FOREIGN KEY (iuserid)
    REFERENCES ui.webuser (iuserid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE ui.emailaudittrail add column itenantid integer;

ALTER TABLE ui.emailaudittrail add constraint tenant_fk FOREIGN KEY(itenantid)
REFERENCES ui.tenants (itenantid) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION;

ALTER TABLE IF EXISTS ui.rulesdraftaudit
    ADD COLUMN itenantid integer;
    
ALTER TABLE IF EXISTS ui.rulesdraftaudit
    ADD CONSTRAINT fkg3wpaicsu24nc8f2spmr7hc9k FOREIGN KEY (itenantid)
    REFERENCES ui.tenants (itenantid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
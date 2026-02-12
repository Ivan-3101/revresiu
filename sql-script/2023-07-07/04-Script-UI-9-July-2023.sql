CREATE TABLE IF NOT EXISTS ui.reportusermap
(
    reportid integer NOT NULL,
    iuserid integer NOT NULL,
    CONSTRAINT fk5wr3fa31aoet3ls030sxjg9t6 FOREIGN KEY (iuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fksio9chbe0i9ngb46khspr8h2r FOREIGN KEY (reportid)
        REFERENCES ui.reportmailconfig (reportid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE ui.rules (
                          iruleid integer NOT NULL,
                          bactive boolean,
                          bcustom boolean,
                          bdelete boolean,
                          dtentrydatetime timestamp without time zone,
                          dtstartdate timestamp without time zone,
                          iversion integer,
                          vcbpmnfilelocation character varying(255),
                          vcruledescription character varying(1000),
                          vcruledetail text,
                          vcrulemapinfo character varying(255),
                          vcrulename character varying(255),
                          vcruleorder character varying(255) NOT NULL,
                          vcruleparams text,
                          idecisionid integer,
                          iuserid integer,
                          iruleavailableid integer,
                          vclabel text,
                          ruledimension character varying(255),
                          rulestate character varying(255),
                          vcruletype character varying(255),
                          iinstance integer
);

CREATE SEQUENCE ui.rules_iruleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ONLY ui.rules ALTER COLUMN iruleid SET DEFAULT nextval('ui.rules_iruleid_seq'::regclass);


ALTER TABLE ONLY ui.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (iruleid);


ALTER TABLE ONLY ui.rules
    ADD CONSTRAINT fkh2s3a76gcpgau4tlan4sohwm8 FOREIGN KEY (idecisionid) REFERENCES masters.decisions(idecisionid);

ALTER TABLE ONLY ui.rules
    ADD CONSTRAINT fksy7v9wykm1xdo7v0g8cft34kq FOREIGN KEY (iuserid) REFERENCES ui.webuser(iuserid);

Alter table ui.rulesaudit Alter Column vcrulename type text;




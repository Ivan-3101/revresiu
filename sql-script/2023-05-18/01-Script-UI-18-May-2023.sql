CREATE SEQUENCE IF NOT EXISTS ui.metadata_imetadataid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE SEQUENCE IF NOT EXISTS ui.metadataaudit_imetadataauditid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.metadata
(
    imetadataid integer NOT NULL DEFAULT nextval('ui.metadata_imetadataid_seq'::regclass),
    dtapproverstamp timestamp without time zone,
    dtentrystamp timestamp without time zone,
    bml boolean,
    bscore boolean,
    bui boolean,
    irecordstatus integer,
    vcprefix jsonb,
    vccolumnname character varying(1024) COLLATE pg_catalog."default",
    vcdescription character varying(1024) COLLATE pg_catalog."default",
    vcdtype character varying(32) COLLATE pg_catalog."default",
    vcpath character varying(256) COLLATE pg_catalog."default",
    vcquery text COLLATE pg_catalog."default",
    vcroot character varying(99) COLLATE pg_catalog."default",
    iapproveruserid integer,
    ientryuserid integer,
    istatus integer,
    config jsonb,
    CONSTRAINT metadata_pkey PRIMARY KEY (imetadataid),
    CONSTRAINT fk3f08fljy79orb42hbe2bbomt2 FOREIGN KEY (ientryuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkh6f5h5agp78e0qdw8202k0ys5 FOREIGN KEY (iapproveruserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fksny6fpkiotmw9oeirb3s0y8bb FOREIGN KEY (istatus)
        REFERENCES ui.statuscode (istatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS ui.metadataaudit
(
    imetadataauditid integer NOT NULL DEFAULT nextval('ui.metadataaudit_imetadataauditid_seq'::regclass),
    bclosed boolean NOT NULL,
    dtapproverstamp timestamp without time zone,
    dtentrystamp timestamp without time zone,
    vcaction character varying(3) COLLATE pg_catalog."default" NOT NULL,
    vcremark character varying(255) COLLATE pg_catalog."default",
    bml boolean,
    bscore boolean,
    bui boolean,
    irecordstatus integer,
    vcprefix jsonb,
    vccolumnname character varying(1024) COLLATE pg_catalog."default",
    vcdescription character varying(1024) COLLATE pg_catalog."default",
    vcdtype character varying(32) COLLATE pg_catalog."default",
    vcpath character varying(256) COLLATE pg_catalog."default",
    vcquery text COLLATE pg_catalog."default",
    vcroot character varying(99) COLLATE pg_catalog."default",
    iapproveruserid integer,
    ientryuserid integer,
    istatus integer,
    config jsonb,
    CONSTRAINT metadataaudit_pkey PRIMARY KEY (imetadataauditid),
    CONSTRAINT fk5kx19cp85109ltlab6ndhhdev FOREIGN KEY (iapproveruserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkev98vsw0pd3c60uij53we9qeg FOREIGN KEY (ientryuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fklrusgf5i7xlvo21s0aemo8ncw FOREIGN KEY (istatus)
        REFERENCES ui.statuscode (istatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
CREATE TABLE IF NOT EXISTS ui.webusermapping
(
    mappingid integer NOT NULL,
    mappingtype character varying(255) COLLATE pg_catalog."default" NOT NULL,
    webuserid integer NOT NULL,
    CONSTRAINT webusermapping_pkey PRIMARY KEY (mappingid, mappingtype, webuserid),
    CONSTRAINT fkbh0qdidfpaf8kjhci3wg8ud61 FOREIGN KEY (webuserid)
        REFERENCES ui.webuser (iuserid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE IF NOT EXISTS ui.webusermappingaudit
(
    mappingid integer NOT NULL,
    mappingtype character varying(255) COLLATE pg_catalog."default" NOT NULL,
    webuserauditid integer NOT NULL,
    CONSTRAINT webusermappingaudit_pkey PRIMARY KEY (mappingid, mappingtype, webuserauditid),
    CONSTRAINT fkos86kh2g1ynt1q7cos8g6nx3s FOREIGN KEY (webuserauditid)
        REFERENCES ui.webuseraudit (iuserauditid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


INSERT INTO ui.webusermapping(
	mappingid, mappingtype, webuserid)
	SELECT iroleid, 'Role', iuserid
	FROM ui.userrolemap;

INSERT INTO ui.webusermapping(
	mappingid, mappingtype, webuserid)
	SELECT igroupid, 'Group', iuserid
	FROM ui.usergroupmap;

DROP VIEW ui.userrolemenuaccess;

CREATE OR REPLACE VIEW ui.userrolemenuaccess
 AS
 SELECT row_number() OVER (ORDER BY webuser.iuserid) AS userrolemenuviewid,
    webuser.iuserid,
    webusermapping.mappingid as "iroleid",
    rolemenuaccessmap.imenuid,
    menustructuredesc.iparentmenu,
    menustructuredesc.vcicon,
    menustructuredesc.vcmenuname,
    menustructuredesc.vcmini,
    menustructuredesc.vcpath,
    menustructuredesc.vcrtlmini,
    menustructuredesc.vcrtlname,
    menustructuredesc.vcstate,
    menustructuredesc.vclayout,
    menustructuredesc.bcollapse,
    menustructuredesc.isortorder,
    rolemenuaccessmap.badd,
    rolemenuaccessmap.bapprove,
    rolemenuaccessmap.bdelete,
    rolemenuaccessmap.bpublish,
    rolemenuaccessmap.bview,
    rolemenuaccessmap.bedit
   FROM ui.webuser
     LEFT JOIN ui.webusermapping ON webusermapping.webuserid = webuser.iuserid and webusermapping.mappingtype = 'Role'
     LEFT JOIN ui.rolemenuaccessmap ON rolemenuaccessmap.iroleid = webusermapping.mappingid
     LEFT JOIN ui.menustructuredesc ON menustructuredesc.imenuid = rolemenuaccessmap.imenuid;
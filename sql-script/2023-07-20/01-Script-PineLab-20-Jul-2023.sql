CREATE SEQUENCE IF NOT EXISTS ui.responsecallbacktemplate_templateid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE IF NOT EXISTS ui.responsecallbacktemplate
(
    templateid integer NOT NULL DEFAULT nextval('ui.responsecallbacktemplate_templateid_seq'::regclass),
    subjecttemplate text ,
    bodytemplate text ,
	messageName text 
 
);

INSERT INTO ui.responsecallbacktemplate(templateid, subjecttemplate, bodytemplate, messagename)	VALUES (1, '', '', 'response_from_merchant');
UPDATE ui.emailtemplate	SET  subject='[(${transactionId})] | Hold on Identified Risky Transaction' WHERE id=11;
	
UPDATE ui.emailtemplate	SET  subject='Request for Information Regarding Identified Risky Transaction [(${transactionId})]' WHERE id=12;

UPDATE ui.emailtemplate	SET  subject='[(${transactionId})] | Transaction Settlement Processed'	WHERE id=13;
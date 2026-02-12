UPDATE ui.ValidationFieldsList
SET vcValidation = '{ "maxLength": 255 }'
WHERE vcFieldDisplayName IN ('Payee Address', 'Payer Address');

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath) VALUES (
( select max(ifieldid) + 1 from ui.validationfieldslist )::integer, false::boolean, 'String'::character varying, 'Payee Card'::character varying, 'card_number'::character varying, 'payee.attribs.card.cardReference'::character varying)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath) VALUES (
( select max(ifieldid) + 1 from ui.validationfieldslist )::integer, false::boolean, 'String'::character varying, 'Payer Card'::character varying, 'card_number'::character varying, 'payer.attribs.card.cardReference'::character varying)
 returning ifieldid;


DELETE FROM ui.rolemenuaccessmap WHERE imenuid = 498;
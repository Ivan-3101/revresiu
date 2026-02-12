

CREATE TABLE masters.rulesavailable (
                                        iruleavailableid integer NOT NULL,
                                        bactive boolean,
                                        bcustom boolean,
                                        bdelete boolean,
                                        bpayee boolean,
                                        bpayer boolean,
                                        btransaction boolean,
                                        ruledimension character varying(255),
                                        rulestate character varying(255),
                                        vclabel text,
                                        vcruledescription character varying(1000),
                                        vcrulename character varying(255),
                                        vcruleparams text,
                                        vcruletype character varying(255),
                                        idecisionid integer
);


CREATE SEQUENCE masters.rulesavailable_iruleavailableid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ONLY masters.rulesavailable ALTER COLUMN iruleavailableid SET DEFAULT nextval('masters.rulesavailable_iruleavailableid_seq'::regclass);


INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (1, true, false, false, true, true, true, 'List ', 'Alert', '{ "label": ["Static","Transaction","Payer","Payee","List"]}', NULL, 'Whitelist', '{"type":1,"successscore":0,"successremark":"White list","failremarks":" ","failscore":0}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (2, true, false, false, true, true, true, 'List ', 'Decline', '{ "label": ["Static","Transaction","Payer","Payee","List"]}', NULL, 'Blacklist', '{"type":0,"successscore":0,"successremark":"","failremarks":"in Blacklist ","failscore":100}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (3, true, false, false, true, true, true, 'List ', 'Alert', '{ "label": ["Static","Transaction","Payer","Payee","List"]}', NULL, 'Greylist', '{"type":1,"successscore":0,"successremark":"","failremarks":"in Greylist ","failscore":10}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (7, true, false, false, false, false, true, 'Value', 'Alert', '{ "label": ["Static","Transaction","Payer","Value"]}', NULL, 'Payer value exceeded % of limit', '{"type":1,"successscore":0,"successremark":"","failremarks":"Payer exhausted signficant % of limit","failscore":10,"cash_per": 80, "credit_per": 40}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (9, true, false, false, true, true, true, 'MCC', 'Alert', '{ "label": ["Static","Transaction","Payer","Payee","MCC"]}', NULL, 'Payer transacting at odd time slot for MCC', '{"type":1,"successscore":0,"successremark":"","failremarks":"Payer transacting at odd time slot for MCC","failscore":10}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (10, true, false, false, true, true, true, 'MCC', 'Alert', '{ "label": ["Static","Transaction","Payer","Payee","MCC"]}', NULL, 'Payer exceeded MCC specific limit', '{"type":1,"successscore":0,"successremark":"","failremarks":"MCC Limits exceeded ","failscore":10}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (11, true, false, false, true, false, true, 'Value', 'Alert', '{ "label": ["Dynamic","Transaction","Payee","Value"]}', NULL, 'Payee value exceeded 95th per', '{"type":1,"successscore":0,"successremark":"","failremarks":"Payee Value exceeded 95th per ","failscore":10}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (12, true, false, false, true, true, true, 'MCC', 'Alert', '{ "label": ["Dynamic","Transaction","Payer","Payee","MCC"]}', NULL, 'MCC value exceeds 95th per', '{"type":1,"successscore":0,"successremark":"","failremarks":"MCC Value exceeded 95th per ","failscore":10}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (13, true, false, false, true, true, true, 'Value', 'Alert', '{ "label": ["Dynamic","Transaction","Payer","Payee","Value"]}', NULL, 'Location value exceeds 95th per', '{"type":1,"successscore":0,"successremark":"","failremarks":"Small value laundering ","failscore":10}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (14, true, false, false, true, true, true, 'Value', 'Alert', '{ "label": ["Heuristic","Transaction","Payer","Payee","Value"]}', NULL, 'Small value laundering Heuristic', '{"type":1,"successscore":0,"successremark":"","failremarks":"Merchant risk score  ","failscore":10}', 'Heuristic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (15, true, false, false, true, true, true, 'IP', 'Alert', '{ "label": ["Heuristic","Transaction","Payer","Payee","Value"]}', NULL, 'Merchant risk score Heuristic', '{"type":0,"successscore":0,"successremark":"","failremarks":" IP TOR","failscore":100}', 'Heuristic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (16, true, false, false, true, true, false, 'IP', 'Block', '{ "label": ["Dynamic","Payer","Payee","IP"]}', NULL, 'IP from TOR', '{"type":0,"successscore":0,"successremark":"","failremarks":" IP TOR","failscore":100}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (17, true, false, false, true, true, false, 'IP', 'Block', '{ "label": ["Dynamic","Payer","Payee","IP"]}', NULL, 'IP and BIN Country mismatch', '{"type":0,"successscore":0,"successremark":"","failremarks":" IP and BIN Country mismatch","failscore":100}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (18, true, false, false, true, true, false, 'IP', 'Block', '{ "label": ["Dynamic","Payer","Payee","IP"]}', NULL, 'IP from Public Proxy', '{"type":0,"successscore":0,"successremark":"","failremarks":" Public IP ","failscore":100}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (19, true, false, false, true, true, false, 'KSD', 'Alert', '{ "label": ["Dynamic","Payer","Payee","KSD"]}', NULL, 'Card data Keystroke Bot', '{"type":0,"successscore":0,"successremark":"","failremarks":" Public IP ","failscore":100}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (20, true, false, false, true, true, false, 'Device', 'Alert', '{ "label": ["Dynamic","Payer","Payee","Device"]}', NULL, 'Browser fingerprint suspicious', '{"type":0,"successscore":0,"successremark":"","failremarks":" Browser fingerprint suspicious","failscore":100}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (21, true, false, false, true, true, false, 'Device', 'Alert', '{ "label": ["Dynamic","Payer","Payee","Device"]}', NULL, 'Device fingerprint suspicious', '{"type":0,"successscore":0,"successremark":"","failremarks":" Device fingerprint suspicious","failscore":100}', 'Dynamic', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (4, true, false, false, false, true, true, 'Value', 'Alert', '{ "label": ["Static","Transaction","Payer","Value"]}', NULL, 'Payer value exceeded 60 mins', '{"type":1,"successscore":0,"successremark":"","m60":{"value":7500000,"failremarks":"Payee value exceeded in 60 min timeframe","failscore":10}}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (5, true, false, false, true, true, true, 'Value', 'Alert', '{ "label": ["Static","Transaction","Payee","Value"]}', NULL, 'Payee value exceeded 30 mins', '{"type":1,"successscore":0,"successremark":"","m30":{"value":5000000,"failremarks":"Payee value exceeded in 30 min timeframe","failscore":10}}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (6, true, false, false, false, true, true, 'Count', 'Alert', '{ "label": ["Static","Transaction","Payer","Count"]}', NULL, 'Payer txn count exceeded 1 day', '{"type":1,"successscore":0,"successremark":"","d01":{"count":10,"failremarks":"d01 velocity failed","failscore":10}}', 'Static', 1);
INSERT INTO masters.rulesavailable (iruleavailableid, bactive, bcustom, bdelete, bpayee, bpayer, btransaction, ruledimension, rulestate, vclabel, vcruledescription, vcrulename, vcruleparams, vcruletype, idecisionid) VALUES (8, true, false, false, true, true, true, 'Count', 'Alert', '{ "label": ["Static","Transaction","Payer","Payee","Count"]}', NULL, 'Txn with same payee exceeded 60 min', '{"type":1,"successscore":0,"successremark":"","m60":{"count":7,"failremarks":"Txn with same payee exceeded 60 min","failscore":10}}', 'Static', 1);


SELECT pg_catalog.setval('masters.rulesavailable_iruleavailableid_seq', 1, false);


ALTER TABLE ONLY masters.rulesavailable
    ADD CONSTRAINT rulesavailable_pkey PRIMARY KEY (iruleavailableid);

ALTER TABLE ONLY masters.rulesavailable
    ADD CONSTRAINT fkc02pbjv2lydt6tbalqt8itqlw FOREIGN KEY (idecisionid) REFERENCES masters.decisions(idecisionid);



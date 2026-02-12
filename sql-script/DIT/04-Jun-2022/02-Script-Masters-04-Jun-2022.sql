ALTER TABLE masters.transactionclasses
    ADD COLUMN vcdecisionparms jsonb,ADD COLUMN vcresultparams jsonb;

ALTER SEQUENCE masters.transactionclasses_seq RESTART WITH 10;

INSERT INTO masters.transactionclasses(
    vcclassname, iproductid, ichannelid, idecisionid, bpayermandatory, bpayeemandatory, bactive, irecordstatus, dtentrydatetime, vcdecisionparms, vcresultparams)
VALUES ('UPI', 1, 1, 1, true, true, true, 1, '2022-06-01 13:10:22', null, null),('CARD|PG', 5, 1, 2, true, true, true, 1, '2022-06-01 13:10:22', null, null),('NB|PG', 1, 1, 1, true, true, true, 1, '2022-06-01 13:10:22', null, null);


ALTER SEQUENCE masters.decisions_seq RESTART WITH 6;

INSERT INTO masters.decisions(
    iproductid, vcdecisionname, vcdecisiondetail, vcdecisionmapinfo, bactive, dtentrydatetime, iuserid, irecordstatus)
VALUES ( 1, 'UPI Hi Risk MCC', 'UPI FRM Authorization', null, true, null, null, 1),
       ( 1, 'UPI Low Risk MCC', 'UPI FRM Authorization', null, true, null, null, 1),
       ( 5, 'Card Hi Risk MCC', 'Card Authorization', null, true, null, null, 1),
       ( 5, 'Card Medium Risk MCC', 'Card Authorization', null, true, null, null, 1),
       ( 5, 'Card Low Risk MCC', 'Card Authorization', null, true, null, null, 1);
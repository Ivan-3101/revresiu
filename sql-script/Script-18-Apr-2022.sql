UPDATE ui.scorerequests
	SET vcrequestdata='{
  "reqid": "{{$timestamp}}",
  "org": "Mswipe",
  "ts": "{{$isoTimestamp}}",
  "txn": {
    "ts": "{{$isoTimestamp}}",
    "id": "{{$timestamp}}",
    "org_txn_id": "",
    "note": "online purchase",
    "type": "PAY",
    "class": "UPI|API",
    "attribs": {
      "key_name": "transaction attribute value"
    }
  },
  "payer": {
    "addr": "nt@oksbi",
    "type": "PERSON",
    "amount": 100000,
    "currency": "INR",
    "attribs": {
      "identity": {
        "type": "AADHAAR",
        "verified_name": "Niraj T"
      },
      "device": {
        "id": "123456789",
        "mobile": "91.99999.99999",
        "geocode": "12.9667,77.5667",
        "location": "Sarjapur Road, Bangalore, KA, IN",
        "ip": "123.123.123.123",
        "type": "mobile",
        "os": "Android 4.4",
        "app": "GPay",
        "capability": "11001"
      }
    }
  },
  "payee": {
    "addr": "BurgerKing@oksbi",
    "type": "ENTITY",
    "mcc": 5814,
    "amount": 100000,
    "currency": "INR",
    "attribs": {
      "identity": {
        "type": "ACCOUNT",
        "verified_name": "Pizza Hut"
      }
    }
  }
}'
	WHERE vcrequestid='R-1634207692255';
UPDATE ui.scorerequests
	SET vcrequestdata='{
  "reqid": "{{$timestamp}}",
  "org": "Mswipe",
  "ts": "{{$isoTimestamp}}",
  "txn": {
    "ts": "{{$isoTimestamp}}",
    "id": "{{$timestamp}}",
    "org_txn_id": "",
    "note": "online purchase",
    "type": "PAY",
    "class": "UPI|API",
    "attribs": {
      "key_name": "transaction attribute value"
    }
  },
  "payer": {
    "addr": "nt@oksbi",
    "type": "PERSON",
    "amount": 100000,
    "currency": "INR",
    "attribs": {
      "identity": {
        "type": "AADHAAR",
        "verified_name": "Niraj T"
      },
      "device": {
        "id": "123456789",
        "mobile": "91.99999.99999",
        "geocode": "12.9667,77.5667",
        "location": "Sarjapur Road, Bangalore, KA, IN",
        "ip": "123.123.123.123",
        "type": "mobile",
        "os": "Android 4.4",
        "app": "GPay",
        "capability": "11001"
      }
    }
  },
  "payee": {
    "addr": "BurgerKing@oksbi",
    "type": "ENTITY",
    "mcc": 5814,
    "amount": 100000,
    "currency": "INR",
    "attribs": {
      "identity": {
        "type": "ACCOUNT",
        "verified_name": "Pizza Hut"
      }
    }
  }
}'
	WHERE vcrequestid='R-1634207692258';


CREATE TABLE ui.ticketidgenerator (
    ticketid bigint NOT NULL
);


ALTER TABLE ONLY ui.ticketidgenerator
    ADD CONSTRAINT ticketidgenerator_pkey PRIMARY KEY (ticketid);


INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (16, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and iLiveMessageID > :iLiveMessageID order by dtTrxnTime desc', 'livetransactionAutoRefresh');


INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (17, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payer.vcvpaname as "Payer Name",
Payee.vcAddress as "Payee VPA",
payee.vcvpaname as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule"
from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and txnclass = :className and iLiveMessageID > :iLiveMessageID order by dtTrxnTime desc', 'livetransactionbyclassAutoRefresh');

INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (20, 1, 'iLiveMessageID', 'Integer', 16);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (21, 1, 'className', 'String', 17);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (22, 2, 'iLiveMessageID', 'Integer', 17);

CREATE SEQUENCE ui.ticket_seq
    INCREMENT 1
START 1;

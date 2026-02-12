alter table masters.rules add constraint FKh2s3a76gcpgau4tlan4sohwm8 foreign key (idecisionid) references masters.decisions;
ALTER TABLE masters.rules DROP COLUMN IF EXISTS idecisionsid CASCADE;
ALTER TABLE ui.webuser ADD COLUMN resetpasswordtoken varchar(60);
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
	WHERE vcrequestid='1646332038';
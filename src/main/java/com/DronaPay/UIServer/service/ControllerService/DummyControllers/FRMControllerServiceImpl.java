package com.DronaPay.UIServer.service.ControllerService.DummyControllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class FRMControllerServiceImpl implements FRMControllerService{


    private static final Logger LOGGER = LoggerFactory.getLogger(FRMControllerServiceImpl.class);

    public ResponseEntity<?> blockFund(String jsonString) {

        LOGGER.debug("enrich case called");

        String response="{\n" +
                "\"variables\":{\n" +
                "\"Transaction\":{\n" +
                "\"value\":\"{\\\"reqid\\\":\\\"26\\\",\\\"ts\\\":\\\"2021-10-18T10:04:30.000+05:30\\\",\\\"txn\\\":{\\\"ts\\\":\\\"2021-10-18T10:04:29.500+05:30\\\",\\\"id\\\":\\\"t26\\\",\\\"org_txn_id\\\":\\\"\\\",\\\"note\\\":\\\"online purchase\\\",\\\"type\\\":\\\"PAY\\\",\\\"class\\\":\\\"UPI|API\\\",\\\"attribs\\\":{\\\"status\\\":\\\"settled\\\"}},\\\"payer\\\":{\\\"addr\\\":\\\"kalicharan_1@okhdfc\\\",\\\"type\\\":\\\"PERSON\\\",\\\"amount\\\":50000,\\\"currency\\\":\\\"INR\\\",\\\"attribs\\\":{\\\"identity\\\":{\\\"type\\\":\\\"AADHAAR\\\",\\\"verified_name\\\":\\\"kalicharan\\\"},\\\"device\\\":{\\\"id\\\":\\\"123456789\\\",\\\"mobile\\\":\\\"91.99999.99999\\\",\\\"geocode\\\":\\\"12.9667,77.5667\\\",\\\"location\\\":\\\"Sarjapur Road, Bangalore, KA, IN\\\",\\\"ip\\\":\\\"123.123.123.123\\\",\\\"type\\\":\\\"mobile\\\",\\\"os\\\":\\\"Android 4.4\\\",\\\"app\\\":\\\"CC 1.0\\\",\\\"capability\\\":\\\"11001\\\"}}},\\\"payee\\\":{\\\"addr\\\":\\\"chheda@ybl\\\",\\\"type\\\":\\\"ENTITY\\\",\\\"mcc\\\":5411,\\\"amount\\\":50000,\\\"currency\\\":\\\"INR\\\",\\\"attribs\\\":{\\\"identity\\\":{\\\"type\\\":\\\"ACCOUNT\\\",\\\"verified_name\\\":\\\"Chheda Stores\\\"},\\\"account_details\\\":{ \\\"phone\\\":\\\"918097009979\\\" }}}}\",\n"
                +
                "\"type\":\"string\"\n" +
                "},\n" +
                "\"RiskScore\":{\"value\":20,\"type\":\"long\"}}}";

        return ResponseEntity.ok(response);
    }
}

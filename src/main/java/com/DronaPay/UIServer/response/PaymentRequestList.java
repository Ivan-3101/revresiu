package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.model.ScoreRequests;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class PaymentRequestList {
    private String value;
    private Integer label;
    public static List<PaymentRequestList> parse(List<ScoreRequests> srl)
    {
        List<PaymentRequestList> res = new ArrayList<>();
        int index = 1;
        for(ScoreRequests sr : srl)
        {
            PaymentRequestList prl = new PaymentRequestList();
            prl.setValue(sr.getVcRequestID());
            prl.setLabel(index);
            res.add(prl);
            index++;
        }
        return res;
    }
}

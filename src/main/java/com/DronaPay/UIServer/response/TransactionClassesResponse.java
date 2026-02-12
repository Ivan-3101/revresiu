package com.DronaPay.UIServer.response;

import com.DronaPay.UIServer.model.Decisions;
import com.DronaPay.UIServer.model.TransactionClasses;
import lombok.Data;
import org.springframework.web.util.HtmlUtils;

import java.util.ArrayList;
import java.util.List;

@Data
public class TransactionClassesResponse {
    private Integer value;
    private String label;

    public static List<TransactionClassesResponse> parse(List<TransactionClasses> tcl)
    {
        List<TransactionClassesResponse> res = new ArrayList<>();
        for(TransactionClasses tc : tcl)
        {

            TransactionClassesResponse tcr = new TransactionClassesResponse();
            tcr.setValue(tc.getIClassID());
            tcr.setLabel(HtmlUtils.htmlEscape(tc.getVcClassName()));
            res.add(tcr);
        }
        return res;
    }
    public static List<TransactionClassesResponse> parseParameterType(List<String> prl)
    {
        List<TransactionClassesResponse> res = new ArrayList<>();
        int i = 1;
        for(String pr : prl)
        {
            TransactionClassesResponse tcr = new TransactionClassesResponse();
            tcr.setValue(i);
            tcr.setLabel(pr);
            res.add(tcr);
            i++;
        }
        return res;
    }

    public static TransactionClassesResponse parse(TransactionClasses transactionClasses)
    {
        TransactionClassesResponse response = new TransactionClassesResponse();
        response.setValue(transactionClasses.getIClassID());
        response.setLabel(transactionClasses.getVcClassName());
        return response;
    }

    public static TransactionClassesResponse parse(Decisions decision)
    {
        TransactionClassesResponse response = new TransactionClassesResponse();
        response.setValue(decision.getIDecisionID());
        response.setLabel(decision.getVcDecisionName());
        return response;
    }
}

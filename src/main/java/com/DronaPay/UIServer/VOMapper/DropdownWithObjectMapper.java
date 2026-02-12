package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.ResponseVO.DropdownWithObject;
import com.DronaPay.UIServer.model.Dashboard;
import com.DronaPay.UIServer.model.DecisionUi;
import com.DronaPay.UIServer.model.ListMaster;
import com.DronaPay.UIServer.model.LiveTrans;
import com.DronaPay.UIServer.model.Organization;
import com.DronaPay.UIServer.model.Vpa;
import com.DronaPay.UIServer.model.WorkflowMasters;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class DropdownWithObjectMapper {


    public static List<DropdownWithObject> parseFromOrganizations(List<Organization> orgs) {
        List<DropdownWithObject> res = new ArrayList<>();
        for(Organization org: orgs) {
            DropdownWithObject temp = DropdownWithObject
                                    .builder()
                                    .label(org.getVcOrgId())
                                    .value(org.getVcOrgId())
                                    .build();
            res.add(temp);
        }
        return res;
    }
    public static List<DropdownWithObject> parseVpaFromLiveTransForPayer(List<LiveTrans> liveTransList) {
        List<DropdownWithObject> res = new ArrayList<>();
        for (LiveTrans liveTrans : liveTransList) {
            DropdownWithObject tcr = DropdownWithObject
                    .builder()
                    .label(liveTrans.getIPayerVpaID().getVcExternalAddressID())
                    .value(liveTrans.getIPayerVpaID().getIVpaID())
                    .build();
            res.add(tcr);
        }
        return res;
    }

    public static List<DropdownWithObject> parseManualWorkflows(List<WorkflowMasters> workflowlist) {
        List <DropdownWithObject> res = new ArrayList<>();
        for(WorkflowMasters wf: workflowlist) {
            DropdownWithObject wflObj = DropdownWithObject.builder().label(wf.getWorkflowName()).value(wf.getWorkflowId()).build();
            res.add(wflObj);
        }
        return res;
    }

     public static List<DropdownWithObject> parseManualDecisions(List<DecisionUi> decList) {
        List <DropdownWithObject> res = new ArrayList<>();
        for(DecisionUi dec: decList) {
            DropdownWithObject decObj = DropdownWithObject.builder().label(dec.getVcDecisionName()).value(dec.getMasterDecisionId()).build();
            res.add(decObj);
        }
        return res;
    }

    public static List<DropdownWithObject> parseVpaFromLiveTransForPayee(List<LiveTrans> liveTransList) {
        List<DropdownWithObject> res = new ArrayList<>();
        for (LiveTrans liveTrans : liveTransList) {
            DropdownWithObject tcr = DropdownWithObject
                    .builder()
                    .label(liveTrans.getIPayeeVpaID().getVcExternalAddressID())
                    .value(liveTrans.getIPayeeVpaID().getIVpaID())
                    .build();
            res.add(tcr);
        }
        return res;
    }

    public static List<DropdownWithObject> parseVpaFromVpa(List<Vpa> vpaList) {
        List<DropdownWithObject> res = new ArrayList<>();
        for (Vpa vpa : vpaList) {
            DropdownWithObject tcr = DropdownWithObject
                    .builder()
                    .label(vpa.getVcAddress())
                    .value(vpa.getIVpaID())
                    .build();
            res.add(tcr);
        }
        return res;
    }

    public static List<DropdownWithObject> parseFromID(List<LiveTrans> liveTransList) {
        List<DropdownWithObject> res = new ArrayList<>();
        for (LiveTrans liveTrans : liveTransList) {
            DropdownWithObject tcr = DropdownWithObject
                    .builder()
                    .label(liveTrans.getVcMsgID())
                    .value(liveTrans.getDtTrxnTime())
                    .build();
            res.add(tcr);
        }
        return res;
    }

    public static List<DropdownWithObject> parseDashboardDropdown(List<Dashboard> dashboardList) {
        List<DropdownWithObject> res = new ArrayList<>();
        for (Dashboard dashboard : dashboardList) {
            DropdownWithObject tcr = DropdownWithObject
                    .builder()
                    .label(dashboard.getVcDashboardName())
                    .value(dashboard.getIDashboardID())
                    .build();
            res.add(tcr);
        }
        return res;
    }

    public static List<DropdownWithObject> parseDashboardDropdownFromObject(List<Object[]> rows) {
        List<DropdownWithObject> res = new ArrayList<>();
        if (rows.size() > 0) {
            Object[] array = rows.get(0);
            int lenght = array.length;
            if (lenght == 2) {
                for (int i = 0; i < rows.size(); i++) {
                    Object[] row = rows.get(i);
                    res.add(makeDropdownObjectFromSingleObject(row[0]));
                }
            } else if (lenght == 3) {
                for (int i = 0; i < rows.size(); i++) {
                    Object[] row = rows.get(i);
                    res.add(makeDropdownObjectFromLableAndValueObject(row[0], row[1]));
                }
            }
            return res;
        } else {
            return null;
        }
    }

    public static DropdownWithObject makeDropdownObjectFromLableAndValueObject(Object label, Object value) {
        DropdownWithObject tcr = DropdownWithObject
                .builder()
                .label(String.valueOf(label))
                .value(value)
                .build();
        return tcr;
    }

    public static DropdownWithObject makeDropdownObjectFromSingleObject(Object object) {
        DropdownWithObject tcr = DropdownWithObject
                .builder()
                .label(String.valueOf(object))
                .value(object)
                .build();
        return tcr;
    }

    public static List<DropdownWithObject> parse(List<ListMaster> listMasters) {
        List<DropdownWithObject> res = new ArrayList<>();
        res = listMasters.stream()
                .map(lm ->  DropdownWithObject.builder()
                        .label(lm.getVcName())
                        .value(lm.getId().getIListMasterID())
                        .build())
                .collect(Collectors.toList());
        return res;
    }
}

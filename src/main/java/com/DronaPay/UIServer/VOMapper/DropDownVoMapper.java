package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.ResponseVO.DropDownVo;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.model.sim.Simulations;

import java.util.ArrayList;
import java.util.List;

public class DropDownVoMapper {

    public static List<DropDownVo> parseWebUser(List<WebUser> webUserList) {
        List<DropDownVo> res = new ArrayList<>();
        for (WebUser wbU : webUserList) {
            DropDownVo temp = DropDownVo.builder().label(wbU.getVcUserName()).value(Integer.toString(wbU.getIuserID()))
                    .build();
            res.add(temp);
        }
        return res;
    }

    public static List<DropDownVo> parseAggregateTypes(List<String> types) {
        List<DropDownVo> res = new ArrayList<>();
        for (String type : types) {
            DropDownVo temp = DropDownVo.builder().label(type).value(type)
                    .build();
            res.add(temp);
        }
        DropDownVo temp = DropDownVo.builder().label("custom").value("custom")
                .build();
        res.add(temp);
        return res;
    }

    public static List<DropDownVo> parseWorkflow(List<WorkflowMasters> workflowMastersList) {
        List<DropDownVo> res = new ArrayList<>();
        for (WorkflowMasters wfl : workflowMastersList) {
            DropDownVo temp = DropDownVo.builder().label(wfl.getWorkflowName())
                    .value(Integer.toString(wfl.getWorkflowId())).build();
            res.add(temp);
        }
        return res;
    }

    public static List<DropDownVo> parse(List<ValidationFieldsList> validationFieldsList) {
        List<DropDownVo> res = new ArrayList<>();
        for (ValidationFieldsList vfl : validationFieldsList) {
            DropDownVo temp = DropDownVo.builder().label(vfl.getVcFieldDisplayName()).value(vfl.getVcInternalField())
                    .build();
            res.add(temp);
        }
        return res;
    }

    public static List<DropDownVo> parseGroup(List<GroupDesc> groupDescList) {
        List<DropDownVo> res = new ArrayList<>();
        for (GroupDesc gd : groupDescList) {
            DropDownVo temp = DropDownVo.builder().label(gd.getVcGroupName()).value(Integer.toString(gd.getIgroupID()))
                    .build();
            res.add(temp);
        }
        return res;
    }

    public static List<DropDownVo> parseGroup(WebUser user) throws Exception {
        // List<GroupDesc> groupDescList = user.getUserGroup();
        String open = "{\r\n    \"candidateUser\": \"" + user.getIuserID()
                + "\",    \r\n    \"sorting\": [\r\n        {\r\n            \"sortBy\": \"created\",\r\n            \"sortOrder\": \"asc\"\r\n        }\r\n    ]" +
				", \"nameNotEqual\":\"Review Confirm Frauds\"" +
                "\r\n}";
        String claimed = "{\r\n    \"assignee\": \"" + user.getIuserID()
                + "\",    \r\n    \"sorting\": [\r\n        {\r\n            \"sortBy\": \"created\",\r\n            \"sortOrder\": \"asc\"\r\n        }\r\n    ]" +
				", \"nameNotEqual\":\"Review Confirm Frauds\"" +
                "" +
                "\r\n}";
        // String priorityTicket="{\r\n \"candidateUser\": \""+ user.getVcUserName()
        // +"\", \r\n \"sorting\": [\r\n {\r\n \"sortBy\": \"created\",\r\n
        // \"sortOrder\": \"asc\"\r\n }\r\n ]\r\n}";
        String priorityTicket = "Aggregated";

        String closed = "{\r\n  \"finished\":true,\r\n  \"sorting\":[\r\n   \r\n    {\r\n      \"sortBy\": \"startTime\",\r\n      \"sortOrder\": \"desc\"\r\n    }\r\n  ],\n  \"processDefinitionKeyNotIn\":[\"Orchestrator\"]\n  \n}";


        String myclosed = "{\r\n  \"finished\":true,\r\n \"taskAssignee\":\"" + user.getIuserID() + "\", \"sorting\":[\r\n   \r\n    {\r\n      \"sortBy\": \"startTime\",\r\n      \"sortOrder\": \"desc\"\r\n    }\r\n  ],\n  \"processDefinitionKeyNotIn\":[\"Orchestrator\"]\n  \n}";

        DropDownVo allTask = DropDownVo
                .builder()
                .label("Open")
                .value(open)
                .build();

        DropDownVo myTask = DropDownVo
                .builder()
                .label("My")
                .value(claimed)
                .build();

        DropDownVo priority = DropDownVo
                .builder()
                .label("Aggregated")
                .value(priorityTicket)
                .build();

        DropDownVo closedDrop = DropDownVo
                .builder()
                .label("Closed")
                .value(closed)
                .build();

        DropDownVo MyclosedDrop = DropDownVo
                .builder()
                .label("My Closed")
                .value(myclosed)
                .build();

        List<DropDownVo> res = new ArrayList<>();

        res.add(allTask);
        res.add(myTask);
        res.add(priority);
        res.add(closedDrop);
        res.add(MyclosedDrop);
        // for( GroupDesc gd : groupDescList)
        // {
        // DropDownVo temp = DropDownVo
        // .builder()
        // .label(gd.getVcGroupName())
        // .value("?candidateGroups="+gd.getVcGroupID())
        // .build();
        // res.add(temp);
        // }
        return res;
    }

    public static List<DropDownVo> parseWithNameAsValue(List<TransactionClassesUI> tcl) {
        List<DropDownVo> res = new ArrayList<>();
        for (TransactionClassesUI tc : tcl) {
            DropDownVo tcr = DropDownVo
                    .builder()
                    .label(tc.getVcClassName())
                    .value(tc.getVcClassName())
                    .build();
            res.add(tcr);
        }
        return res;
    }

    public static List<DropDownVo> parseSimulations(List<Simulations> simulations_list) {

        List<DropDownVo> res = new ArrayList<>();
        for (Simulations simulations : simulations_list) {
            DropDownVo tcr = DropDownVo
                    .builder()
                    .label(simulations.getSimid())
                    .value(simulations.getSimid())
                    .build();
            res.add(tcr);
        }
        return res;
    }
}

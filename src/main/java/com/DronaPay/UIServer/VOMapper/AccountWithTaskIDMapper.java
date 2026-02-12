package com.DronaPay.UIServer.VOMapper;

import com.DronaPay.UIServer.model.CamundaModels.AccountWithTaskID;
import com.DronaPay.UIServer.response.AccountWiseResponse;

import java.util.*;
import java.util.stream.Collectors;

public class AccountWithTaskIDMapper {

    public static Map<String, Object> AccountWithTaskIDMapper(List<AccountWithTaskID> inputlist, String sortorder,
            Integer limit) {

        Long count = inputlist.stream()
                .map(AccountWithTaskID::getProcessid)
                .distinct()
                .count();

        Map<String, Map<String, List<AccountWithTaskID>>> grouppedListTenant = inputlist.stream()
                .collect(Collectors.groupingBy(AccountWithTaskID::getTenantid,
                        Collectors.groupingBy(AccountWithTaskID::getAccount)));

        List<AccountWiseResponse> res = new ArrayList<>();
        for (Map.Entry<String, Map<String, List<AccountWithTaskID>>> tenEntry : grouppedListTenant.entrySet()) {
            String tenantId = tenEntry.getKey();
            Map<String, List<AccountWithTaskID>> grouppedList = tenEntry.getValue();
            for (Map.Entry<String, List<AccountWithTaskID>> entry : grouppedList.entrySet()) {
                AccountWiseResponse temp = new AccountWiseResponse();
                temp.setAccount(entry.getKey());
                temp.setItenantId(Integer.parseInt(tenantId));
                List<Map<String, String>> maplist = new ArrayList<>();
                List<AccountWithTaskID> temp1 = entry.getValue();
                for (AccountWithTaskID a : temp1) {
                    Map<String, String> i = new HashMap<>();
                    i.put("taskid", a.getTaskid());
                    i.put("processid", a.getProcessid());
                    maplist.add(i);
                }
                temp.setTicketList(maplist);
                temp.setCount(entry.getValue().size());
                res.add(temp);
            }
        }

        Collections.sort(res, (o1, o2) -> o1.getCount() - o2.getCount());

        if (sortorder.equalsIgnoreCase("desc")) {
            Collections.reverse(res);
        }

        if (res.size() > limit) {
            res = res.subList(0, limit);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("count", count);
        response.put("list", res);

        return response;
    }
}

package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.EmailReport;
import java.util.*;

public interface EmailReportRepoService {
    public EmailReport findByReportId(Integer id, Integer tenantid) throws Exception;
    public List<EmailReport> findAllActiveReports() throws Exception;
    public EmailReport save(EmailReport report) throws Exception;
    public List<EmailReport> findAllNondeletedReports() throws Exception;
    public List<EmailReport> findAllNondeletedReportsTenant(List<Integer> tenants);
}

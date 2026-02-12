package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.EmailReport;

import com.DronaPay.UIServer.repository.EmailReportRepo;

@Service
public class EmailReportRepoServiceImpl implements EmailReportRepoService {
    @Autowired
    private EmailReportRepo emailReportRepository;

    @Override
    public EmailReport findByReportId(Integer id, Integer tenantid) throws Exception {
        return emailReportRepository.findByReportIdAndItenantId_Itenantid(id, tenantid);
    }

    @Override
    public List<EmailReport> findAllActiveReports() throws Exception {
        return emailReportRepository.findByBactiveTrueAndBdeleteFalse();
    }

    @Override
    public EmailReport save(EmailReport report) throws Exception {
       return emailReportRepository.save(report);
    }

    @Override
    public List<EmailReport> findAllNondeletedReports() throws Exception {
        return emailReportRepository.findByBdeleteFalseAndItenantIdIsNotNull();
    }

    @Override
    public List<EmailReport> findAllNondeletedReportsTenant(List<Integer> tenants) {
        return emailReportRepository.findByBdeleteFalseAndItenantId_ItenantidIn(tenants);
    }
    
}

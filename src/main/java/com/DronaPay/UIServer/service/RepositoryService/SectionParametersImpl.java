package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.SectionParameters;
import com.DronaPay.UIServer.repository.SectionParametersRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SectionParametersImpl implements SectionParametersService {

    @Autowired
    private SectionParametersRepo sectionParametersRepo;

    public List<SectionParameters> findBySummaryName(String summaryname,Integer tenantId) throws Exception
    {
        //return sectionParametersRepo.findBySectionName(summaryname);
        return sectionParametersRepo.findByVcSectionNameAndItenantIdAndBactiveTrueAndBdeleteFalse(summaryname,tenantId);
    }
}

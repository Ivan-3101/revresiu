package com.DronaPay.UIServer.service.RepositoryService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DronaPay.UIServer.model.MetaData;
import com.DronaPay.UIServer.repository.HistoricProfileRepository;

@Service
public class HistoricProfilesServiceImpl implements  HistoricProfilesService {

    @Autowired
    private HistoricProfileRepository historicProfileRepository;

    @Override
    public List<MetaData> findAllData() throws Exception {
        return historicProfileRepository.findAll();
    }

    @Override
    public List<MetaData> findByColumnAndRoot(List<String> columns, String root, Integer tenantid) throws Exception {
        return historicProfileRepository.findAllByVccolumnnameInAndItenantId(columns, tenantid).stream().filter(md->md.getVcroot().equals(root)).collect(Collectors.toList());
    }

    @Override
    public List<MetaData> findAllActiveTenant(Integer tenantid) {
        return historicProfileRepository.findAllByItenantId(tenantid)
        .stream()
        .filter(mtdu->(mtdu.getIrecordStatus() == null || mtdu.getIrecordStatus() == 0))
        .collect(Collectors.toList());
    }

    // @Override
    // public MetaData findByVcrootVcPath(String vcroot, String vcpath) throws Exception {
    //     return historicProfileRepository.findByVcrootAndVcpathAndiRecordStatusIsNot(vcroot, vcpath, 1);
    // }
    
    
}

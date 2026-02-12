package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MetaData;
import com.DronaPay.UIServer.model.MetadataUi;
import com.DronaPay.UIServer.repository.HistoricProfileRepository;
import com.DronaPay.UIServer.repository.MetadataUiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class MetadataUiServiceImpl extends MetadataUiService {

    @Autowired
    private MetadataUiRepository metadataUiRepository;

    @Autowired
    private HistoricProfileRepository historicProfileRepository;

    @Override
    public MetadataUi saveAudit(MetadataUi input) {
        MetaData pMeta = null;
        // addition case
        if (input.getIrecordStatus() == 0) {
            pMeta = new MetaData();
            pMeta.setBml(input.getBml());
            pMeta.setBscore(input.getBscore());
            pMeta.setBui(input.getBui());
            pMeta.setConfig(input.getConfig());
            pMeta.setIrecordStatus(input.getIrecordStatus());
            pMeta.setVcPrefix(input.getVcPrefix());
            pMeta.setVccolumnname(input.getVccolumnname());
            pMeta.setVcdescription(input.getVcdescription());
            pMeta.setVcdtype(input.getVcdtype());
            pMeta.setVcpath(input.getVcpath());
            pMeta.setVcquery(input.getVcquery());
            pMeta.setVcroot(input.getVcroot());
            pMeta.setItenantId(input.getItenantId());
        } else {
            pMeta = historicProfileRepository.findById(input.getIMetadataId()).get();
            pMeta.setIrecordStatus(1);
        }


        pMeta = historicProfileRepository.save(pMeta);
        System.out.println(pMeta);

        input.setIMetadataId(pMeta.getId());
        System.out.println(input);
        return metadataUiRepository.save(input);
    }

    @Override
    public List<MetadataUi> findAllActiveMetadata() throws Exception {
        return metadataUiRepository.findByIrecordStatusIsNullOrIrecordStatus(0);
    }

    @Override
    public List<MetadataUi> findAllActiveMetadataTenants(List<Integer> tenants) throws Exception {
        return metadataUiRepository.findAllByItenantIdIn(tenants)
                .stream()
                .filter(mtdu -> (mtdu.getIrecordStatus() == null || mtdu.getIrecordStatus() == 0))
                .collect(Collectors.toList());
    }

    @Override
    public MetadataUi findByVcrootVcPath(String vcroot, String vcpath) throws Exception {
        return metadataUiRepository.findByVcrootAndVcpathAndIrecordStatusIsNot(vcroot, vcpath, 1);
    }

    @Override
    public List<MetadataUi> findByColumnAndRootTenant(List<String> columns, String root, Integer tenantid) {
        return metadataUiRepository.findAllByVccolumnnameInAndVcrootAndItenantId(columns, root, tenantid);
    }


    @Override
    public MetadataUi findByVcrootVcPathTenant(String vcroot, String vcpath, Integer tenant) throws Exception {
        return metadataUiRepository.findByVcrootAndVcpathAndIrecordStatusIsNotAndItenantId(vcroot, vcpath, 1,
                tenant);
    }

    @Override
    public MetadataUi findById(Integer id) throws Exception {
        return metadataUiRepository.findById(id).orElse(null);
    }

    @Override
    public List<MetadataUi> findDUplicate(String label, String window, String root, String path, Integer tenant) {
        return metadataUiRepository.findAllByItenantIdAndVcpathAndVcrootAndIrecordStatus(tenant, path, root, 0)
                .stream()
                .filter(a ->
                        a.getConfig() != null &&
                                (a.getConfig().get("label") == null ? label == null : a.getConfig().get("label").asText().equals(label)) &&
                                (a.getConfig().get("window") == null ? window == null : a.getConfig().get("window").asText().equals(window))
                )
                .collect(Collectors.toList());

    }

}

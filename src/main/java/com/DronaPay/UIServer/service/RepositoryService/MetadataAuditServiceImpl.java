package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MetadataUiAudit;
import com.DronaPay.UIServer.repository.MetadataUiAuditRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class MetadataAuditServiceImpl extends MetadataAuditService {

    @Autowired
    private MetadataUiAuditRepository metadataUiAuditRepository;

    @Override
    @Transactional
    public MetadataUiAudit saveAudit(MetadataUiAudit input) {
        return metadataUiAuditRepository.save(input);
    }

    @Override
    public List<MetadataUiAudit> findPendingEntries() {
        return metadataUiAuditRepository.findByIstatusIsNullAndBclosedFalse();
    }

    @Override
    public MetadataUiAudit findByVcrootVcPath(String vcroot, String vcpath) throws Exception {
        return metadataUiAuditRepository.findByVcrootAndVcpathAndIstatusIsNullAndBclosedFalse(vcroot, vcpath);
    }

    @Override
    public List<MetadataUiAudit> findPendingEntriesTenants(List<Integer> tenants) {
        return metadataUiAuditRepository.findAllByIstatusIsNullAndBclosedFalseAndItenantIdIn(tenants);
    }

    @Override
    public MetadataUiAudit findByVcrootVcPathTenant(String vcroot, String vcpath, Integer tenant) throws Exception {
        return metadataUiAuditRepository
                .findByVcrootAndVcpathAndIstatusIsNullAndBclosedFalseAndItenantId(vcroot, vcpath, tenant);
    }

    @Override
    public MetadataUiAudit findByAuditId(Integer id, Integer tenantId) throws Exception {
        return metadataUiAuditRepository.findByiMetadataIdAndItenantIdAndIstatusIsNullAndBclosedFalse(id, tenantId);
    }

    @Override
    public MetadataUiAudit findByMetadatUiId(Integer id, Integer tenantId) throws Exception {
        return metadataUiAuditRepository.findByiMetadataAuditIdAndItenantIdAndIstatusIsNullAndBclosedFalse(id, tenantId);
    }

    @Override
    public List<MetadataUiAudit> findDUplicate(String label, String window, String root, String path, Integer tenant) {
        return metadataUiAuditRepository.findAllByItenantIdAndVcpathAndVcrootAndBclosedFalseAndIrecordStatusIsNull(tenant, path, root)
                .stream()
                .filter(a ->
                        a.getConfig() != null &&
                                (a.getConfig().get("label") == null ? label == null : a.getConfig().get("label").asText().equals(label)) &&
                                (a.getConfig().get("window") == null ? window == null : a.getConfig().get("window").asText().equals(window))
                )
                .collect(Collectors.toList());

    }

}

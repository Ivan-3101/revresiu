package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.MetadataUiAudit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MetadataUiAuditRepository extends JpaRepository<MetadataUiAudit, Integer> {
    public MetadataUiAudit findByVcrootAndVcpathAndIstatusIsNullAndBclosedFalse(String vcroot, String vcpath);

    public MetadataUiAudit findByiMetadataAuditIdAndItenantIdAndIstatusIsNullAndBclosedFalse(Integer id, Integer tenantId);

    public MetadataUiAudit findByiMetadataIdAndItenantIdAndIstatusIsNullAndBclosedFalse(Integer id, Integer tenantId);

    public MetadataUiAudit findByVcrootAndVcpathAndIstatusIsNullAndBclosedFalseAndItenantId(String vcroot, String vcpath, Integer tenant);

    public List<MetadataUiAudit> findByIstatusIsNullAndBclosedFalse();

    public List<MetadataUiAudit> findAllByIstatusIsNullAndBclosedFalseAndItenantIdIn(List<Integer> tenants);

//    @Query(value = "SELECT * FROM ui.metadataaudit e WHERE e.config ->> 'label' = :label AND e.config ->> 'window' = :window AND e.vcroot = :root ")
//    List<MetadataUiAudit> findDuplicate(@Param("label") String label,@Param("window") String window,@Param("root") String root,@Param("path") String path,@Param("tenant") Integer tenant);

    List<MetadataUiAudit> findAllByItenantIdAndVcpathAndVcrootAndBclosedFalseAndIrecordStatusIsNull(Integer tenant, String vcpath, String root);

}

package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.MetadataUi;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MetadataUiRepository extends JpaRepository<MetadataUi, Integer> {
    public MetadataUi findByVcrootAndVcpathAndIrecordStatusIsNot(String vcroot, String vcpath, Integer one);

    public MetadataUi findByVcrootAndVcpathAndIrecordStatusIsNotAndItenantId(String vcroot, String vcpath, Integer one, Integer tenant);

    public List<MetadataUi> findByIrecordStatusIsNullOrIrecordStatus(Integer zero);

    public List<MetadataUi> findAllByItenantIdIn(List<Integer> tenants);

//    @Query(value = "SELECT * FROM ui.metadata e WHERE e.config ->> 'label' = :label AND e.config ->> 'window' = :window AND e.vcroot = :root AND e.vcpath = :path  AND e.itenantid = :tenant  AND irecordstatus=0 ",nativeQuery = true)
//    List<MetadataUi> findDuplicate(@Param("label") String label,@Param("window") String window,@Param("root") String root,@Param("path") String path,@Param("tenant") Integer tenant);

    List<MetadataUi> findAllByItenantIdAndVcpathAndVcrootAndIrecordStatus(Integer tenant, String vcpath, String root, Integer recordstatus);

    List<MetadataUi> findAllByVccolumnnameInAndVcrootAndItenantId(List<String> columns, String root, Integer tenantid);


}

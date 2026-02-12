package com.DronaPay.UIServer.repository;

// import java.util.List;

import com.DronaPay.UIServer.CompositeKey.MetaDataKey;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Query;

import com.DronaPay.UIServer.model.MetaData;

public interface HistoricProfileRepository extends JpaRepository<MetaData, Integer > {
    public MetaData findByirecordStatusIsNotAndVcrootAndVcpath(Integer one, String vcroot, String vcpath);

    public MetaData findByirecordStatusIsNotAndVcrootAndVcpathAndItenantId(Integer one, String vcroot, String vcpath,
            Integer tenant);

    public List<MetaData> findAllByVccolumnnameInAndItenantId(List<String> columns, Integer id);
    public List<MetaData> findAllByItenantId(Integer tenantid);
}

package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.FormMaster;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FormMasterRepository extends JpaRepository<FormMaster, Integer> {

    Optional<FormMaster> findByVcFormNameAndItenantId(String vcFormName, Integer tenantid);

    Optional<FormMaster> findByIformIDAndItenantId(Integer id, Integer tenantid);

}

package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.CompositeKey.WebuserMappingAuditKey;
import com.DronaPay.UIServer.model.WebuserMappingAudit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WebuserMappingAuditRepository extends JpaRepository<WebuserMappingAudit, WebuserMappingAuditKey> {
    List<WebuserMappingAudit> findAllByMappingIDAndMappingType(Integer mappingID, String mappingType);

    List<WebuserMappingAudit> findAllByMappingIDInAndMappingType(List<Integer> mappingID, String mappingType);

    // List<WebuserMappingAudit> findAllByMappingIDInAndMappingTypeAndWebUserAuditID_IstatusIsNullAndWebUserAuditID_BclosedFalse(
    // List<Integer> mappingID, String mappingType);

    void deleteAllByWebUserAuditIDAndIorgId(Integer userid, Integer orgid);

    List<WebuserMappingAudit> findAllByMappingIDInAndMappingTypeAndWebUserAuditIDInAndIorgId(List<Integer> mappingids, String mappingtype, List<Integer> uids, Integer orgid);

    List<WebuserMappingAudit> findAllByMappingTypeAndWebUserAuditIDInAndIorgId(String mappingtype, List<Integer> uids, Integer orgid);

    List<WebuserMappingAudit> findAllByMappingTypeAndWebUserAuditIDAndIorgId(String mappingtype, Integer uids, Integer orgid);


    List<WebuserMappingAudit> findAllByWebUserAuditIDAndIorgId(Integer iuserauditid, Integer iorgid);

    List<WebuserMappingAudit> findAllByWebUserAuditIDInAndIorgId(List<Integer> iuserauditid, Integer iorgid);
}

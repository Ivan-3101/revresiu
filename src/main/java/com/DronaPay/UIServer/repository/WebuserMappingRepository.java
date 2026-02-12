package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.CompositeKey.WebuserMappingKey;
import com.DronaPay.UIServer.model.WebuserMapping;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WebuserMappingRepository extends JpaRepository<WebuserMapping, WebuserMappingKey> {

    List<WebuserMapping> findAllByMappingIDAndMappingType(Integer mappingID, String mappingType);

    List<WebuserMapping> findAllByMappingIDAndMappingTypeAndItenantId(Integer mappingID, String mappingType, Integer tenantid);

    List<WebuserMapping> findAllByMappingIDInAndMappingType(List<Integer> mappingID, String mappingType);

    List<WebuserMapping> findAllByMappingIDInAndMappingTypeAndItenantId(List<Integer> mappingID, String mappingType, Integer tenantid);

    // List<WebuserMapping> findAllByMappingIDInAndMappingTypeAndWebuserID_iStatus_iStatusIDOrderByWebuserID_DtApproverStampDesc(
    //     List<Integer> mappingID, String mappingType, Integer one
    // );

    List<WebuserMapping> findAllByMappingIDInAndMappingTypeAndWebuserIDInAndIorgId(List<Integer> mappingid, String mappingType, List<Integer> userid, Integer orgid);

    List<WebuserMapping> findAllByMappingTypeAndWebuserIDInAndIorgId(String mappingType, List<Integer> userid, Integer iorgid);


    List<WebuserMapping> findAllByMappingTypeAndWebuserIDAndIorgId(String mappingType, Integer userid, Integer iorgid);


    List<WebuserMapping> findAllByWebuserIDAndIorgId(Integer userid, Integer iorgid);

    void deleteAllByWebuserIDAndIorgId(Integer userid, Integer orgid);

    List<WebuserMapping> findAllByWebuserIDInAndIorgId(List<Integer> userid, Integer iorgid);

    Optional<WebuserMapping> findByWebuserIDAndMappingType(Integer webuserID, String mappingType);

    List<WebuserMapping> findByIorgIdAndMappingIDAndMappingType(Integer orgId, Integer mappingID, String mappingType);

}

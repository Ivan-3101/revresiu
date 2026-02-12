package com.DronaPay.UIServer.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.SectionParameters;

@Repository
public interface SectionParametersRepo extends JpaRepository<SectionParameters, Integer> {

    // @Query("SELECT s FROM SectionParameters s WHERE s.vcSectionName = :sectionname AND s.bActive =true and s.bDelete = false")
    // public List<SectionParameters> findBySectionName(@Param("sectionname") String sectionname);
    public List<SectionParameters> findByVcSectionNameAndItenantIdAndBactiveTrueAndBdeleteFalse(String sectionname,Integer tenantId);

    public SectionParameters findByiDashboardQueryIDAndItenantIdAndBactiveTrueAndBdeleteFalse(Integer queryId,Integer tenantId);
}

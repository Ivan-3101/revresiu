package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.TemplateResponse;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TemplateResponseRepository extends JpaRepository<TemplateResponse,Integer>{

    // @Query("SELECT t FROM TemplateResponse t WHERE t.templateName = :templateName AND t.activeFlag ='Y'")
    // public TemplateResponse findBytemplateNameAndActiveFlag(@Param("templateName") String templatename);

    public TemplateResponse findByTemplateNameAndActiveFlag(String templatename, String Yes);
    
}

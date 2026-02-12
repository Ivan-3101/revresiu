package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.UploadChargeBack;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UploadChargeBackRepository extends JpaRepository<UploadChargeBack, Integer> {
    
}

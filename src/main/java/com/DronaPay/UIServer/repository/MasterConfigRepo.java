package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.MasterConfig;

import java.util.List;

public interface MasterConfigRepo extends JpaRepository<MasterConfig, Integer> {
    List<MasterConfig> findByConfigNameInAndBdeleteFalse(List<String> names);
}

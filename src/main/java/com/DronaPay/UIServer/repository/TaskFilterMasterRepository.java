package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.TaskFilterMaster;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaskFilterMasterRepository extends JpaRepository<TaskFilterMaster, Integer> {
}

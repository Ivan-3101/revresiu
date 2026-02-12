package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.ActivityLog;

@Repository
public interface ActivityLogRepository extends JpaRepository<ActivityLog, Integer> 
{
	
}

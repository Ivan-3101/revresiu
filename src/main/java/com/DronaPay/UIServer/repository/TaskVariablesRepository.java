package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.TaskVariables;

public interface TaskVariablesRepository extends JpaRepository<TaskVariables, Integer> {
    
}

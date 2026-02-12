package com.DronaPay.UIServer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.TaskLHSMap;
public interface TaskLHSMapRepository extends JpaRepository<TaskLHSMap, Integer> {
    public List<TaskLHSMap> findByOptionId_Vclabel(String label);
}

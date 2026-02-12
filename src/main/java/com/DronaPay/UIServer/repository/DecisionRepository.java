package com.DronaPay.UIServer.repository;

import java.util.List;

import com.DronaPay.UIServer.model.Decisions;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface DecisionRepository extends JpaRepository<Decisions, Integer> {

    // @Query("SELECT d FROM Decisions d WHERE d.bActive = true ")
    // public List<Decisions> findAllActive();

    public List<Decisions> findByBactiveTrue();

}

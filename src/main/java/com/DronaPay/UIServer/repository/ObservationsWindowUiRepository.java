package com.DronaPay.UIServer.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.DronaPay.UIServer.model.ObservationWindows;

public interface ObservationsWindowUiRepository extends  JpaRepository<ObservationWindows, Integer>{
    
    // @Query("SELECT d FROM ObservationWindows d WHERE (d.istatus.iStatusID = 1 OR d.istatus.iStatusID = null) AND d.irecordStatus=0 ")
    // public List<ObservationWindows> findAllNonDeleted();

    // @Query("SELECT MAX(d.wid) FROM ObservationWindows d ")
    // public Integer findMaxId();
    public ObservationWindows findTopByOrderByWidDesc();

    public Optional<ObservationWindows> findByWidAndItenantId(Integer wid, Integer tenantid);

    // @Query("SELECT d FROM ObservationWindows d WHERE d.wName=:wname AND d.iRecordStatus=0 ")
    // public ObservationWindows findByWindowName(@Param("wname") String wName);
    public ObservationWindows findByWnameAndIrecordStatusAndItenantId(String wname, Integer zero, Integer tenantid);

    public List<ObservationWindows> findAllByItenantIdIn(List<Integer> tenants);
}

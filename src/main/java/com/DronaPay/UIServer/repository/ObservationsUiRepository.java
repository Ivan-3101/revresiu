package com.DronaPay.UIServer.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.DronaPay.UIServer.model.ObservationsUi;

public interface ObservationsUiRepository extends JpaRepository<ObservationsUi, Integer>{
    
    // @Query("SELECT d FROM ObservationsUi d WHERE (d.istatus.iStatusID = 1 OR d.istatus.iStatusID = null) And d.irecordStatus=0")
    // public List<ObservationsUi> findAllNonDeleted();

    // @Query("SELECT d FROM ObservationsUi d WHERE d.wId.wId=:wid And d.iRecordStatus=0")
    // public List<ObservationsUi> findAllBywId(@Param("wid") Integer wId);

    public Optional<ObservationsUi> findByOidAndWidAndItenantId(Integer oid, Integer wid, Integer tenantid);

    public List<ObservationsUi> findAllByWidAndItenantIdAndIrecordStatus(Integer wid, Integer itenantid, Integer zero);

    // public List<ObservationsUi> findAllByItenantId_ItenantidIn(List<Integer> tenants);

    public List<ObservationsUi> findAllByItenantIdIn(List<Integer> tenants);

    // @Query("SELECT MAX(d.oid) FROM ObservationsUi d")
    // public Integer findMaxId();
    public ObservationsUi findTopByOrderByOidDesc();

    // @Query("SELECT d FROM ObservationsUi d WHERE d.oName=:oname And d.iRecordStatus=0")
    // public ObservationsUi findByOName(@Param("oname") String oName);
    public ObservationsUi findByOnameAndIrecordStatus(String oname, Integer zero);

    Optional<ObservationsUi> findByOnameAndItenantIdAndIrecordStatus(String oname, Integer itenantid, Integer zero);



}

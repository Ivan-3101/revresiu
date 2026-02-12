package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.ScoreRequests;

@Repository
public interface ScoreRequestRepository extends JpaRepository<ScoreRequests, String> {


    // @Query("select sr from ScoreRequests sr where sr.vcRequestID = : vcRequestID")
    // public ScoreRequests findByVcRequestID(@Param("vcRequestID") String vcRequestID);
    public ScoreRequests findByVcRequestID(String vcRequestID);

    //public ScoreRequests findByvcRequestID(@Param("vcRequestID") String vcRequestID);

    // @Query(value = "select * from ui.scorerequests where  cast(vcrequestdata AS json) -> 'txn' ->> 'class' = :vcRequestID", nativeQuery = true)
    //@Query("select sr from ScoreRequests sr where JSON_VALUE(sr.vcRequestData, '$.txn.class') = :vcRequestID")
    // public List<ScoreRequests> findByClassName(@Param("vcRequestID") String vcClassName);
}

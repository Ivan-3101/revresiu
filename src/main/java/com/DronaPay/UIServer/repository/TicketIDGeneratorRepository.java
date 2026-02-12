package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.TicketIDGenerator;

@Repository
public interface TicketIDGeneratorRepository extends JpaRepository<TicketIDGenerator,Long> {

    // @Query("SELECT count(iID) FROM TicketIDGenerator where iYear = :iyear")
    // public Integer findLastTicketIDByIYear(@Param("iyear") int iyear);

}

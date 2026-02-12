package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.PerspectiveQueryParameters;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PerspectiveQueryParametersRepository extends JpaRepository<PerspectiveQueryParameters, Integer> {

}

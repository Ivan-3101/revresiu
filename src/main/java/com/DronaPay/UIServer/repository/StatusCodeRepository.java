package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.DronaPay.UIServer.model.StatusCode;

@Repository
public interface StatusCodeRepository extends JpaRepository<StatusCode, Integer> {

//	public StatusCode findByiStatusID(int i);
}

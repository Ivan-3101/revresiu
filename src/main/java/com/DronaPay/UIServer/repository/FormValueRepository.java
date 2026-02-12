package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.FormValue;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface FormValueRepository extends JpaRepository<FormValue, Integer> {

    Optional<FormValue> findByIvalueIDAndItenantId(Integer formid, Integer tenantid);

}

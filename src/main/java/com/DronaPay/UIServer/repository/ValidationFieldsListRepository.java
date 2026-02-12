package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ValidationFieldsList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ValidationFieldsListRepository extends JpaRepository<ValidationFieldsList, Integer> {

    List<ValidationFieldsList> findAllByitenantId(Integer tenantId);


}

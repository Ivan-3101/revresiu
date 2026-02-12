package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.TransactionClasses;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionClassesRepository extends JpaRepository<TransactionClasses, Integer> {
//    public TransactionClasses findByiClassID(int iClassID);
    public List<TransactionClasses> findBybActiveTrue();

}

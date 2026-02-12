package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.Vpa;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


import java.math.BigInteger;

@Repository
public interface VpaRepository extends JpaRepository<Vpa, BigInteger> {

    public Vpa findByvcAddress(String address);

    public Vpa findByVcExternalAddressID(String address);
}


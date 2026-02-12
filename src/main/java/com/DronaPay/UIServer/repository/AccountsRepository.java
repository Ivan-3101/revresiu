package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.Accounts;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


import java.math.BigInteger;

@Repository
public interface AccountsRepository extends JpaRepository<Accounts, BigInteger> {

    public Accounts findByVcExternalAccountID(String address);
}


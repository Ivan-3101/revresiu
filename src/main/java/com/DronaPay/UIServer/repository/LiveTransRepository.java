package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.LiveTrans;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.math.BigInteger;

@Repository
public interface LiveTransRepository extends JpaRepository<LiveTrans, BigInteger> {


}

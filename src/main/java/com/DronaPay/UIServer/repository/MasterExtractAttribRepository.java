package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.CompositeKey.MasterExtractAttribsKey;
import com.DronaPay.UIServer.model.MasterExtractAttribs;

public interface MasterExtractAttribRepository extends JpaRepository<MasterExtractAttribs, MasterExtractAttribsKey>{

}

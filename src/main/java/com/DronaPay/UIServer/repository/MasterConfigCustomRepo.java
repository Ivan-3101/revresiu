package com.DronaPay.UIServer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.DronaPay.UIServer.model.MasterConfigCustom;
import java.util.List;

public interface MasterConfigCustomRepo extends JpaRepository<MasterConfigCustom, Integer>{
    public List<MasterConfigCustom> findByIparentId_IconfigIdInAndBdeleteFalse(List<Integer> ids);
}

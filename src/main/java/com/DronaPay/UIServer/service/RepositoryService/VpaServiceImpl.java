package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.repository.VpaRepository;
import com.DronaPay.UIServer.model.Vpa;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VpaServiceImpl implements VpaService{

    @Autowired
    private VpaRepository vpaRepository;

    public List<Vpa> findAll()
    {
        return vpaRepository.findAll();
    }

    public Vpa findByExternalid(String vpaAddress){
        return vpaRepository.findByvcAddress(vpaAddress);
    }

    public Vpa findByVcExternalID(String address) {
        return vpaRepository.findByVcExternalAddressID(address);
    }
}

package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.Vpa;
import java.util.List;


public interface VpaService {

    public List<Vpa> findAll();

    public Vpa findByExternalid(String vpaAddress);

    public Vpa findByVcExternalID(String address);


}

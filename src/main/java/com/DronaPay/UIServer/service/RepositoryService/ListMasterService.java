package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ListMaster;

import java.util.List;

public interface ListMasterService  {

    public List<ListMaster> findBlackAndGrey() throws Exception;


    public List<ListMaster> findAll() throws Exception;

    public ListMaster findByID(Integer ilistmasterid,Integer tenantid) throws Exception;

    public List<ListMaster> findByName(String name) throws Exception;

    public ListMaster save(ListMaster lm) throws Exception;

    public List<ListMaster> findAllTenants(List<Integer> tenants) throws Exception;

     public List<ListMaster> findAllTenant(Integer tenants) throws Exception;

}

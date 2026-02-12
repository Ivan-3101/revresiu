package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.RoleDesc;
import com.DronaPay.UIServer.util.UserMapping;

import java.util.List;
import java.util.Map;

import org.apache.catalina.mbeans.UserMBean;

public interface RoleDescService {

    // this function is to save new role
    public void save(RoleDesc roleDesc) throws Exception;

    public RoleDesc findByiroleid(int n) throws Exception;

    public List<RoleDesc> findAll() throws Exception;

    public Map<Integer, RoleDesc> findAllMap();

    public List<RoleDesc> findAllById(UserMapping umap);

    public List<RoleDesc> findAllByTenantIds(List<Integer> tenantids);

}

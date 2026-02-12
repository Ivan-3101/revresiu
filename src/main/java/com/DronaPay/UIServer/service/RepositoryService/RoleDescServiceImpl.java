package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.RoleDesc;
import com.DronaPay.UIServer.repository.RoleDescRepository;
import com.DronaPay.UIServer.util.UserMapping;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class RoleDescServiceImpl implements RoleDescService {

    @Autowired
    private RoleDescRepository roleDescRepository;

    // this function is to save new role
    public void save(RoleDesc roleDesc) throws Exception {
        roleDescRepository.save(roleDesc);
    }

    public RoleDesc findByiroleid(int n) throws Exception {
//        return roleDescRepository.findByiRoleID(n);
        return roleDescRepository.getById(n);
    }

    public List<RoleDesc> findAll() throws Exception {
        return roleDescRepository.findAll();
    }

    public Map<Integer, RoleDesc> findAllMap() {
        return roleDescRepository.findAll().stream().collect(Collectors.toMap(RoleDesc::getIRoleID, Function.identity()));
    }

    @Cacheable("userrolebyid")
    public List<RoleDesc> findAllById(UserMapping usermapping) {
        return roleDescRepository.findAllByiRoleIDInAndItenantIdIn(usermapping.getMappingIds(), usermapping.getTenantids());
    }

    @Override
    public List<RoleDesc> findAllByTenantIds(List<Integer> tenantids) {
//        return roleDescRepository.findAllByItenantIdIn(tenantids);
        return roleDescRepository.findAllByItenantIdIn(tenantids)
                .stream()
                .filter(roleDesc -> !roleDesc.getVcRoleName().equals("Drona God"))
                .collect(Collectors.toList());
    }
}
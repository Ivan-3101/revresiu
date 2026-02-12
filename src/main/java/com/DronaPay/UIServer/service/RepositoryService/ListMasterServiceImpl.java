package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ListMaster;
import com.DronaPay.UIServer.repository.ListMasterRespository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ListMasterServiceImpl implements ListMasterService {

    @Autowired
    private ListMasterRespository listMasterRespository;

    public List<ListMaster> findBlackAndGrey() throws Exception{
        //return listMasterRespository.findBlackAndGrey();
        List<String> blackGrey = new ArrayList<>();
        blackGrey.add("Black");
        blackGrey.add("Grey");
        return listMasterRespository.findByVcNameIn(blackGrey);
    }

    @Override
    public List<ListMaster> findAllTenants(List<Integer> tenants) throws Exception {
        return listMasterRespository.findAllById_ItenantId_ItenantidInOrId_ItenantId_ItenantidIsNull(tenants);
    }

    public List<ListMaster> findAll() throws Exception{
        return listMasterRespository.findAll();
    }


    public ListMaster findByID(Integer ilistmasterid,Integer tenantid) throws Exception
    {
        return listMasterRespository.findById_iListMasterIDAndId_ItenantId_Itenantid(ilistmasterid,tenantid);
    }

    public List<ListMaster> findByName(String name) throws Exception
    {
        return listMasterRespository.findByVcName(name);
    }

    public ListMaster save(ListMaster lm) throws Exception
    {
        return listMasterRespository.save(lm);
    }

    @Override
    public List<ListMaster> findAllTenant(Integer tenants) throws Exception {
        return listMasterRespository.findAllById_ItenantId_Itenantid(tenants);
    }
}

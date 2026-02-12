package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.ListMaster;
import com.DronaPay.UIServer.model.EmbeddedId.ListMasterEmbeddedId;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ListMasterRespository extends JpaRepository<ListMaster,ListMasterEmbeddedId> {

     // @Query("SELECT lm FROM ListMaster lm where lm.vcName  in ('Black', 'Grey') ")
     // public List<ListMaster> findBlackAndGrey();

     public List<ListMaster> findByVcNameIn(List<String> nameList);

     public List<ListMaster> findByVcName(String name);

     public List<ListMaster> findAllById_ItenantId_ItenantidInOrId_ItenantId_ItenantidIsNull(List<Integer> tenants);

     public List<ListMaster> findAllById_ItenantId_Itenantid(Integer tenants);

      public ListMaster findById_iListMasterIDAndId_ItenantId_Itenantid(Integer masterId, Integer tenantId);
}



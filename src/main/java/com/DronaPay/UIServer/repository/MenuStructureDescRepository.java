package com.DronaPay.UIServer.repository;

import com.DronaPay.UIServer.model.MenuStructureDesc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface MenuStructureDescRepository extends JpaRepository<MenuStructureDesc, Integer> {

    Optional<MenuStructureDesc> findByVcMenuName(String vcMenuName);

    List<MenuStructureDesc> findByiParentMenu_iMenuID(Integer parentMenuId);
}

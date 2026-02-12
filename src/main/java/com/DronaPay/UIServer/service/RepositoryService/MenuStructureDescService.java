package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.MenuStructureDesc;
import com.DronaPay.UIServer.model.WebUser;

import java.util.List;
import java.util.Optional;

public interface MenuStructureDescService {

    public void save(MenuStructureDesc menuStructureDesc);

    public List<MenuStructureDesc> findAll();

    public Integer findByVcMenuName(String vcMenuName, WebUser loggedinuser);

    public Optional<MenuStructureDesc> findById(Integer menuId);

    public List<MenuStructureDesc> findAllByIParentMenu(Integer parentMenuId);

}

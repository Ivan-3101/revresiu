package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.MenuStructureDesc;
import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.repository.MenuStructureDescRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MenuStructureDescServiceImpl implements MenuStructureDescService {

    @Autowired
    private MenuStructureDescRepository menuStructureDescRepository;

    public void save(MenuStructureDesc menuStructureDesc) {
        menuStructureDescRepository.save(menuStructureDesc);
    }

    public List<MenuStructureDesc> findAll() {
        return menuStructureDescRepository.findAll();
    }


    @Cacheable(value = "MENUS", key = "#vcMenuName", unless = "#result == null")
    public Integer findByVcMenuName(String vcMenuName, WebUser loggedinuser) {
        return menuStructureDescRepository.findByVcMenuName(vcMenuName)
                .orElseThrow(() -> new NotFoundException("failed to find menu with menuname " + vcMenuName, loggedinuser, vcMenuName)).getIMenuID();
    }

    @Cacheable(value = "MENUSBYID", key = "#menuId", unless = "#result == null")
    public Optional<MenuStructureDesc> findById(Integer menuId) {
        return menuStructureDescRepository.findById(menuId);
    }

    @Cacheable(value = "PARENTMENUSBYID", key = "#parentMenuId", unless = "#result == null")
    public List<MenuStructureDesc> findAllByIParentMenu(Integer parentMenuId) {
        return menuStructureDescRepository.findByiParentMenu_iMenuID(parentMenuId);
    }

}

package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ClientUser;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public interface ClientUserService {

    public ClientUser loadUserByUsername(String username) throws UsernameNotFoundException;

    public ClientUser save(ClientUser clientUser) throws UsernameNotFoundException;
}

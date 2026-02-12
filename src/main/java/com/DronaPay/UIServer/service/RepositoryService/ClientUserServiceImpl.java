package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.exception.NotFoundException;
import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.repository.ClientUserRepository;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Service
public class ClientUserServiceImpl implements ClientUserService
//        , UserDetailsService
{

    private final ClientUserRepository clientUserRepository;

    public ClientUserServiceImpl(ClientUserRepository clientUserRepository) {
        this.clientUserRepository = clientUserRepository;
    }

    @Override
    public ClientUser loadUserByUsername(String username) throws UsernameNotFoundException {

        return clientUserRepository.findById(username)
                .orElseThrow(() -> new NotFoundException("failed to find user with username " + username, username));
    }

    public ClientUser save(ClientUser clientUser) throws UsernameNotFoundException {

        return clientUserRepository.save(clientUser);
    }
}

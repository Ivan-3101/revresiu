package com.DronaPay.UIServer.security;

import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.service.RepositoryService.ClientUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Collections;

@Component
public class ClientUserAuthProvider implements AuthenticationProvider {

    @Autowired
    private ClientUserService clientUserService;

    @Autowired
    private PasswordEncoder passwordEncoder;


    @Override
    public Authentication authenticate(Authentication auth)
            throws AuthenticationException {
        String username = auth.getName();
        String password = auth.getCredentials()
                .toString();

        ClientUser client = clientUserService.loadUserByUsername(username);

        if (passwordEncoder.matches(password, client.getPassword())) {
            return new UsernamePasswordAuthenticationToken
                    (username, password, Collections.emptyList());
        } else {
            throw new
                    BadCredentialsException("External system authentication failed");
        }
    }

    @Override
    public boolean supports(Class<?> auth) {
        return auth.equals(UsernamePasswordAuthenticationToken.class);
    }
}

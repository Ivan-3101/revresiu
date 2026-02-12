package com.DronaPay.UIServer.security;

import com.DronaPay.UIServer.model.WebUser;
import com.DronaPay.UIServer.service.RepositoryService.WebUserService;
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
public class WebUserAuthProvider implements AuthenticationProvider {

    @Autowired
    private WebUserService clientUserService;

    @Autowired
    private PasswordEncoder passwordEncoder;


    @Override
    public Authentication authenticate(Authentication auth)
            throws AuthenticationException {
        String username = auth.getName();
        String password = auth.getCredentials()
                .toString();

        WebUser client = clientUserService.loadUserByUsername(username);

        if (passwordEncoder.matches(password, client.getPassword())) {
            return new UsernamePasswordAuthenticationToken
                    (username, password, Collections.emptyList());
        } else {
            throw new
                    BadCredentialsException("Wrong password");
        }
    }

    @Override
    public boolean supports(Class<?> auth) {
        return auth.equals(UsernamePasswordAuthenticationToken.class);
    }
}

package com.DronaPay.UIServer.security;

import com.DronaPay.UIServer.Constants.ClientUserProtectedURI;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;


@Component
public class RestAuthenticationEntryPointClientAPI implements AuthenticationEntryPoint {

    private List<AntPathRequestMatcher> matchers = Arrays.stream(ClientUserProtectedURI.Client_Protected_Url)
            .map(a -> new AntPathRequestMatcher(a)).toList();

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException, ServletException {
        if (matchers.stream().anyMatch(a -> a.matches(request))) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, authException.getMessage());
        }
    }

}

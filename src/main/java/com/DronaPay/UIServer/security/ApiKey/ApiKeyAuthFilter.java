package com.DronaPay.UIServer.security.ApiKey;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import java.util.Arrays;
import java.util.List;

import static com.DronaPay.UIServer.Constants.ClientUserProtectedURI.Api_Protected_Url;
import static com.DronaPay.UIServer.Constants.ClientUserProtectedURI.Client_Protected_Url;

public class ApiKeyAuthFilter extends AbstractPreAuthenticatedProcessingFilter {


    private Boolean clientUserEnebled;

    public ApiKeyAuthFilter(Boolean clientUserEnebled) {
        this.clientUserEnebled = clientUserEnebled;
    }

    @Override
    protected Object getPreAuthenticatedPrincipal(HttpServletRequest request) {
        List<AntPathRequestMatcher> matchers = Arrays.stream(Api_Protected_Url)
                .map(a -> new AntPathRequestMatcher(a)).toList();
        boolean valid = false;
        if (matchers.stream().anyMatch(a -> a.matches(request))) {
            valid = true;
        }

        if (!clientUserEnebled) {
            List<AntPathRequestMatcher> matchersclient = Arrays.stream(Client_Protected_Url)
                    .map(a -> new AntPathRequestMatcher(a)).toList();

            if (matchersclient.stream().anyMatch(a -> a.matches(request))) {
                valid = true;
            }
        }

        if (valid)
            return request.getHeader("X-API-KEY");
        else
            return null;
    }

    @Override
    protected Object getPreAuthenticatedCredentials(HttpServletRequest request) {
        return null;
    }
}

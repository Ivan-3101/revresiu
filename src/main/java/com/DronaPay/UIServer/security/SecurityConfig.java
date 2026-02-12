package com.DronaPay.UIServer.security;

import com.DronaPay.UIServer.security.ApiKey.ApiKeyAuthFilter;
import com.DronaPay.UIServer.security.ApiKey.ApiKeyAuthManager;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import com.DronaPay.UIServer.util.WebuserMappingUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.header.writers.XXssProtectionHeaderWriter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import java.util.Arrays;
import java.util.List;

import static com.DronaPay.UIServer.Constants.ClientUserProtectedURI.*;
import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private static final Logger logger = LoggerFactory.getLogger(SecurityConfig.class);
    List<AntPathRequestMatcher> matchers = Arrays.stream(Client_Protected_Url)
            .map(a -> new AntPathRequestMatcher(a)).toList();
    List<AntPathRequestMatcher> matchersapi = Arrays.stream(Api_Protected_Url)
            .map(a -> new AntPathRequestMatcher(a)).toList();

    //    @Value("${spring.security.oauth2.resourceserver.jwt.user-name-attribute}")

    @Autowired
    private WebUserService webUserService;
    @Autowired
    private ActiveLoginTokenService activeLoginTokenService;
    @Autowired
    private PasswordConfig passwordConfig;
    @Autowired
    private JWTTokenHelper jwtTokenHelper;
    @Autowired
    private RestAuthenticationEntryPoint restAuthenticationEntryPoint;
    @Value(value = "${auth.apikeyvalue}")
    private String apiKeyValue;
    @Value(value = "${auth.apikey}")
    private Boolean apiKeyEnabled;

    @Value(value = "${UIServer.Client.User.Enabled}")
    private Boolean clientUserEnebled;
    @Autowired
    private ClientUserAuthProvider clientUserAuthProvider;
    @Autowired
    private WebUserAuthProvider webUserAuthProvider;
    //    @Autowired
//    private RelyingPartyRegistrationRepository relyingPartyRegistrationRepository;
    @Autowired
    private RestAuthenticationEntryPointClientAPI restAuthenticationEntryPointClientAPI;

    @Autowired
    private WorkflowMasterService workflowMasterService;

    @Autowired
    private GroupDescService groupDescService;

    @Autowired
    private TenantRepositoryService tenantRepositoryService;

    @Autowired
    private RoleDescService roleDescService;

    @Autowired
    private UserRoleMenuAccessService userRoleMenuAccessService;

    @Autowired
    private WebuserMappingService webuserMappingService;

    @Autowired
    private WebuserMappingUtil webuserMappingUtil;

    @Autowired
    private TransactionClassesUiService transactionClassesService;
    @Autowired
    private LoggerEncoderUtil loggerEncoderUtil;

    @Bean
    public AuthenticationManager authManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder authenticationManagerBuilder =
                http.getSharedObject(AuthenticationManagerBuilder.class);
        authenticationManagerBuilder.authenticationProvider(webUserAuthProvider);
        authenticationManagerBuilder.authenticationProvider(clientUserAuthProvider);

        return authenticationManagerBuilder.build();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, AuthenticationManager authenticationManager) throws Exception {

        if (apiKeyEnabled) {
            logger.info("api_key enabled.");
            ApiKeyAuthFilter apiKeyAuthFilter = new ApiKeyAuthFilter(clientUserEnebled);
            apiKeyAuthFilter.setAuthenticationManager(new ApiKeyAuthManager(apiKeyValue, loggerEncoderUtil));
            if (clientUserEnebled) {
                http
                        .authorizeHttpRequests()
                        .requestMatchers(Api_Protected_Url)
                        .authenticated()
                        .requestMatchers(Client_Protected_Url)
                        .authenticated()
                        .and()
                        .addFilter(apiKeyAuthFilter);
            } else {
                http
                        .authorizeHttpRequests()
                        .requestMatchers(Api_Protected_Url)
                        .authenticated()
                        .and()
                        .addFilter(apiKeyAuthFilter);
            }


        }


        if (clientUserEnebled) {
            http.authorizeHttpRequests((request) -> request
                            .requestMatchers(Client_Protected_Url)
                            .authenticated().and()
                            .addFilterBefore(new JWTAuthenticationFilter(jwtTokenHelper, activeLoginTokenService, groupDescService,
                                            tenantRepositoryService, roleDescService, workflowMasterService, userRoleMenuAccessService, webUserService, webuserMappingService, webuserMappingUtil, transactionClassesService),
                                    UsernamePasswordAuthenticationFilter.class))
                    .exceptionHandling()
                    .defaultAuthenticationEntryPointFor(restAuthenticationEntryPointClientAPI, new RequestMatcher() {
                        @Override
                        public boolean matches(HttpServletRequest request) {

                            if (matchers.stream().anyMatch(a -> a.matches(request)) || matchersapi.stream().anyMatch(a -> a.matches(request))) {
                                return true;
                            }
                            return false;
                        }
                    });
        }

        http
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(restAuthenticationEntryPoint);

        http.addFilterBefore(new JWTAuthenticationFilter(jwtTokenHelper, activeLoginTokenService, groupDescService, tenantRepositoryService, roleDescService, workflowMasterService, userRoleMenuAccessService, webUserService, webuserMappingService, webuserMappingUtil, transactionClassesService),
                UsernamePasswordAuthenticationFilter.class);
        http
                .authorizeHttpRequests(
                        (request) -> request
                                .requestMatchers(PUBLIC_URLS)
                                .permitAll()
                                .requestMatchers(HttpMethod.OPTIONS, "/**").denyAll()
                                .requestMatchers(HttpMethod.TRACE, "/**").denyAll()
                                .anyRequest()
                                .authenticated().and().authenticationManager(authenticationManager));

        http
                .csrf()
                .disable()
                .formLogin().disable()
                .httpBasic().disable()
                .cors();

//        }

        http.securityContext(context -> context.requireExplicitSave(false));
//        http.servletApi(Customizer.withDefaults());

        http.headers()
                .cacheControl(withDefaults())
                .frameOptions((frameOptions -> frameOptions.sameOrigin()))
                .xssProtection(xss -> xss
                        .headerValue(XXssProtectionHeaderWriter.HeaderValue.ENABLED_MODE_BLOCK))
                .httpStrictTransportSecurity().maxAgeInSeconds(16070400).includeSubDomains(true)
                .and()
                .contentSecurityPolicy(contentSecurityPolicyConfig -> contentSecurityPolicyConfig
                        .policyDirectives("default-src 'self' https://blockly-demo.appspot.com; " +
                                "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net;" +
                                "worker-src 'self' blob: ; " +
                                "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdn.jsdelivr.net; " +
                                "img-src 'self' data: https://blockly-demo.appspot.com; " +
                                "font-src 'self' data: https://fonts.gstatic.com https://cdn.jsdelivr.net; "+
                                "frame-ancestors 'none' ;"));
        return http.build();
    }

//    @Bean
//    public WebSecurityCustomizer webSecurityCustomizer() {
//        return (web) -> web.ignoring().requestMatchers(PUBLIC_URLS);
//    }

}

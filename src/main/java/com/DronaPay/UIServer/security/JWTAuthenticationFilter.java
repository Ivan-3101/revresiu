package com.DronaPay.UIServer.security;

import com.DronaPay.UIServer.Cache.LoggedUser;
import com.DronaPay.UIServer.Constants.Enum.WebuserMappingType;
import com.DronaPay.UIServer.model.*;
import com.DronaPay.UIServer.service.RepositoryService.*;
import com.DronaPay.UIServer.util.UserMapping;
import com.DronaPay.UIServer.util.WebuserMappingUtil;
import com.auth0.jwk.InvalidPublicKeyException;
import com.auth0.jwk.JwkException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.DronaPay.UIServer.Constants.ClientUserProtectedURI.Client_Protected_Url;

public class JWTAuthenticationFilter extends OncePerRequestFilter {

    private JWTTokenHelper jwtTokenHelper;
    private ActiveLoginTokenService activeLoginTokenService;

    private GroupDescService groupDescService;

    private TenantRepositoryService tenantRepositoryService;

    private WorkflowMasterService workflowMasterService;

    private RoleDescService roleDescService;

    private WebUserService webUserService;

    private UserRoleMenuAccessService userRoleMenuAccessService;

    private WebuserMappingService webuserMappingService;

    private WebuserMappingUtil webuserMappingUtil;

    private TransactionClassesUiService transactionClassesService;

    public JWTAuthenticationFilter(JWTTokenHelper jwtTokenHelper, ActiveLoginTokenService activeLoginTokenService,
                                   GroupDescService groupDescService, TenantRepositoryService tenantRepositoryService,
                                   RoleDescService roleDescService, WorkflowMasterService workflowMasterService,
                                   UserRoleMenuAccessService roleMenuAccessMapService, WebUserService webUserService,
                                   WebuserMappingService webuserMappingService, WebuserMappingUtil webuserMappingUtil, TransactionClassesUiService transactionClassesService) {
        this.jwtTokenHelper = jwtTokenHelper;
        this.activeLoginTokenService = activeLoginTokenService;
        this.groupDescService = groupDescService;
        this.tenantRepositoryService = tenantRepositoryService;
        this.roleDescService = roleDescService;
        this.workflowMasterService = workflowMasterService;
        this.userRoleMenuAccessService = roleMenuAccessMapService;
        this.webUserService = webUserService;
        this.webuserMappingService = webuserMappingService;
        this.webuserMappingUtil = webuserMappingUtil;
        this.transactionClassesService = transactionClassesService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String authToken = jwtTokenHelper.getToken(request);
        ActiveLoginToken activeLoginToken = authToken != null ? activeLoginTokenService.findByActiveTokens(authToken) : null;

        if (activeLoginToken != null) {

            WebUser webUser = webUserService.findByUserOrgId(activeLoginToken.getIUserId(), activeLoginToken.getIorgId());
            if (webUser != null) {
                try {
                    if (jwtTokenHelper.validateToken(authToken, webUser)) {
                        List<WorkflowMasters> allowedWfls = new ArrayList<>();
                        // List<TransactionClassesUI> allowedClass = new ArrayList<>();

                        List<WebuserMapping> webuserMappings = webuserMappingService.findByIDsWebuserIDandOrgID(webUser.getIuserID(),
                                webUser.getIorgId().getIorgid());

                        Map<String, List<Integer>> mappings =
                                webuserMappings
                                        .stream()
                                        .collect(Collectors.groupingBy(WebuserMapping::getMappingType,
                                                Collectors.mapping(WebuserMapping::getMappingID, Collectors.toList())));
                        UserMapping workflowIds = webuserMappingUtil.mappingHelper(webuserMappings, String.valueOf(WebuserMappingType.Workflow));
                        UserMapping classIds = webuserMappingUtil.mappingHelper(webuserMappings, String.valueOf(WebuserMappingType.TransactionClass));
                        UserMapping groupIds = webuserMappingUtil.mappingHelper(webuserMappings, String.valueOf(WebuserMappingType.Group));
                        UserMapping roleIds = webuserMappingUtil.mappingHelper(webuserMappings, String.valueOf(WebuserMappingType.Role));
                        List<Integer> tenantIds = mappings.get(String.valueOf(WebuserMappingType.Tenant));

                        if (workflowIds.getMappingIds().contains(-1)) {
                            allowedWfls = workflowMasterService.findAllByTenants(tenantIds);
                        } else {
                            allowedWfls = workflowMasterService.findByWorkflowIDs(workflowIds);
                        }

                        // if(classIds.getMappingIds().contains(-1)) {
                        //     allowedClass = transactionClassesService.findAllByTenantIds(tenantIds);
                        // } else {
                        //     allowedClass = transactionClassesService.findByTenantClass(classIds);
                        // }

                        LoggedUser user = LoggedUser
                                .builder()
                                .webUser(webUser)
                                .groups(groupDescService.findAllById(groupIds))
                                .tenant(tenantRepositoryService.findByTenantIds(tenantIds))
                                .roleDescs(roleDescService.findAllById(roleIds))
                                .permissions(userRoleMenuAccessService.getPermissions(webUser.getIuserID(), webUser.getIorgId().getIorgid(), roleIds))
                                .workflows(allowedWfls)
                                .userTenant(tenantIds)
                                .userClass(classIds)
                                .build();

                        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                                user, null, webUser.getAuthorities());
                        authentication.setDetails(new WebAuthenticationDetails(request));
                        SecurityContextHolder.getContext().setAuthentication(authentication);
                    }
                } catch (InvalidPublicKeyException e) {
                    throw new RuntimeException(e);
                } catch (JwkException e) {
                    throw new RuntimeException(e);
                }
            } else {

                List<AntPathRequestMatcher> matchers = Arrays.stream(Client_Protected_Url)
                        .map(a -> new AntPathRequestMatcher(a)).toList();
                if (matchers.stream().anyMatch(a -> a.matches(request))) {
                    ClientUser webUser1 = activeLoginToken.getIClientUser();
                    if (jwtTokenHelper.validateToken(authToken, webUser1)) {
                        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                                webUser1, null, webUser1.getAuthorities());
                        authentication.setDetails(new WebAuthenticationDetails(request));
                        SecurityContextHolder.getContext().setAuthentication(authentication);
                    }
                }
            }
        }
        filterChain.doFilter(request, response);
    }

}

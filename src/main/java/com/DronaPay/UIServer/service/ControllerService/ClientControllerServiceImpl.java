package com.DronaPay.UIServer.service.ControllerService;

import com.DronaPay.UIServer.Constants.ResponseMessages;
import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.requests.ClientUserLoginRequest;
import com.DronaPay.UIServer.response.ApiResponse;
import com.DronaPay.UIServer.response.Records.ClientLogin;
import com.DronaPay.UIServer.response.Records.NewClientRegistration;
import com.DronaPay.UIServer.security.ClientUserAuthProvider;
import com.DronaPay.UIServer.security.JWTTokenHelper;
import com.DronaPay.UIServer.service.ControllerService.CaseManagement.TasksServiceImpl;
import com.DronaPay.UIServer.service.RepositoryService.ActiveLoginTokenService;
import com.DronaPay.UIServer.service.RepositoryService.ClientUserService;
import com.DronaPay.UIServer.util.LoggerEncoderUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.UUID;

@Slf4j
@Service
public class ClientControllerServiceImpl implements ClientControllerService {

    private final ClientUserService clientUserService;

    private final ClientUserAuthProvider clientUserAuthProvider;

    private final LoggerEncoderUtil loggerEncoderUtil;

    private final JWTTokenHelper jWTTokenHelper;

    private final ActiveLoginTokenService activeLoginTokenService;

    private final Environment env;

    private PasswordEncoder passwordEncoder;

    @Value("${jwt.auth.expires_in}")
    private Integer expirein;

    public ClientControllerServiceImpl(ClientUserService clientUserService, ClientUserAuthProvider clientUserAuthProvider, LoggerEncoderUtil loggerEncoderUtil, JWTTokenHelper jWTTokenHelper, ActiveLoginTokenService activeLoginTokenService, Environment env, PasswordEncoder passwordEncoder) {
        this.clientUserService = clientUserService;
        this.clientUserAuthProvider = clientUserAuthProvider;
        this.loggerEncoderUtil = loggerEncoderUtil;
        this.jWTTokenHelper = jWTTokenHelper;
        this.activeLoginTokenService = activeLoginTokenService;
        this.env = env;
        this.passwordEncoder = passwordEncoder;
    }


    public ResponseEntity<?> login(ClientUserLoginRequest authenticationRequest,
                                   HttpServletRequest request)
            throws InvalidKeySpecException, NoSuchAlgorithmException {


        Authentication authentication = null;
        ClientUser findUser = clientUserService.loadUserByUsername(authenticationRequest.getClientid());


        try {

            authentication = clientUserAuthProvider.authenticate(new UsernamePasswordAuthenticationToken(
                    authenticationRequest.getClientid(), authenticationRequest.getClientsecret()));

            System.out.println(authentication);

            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (BadCredentialsException e) {
            log.error("Error : " + e.toString() + "\nParam : { \"Client ID\": \""
                    + loggerEncoderUtil.encode(authenticationRequest.getClientid())
                    + "\", \"IPAddress\" : \"" + loggerEncoderUtil.encode(request.getRemoteAddr()) + "\"}");

            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "Please Enter Valid Credentials"),
                    HttpStatus.BAD_REQUEST);
        }

        if (authentication != null) {
            ClientUser user = findUser;
//            LoginResponse response = new LoginResponse();
//            response.setTokentype("Bearer");

            String jwtToken = jWTTokenHelper.generateToken(user.getUsername());

            try {
                activeLoginTokenService.saveToken(jwtToken, user);
                activeLoginTokenService.deletePastWeeksToken(
                        Integer.parseInt(env.getProperty("token.cleanup.day")));
            } catch (Exception e) {
                log.error("Error : " + e + "\nParam : " + loggerEncoderUtil.encode(authenticationRequest.getClientid()));
                return new ResponseEntity<ApiResponse>(
                        new ApiResponse(false, ResponseMessages.GenericErrorMessage),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }

//            response.setToken(jwtToken);
//            response.setExpirein(expirein);
            log.debug("Exiting logAuth Method in " + AuthenticationServiceImpl.class
                    + " class with response  :  jwt token");
            return ResponseEntity.ok(new ClientLogin(jwtToken, "Bearer", expirein));
        } else {
            log.debug("Exiting logAuth Method in " + TasksServiceImpl.class
                    + " class with response  : authentication failed message");
            return new ResponseEntity<ApiResponse>(new ApiResponse(false, "authentication object is null"),
                    HttpStatus.BAD_REQUEST);
        }
    }

    public ResponseEntity<?> newClient(String clientName) {
        String clientid = UUID.randomUUID().toString();
        String clientSecret = UUID.randomUUID().toString();
        String clientSecretHash = passwordEncoder.encode(clientSecret);
        ClientUser clientUser = new ClientUser();
        clientUser.setClientID(clientid);
        clientUser.setVcClientSecret(clientSecretHash);
        clientUser.setVcClientName(clientName);
        clientUserService.save(clientUser);
        return ResponseEntity.ok(new NewClientRegistration(clientid, clientSecret));
    }

}

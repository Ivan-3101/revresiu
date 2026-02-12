package com.DronaPay.UIServer.service.RepositoryService;

import com.DronaPay.UIServer.model.ActiveLoginToken;
import com.DronaPay.UIServer.model.ClientUser;
import com.DronaPay.UIServer.model.WebUser;

import java.util.Optional;

public interface ActiveLoginTokenService {

    public ActiveLoginToken findByActiveTokens(String tokens);


    public Optional<ActiveLoginToken> findByRefreshTokens(String tokens);

    public ActiveLoginToken verifyExpiry(ActiveLoginToken tokens);

    public WebUser findUserbyToken(ActiveLoginToken token);

    public void deleteToken(String tokens) throws Exception;

    public void deleteTokenByUserID(WebUser user) throws Exception;

    public ActiveLoginToken saveToken(String token, WebUser user, String refresh, Boolean isRefreshGenerated) throws Exception;


    public ActiveLoginToken saveToken(String token, ClientUser user) throws Exception;

//    public ActiveLoginToken update(ActiveLoginToken activeLoginToken) throws Exception;

    public void deletePastWeeksToken(int cleanUpDay);

}
